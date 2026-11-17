return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "williamboman/mason.nvim",
        config = true,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "ts_ls",
            "tailwindcss",
            "gopls",
            "templ",
          },
          automatic_installation = true,
        },
      },
    },
    config = function()
      -- Automatically install and configure servers
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Set default capabilities (Blink CMP) across all LSP servers
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Buffer-local keymaps & disable semantic tokens on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end

          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
          vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
        end,
      })

      -- Filetypes
      vim.filetype.add({
        extension = {
          njk = "jinja",
        },
      })

      -- Enable servers
      local servers = { "lua_ls", "gopls", "templ", "tailwindcss", "ts_ls", "jinja_lsp" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", "eslint" },
          typescript = { "prettierd", "prettier", "eslint" },
        },
      })
    end,
  },
}
