local M = {}

function M.setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"pyright",
		},
	})

	vim.lsp.config("pyright", {
		single_file_support = true,
	})
end

return M
