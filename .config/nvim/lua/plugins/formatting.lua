-- Plugin for formatting code:
return {
  "stevearc/conform.nvim",
  require("conform").setup({
    formatters_by_ft = {
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      lua = { "stylua" },
      python = { "black" },
    },
  }),
}
