return {
  -- Mason package manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "julials" }, -- Automatically install Julia language server
        automatic_installation = true,    -- Optional: Automatically install servers
      })

      -- Set up Julia LSP server using lspconfig
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,

        -- Custom configuration for Julia LSP
        ["julials"] = function()
          lspconfig.julials.setup({
            cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", [[
              import LanguageServer; import Pkg;
              server = LanguageServer.LanguageServerInstance(
                stdin, stdout, false,
                Base.CurrentEnv().pwd(),
                nothing,
              );
              server.runlinter = true;
              server.run()
            ]] },
            root_dir = lspconfig.util.root_pattern(".git", "Project.toml"),
            settings = {
              julia = {
                format = {
                  enable = true,
                },
              },
            },
          })
        end,
      })
    end,
  },
}
