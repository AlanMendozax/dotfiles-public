-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function set_tmux_status(position)
  local handle = io.popen(string.format("tmux set-option -g status-position %s", position))
  if handle then
    handle:close()
  end
end

-- Cambiar barra de estado al abrir Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_tmux_status("top")
  end,
})

-- Cambiar barra de estado al salir de Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    set_tmux_status("bottom")
  end,
})

-- Cuando se entra a fzf, mover tmux al top
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function()
    set_tmux_status("top")
  end,
})

-- Cuando se entra al dashboard, mover tmux al bottom
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_dashboard",
  callback = function()
    set_tmux_status("bottom")
  end,
})

-- Cuando se sale de fzf y regresa al dashboard, mover tmux al bottom
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "fzf" then
      set_tmux_status("bottom")
    end
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "snacks_dashboard" then
      set_tmux_status("top")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "snacks_dashboard" then
      set_tmux_status("bottom")
    end
  end,
})
