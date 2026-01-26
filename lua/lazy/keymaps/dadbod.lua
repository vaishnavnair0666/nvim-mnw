local map = vim.keymap.set
local opts = { silent = true }

map(
	"n",
	"<leader>bb",
	"<cmd>DBUIToggle<CR>",
	vim.tbl_extend("force", opts, {
		desc = "DB: Toggle UI",
	})
)

map(
	"n",
	"<leader>br",
	"<cmd>DBUIRefresh<CR>",
	vim.tbl_extend("force", opts, {
		desc = "DB: Refresh UI",
	})
)

map(
	{ "n", "v" },
	"<leader>bq",
	"<cmd>DB<CR>",
	vim.tbl_extend("force", opts, {
		desc = "DB: Run query",
	})
)

map(
	"n",
	"<leader>bl",
	"<cmd>DBLastQueryInfo<CR>",
	vim.tbl_extend("force", opts, {
		desc = "DB: Last query info",
	})
)

map(
	"n",
	"<leader>bc",
	"<cmd>DBUIAddConnection<CR>",
	vim.tbl_extend("force", opts, {
		desc = "DB: Add connection",
	})
)
