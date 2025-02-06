return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require("null-ls")

      -- Attempt to load the Julia formatter
      local ok, julia = pcall(require, "plugins.null-ls.julia")
      if not ok then
        print("Julia formatter not found.")
      end

      -- Set up null-ls with sources
      null_ls.setup({
        sources = {
          -- Lua formatting with Stylua
          null_ls.builtins.formatting.stylua,

          -- Spell-check suggestions
          null_ls.builtins.completion.spell,

          -- ESLint diagnostics
          require("none-ls.diagnostics.eslint"),

          -- Add Julia formatter if loaded successfully
          ok and julia or nil,
        },
      })
    end,
  },
}
