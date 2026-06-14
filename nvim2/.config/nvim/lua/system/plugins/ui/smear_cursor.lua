return {
	"sphamba/smear-cursor.nvim",
	enabled = false, -- disable this thing to test scroll issue
	event = "VeryLazy",
	opts = {
		stiffness = 0.92,
		trailing_stiffness = 0.37,
		smear_width = 0.52,
		smear_between_neighbor_lines = true,
		distance_stop_animating = 0.28,
		cursor_color = "#fabd2f",
	},
}
