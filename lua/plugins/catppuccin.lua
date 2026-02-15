-- lua/plugins/rose-pine.lua
-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		vim.cmd("colorscheme rose-pine")
-- 	end
-- }

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local transparent_background = false -- change if you want transparency
      local clear = {}

      -- Set flavor before setup
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

      require("catppuccin").setup({
        background = { light = "latte", dark = "mocha" },
        transparent_background = transparent_background,
        dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
        show_end_of_buffer = false,
        term_colors = true,
        styles = {
          comments = { "italic" },
          functions = { "bold" },
          keywords = { "italic" },
          operators = { "bold" },
          conditionals = { "bold" },
          loops = { "bold" },
          booleans = { "bold", "italic" },
        },
        highlight_overrides = {
          all = function(cp)
            return {
              NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
              FloatBorder = { fg = transparent_background and cp.blue or cp.mantle, bg = transparent_background and cp.none or cp.mantle },
              CursorLineNr = { fg = cp.green },
              -- optionally add a few more key UI highlights if you want
            }
          end,
        },
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}



