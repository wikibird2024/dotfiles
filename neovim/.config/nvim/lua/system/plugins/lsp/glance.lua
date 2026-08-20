-- VSCode-style "Peek" windows for LSP locations -- preview + edit without
-- leaving your spot. Complements the existing gd/gr (fzf-lua jump-to) with
-- an uppercase peek variant instead of replacing them.
return {
	"DNLHC/glance.nvim",
	cmd = "Glance",
	keys = {
		{ "gD", "<cmd>Glance definitions<CR>",      desc = "Peek Definition" },
		{ "gR", "<cmd>Glance references<CR>",       desc = "Peek References" },
		{ "gY", "<cmd>Glance type_definitions<CR>", desc = "Peek Type Definition" },
		{ "gM", "<cmd>Glance implementations<CR>",  desc = "Peek Implementation" },
	},
	opts = {
		border = { enable = true },
	},
}
