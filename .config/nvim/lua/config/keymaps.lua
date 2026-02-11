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

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Tabs
keymap.set("n", "<tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
keymap.set("n", "<s-tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts, { desc = "Jump forward" })

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

-- Increment/decrement
keymap.set("n", "+", function()
	return require("dial.map").inc_normal()
end, { expr = true, desc = "Increment" })
keymap.set("n", "-", function()
	return require("dial.map").dec_normal()
end, { expr = true, desc = "Decrement" })

-- Buffers
keymap.set("n", "<leader>th", function()
	require("close_buffers").delete({ type = "hidden" })
end, { desc = "Close hidden buffers" })
keymap.set("n", "<leader>tu", function()
	require("close_buffers").delete({ type = "nameless" })
end, { desc = "Close Nameless Buffers" })

-- Zk notes
keymap.set("n", ";za", "<cmd>ZkNotes<cr>", { unpack(opts), desc = "List of all existing notes" })
keymap.set(
	"v",
	";zf",
	":'<,'>ZkMatch<cr>",
	{ unpack(opts), desc = "Search notes matching the current visual selection" }
)
keymap.set("n", ";zt", "<cmd>ZkTags<cr>", { unpack(opts), desc = "Search notes using a list of all existing tags" })
keymap.set("n", ";zo", function()
	local inp = vim.fn.input("Tags: ")
	if inp == "" then
		return
	end

	local tags = {}
	for tag in string.gmatch(inp, "([^,]+)") do
		tag = vim.trim(tag)
		if tag ~= "" then
			table.insert(tags, tag)
		end
	end

	if #tags == 0 then
		return
	end

	require("zk.commands").get("ZkNotes")({
		tags = tags,
	})
end, vim.tbl_extend("force", opts, { desc = "Search notes by a given tag" }))
keymap.set(
	"n",
	";zn",
	"<cmd>ZkNew { template = 'default.md', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new note" }
)
keymap.set(
	"n",
	";zc",
	"<cmd>ZkNew { template = 'concept.md', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new concept" }
)
keymap.set(
	"n",
	";zs",
	"<cmd>ZkNew { template = 'software-guide.md', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new software guide" }
)
keymap.set(
	"n",
	";zh",
	"<cmd>ZkNew { template = 'hardware-guide.md', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new hardware guide" }
)
keymap.set(
	"n",
	";zd",
	"<cmd>ZkNew { template = 'design-tradeoff.md', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new design-tradeoff" }
)
keymap.set(
	"n",
	";zi",
	"<cmd>ZkNew { group = 'index', title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>",
	{ unpack(opts), desc = "Create a new index" }
)
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

-- Zen mode
keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "ZenMode" })

-- Telescope
keymap.set("n", "gd", function()
	-- DO NOT REUSE WINDOW
	require("telescope.builtin").lsp_definitions({ reuse_win = false })
end, { desc = "Goto definition" })

keymap.set("n", "sf", function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions

	local function telescope_buffer_dir()
		return vim.fn.expand("%:p:h")
	end

	telescope.extensions.file_browser.file_browser({
		cwd = telescope_buffer_dir(),
		attach_mappings = function(_, map)
			-- Your custom mappings
			map("n", "N", fb_actions.create)
			map("n", "h", fb_actions.goto_parent_dir)
			map("n", "/", function()
				vim.cmd("startinsert")
			end)
			map("n", "<C-u>", function(prompt_bufnr)
				for i = 1, 10 do
					actions.move_selection_previous(prompt_bufnr)
				end
			end)
			map("n", "<C-d>", function(prompt_bufnr)
				for i = 1, 10 do
					actions.move_selection_next(prompt_bufnr)
				end
			end)
			map("n", "<PageUp>", actions.preview_scrolling_up)
			map("n", "<PageDown>", actions.preview_scrolling_down)

			return true
		end,
	})
end, { desc = "Open file browser with the path of the current buffer" })

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
