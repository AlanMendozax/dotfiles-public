local M = {}

function M.setup()
	local disabled_lsp = {
		"lua_ls",
		"clangd",
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
		"clangd",
		"selene",
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

	local function is_text_file(binary)
		local file = io.open(binary, "rb")
		if not file then
			return false
		end

		local chunk = file:read(4) or ""
		file:close()
		return not chunk:match("^\x7FELF")
	end

	local function needs_fix(binary)
		local file = io.open(binary, "r")
		if not file then
			return false
		end

		local first_line = file:read("*l") or ""
		file:close()
		return is_text_file(binary) and not first_line:match("/data/data/com.termux/")
	end

	local mason_path = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/"

	for _, binary in ipairs(vim.fn.glob(mason_path .. "*", true, true)) do
		if vim.fn.filereadable(binary) == 1 and needs_fix(binary) then
			os.execute("termux-fix-shebang " .. binary)
			vim.notify("Fixed shebang for: " .. binary .. " 😃", vim.log.levels.INFO)
		end
	end
end

return M
