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
  end,
}
