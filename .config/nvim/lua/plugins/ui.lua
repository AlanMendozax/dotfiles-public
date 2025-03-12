return {
	-- Messages, cmdline and the popupmenu
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

	-- Notifications
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",

		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
			opts.sections.lualine_z = { "encoding" }
		end,
	},

	-- Distraction-free work mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
	},

	-- Preview markdown files
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},

	-- User interface
	{
		"folke/snacks.nvim",
		opts = {
			scroll = { enabled = false },
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
		keys = {},
	},

	ui = {
		icons = {
			package_installed = " ",
			package_uninstalled = "󰚌 ",
			package_pending = "➜",
		},
		border = "rounded",
		height = 0.8,
	},
}
