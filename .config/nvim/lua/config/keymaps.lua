-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Refactoring tool
keymap.set("v","<leader>r", function()
  require("refactoring").select_refactor()
end, { noremap = true, silent = true, expr = false, desc = "Refactoring" })

-- Format code
keymap.set({ "n", "v" }, "<leader>mp", function()
  require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- Window navigation
keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>")
keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>")
keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>")

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- Put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- Get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- Get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- Next diff hunk
keymap.set("n", "<leader>cp", "[c") -- Previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- Open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- Jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- Jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- Jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- Jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- Close quickfix list

-- Debugging
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>") -- Add a breakpoint for debugging
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>") -- Add a breakpoint with a condition for debugging
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>") -- Run or continue the debugger

-- Create a test class for Python
keymap.set("n", "<leader>ptc", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_class()
  end
end)

--create a test method for Python
keymap.set("n", "<leader>ptm", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_method()
  end
end)

-- Organize imports for Java
keymap.set("n", "<leader>jgo", function()
  if vim.bo.filetype == "java" then
    require("jdtls").organize_imports()
  end
end)

-- Update projects config for Java
keymap.set("n", "<leader>jgu", function()
  if vim.bo.filetype == "java" then
    require("jdtls").update_projects_config()
  end
end)

-- Create a test class for Java
keymap.set("n", "<leader>jtc", function()
  if vim.bo.filetype == "java" then
    require("jdtls").test_class()
  end
end)

-- Create a test method for Java
keymap.set("n", "<leader>jtm", function()
  if vim.bo.filetype == "java" then
    require("jdtls").test_nearest_method()
  end
end)
