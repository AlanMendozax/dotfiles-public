-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Sets the position of the tmux status bar globally.
-- @param position (string): The desired position for the status bar ("top" or "bottom").
local function set_tmux_status(position)
	local handle = io.popen("tmux set-option -g status-position " .. position)
	if handle then
		handle:close()
	end
end

-- Autocmds to dynamically change the position of the tmux status bar
local autocmds = {
	-- Change the position when opening/closing Neovim
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

	-- Change the position depending on the file type
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

	-- Restore the position when exiting fzf and returning to dashboard
	{
		event = "BufWinLeave",
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "fzf" then
				set_tmux_status("bottom")
			end
		end,
	},

	-- Control the position when entering/exiting the dashboard
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

-- Register all autocmds for tmux status bar position control in a group
local group = vim.api.nvim_create_augroup("TmuxStatus", { clear = true })
for _, cmd in ipairs(autocmds) do
	vim.api.nvim_create_autocmd(cmd.event, {
		group = group,
		pattern = cmd.pattern,
		callback = cmd.callback,
	})
end

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Noice plugin
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(event)
		vim.schedule(function()
			require("noice.text.markdown").keys(event.buf)
		end)
	end,
})

-- Format on save
vim.api.nvim_create_user_command("ToggleAutoformat", function()
	require("craftzdog.lsp").toggleAutoformat()
end, {})
