return {
  cmd = {
    "clangd",
    "--background-index",
    -- 1. THREAD LIMIT: Critical for low-resource environments
    "-j=1",
    -- 2. RAM LIMIT: Reduces indexer caching footprint
    "--limit-results=20",
    "--malloc-trim",
    -- 3. FEATURES: Turn off heavy deep-analysis to stop lag
    "--clang-tidy=false",
    "--header-insertion=never",
    "--completion-style=bundled",
    -- 4. CROSS-COMPILING: Allows clangd to read your target toolchain headers
    "--query-driver=/usr/bin/arm-none-eabi*",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  -- Uses lspconfig utility helper to identify the project root directory
  root_dir = function(fname)
    local lspconfig = require("lspconfig")
    return lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".clangd", ".git")(fname)
  end,
}
