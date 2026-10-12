-- Flash firmware with one key (<leader>cf / :Flash). The project owns the flash
-- command; this only calls it:
--   1. CMake project (Neovim's folder): build the target "flash"
--      (cmake-tools, same panel as <leader>cb). Template: cmake/flash.cmake.
--   2. otherwise: a .vscode/tasks.json task "Flash", or a justfile recipe "flash"
--   3. otherwise: say the project has no flash command. Nothing is guessed.

local M = {}

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, { title = "Flash" })
end

-- Folder of the current file, or the cwd for a buffer without a file.
local function start_dir()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then return vim.fn.getcwd() end
	return vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(file, ":p")))
end

-- Run an overseer task by name with `cwd` as its working folder.
-- on_missing() runs when no task of that name exists.
local function run_named_task(name, cwd, on_missing)
	require("overseer").run_task({ name = name, cwd = cwd }, function(task, err)
		if task then
			notify("Running task '" .. name .. "' in " .. cwd)
			require("overseer").open({ enter = false })
		elseif err then
			on_missing()
		end
	end)
end

function M.flash()
	local cmake = require("cmake-tools")
	if cmake.is_cmake_project() then
		cmake.build({ target = "flash" })
		return
	end

	local dir = start_dir()
	local tasks_file = require("overseer.vscode.vs_util").get_tasks_file(vim.fn.getcwd(), dir)
	local task_folder = tasks_file and vim.fs.dirname(vim.fs.dirname(tasks_file))
	local justfile_folder = vim.fs.root(dir, { "justfile", "Justfile", ".justfile" })

	local function no_flash_command()
		local cmake_folder = vim.fs.root(dir, "CMakeLists.txt")
		if cmake_folder then
			notify("cmake-tools works on Neovim's folder (" .. vim.fn.getcwd() .. "), but this file's CMake"
				.. " project is " .. cmake_folder .. ". Run :cd " .. vim.fn.fnameescape(cmake_folder)
				.. " and flash again.", vim.log.levels.WARN)
			return
		end
		notify("This project has no flash command: add a CMake target \"flash\""
			.. " (templates/embedded-firmware/cmake/flash.cmake), a .vscode/tasks.json"
			.. " task \"Flash\", or a justfile recipe \"flash\".", vim.log.levels.WARN)
	end

	local function try_justfile()
		if justfile_folder then
			run_named_task("just flash", justfile_folder, no_flash_command)
		else
			no_flash_command()
		end
	end

	if task_folder then
		run_named_task("Flash", task_folder, try_justfile)
	else
		try_justfile()
	end
end

return M
