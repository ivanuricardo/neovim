local api = vim.api

api.nvim_set_keymap("t", "<A-h>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
api.nvim_set_keymap("t", "<A-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
api.nvim_set_keymap("t", "<A-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
api.nvim_set_keymap("t", "<A-l>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })

api.nvim_set_keymap("n", "<A-h>", "<C-w>h", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<A-j>", "<C-w>j", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<A-k>", "<C-w>k", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<A-l>", "<C-w>l", { noremap = true, silent = true })

api.nvim_set_keymap("n", "<CR>", ":SlimeSend<CR>j", { noremap = true, silent = true })

-- Key mappings for Language Client actions
api.nvim_set_keymap("n", "K", ":call LanguageClient_textDocument_hover()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "gd", ":call LanguageClient_textDocument_definition()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<F2>", ":call LanguageClient_textDocument_rename()<CR>", { noremap = true, silent = true })

-- Map <Tab> to :bnext
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })

-- Map <S-Tab> to :bprev
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

