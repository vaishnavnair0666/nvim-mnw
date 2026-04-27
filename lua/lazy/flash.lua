return {
  {
    "flash.nvim",
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        function()
          require("flash").remote()
        end,
        desc = "Flash remote",
        mode = "o",
      },
      {
        "R",
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter search",
        mode = { "o", "x" },
      },
      {
        "<c-s>",
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash",
        mode = { "c" },
      },
    },

    after = function()
      require("flash").setup({
        labels = "asdfghjklqwertyuiopzxcvbnm",

        search = {
          multi_window = true,
          forward = true,
          wrap = true,
        },

        jump = {
          jumplist = true,
        },

        modes = {
          char = {
            enabled = true,
            jump_labels = true,
          },
        },
      })
    end,
  },
}
