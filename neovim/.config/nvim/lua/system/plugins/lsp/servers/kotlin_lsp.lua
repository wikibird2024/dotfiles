local M = {}

-- Kotlin: JetBrains kotlin-lsp (alpha, from Mason; binary `intellij-server`,
-- bundles its own JRE). The root must be the Gradle project (in a Flutter app:
-- app/android), not the git repo, or the Gradle import finds nothing.
-- settings.gradle* wins over a sub-module's build.gradle*.
function M.setup(capabilities)
	vim.lsp.config("kotlin_lsp", {
		capabilities = capabilities,
		root_markers = {
			{ "settings.gradle", "settings.gradle.kts" },
			{ "build.gradle", "build.gradle.kts", "pom.xml" },
		},
	})
end

return M
