return {
  {
    "nvim-lspconfig",
    lazy = false,
  },

  {
    "none-ls.nvim",
    lazy = false,

    dependencies = {
      "nvim-lspconfig",
      -- "blink.cmp",
    },

    after = function()
      local null_ls = require("null-ls")

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      null_ls.setup({
        diagnostics_format = "[#{m}] #{s} (#{c})",
        debounce = 250,
        default_timeout = 5000,
        sources = {
          formatting.stylua,
          code_actions.statix,
          diagnostics.deadnix,
        },
      })

      -- LSP capabilities
      -- vim.lsp.config("*", {
      --   capabilities = require("blink.cmp").get_lsp_capabilities(),
      -- })

      -- Diagnostics UI
      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
        virtual_lines = { enable = true, current_line = true },
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })

      -- Enable servers
      vim.lsp.enable({
        "nil_ls",
        "lua_ls",
        "ccls",
        -- "rust_analyzer",
        "pyright",
        "bashls",
        "tsserver",
        "html",
        "cssls",
        "jsonls",
        "jdtls",
        "qmlls",
      })
    end,

    wk = {
      { "<leader>l",  group = "LSP" },
      { "<leader>lg", group = "Goto" },
      { "<leader>lw", group = "Workspace" },
    },

    keys = AddKeyOpts({
      { "<leader>lgd", vim.lsp.buf.definition,      desc = "Definition" },
      { "<leader>lgD", vim.lsp.buf.declaration,     desc = "Declaration" },
      { "<leader>lgt", vim.lsp.buf.type_definition, desc = "Type definition" },
      {
        "<leader>lgn",
        function()
          vim.diagnostic.jump({ count = 1 })
        end,
        desc = "Next diagnostic",
      },
      {
        "<leader>lgp",
        function()
          vim.diagnostic.jump({ count = -1 })
        end,
        desc = "Prev diagnostic",
      },
      { "<leader>lh", vim.lsp.buf.hover,          desc = "Hover" },
      { "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature" },
      { "<leader>ln", vim.lsp.buf.rename,         desc = "Rename" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format",
      },
    }, { silent = true }),
  },
}
