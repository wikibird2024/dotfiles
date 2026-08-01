return {
	"milanglacier/minuet-ai.nvim",
	opts = {
		provider = "openai_fim_compatible",
		n_completions = 1, -- resource saving for local model
		context_window = 512, -- small starting point for CPU-only inference
		provider_options = {
			openai_fim_compatible = {
				api_key = "TERM", -- Ollama needs no key; any set env var name works
				name = "Ollama",
				end_point = "http://127.0.0.1:11434/v1/completions",
				model = "qwen2.5-coder:1.5b",
				optional = {
					max_tokens = 56,
					top_p = 0.9,
				},
			},
		},
		virtualtext = {
			auto_trigger_ft = { "c", "cpp", "h" }, -- automatic ghost-text for C/C++/headers only
			keymap = {
				-- no suggestion visible yet: requests one; suggestion visible: cycles it
				next = "<A-\\>",
				accept = "<A-y>",
				accept_line = "<A-a>",
				dismiss = "<A-e>",
			},
		},
	},
}
