local keymap = vim.keymap

keymap.set("n", "<leader>pt", function()
	require("dap-python").test_class()
end, { desc = "Execute the current test class under the cursor" })

keymap.set("n", "<leader>pm", function()
	require("dap-python").test_method()
end, { desc = "Execute the current test method under the cursor" })
