if os.execute("ps aux | grep -v grep | grep Xvnc > /dev/null") ~= 0 then
	require("termux.colorscheme").setup()
end
