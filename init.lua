require("config.lazy")
require("config.options")
require("config.keymaps")
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
require("luasnip").filetype_extend("plaintex", {"tex"})

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.jl", -- Trigger for Julia files
  callback = function()
    vim.lsp.buf.format({ async = false }) -- Format the file
    vim.cmd("write") -- Save the file
  end,
})

vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

vim.cmd[[
    " Expand snippets in insert mode with Tab
    imap <silent><expr> <Tab> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>'

    " Jump forward in through tabstops in insert and visual mode with Control-f
    imap <silent><expr> <C-n> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-n>'
    smap <silent><expr> <C-n> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-n>'
    " Jump backward through snippet tabstops with Shift-Tab (for example)
    imap <silent><expr> <C-p> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-p>'
    smap <silent><expr> <C-p> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-p>'
    " jk to move around quicker
    imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
    smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
]]

vim.keymap.set("n", "<leader>dd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.R",
    callback = function()
        vim.cmd("RFormat")
    end,
})
