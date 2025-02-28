local function set_tmux_status(position)
        local handle = io.popen("tmux set-option -g status-position " .. position)
        if handle then
                handle:close()
        end
end

local autocmds = {
        -- Cambiar barra de estado al abrir/cerrar Neovim
        {
                event = "VimEnter",
                callback = function()
                        set_tmux_status("top")
                end,
        },
        {
                event = "VimLeave",
                callback = function()
                        set_tmux_status("bottom")
                end,
        },

        -- Cambios según el tipo de archivo
        {
                event = "FileType",
                pattern = "fzf",
                callback = function()
                        set_tmux_status("top")
                end,
        },
        {
                event = "FileType",
                pattern = "snacks_dashboard",
                callback = function()
                        set_tmux_status("bottom")
                end,
        },

        -- Restaurar barra de estado al salir de fzf y regresar al dashboard
        {
                event = "BufWinLeave",
                pattern = "*",
                callback = function()
                        if vim.bo.filetype == "fzf" then
                                set_tmux_status("bottom")
                        end
                end,
        },

        -- Control al entrar/salir del dashboard
        {
                event = "BufLeave",
                pattern = "*",
                callback = function()
                        if vim.bo.filetype == "snacks_dashboard" then
                                set_tmux_status("top")
                        end
                end,
        },
        {
                event = "BufEnter",
                pattern = "*",
                callback = function()
                        if vim.bo.filetype == "snacks_dashboard" then
                                set_tmux_status("bottom")
                        end
                end,
        },
}

-- Registrar todos los autocmds en un grupo
local group = vim.api.nvim_create_augroup("TmuxStatus", { clear = true })
for _, cmd in ipairs(autocmds) do
        vim.api.nvim_create_autocmd(cmd.event, {
                group = group,
                pattern = cmd.pattern,
                callback = cmd.callback,
        })
end
-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})
