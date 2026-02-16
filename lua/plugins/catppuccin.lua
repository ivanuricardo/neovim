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
        flavour = "mocha",
        color_overrides = {
  	mocha = {
  	  base = "#1d181e",     -- background base
  	  mantle = "#2a232d",   -- secondary background
  	  crust = "#11111b",    -- darkest background
  	  text = "#cdd6f4",     -- main foreground text
  	  rosewater = "#f5e0dc", -- adjust highlights
  	  flamingo = "#f2cdcd",
  	  pink = "#f5c2e7",
  	  mauve = "#89b4fa",
  	  red = "#f38ba8",
  	  maroon = "#eba0ac",
  	  peach = "#fab387",
  	  yellow = "#f9e2af",
  	  green = "#aaf7a6",
  	  teal = "#94e2d5",
  	  sky = "#89dceb",
  	  sapphire = "#74c7ec",
  	  blue = "#cba6f7",
  	  lavender = "#b4befe",
  	},
        },
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}



