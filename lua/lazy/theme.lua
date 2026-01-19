return {
  "tokyonight.nvim",

  after = function()
    -- Optional theme config
    require("tokyonight").setup({
      style = "storm",
      transparent = false,
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("tokyonight")
  end,
}
