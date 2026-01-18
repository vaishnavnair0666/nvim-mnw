return {
	"fzf-lua",

	-- mnw loads plugins from pack/*/start eagerly
	after = function()
		-- Environment config
		vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info"

		-- Explicit require (no globals)
		local fzf = require("fzf-lua")

		-- Setup
		fzf.setup({
			"telescope",
			"hide",
		})

		-- Integrate with vim.ui.select
		fzf.register_ui_select()
	end,

	-- Keymaps can safely call require() because plugin is already loaded
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Files",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep_native()
			end,
			desc = "Ripgrep (native)",
		},
		{
			"<leader>fG",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Ripgrep",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume picker",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>la",
			function()
				require("fzf-lua").lsp_code_actions()
			end,
			desc = "Code actions",
		},
	},

	wk = {
		{ "<leader>f", desc = "Fuzzy find" },
	},
}
