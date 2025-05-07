return {
  -- Mason package manager (now under mason-org)
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason-registry",
    },
    config = function()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup({
        ensure_installed = { "julials" },
        automatic_installation = true,
        -- New handler configuration format
        handlers = {
          -- Default handler
          function(server_name)
            lspconfig[server_name].setup({})
          end,

          -- Custom Julia configuration
          julials = function()
            lspconfig.julials.setup({
              cmd = {
                "julia",
                "--startup-file=no",
                "--history-file=no",
                "-e", [[
                  using LanguageServer
                  using StaticLint
                  server = LanguageServerInstance(stdin, stdout, Base.ARGS[3])
                  server.runlinter = true
                  run(server)
                ]],
                vim.fn.expand("$MASON/share/julia-environment"),
              },
              root_dir = lspconfig.util.root_pattern(".git", "Project.toml"),
              settings = {
                julia = {
                  format = { enable = true },
                  environmentPath = vim.fn.expand("$MASON/share/julia-environment"),
                },
              },
            })
          end,
        }
      })
    end,
  },
}
