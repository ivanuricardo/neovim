return {
  -- 1) nvim-cmp setup
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- Provides LSP source for nvim-cmp
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
        },
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },

  -- 2) nvim-lspconfig setup
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          underline = true,
          signs = false,
          update_in_insert = true,
        })

      -- Basic on_attach: sets up omnifunc, etc.
      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      -- Setup for R language server
      lspconfig.r_language_server.setup({
        cmd = { "R", "--slave", "-e", "languageserver::run()" },
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          -- Define a suitable root directory for your R projects
          local path = vim.fs.find({ ".git", "DESCRIPTION" }, { path = fname, upward = true })[1]
          return path and vim.fs.dirname(path) or vim.fs.dirname(fname) or vim.fn.getcwd()
        end,
        settings = {
          r = {
            lsp = {
              trace = { server = "verbose" },
            },
          },
        },
      })

      -- Example: setup for Julia LS
      lspconfig.julials.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
