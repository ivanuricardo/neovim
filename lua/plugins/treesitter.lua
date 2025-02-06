return {
  -- Lazy manager bootstrapping omitted for brevity

  -- 1. Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- Ensures parsers are installed/updated
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Make sure "julia" is on the list of parsers you want installed
        ensure_installed = { "lua", "julia", "python", "vim", "bash", "r" },
        highlight = { enable = true },
      })
    end,
  },
}
