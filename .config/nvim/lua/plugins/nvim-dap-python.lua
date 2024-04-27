return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
  },
  {
    -- https://github.com/mfussenegger/nvim-dap-python
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
     'mfussenegger/nvim-dap',
     'rcarriga/nvim-dap-ui',
    },
    config = function (_, opts)
      -- Update the path passed to setup to point to your system or virtual env python binary
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require('dap-python').setup(path)
    end,
  },
}
