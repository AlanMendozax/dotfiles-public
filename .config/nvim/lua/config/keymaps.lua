-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap

-- Window navigation
keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>")
keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>")
keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>")

-- Add a breakpoint for debugging
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")

-- Create a test class
keymap.set("n", "<leader>tc", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_class()
  end
end)

--create a test method
keymap.set("n", "<leader>tm", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_method()
  end
end)
