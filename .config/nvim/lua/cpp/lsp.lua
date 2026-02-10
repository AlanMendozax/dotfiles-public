local M = {}

function M.setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"clangd",
		},
	})

	vim.lsp.config("clangd", {
		cmd = { "clangd" },
	})

	require("nvim-treesitter").setup({
		ensure_installed = {
			"c",
			"cpp",
			"cmake",
			"make",
		},
	})
end

return M
