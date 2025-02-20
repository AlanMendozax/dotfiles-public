return {
  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {},
  },

  --completion
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      opts.sources = {
        { name = "emoji" },
        { name = "path" },
      }
    end,
  },
}
