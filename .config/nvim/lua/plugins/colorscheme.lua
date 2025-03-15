return {
	-- Theme
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
				on_colors = function(colors)
					colors.bg_float = "#000000"
					colors.base03 = "#000000"
					colors.base02 = "#222222"
				end,
				on_highlights = function(highlights, colors)
					highlights.CursorLine = { bg = "#222222" }
					highlights.DiagnosticVirtualTextWarn = { fg = colors.yellow500 }
					highlights.DiagnosticVirtualTextError = { fg = colors.red500 }
					highlights.DiagnosticVirtualTextHint = { fg = colors.cyan500 }
					highlights.DiagnosticVirtualTextInfo = { fg = colors.blue500 }
					highlights.FloatBorder = { fg = "#222222" }
					highlights.SnacksIndent = { fg = "#222222", nocombine = true }
					highlights.SnacksPickerBorder = { fg = "#222222" }
					highlights.TelescopePromptTitle = { fg = colors.cyan500 }
					highlights.TelescopePreviewTitle = { fg = colors.yellow500 }
					highlights.TelescopeResultsTitle = { fg = colors.orange500 }
					highlights.WinSeparator = { fg = "#222222", bold = true }
				end,
			}
		end,
	},

	get_lualine_theme = function()
		local custom_osaka = require("lualine.themes.solarized-osaka")
		custom_osaka.normal.a = { fg = "#eee8d5", bg = "#222222" }
		custom_osaka.normal.c.bg = "#000000"
		return custom_osaka
	end,

	-- Highlight text patterns
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},
}
