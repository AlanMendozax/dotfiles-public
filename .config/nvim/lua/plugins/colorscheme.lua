return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_colors = function(colors)
				colors.bg_float = "#000000"
				colors.base03 = "#000000"
				colors.base02 = "#111111"
			end,
			on_highlights = function(highlights, colors)
				highlights.CursorLine = { bg = "#111111" }
				highlights.DiagnosticVirtualTextWarn = { fg = colors.yellow500 }
				highlights.DiagnosticVirtualTextError = { fg = colors.red500 }
				highlights.DiagnosticVirtualTextHint = { fg = colors.cyan500 }
				highlights.DiagnosticVirtualTextInfo = { fg = colors.blue500 }
				highlights.FloatBorder = { fg = "#222222" }
				highlights.SnacksIndent = { fg = "#222222", nocombine = true }
				highlights.SnacksPickerBorder = { fg = "#222222" }
				highlights.WinSeparator = { fg = "#222222", bold = true }
			end,
		},
		config = function(_, opts)
			_G.get_lualine_theme = function()
				local custom_osaka = require("lualine.themes.solarized-osaka")
				custom_osaka.normal.a = { fg = "#eee8d5", bg = "#222222" }
				custom_osaka.normal.c.bg = "#000000"
				return custom_osaka
			end
			require("solarized-osaka").setup(opts)
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
