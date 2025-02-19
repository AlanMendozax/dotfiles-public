return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = 8123,
        executable = {
          command = "js-debug-adapter",
        },
      }
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
          },
        }
      end
      dap.configurations.java = {
        {
          name = "Debug Launch (2GB)";
          type = 'java';
          request = 'launch';
          vmArgs = "" ..
            "-Xmx2g "
        },
        {
          name = "Debug Attach (8000)";
          type = 'java';
          request = 'attach';
          hostName = "127.0.0.1";
          port = 8000;
        },
        {
          name = "Debug Attach (5005)";
          type = 'java';
          request = 'attach';
          hostName = "127.0.0.1";
          port = 5005;
        },
        --{
          --name = "My Custom Java Run Configuration",
          --type = "java",
          --request = "launch",
          -- You need to extend the classPath to list your dependencies.
          -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
          -- classPaths = {},

          -- If using multi-module projects, remove otherwise.
          -- projectName = "yourProjectName",

          -- javaExec = "java",
          --mainClass = "replace.with.your.fully.qualified.MainClass",

          -- If using the JDK9+ module system, this needs to be extended
          -- `nvim-jdtls` would automatically populate this property
          -- modulePaths = {},
          --vmArgs = "" ..
            --"-Xmx2g "
        --},
      }
    end,
  },
  {
    -- https://github.com/mfussenegger/nvim-dap-python
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- Update the path passed to setup to point to your system or virtual env python binary
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    opts = {
      -- Display debug text as a comment
      commented = true,
      -- Customize virtual text
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
    }
  },
}
