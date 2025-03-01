return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			on_colors = function(colors)
				colors.bg_statusline = "#000000"
				colors.bg_float = "#000000"
				colors.bg_sidebar = "#000000"
			end,
			on_highlights = function(highlights, colors)
				highlights.DiagnosticVirtualTextWarn = { fg = colors.yellow500 }
				highlights.DiagnosticVirtualTextError = { fg = colors.red500 }
				highlights.DiagnosticVirtualTextHint = { fg = colors.cyan500 }
				highlights.DiagnosticVirtualTextInfo = { fg = colors.blue500 }
			end,
		},
		config = function(_, opts)
			require("solarized-osaka").setup(opts)
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
