return {
	"rest.nvim",
	dependencies = {
		"fidget.nvim",
	},
	ft = { "http" },

	after = function()
		require("rest-nvim").setup({
			client = "curl",

			progress = true,
			result = {
				split = "horizontal",
				show_headers = true,
				formatters = {
					json = "jq",
				},
			},

			env = {
				enable = true,
				pattern = ".*%.env%.json", -- .rest.env.json
			},

			highlight = {
				enable = true,
				timeout = 750,
			},
		})
	end,

	keys = {
		{
			"<leader>rr",
			"<cmd>Rest run<cr>",
			desc = "Run HTTP request",
		},
		{
			"<leader>rl",
			"<cmd>Rest last<cr>",
			desc = "Re-run last request",
		},
	},

	wk = {
		{ "<leader>r", desc = "REST / API" },
	},
}
