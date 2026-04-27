return {
	{
		"nvim-surround",

		keys = {
			"ys",
			"ds",
			"cs",
			"S",
		},

		after = function()
			require("nvim-surround").setup({})
		end,
	},
}
