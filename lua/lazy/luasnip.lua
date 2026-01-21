return {
  "LuaSnip",

  after = function()
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = false,
      region_check_events = "CursorMoved",
      delete_check_events = "TextChanged",
    })

    luasnip.filetype_extend("typescriptreact", { "typescript", "javascript" })
    luasnip.filetype_extend("javascriptreact", { "javascript" })
    luasnip.filetype_extend("markdown", { "text" })
  end,
}
