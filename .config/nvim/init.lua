vim.opt.clipboard="unnamedplus"
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


-- configure backup and swap

-- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks
vim.opt.breakindent = false
vim.opt.breakindentopt = "shift:0,sbr"

-- String to put at the start of lines that have been wrapped.
vim.opt.showbreak = "   →"

-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.hlsearch = false
-- vim.opt.breakindent = true
-- vim.opt.expandtab = true
-- vim.opt.smarttab = true



vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')






local lazy = {}

function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    if vim.g.plugins_ready then
      return
    end

    -- You can "comment out" the line below after lazy.nvim is installed
    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)

    require('lazy').setup(plugins, lazy.opts)
    vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
    { 
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
        }
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            theme = "auto",
        }
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { 'bash-language-server', 'pylsp', 'marksman', 'lua_ls' },
        }
    },
    {
        "neovim/nvim-lspconfig",
    },
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('catppuccin')
require('lualine').setup()

require('lsp')
