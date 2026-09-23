-- Cortex-M build / flash / debug helpers, shared by nvim-dap.lua and cmake-tools.lua.
-- OpenOCD is the GDB server: a project-local openocd.cfg wins, else ST-Link + STM32F7.
local M = {}

M.CONFIG_NAME = "Embedded: build + flash + debug (OpenOCD)"

local GDB_PORT = 3333
local server      -- OpenOCD vim.SystemObj, lives only as long as a debug session
local chosen = {} -- cwd -> ELF path, so the picker asks once per nvim session

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "Embedded" })
end

local function tail(lines, n)
	return table.concat(vim.list_slice(lines, math.max(1, #lines - n + 1)), "\n")
end

-- OpenOCD's "unable to connect" is almost always hardware, not config.
local function openocd_error(lines)
	local msg = "OpenOCD failed:\n" .. tail(lines, 4)
	if table.concat(lines, "\n"):find("unable to connect to the target") then
		msg = msg .. "\n\nST-Link found but MCU not answering: check SWD wiring, board power, BOOT0."
	end
	notify(msg, vim.log.levels.ERROR)
end

local function openocd_cmd(extra)
	local cmd = { "openocd", "-f", "interface/stlink.cfg", "-f", "target/stm32f7x.cfg" }
	if vim.uv.fs_stat(vim.fn.getcwd() .. "/openocd.cfg") then
		cmd = { "openocd", "-f", "openocd.cfg" }
	end
	return vim.list_extend(cmd, extra or {})
end

-- Newest ELF under build/ (only prompts when there's more than one).
function M.pick_elf(force)
	local cwd = vim.fn.getcwd()
	if not force and chosen[cwd] and vim.uv.fs_stat(chosen[cwd]) then
		return chosen[cwd]
	end
	local elfs = vim.fn.glob(cwd .. "/build/**/*.elf", true, true)
	table.sort(elfs, function(a, b) return vim.uv.fs_stat(a).mtime.sec > vim.uv.fs_stat(b).mtime.sec end)

	local elf
	if #elfs == 1 then
		elf = elfs[1]
	elseif #elfs > 1 then
		local choices = { "Select firmware ELF (newest first):" }
		for i, f in ipairs(elfs) do
			choices[#choices + 1] = string.format("%d: %s", i, vim.fn.fnamemodify(f, ":."))
		end
		elf = elfs[vim.fn.inputlist(choices)]
	else
		elf = vim.fn.input("Firmware ELF: ", cwd .. "/", "file")
		elf = elf ~= "" and elf or nil
	end
	chosen[cwd] = elf
	if force and elf then notify("ELF: " .. vim.fn.fnamemodify(elf, ":.")) end
	return elf
end

-- Rebuild the ELF's own CMake build dir so we never flash a stale image.
local function build(elf, on_done)
	local dir = vim.fs.dirname(elf)
	if not vim.uv.fs_stat(dir .. "/CMakeCache.txt") then
		return on_done(true)
	end
	notify("Building " .. vim.fn.fnamemodify(dir, ":."))
	vim.system({ "cmake", "--build", dir }, { text = true }, vim.schedule_wrap(function(r)
		if r.code == 0 then
			return on_done(true)
		end
		vim.fn.setqflist({}, " ", { title = "cmake --build " .. dir, lines = vim.split(r.stdout .. r.stderr, "\n") })
		notify("Build failed: errors in quickfix (<leader>xq, ]q / [q)", vim.log.levels.ERROR)
		on_done(false)
	end))
end

local function start_server(on_ready)
	if server then
		return on_ready(true)
	end
	local log, ready = {}, false
	server = vim.system(openocd_cmd(), {
		stdout = false,
		stderr = function(_, data) -- OpenOCD logs everything to stderr
			if not data then return end
			vim.list_extend(log, vim.split(data, "\n", { trimempty = true }))
			if not ready and data:find("port " .. GDB_PORT .. " for gdb") then
				ready = true
				vim.schedule(function() on_ready(true) end)
			end
		end,
	}, vim.schedule_wrap(function()
		server = nil
		if not ready then
			openocd_error(log)
			on_ready(false)
		end
	end))
end

function M.stop_server()
	if server then
		server:kill("sigterm")
		server = nil
	end
end

-- dap `program` field: pick ELF -> build -> start OpenOCD, then hand the ELF to nvim-dap.
function M.prepare_debug()
	return coroutine.create(function(dap_run_co)
		local ABORT = require("dap").ABORT
		local elf = M.pick_elf()
		if not elf then
			return coroutine.resume(dap_run_co, ABORT)
		end
		build(elf, function(ok)
			if not ok then
				return coroutine.resume(dap_run_co, ABORT)
			end
			start_server(function(up)
				coroutine.resume(dap_run_co, up and elf or ABORT)
			end)
		end)
	end)
end

-- Run after GDB attaches: reset, flash, then start at the ELF's own vector table.
-- g_pfnVectors is the STM32Cube startup symbol; using it (not a fixed address) skips
-- a bootloader for apps linked at an offset (e.g. 0x08020000) and is a no-op otherwise.
local POST_ATTACH = {
	{ "monitor reset halt", fatal = true },
	{ "load",               fatal = true },
	{ "set $sp = ((unsigned int *)&g_pfnVectors)[0]" },
	{ "set $pc = ((unsigned int *)&g_pfnVectors)[1]" },
	{ "tbreak main" },
}

function M.after_attach(session)
	local function step(i)
		local c = POST_ATTACH[i]
		if not c then
			notify("Flashed; running to main()")
			-- dap.continue() needs the attach "stopped" event to have landed; else ask GDB directly
			if session.stopped_thread_id then
				return require("dap").continue()
			end
			return session:request("continue", { threadId = 1 }, function() end)
		end
		session:request("evaluate", { expression = c[1], context = "repl" }, function(err)
			if err then
				notify(string.format("gdb `%s` failed: %s", c[1], err.message or vim.inspect(err)),
					c.fatal and vim.log.levels.ERROR or vim.log.levels.WARN)
				if c.fatal then return end
			end
			step(i + 1)
		end)
	end
	step(1)
end

function M.flash()
	if require("dap").session() then
		return notify("Stop the debug session first (<leader>dt): it holds the ST-Link", vim.log.levels.WARN)
	end
	local elf = M.pick_elf()
	if not elf then return end
	M.stop_server()
	build(elf, function(ok)
		if not ok then return end
		notify("Flashing " .. vim.fn.fnamemodify(elf, ":t"))
		local cmd = openocd_cmd({ "-c", string.format("program {%s} verify reset exit", elf) })
		vim.system(cmd, { text = true }, vim.schedule_wrap(function(r)
			if r.code == 0 then
				notify("Flash OK: " .. vim.fn.fnamemodify(elf, ":t") .. " (target reset)")
			else
				openocd_error(vim.split(r.stderr, "\n", { trimempty = true }))
			end
		end))
	end)
end

vim.api.nvim_create_autocmd("VimLeavePre", { callback = M.stop_server, desc = "Stop OpenOCD on exit" })

return M
