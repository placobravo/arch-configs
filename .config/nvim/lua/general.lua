vim.opt.clipboard="unnamedplus"
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cmdheight = 0
vim.opt.autochdir = true
vim.opt.expandtab = true

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- configure backup and swap

-- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks
vim.opt.breakindent = false
vim.opt.breakindentopt = "shift:0,sbr"

-- String to put at the start of lines that have been wrapped.
vim.opt.showbreak = "   →"

