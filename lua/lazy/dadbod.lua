return {
  {
    "vim-dadbod",
    lazy = true,
    cmd = { "DB", "DBUI", "DBUIToggle" },
  },

  {
    "vim-dadbod-ui",
    lazy = true,
    dependencies = { "vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod"
    end,
  },

  {
    "vim-dadbod-completion",
    lazy = true,
    dependencies = { "vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
  },
}
