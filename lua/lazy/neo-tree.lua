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
			window = {
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
