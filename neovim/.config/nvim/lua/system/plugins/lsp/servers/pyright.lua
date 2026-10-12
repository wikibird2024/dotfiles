local M = {}

-- The project's own venv (uv / `python -m venv` both make <root>/.venv), else nil.
-- Without this pyright uses the first python on $PATH (/usr/bin/python3) and
-- can't see the project's packages unless the venv was activated before nvim.
-- Same rule as `uv run`: the project's .venv wins over an activated one.
-- To pick another interpreter for this session: :LspPyrightSetPythonPath <path>
local function project_venv_python(root_dir)
	if not root_dir then return nil end
	for _, venv_folder in ipairs({ ".venv", "venv" }) do
		local python_path = vim.fs.joinpath(root_dir, venv_folder, "bin", "python")
		if vim.fn.executable(python_path) == 1 then
			return python_path
		end
	end
	return nil
end

function M.setup(capabilities)
	vim.lsp.config.pyright = {
		cmd          = { "pyright-langserver", "--stdio" },
		filetypes    = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
		capabilities = capabilities,
		before_init  = function(_, config)
			local python_path = project_venv_python(config.root_dir)
			if python_path then
				config.settings.python.pythonPath = python_path
			end
		end,
		settings = {
			python = {
				analysis = {
					autoSearchPaths      = true,
					useLibraryCodeForTypes = true,
					diagnosticMode       = "workspace",
					typeCheckingMode     = "basic",
				},
			},
		},
	}
end

return M
