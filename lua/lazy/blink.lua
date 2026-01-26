return {
  { "lspkind.nvim" },
  {
    "blink.cmp",
    dependencies = {
      "blink-emoji.nvim",
      "blink-ripgrep.nvim",
      "blink-cmp-dictionary",
      "blink-cmp-words",
    },
    event = "DeferredUIEnter",
    before = function()
      LZN.trigger_load("lazydev.nvim")
      LZN.trigger_load("lspkind.nvim")
    end,
    after = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      require("blink.cmp").setup({
        signature = { enabled = true },
        completion = {
          menu = {
            auto_show = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ctx.kind_icon
                    if ctx.source_name == "Path" then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        icon = dev_icon
                      end
                    else
                      icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                      })
                    end

                    return icon .. ctx.icon_gap
                  end,

                  -- Optionally, use the highlight groups from nvim-web-devicons
                  -- You can also add the same function for `kind.highlight` if you want to
                  -- keep the highlight groups in sync with the icons.
                  highlight = function(ctx)
                    local hl = ctx.kind_hl
                    if ctx.source_name == "Path" then
                      local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        hl = dev_hl
                      end
                    end
                    return hl
                  end,
                },
              },
              treesitter = { "lsp" },
            },
          },
          ghost_text = { enabled = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
        keymap = {
          preset = "none",
          ["<c-d>"] = {
            function()
              require("blink.cmp").show({ providers = { "dictionary" } })
              vim.notify("dictionary")
            end,
          },
          ["<C-w>"] = {
            function()
              require("blink.cmp").show({ providers = { "wordsdictionary" } })
              vim.notify("words dictionary")
            end,
          },
          ["<C-x>"] = {
            function()
              require("blink.cmp").show({ providers = { "thesaurus" } })
              vim.notify("thesaurus")
            end,
          },
          ["<C-a>"] = {
            function()
              require("blink.cmp").show({ providers = { "emoji" } })
              vim.notify("emoji")
            end,
          },
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-h>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          ["<Up>"] = { "snippet_forward", "fallback" },
          ["<Down>"] = { "snippet_backward", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        sources = {
          default = {
            "lazydev",
            "lsp",
            "buffer",
            "snippets",
            "path",
            "ripgrep",
            "dictionary",
          },
          providers = {
            thesaurus = {
              name = "blink-cmp-words",
              module = "blink-cmp-words.thesaurus",
              score_offset = 0,
              opts = {
                definition_pointers = { "!", "&", "^" },
                similarity_pointers = { "&", "^" },
                similarity_depth = 2,
                filetypes = { "markdown", "text" },
              },
            },
            wordsdictionary = {
              name = "blink-cmp-words",
              module = "blink-cmp-words.dictionary",
              score_offset = 0,
              opts = {
                dictionary_search_threshold = 3,
                definition_pointers = { "!", "&", "^" },
                filetypes = { "markdown", "text", "gitcommit" },
              },
            },
            ripgrep = {
              module = "blink-ripgrep",
              name = "Ripgrep",
              score_offset = -15,
              opts = {
                prefix_min_len = 3,
                project_root_marker = ".git",
                fallback_to_regex_highlighting = true,
                backend = {
                  use = "gitgrep-or-ripgrep",
                  ripgrep = {
                    context_size = 5,
                    max_filesize = "1M",
                    project_root_fallback = true,
                    search_casing = "--ignore-case",
                    additional_rg_options = {},
                    ignore_paths = {},
                    additional_paths = {},
                  },
                },
                gitgrep = {
                  additional_gitgrep_options = {},
                },
              },
            },
            dictionary = {
              module = "blink-cmp-dictionary",
              name = "Dict",
              min_keyword_length = 3,
              score_offset = -20,
              opts = { filetypes = { "markdown", "text", "gitcommit" } },
            },
            emoji = {
              module = "blink-emoji",
              name = "Emoji",
              score_offset = 15,
              opts = {
                insert = true,
                ---@type string|table|fun():table
                trigger = function()
                  return { ":" }
                end,
              },
            },
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end,
  },
}
