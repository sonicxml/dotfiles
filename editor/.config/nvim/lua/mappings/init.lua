vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Escape in terminal Mode
vim.api.nvim_set_keymap('t', '<M-Esc>', '<C-\\><C-n>', {noremap = true})

-- Faster saving, exiting
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>x', ':x!<CR>', {noremap = true})

-- Ctrl+h to stop searching
vim.api.nvim_set_keymap('n', '<C-h>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-h>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Jump to start and end of line using the home row keys
vim.api.nvim_set_keymap('', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('', 'L', '$', {noremap = true})

-- Quick buffer switching
vim.api.nvim_set_keymap('n', '<leader><leader>', ':BufferPick<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':BufferClose<cr>', { noremap = true, silent = true })
