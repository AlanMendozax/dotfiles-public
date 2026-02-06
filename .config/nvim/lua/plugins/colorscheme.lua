return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
				on_colors = function(colors)
					colors.bg_float = "#1c1c1f"
					colors.base03 = "#1c1c1f"
					colors.base02 = "#444444"
				end,
				on_highlights = function(highlights, colors)
					highlights.BlinkCmpMenu = { bg = "#222222" }
					highlights.CursorLine = { bg = "#222222" }
					highlights.DiagnosticVirtualTextWarn = { fg = colors.yellow500 }
					highlights.DiagnosticVirtualTextError = { fg = colors.red500 }
					highlights.DiagnosticVirtualTextHint = { fg = colors.cyan500 }
					highlights.DiagnosticVirtualTextInfo = { fg = colors.blue500 }
					highlights.FloatBorder = { fg = "#222222" }
					highlights.SnacksIndent = { fg = "#444444", nocombine = true }
					highlights.SnacksPickerListCursorLine = { bg = "#222222" }
					highlights.TabLineFill = { bg = "#1c1c1f" }
					highlights.TelescopePromptTitle = { fg = colors.cyan500 }
					highlights.TelescopePreviewTitle = { fg = colors.yellow500 }
					highlights.TelescopeResultsTitle = { fg = colors.orange500 }
					highlights.TelescopeSelection = { bg = "#222222" }
					highlights.Visual = { bg = "#444444" }
				end,
			}
		end,
	},
}
