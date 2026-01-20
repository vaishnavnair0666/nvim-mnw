return {
  "lush.nvim",
  dependencies = {
    "tokyonight.nvim",
  },
  after = function()
    vim.cmd.colorscheme("tokyonight")

    local lush = require("lush")
    ---@diagnostic disable: undefined-global
    lush(function()
      return {
        -- Core UI
        Normal({ bg = "NONE" }),
        CursorLine({ bg = "#2a2a37" }),
        Visual({ bg = "#3b3f51" }),

        -- Line numbers
        LineNr({ fg = "#6c7086" }),
        CursorLineNr({ fg = "#cdd6f4", bold = true }),

        -- Diagnostics
        DiagnosticError({ fg = "#f38ba8" }),
        DiagnosticWarn({ fg = "#f9e2af" }),
        DiagnosticInfo({ fg = "#89b4fa" }),
        DiagnosticHint({ fg = "#a6e3a1" }),

        -- Telescope (safe even if Telescope not loaded yet)
        TelescopeBorder({ fg = "#89b4fa" }),
        TelescopePromptBorder({ fg = "#f38ba8" }),
        TelescopeTitle({ fg = "#a6e3a1", bold = true }),
      }
    end)
  end,
}
