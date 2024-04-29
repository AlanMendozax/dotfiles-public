-- General purpose linters:
return {
  -- https://github.com/mfussenegger/nvim-lint
  "mfussenegger/nvim-lint",
  event = "InsertLeave",
  config = function()
    -- Define a table of linters for each filetype (not extension).
    -- Additional linters can be found here: https://github.com/mfussenegger/nvim-lint#available-linters
    require("lint").linters_by_ft = {
      python = {
        -- Add whichever linters you prefer.
        "mypy",
        "ruff",
      },
    }

    -- If you want automatically run linters after saving. Use "BufWritePost" for less aggressive linting.
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      -- Only run linter for the following extensions. Remove this to always run.
      pattern = { "*.py" },
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
