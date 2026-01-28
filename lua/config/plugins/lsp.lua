return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "williamboman/mason.nvim",
        config = true,
        build = ":MasonUpdate",
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = true
      },
    },
    config = function()
      require('lspconfig').util.default_config.on_init = function(client, _)
        client.server_capabilities.semanticTokensProvider = nil
      end

      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("gopls", { capabilities = capabilities })
      vim.lsp.enable("gopls")

      vim.lsp.config("templ", { capabilities = capabilities })
      vim.lsp.enable("templ")

      vim.lsp.config("tailwindcss", { capabilities = capabilities })
      vim.lsp.enable("tailwindcss")

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("jinja_lsp", { capabilities = capabilities })
      vim.lsp.enable("jinja_lsp")

      vim.lsp.config("jinja_lsp", { capabilities = capabilities })
      vim.filetype.add {
        extension = {
          njk = 'jinja'
        },
      }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, {})
      vim.keymap.set("v", "ga", vim.lsp.buf.code_action, {})
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", "eslint" },
          typescript = { "prettierd", "prettier", "eslint" },
          -- jinja = { "prettier" }
        }
      })
    end
  }
}
