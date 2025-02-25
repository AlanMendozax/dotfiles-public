return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not vim.g.ui_focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			opts.presets.lsp_doc_border = true
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",

		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
			},
		},
	},

	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[

      ██═╗      ████████████████╗
     ████╚╗     ╚══════██╔════██║
    ██╔═██╚╗    ██╗    ██║    ██║
   ██╔╝  ██╚╗   ██║    ██║    ██║
   ╚═╝    ██╚╗  ██║    ██║    ██║
 ██╗       ██╚╗ ██║    ██║    ██║
██╔╝        ██║ ██║    ██║    ██║
╚═╝         ╚═╝ ╚═╝    ╚═╝    ╚═╝
      ]],
				},
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function(_, opts)
			local colorscheme = require("plugins.colorscheme")
			opts.options.theme = colorscheme.get_lualine_theme()
			opts.sections.lualine_z = { "encoding" }
		end,
	},
}
