-- Find project files below the cwd whose name matches a Lua pattern
-- (e.g. the Android head of an Avalonia app: Probe.Android/Probe.Android.csproj).
local function find_projects(name_pattern)
	return vim.fs.find(function(name)
		return name:match(name_pattern) ~= nil
	end, { path = vim.fn.getcwd(), type = "file", limit = 20 })
end

-- One project parameter, pre-filled when exactly one project matches
local function project_param(name_pattern, desc)
	return function()
		local projects = find_projects(name_pattern)
		return {
			project = {
				desc     = desc,
				type     = "string",
				default  = projects[1],
				optional = false,
			},
		}
	end
end

-- Android tasks: device log, and C# (.NET for Android / Avalonia) build-run.
-- Flutter run/reload lives in flutter-tools.nvim (<leader>F…), not here.
local function register_android_templates(overseer)
	overseer.register_template({
		name   = "adb: logcat",
		desc   = "Device log; with a package name, only that app's process",
		params = {
			package = {
				desc     = "App id, e.g. vn.haotran.protocol_lab (empty = all, warnings and up)",
				type     = "string",
				optional = true,
			},
		},
		builder = function(params)
			if params.package and params.package ~= "" then
				return {
					name = "logcat " .. params.package,
					cmd  = "adb logcat -v color --pid=$(adb shell pidof -s " .. params.package .. ")",
				}
			end
			return { name = "logcat", cmd = { "adb", "logcat", "-v", "color", "*:W" } }
		end,
	})

	overseer.register_template({
		name      = "dotnet: run on Android",
		desc      = "Build, install and start the Android project on the connected phone",
		tags      = { overseer.TAG.RUN },
		params    = project_param("Android.*%.csproj$", "Android .csproj"),
		builder   = function(params)
			return {
				name       = "dotnet android run",
				cmd        = { "dotnet", "build", params.project, "-t:Run", "-f", "net10.0-android" },
				components = { "on_output_quickfix", "default" },
			}
		end,
	})

	overseer.register_template({
		name      = "dotnet: run desktop",
		desc      = "Run the desktop head (Avalonia) on this PC",
		tags      = { overseer.TAG.RUN },
		params    = project_param("Desktop.*%.csproj$", "Desktop .csproj"),
		builder   = function(params)
			return {
				name = "dotnet desktop run",
				cmd  = { "dotnet", "run", "--project", params.project },
			}
		end,
	})
end

return {
	"stevearc/overseer.nvim",
	cmd  = { "OverseerRun", "OverseerToggle", "OverseerBuild" },
	keys = {
		{ "<leader>Or", "<cmd>OverseerRun<CR>",    desc = "Overseer: Run Task"    },
		{ "<leader>Ot", "<cmd>OverseerToggle<CR>", desc = "Overseer: Toggle Panel" },
	},
	opts = {
		dap = true, -- run launch.json preLaunchTask / postDebugTask
		task_list = {
			direction  = "bottom",
			min_height = 10,
			max_height = 15,
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)
		register_android_templates(overseer)
	end,
}
