local M = {}

function M.setup()
	local disabled_lsp = {
		"lua_ls",
	}

	local lspconfig = require("lspconfig")

	for _, lsp in ipairs(disabled_lsp) do
		if lspconfig[lsp] then
			lspconfig[lsp].setup({
				mason = false,
			})
		end
	end

	local mason_exclude = {
		"lua-language-server",
		"stylua",
		"ruff",
	}
	local lsp_plugin_config = require("plugins.lsp")
	local filtered_ensure_installed = vim.tbl_filter(function(tool)
		return not vim.tbl_contains(mason_exclude, tool)
	end, lsp_plugin_config.ensure_installed or {})

	require("mason").setup({
		ensure_installed = filtered_ensure_installed,
		automatic_installation = true,
	})

	local mason_lspconfig = require("mason-lspconfig")
	local filter = vim.tbl_filter(function(lsp)
		return not vim.tbl_contains(disabled_lsp, lsp)
	end, lsp_plugin_config.ensure_installed or {})

	mason_lspconfig.setup({
		ensure_installed = filter,
		automatic_installation = true,
	})
end

return M
