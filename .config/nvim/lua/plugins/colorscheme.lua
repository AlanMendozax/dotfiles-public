return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      on_highlights = function(hl, c)
        hl.Normal = { bg = "#00141a" }
        hl.DiagnosticVirtualTextWarn = { fg = c.yellow }
        hl.DiagnosticVirtualTextError = { fg = c.red }
        hl.DiagnosticVirtualTextHint = { fg = c.cyan }
        hl.DiagnosticVirtualTextInfo = { fg = c.blue }
        hl.CmpItemKindSnippet = { fg = c.base, bg = c.violet }
        hl.CmpItemKindKeyword = { fg = c.base, bg = c.red }
        hl.CmpItemKindText = { fg = c.base, bg = c.cyan }
        hl.CmpItemKindMethod = { fg = c.base, bg = c.blue }
        hl.CmpItemKindConstructor = { fg = c.base, bg = c.blue }
        hl.CmpItemKindFunction = { fg = c.base, bg = c.blue }
        hl.CmpItemKindFolder = { fg = c.base, bg = c.blue }
        hl.CmpItemKindModule = { fg = c.base, bg = c.blue }
        hl.CmpItemKindConstant = { fg = c.base, bg = c.orange }
        hl.CmpItemKindField = { fg = c.base, bg = c.green }
        hl.CmpItemKindProperty = { fg = c.base, bg = c.green }
        hl.CmpItemKindEnum = { fg = c.base, bg = c.green }
        hl.CmpItemKindUnit = { fg = c.base, bg = c.green }
        hl.CmpItemKindClass = { fg = c.base, bg = c.yellow }
        hl.CmpItemKindVariable = { fg = c.base, bg = c.magenta }
        hl.CmpItemKindFile = { fg = c.base, bg = c.blue }
        hl.CmpItemKindInterface = { fg = c.base, bg = c.yellow }
        hl.CmpItemKindColor = { fg = c.base, bg = c.red }
        hl.CmpItemKindReference = { fg = c.base, bg = c.red }
        hl.CmpItemKindEnumMember = { fg = c.base, bg = c.red }
        hl.CmpItemKindStruct = { fg = c.base, bg = c.blue }
        hl.CmpItemKindValue = { fg = c.base, bg = c.orange }
        hl.CmpItemKindEvent = { fg = c.base, bg = c.blue }
        hl.CmpItemKindOperator = { fg = c.base, bg = c.blue }
        hl.CmpItemKindTypeParameter = { fg = c.base, bg = c.blue }
      end,
    },
  },
}
