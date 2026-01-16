return {
	"neo-tree.nvim",
	lazy = false,

	after = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
			},
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<leader>e"] = "close_window",
				},
			},
		})
	end,

	wk = {
		{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
	},
}
