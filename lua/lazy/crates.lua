return {
  "crates.nvim",
  event = "BufEnter Cargo.toml",

  after = function()
    require("crates").setup({
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
}
