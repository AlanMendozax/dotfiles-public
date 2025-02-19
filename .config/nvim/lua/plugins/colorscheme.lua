return {
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
    },
    require("tokyonight").setup({
      on_colors = function(colors)
        colors.bg = "#000000"
        colors.bg_statusline = "#000000"
        colors.bg_float = "#000000"
        colors.bg_sidebar = "#000000"
      end,
      on_highlights = function(highlights)
        highlights.DiagnosticVirtualTextWarn = { fg = "#e0af68" }
        highlights.DiagnosticVirtualTextError = { fg = "#db4b4b" }
        highlights.DiagnosticVirtualTextHint = { fg = "#1abc9c" }
        highlights.DiagnosticVirtualTextInfo = { fg = "#0db9d7" }
      end,
    }),
  },
  get_lualine_theme = function()
    local custom_tokyo = require("lualine.themes.tokyonight-night")
    custom_tokyo.normal.c.bg = "#000000"
    return custom_tokyo
  end,
}
