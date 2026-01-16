return {
	"barbecue.nvim",
	lazy = false,

	dependencies = {
		"nvim-navic",
	},
	after = function()
		require("barbecue").setup({
			show_modified = true,
		})
	end,
}
