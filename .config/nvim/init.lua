if vim.loader then
	vim.loader.enable()
end

require("config.lazy")

local profile = vim.env.NVIM_PROFILE
if profile == "cpp" then
	require("config.cpp")
elseif profile == "py" then
	require("config.python")
end
