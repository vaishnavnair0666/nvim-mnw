return {
  "nvim-telescope/telescope.nvim",

  -- lz.n: plugin + extensions already installed by npins (start.json)
  after = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        layout_strategy = "flex",
        sorting_strategy = "ascending",

        layout_config = {
          prompt_position = "top",
          height = 0.94,
          width = 0.90,
        },

        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰",
        },

        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist",
          "build",
        },
      },

      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
        },
      },
    })

    -- Extensions are guaranteed to exist (start.json)
    telescope.load_extension("media_files")
    telescope.load_extension("undo")
  end,

  -- Telescope-only keybinds
  keys = {
    -- core telescope
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Help",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Document symbols",
    },
    {
      "<leader>fS",
      function()
        require("telescope.builtin").lsp_workspace_symbols()
      end,
      desc = "Workspace symbols",
    },

    -- extensions
    {
      "<leader>fu",
      function()
        require("telescope").extensions.undo.undo()
      end,
      desc = "Undo tree",
    },
    {
      "<leader>fm",
      function()
        require("telescope").extensions.media_files.media_files()
      end,
      desc = "Media files",
    },
    -- Git
    {
      "<leader>fc",
      function()
        require("telescope.builtin").git_commits()
      end,
      desc = "Git commits",
    },
    {
      "<leader>fB",
      function()
        require("telescope.builtin").git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>fT",
      function()
        require("telescope.builtin").git_stash()
      end,
      desc = "Git stash",
    },

    -- Editor introspection
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fC",
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>fj",
      function()
        require("telescope.builtin").jumplist()
      end,
      desc = "Jumplist",
    },
  },
}
