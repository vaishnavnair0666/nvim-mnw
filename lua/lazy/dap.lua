return {
  {
    "nvim-dap",
    lazy = false,
  },

  {
    "nvim-dap-ui",
    lazy = false,
    dependencies = { "nvim-dap" },

    wk = {
      { "<leader>d",  group = "Debug" },
      { "<leader>du", desc = "Toggle UI" },
      { "<leader>db", desc = "Toggle breakpoint" },
      { "<leader>dc", desc = "Continue" },
      { "<leader>do", desc = "Step over" },
      { "<leader>di", desc = "Step into" },
      { "<leader>dO", desc = "Step out" },
      { "<leader>dr", desc = "Open REPL" },
    },

    after = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- UI lifecycle (guarded)
      dap.listeners.after.event_initialized["dapui"] = function(session)
        if session then
          dapui.open()
        end
      end
      dap.listeners.before.event_terminated["dapui"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui"] = function()
        dapui.close()
      end

      require("dap").adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }

      require("dap").configurations.cpp = {
        {
          cwd = "${workspaceFolder}",
          name = "Launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          request = "launch",
          stopOnEntry = false,
          type = "lldb",
        },
      }

      -- Keymaps
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end)
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>do", dap.step_over)
      vim.keymap.set("n", "<leader>di", dap.step_into)
      vim.keymap.set("n", "<leader>dO", dap.step_out)
      vim.keymap.set("n", "<leader>dr", dap.repl.open)
    end,
  },

  {
    "nvim-dap-virtual-text",
    lazy = false,
    dependencies = { "nvim-dap" },
    after = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
