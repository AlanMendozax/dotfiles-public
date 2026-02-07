return {
	-- Visual navigation to a word or position within a file
	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},

	-- Interface to interact with Git directly within Neovim
	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {},
	},

	-- Interactive search and filtering in Neovim
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},

		config = function(_, opts)
			local telescope = require("telescope")

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = true,
					initial_mode = "normal",
					layout_config = { height = 40 },
					theme = "dropdown",

					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},

	-- Buffer management
	{
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
	},

	-- Autocomplete plugin
	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					winblend = vim.o.pumblend,
				},
			},
			signature = {
				window = {
					winblend = vim.o.pumblend,
				},
			},
		},
	},

	-- Plain text note-taking assistant
	{
		"zk-org/zk-nvim",
		config = function()
			require("zk").setup({
				picker = "telescope",
			})
		end,
	},
}
