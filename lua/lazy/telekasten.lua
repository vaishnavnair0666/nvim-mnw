return {
	{
		"telekasten.nvim",
		cmd = "Telekasten", -- lazy load on command
		keys = {
			{ "<leader>zp", "<cmd>Telekasten panel<cr>", desc = "Panel" },
			{ "<leader>zn", "<cmd>Telekasten new_note<cr>", desc = "New note" },
			{ "<leader>zf", "<cmd>Telekasten find_notes<cr>", desc = "Find notes" },
			{ "<leader>zg", "<cmd>Telekasten search_notes<cr>", desc = "Grep notes" },
			{ "<leader>zc", "<cmd>Telekasten show_calendar<cr>", desc = "Calendar" },
			{ "<leader>zd", "<cmd>Telekasten goto_today<cr>", desc = "Today note" },
			{ "<leader>zz", "<cmd>Telekasten follow_link<cr>", desc = "Follow link" },
			{ "<leader>zb", "<cmd>Telekasten show_backlinks<cr>", desc = "Backlinks" },
		},

		after = function()
			require("telekasten").setup({
				home = vim.fn.expand("~/Notes"),
				rename_update_links = true,
				sanitize_filename = true,
				auto_set_filetype = false,

				calendar_opts = {
					weeknm = 4,
					calendar_monday = 1,
				},

				dailies = "daily",
				weeklies = "weekly",
				templates = "templates",

				border = "rounded",

				find_command = "rg",
				grep_command = "rg",

				new_note_filename = "title",
				follow_creates_nonexisting = true,

				template_new_note = vim.fn.expand("~/Notes/templates/new.md"),
				template_new_daily = vim.fn.expand("~/Notes/templates/daily.md"),
			})
		end,
	},
	{
		"calendar.nvim",
		keys = {
			{ "<leader>C", "<cmd>Calendar<cr>", desc = "Calendar" },
		},
	},
}
