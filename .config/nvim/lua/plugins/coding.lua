return {
  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  --completion
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
    },
    opts = function(_, opts)
      opts.sources = {
        { name = "emoji" },
        { name = "luasnip" },
        { name = "path" },
      }
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      opts.window = {
        completion = {
          winhighlight = "Normal:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
        documentation = require("cmp").config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
        }),
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "(" .. (strings[2] or "") .. ")"

          return kind
        end,
      }
      opts.view = {
        entries = { name = "custom", selction_order = "near_cursor" },
      }
    end,
  },
}
