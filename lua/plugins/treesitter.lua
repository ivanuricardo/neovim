return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").setup()

      require("nvim-treesitter").install({
        "lua",
        "julia",
        "python",
        "vim",
        "bash",
        "r",
        "markdown",
        "rnoweb",
        "yaml",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "julia",
          "python",
          "vim",
          "bash",
          "r",
          "markdown",
          "rnoweb",
          "yaml",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
