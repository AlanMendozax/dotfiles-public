if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- Check if we are in Termux and load the configuration
if vim.uv.fs_stat("/data/data/com.termux") then
	require("config.termux")
end
