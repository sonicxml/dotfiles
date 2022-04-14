local opt = vim.opt
local cmd = vim.cmd

opt.autochdir = true
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noinsert'
opt.linebreak = false
opt.hidden = true -- Don't require writing when opening a new buffer
opt.ignorecase = true -- Ignore case when searching
opt.mouse = 'a' -- In many terminal emulators the mouse works just fine, thus enable it.
opt.number = true -- Absolute line numbers
opt.scrolloff = 7 -- Set 7 lines to the cursor - when moving vertically using j/k

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.smarttab = true

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

if vim.fn.has('termguicolors') == 1 then
    opt.termguicolors = true
end

opt.undofile = true
opt.undodir = vim.loop.os_homedir() .. '/.vimdid'

opt.updatetime = 1500


local darkmode = vim.api.nvim_eval([[ has('mac') ?  system("defaults read -g AppleInterfaceStyle") =~ '^Dark' : (strftime('%H') % 20) < 7 ]])
if darkmode == 1 then
    opt.background = 'dark'
    cmd 'colorscheme gruvbox'
else
    opt.background = 'dark'
    cmd 'colorscheme nord'
end

-- Remove trailing whitespace on save
vim.api.nvim_command('autocmd BufWritePre * :%s/\\s\\+$//e')
