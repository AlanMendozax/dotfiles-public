-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", function()
	return require("dial.map").inc_normal()
end, { expr = true, desc = "Increment" })
keymap.set("n", "-", function()
	return require("dial.map").dec_normal()
end, { expr = true, desc = "Decrement" })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Zen mode
keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "ZenMode" })

-- Tabs
keymap.set("n", "<tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
keymap.set("n", "<s-tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })

-- Buffers
keymap.set("n", "<leader>th", function()
	require("close_buffers").delete({ type = "hidden" })
end, { desc = "Close hidden buffers" })
keymap.set("n", "<leader>tu", function()
	require("close_buffers").delete({ type = "nameless" })
end, { desc = "Close Nameless Buffers" })

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end, { desc = "Replace HEX with HSL" })

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

-- Telescope
local keys = require("lazyvim.plugins.lsp.keymaps").get()
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

vim.list_extend(keys, {
	{
		"gd",
		function()
			-- DO NOT REUSE WINDOW
			require("telescope.builtin").lsp_definitions({ reuse_win = false })
		end,
		desc = "Goto definition",
		has = "definition",
	},
	{
		"sf",
		function()
			local telescope = require("telescope")

			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end

			telescope.extensions.file_browser.file_browser({
				cwd = telescope_buffer_dir(),
				respect_gitignore = false,
				hidden = true,
				grouped = true,
				previewer = false,
				initial_mode = "normal",
				layout_config = { height = 40 },
			})
		end,
		desc = "Open file browser with the path of the current buffer",
	},
})

keymap.set("n", "<leader>fP", function()
	require("telescope.builtin").find_files({
		cwd = require("lazy.core.config").options.root,
	})
end, { desc = "Find plugin file" })
keymap.set("n", ";f", function()
	local builtin = require("telescope.builtin")
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end, { desc = "Lists files in your current working directory, respects .gitignore" })
keymap.set("n", ";r", function()
	local builtin = require("telescope.builtin")
	builtin.live_grep({
		additional_args = { "--hidden" },
	})
end, {
	desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
})
keymap.set("n", "\\\\", function()
	local builtin = require("telescope.builtin")
	builtin.buffers()
end, { desc = "Lists open buffers" })
keymap.set("n", ";t", function()
	local builtin = require("telescope.builtin")
	builtin.help_tags()
end, { desc = "Lists available help tags and opens a new window with the relevant help info on <cr>" })
keymap.set("n", ";;", function()
	local builtin = require("telescope.builtin")
	builtin.resume()
end, { desc = "Resume the previous telescope picker" })
keymap.set("n", ";e", function()
	local builtin = require("telescope.builtin")
	builtin.diagnostics()
end, { desc = "Lists diagnostics for all open buffers or a specific buffer" })
keymap.set("n", ";s", function()
	local builtin = require("telescope.builtin")
	builtin.treesitter()
end, { desc = "Lists function names, variables, from Treesitter" })

-- Telescope file browser
-- keymap.set("n", "N", function()
-- 	fb_actions.create()
-- end, { desc = "Create file/directory" })
-- keymap.set("n", "h", function()
-- 	fb_actions.goto_parent_dir()
-- end, { desc = "Goto parent dir" })
-- keymap.set("n", "/", function()
-- 	vim.cmd("startinsert")
-- end, { desc = "Insert mode in search" })
-- keymap.set("n", "<C-u>", function()
-- 	local picker = require("telescope.actions.state").get_current_picker(vim.api.nvim_get_current_buf())
-- 	for i = 1, 10 do
-- 		actions.move_selection_previous(picker)
-- 	end
-- end, { desc = "Move selection up" })
-- keymap.set("n", "<C-d>", function()
-- 	local picker = require("telescope.actions.state").get_current_picker(vim.api.nvim_get_current_buf())
-- 	for i = 1, 10 do
-- 		actions.move_selection_next(picker)
-- 	end
-- end, { desc = "Move selection down" })
-- keymap.set("n", "<PageUp>", function()
-- 	actions.preview_scrolling_up()
-- end, { desc = "Scroll up" })
-- keymap.set("n", "<PageDown>", function()
-- 	actions.preview_scrolling_down()
-- end, { desc = "Scroll down" })
