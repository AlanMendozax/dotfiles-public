-- Plugin for formatting code:
return {
  {
    -- https://github.com/sbdchd/neoformat
    'sbdchd/neoformat',
    event = "BufWritePre",
    config = function ()
      vim.g.neoformat_enabled_javascript = {"prettier"}
      vim.g.neoformat_enabled_typescript = {"prettier"}
      vim.g.neoformat_enabled_html = {"prettier"}
      vim.g.neoformat_enabled_css = {"prettier"}
      vim.g.neoformat_enabled_python = {"black"}
      vim.cmd([[
         augroup fmt
           autocmd!
           autocmd BufWritePre * silent Neoformat
         augroup END
      ]])
  end
  },
}
