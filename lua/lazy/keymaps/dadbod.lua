local map = vim.keymap.set

map("n", "<leader>bb", "<cmd>DBUIToggle<CR>", { desc = "DB UI toggle" })
map("n", "<leader>bf", "<cmd>DBUIFindBuffer<CR>", { desc = "DB find buffer" })
map("n", "<leader>bi", "<cmd>DBUILastQueryInfo<CR>", { desc = "DB last query info" })
map("n", "<leader>bc", "<cmd>DBUIAddConnection<CR>", { desc = "DB add connection" })
map({ "n", "v" }, "<leader>bq", "<cmd>DB<CR>", { desc = "DB execute query" })
