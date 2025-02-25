-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function set_tmux_status(position)
	local handle = io.popen("tmux set-option -g status-position " .. position)
	if handle then
		handle:close()
	end
end

local autocmds = {
	-- Cambiar barra de estado al abrir/cerrar Neovim
	{
		event = "VimEnter",
		callback = function()
			set_tmux_status("top")
		end,
	},
	{
		event = "VimLeave",
		callback = function()
			set_tmux_status("bottom")
		end,
	},

	-- Cambios según el tipo de archivo
	{
		event = "FileType",
		pattern = "fzf",
		callback = function()
			set_tmux_status("top")
		end,
	},
	{
		event = "FileType",
		pattern = "snacks_dashboard",
		callback = function()
			set_tmux_status("bottom")
		end,
	},

	-- Restaurar barra de estado al salir de fzf y regresar al dashboard
	{
		event = "BufWinLeave",
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "fzf" then
				set_tmux_status("bottom")
			end
		end,
	},

	-- Control al entrar/salir del dashboard
	{
		event = "BufLeave",
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "snacks_dashboard" then
				set_tmux_status("top")
			end
		end,
	},
	{
		event = "BufEnter",
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "snacks_dashboard" then
				set_tmux_status("bottom")
			end
		end,
	},
}

-- Registrar todos los autocmds en un grupo
local group = vim.api.nvim_create_augroup("TmuxStatus", { clear = true })
for _, cmd in ipairs(autocmds) do
	vim.api.nvim_create_autocmd(cmd.event, {
		group = group,
		pattern = cmd.pattern,
		callback = cmd.callback,
	})
end

vim.g.ui_focused = true

vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		vim.g.ui_focused = true
	end,
})

vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		vim.g.ui_focused = false
	end,
})
