-------------------------------------------------------------------------------
-- File: init.lua
--
-- Author: Umut Sevdi
-- Created: 04/07/22
-------------------------------------------------------------------------------

vim.cmd [[ set t_Co=256 ]]
vim.o.shell = os.getenv("SHELL")
vim.o.encoding = "UTF-8"
vim.o.syntax = "on"
vim.o.cmdheight = 1
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.showtabline = 0
vim.o.foldmethod = "manual"
vim.o.mousemodel = "extend"
vim.o.inccommand = "nosplit"
vim.o.conceallevel = 0
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.spell = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.opt.showmode = false
vim.o.colorcolumn = "80"

vim.schedule(function()
    vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 200
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.cursorline = true
vim.opt.scrolloff = 10
vim.opt.inccommand = 'split'
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.history = 50
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.textwidth = 120
vim.o.jumpoptions = "view"
vim.o.winborder = 'none'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
    {
        'LudoPinelli/comment-box.nvim',
        { 'm4xshen/autoclose.nvim',          opts = {} },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
        'lewis6991/gitsigns.nvim',
        opts = {
            signs              = {
                change       = { text = '┇' },
                changedelete = { text = '╍' },
                untracked    = { text = '┊' },
            },
            current_line_blame = true,
        },
        { "vigoux/notifier.nvim", opts = {} },
    },
    {
        "EdenEast/nightfox.nvim",
        opts = {
            options = {
                transparent = true,
                styles = {
                    comments = "italic",
                    constants = "bold",
                    functions = "bold,italic",
                    keywords = "NONE",
                    types = "bold",
                },
            },
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        opts = { defaults = { layout_config = { vertical = { width = 0.5 } } } },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            { "folke/todo-comments.nvim", opts = {} },
        },
        cmd = { "Telescope" },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        cmd = { "Oil" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        }
    },
    {
        'saghen/blink.cmp',
        dependencies = { {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
        } },
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- C-space: Open menu or open docs if already open
            -- C-y: accept
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            keymap = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'snippets', 'lsp', 'path', 'buffer' },
            },
            snippets = { preset = 'luasnip' },
        },
        opts_extend = { "sources.default" }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            completions = { lsp = { enabled = true } },
            code = {
                position = 'right',
                width = 'block',
                left_pad = 1,
                language_pad = 2,
                right_pad = 1,
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                disabled_filetypes = {
                    winbar = {}
                },
                globalstatus = true
            },
            sections = {
                lualine_a = { 'mode', },
                lualine_b = { 'filename' },
                lualine_c = { 'branch', 'diff' },
                lualine_x = { 'diagnostics' },
                lualine_y = { 'tabs' },
                lualine_z = { 'location' },
            }
        }
    }
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.dotfiles/nvim/snippets/" } })

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('blink.cmp').get_lsp_capabilities()
)

require('mason').setup {}
require('mason-lspconfig').setup {
    ensure_installed = {
        'astro', 'bashls', 'clangd', 'cssls',
        'cmake', 'gopls', 'grammarly', 'html', 'lua_ls',
        'pylsp', 'rust_analyzer', 'ts_ls',
    },
    handlers = { function(srvr)
        require('lspconfig')[srvr].setup { diagnostics = { enable = true, } }
    end,
    }
}
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    ensure_installed = {
        "c", "cmake", "comment", "cpp", "dart", "dockerfile", "go", "gomod",
        "gdscript", "html", "http", "java", "javascript", "jsdoc", "json",
        "lua", "make", "perl", "python", "regex", "rust", "sql", "toml",
        "tsx", "typescript", "yaml", "vim", "vimdoc" },
})

require("telescope").load_extension("ui-select")
vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅝 ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = "󰳦 ",
        }
    },
    virtual_text = true,
}

vim.keymap.set("n", "qq", ":q! <CR>")
vim.keymap.set("n", "<A-h>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-l>", ":tabnext<CR>")
vim.keymap.set("n", "<A-Left>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-Right>", ":tabnext<CR>")
vim.keymap.set("n", "<A-1>", ":tabfirst <CR>")
vim.keymap.set("n", "<A-0>", ":tablast<CR>")
vim.keymap.set("n", "<A-n>", ":tabnew | Oil <CR>")
vim.keymap.set("n", "<A-t>", ":vsplit | Oil <CR>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "fv", "<cmd>TodoTelescope theme=ivy <CR>")
vim.keymap.set("n", "ff", "<cmd>Telescope find_files theme=dropdown <CR>")
vim.keymap.set("n", "fs", "<cmd>Telescope spell_suggest theme=cursor<CR>")
vim.keymap.set("n", "fd", "<cmd>Telescope lsp_references theme=cursor <CR>")
vim.keymap.set("n", "fg", "<cmd>Telescope live_grep theme=dropdown<CR>")
vim.keymap.set("n", "fh", "<cmd>Telescope man_pages sections=2,3<CR>")
vim.keymap.set("n", "<A-d>", "<cmd>:Telescope diagnostics theme=ivy bufnr=0<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-D>", "<cmd>:Telescope diagnostics theme=ivy<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-q>", ":lua vim.lsp.buf.code_action() <CR>")
vim.keymap.set("n", "<A-f>", ":lua vim.lsp.buf.format() <CR>")
vim.keymap.set("n", "<A-r>", ":lua vim.lsp.buf.rename() <CR>")

if vim.fn.executable("clip.exe") == 1 then -- is Windows?
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = { ['+'] = 'clip.exe', ['*'] = 'clip.exe' },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
    vim.cmd [[ colorscheme duskfox ]]
else
    local function getColor()
        local handle = io.popen(
            "/usr/bin/gsettings get org.gnome.desktop.interface color-scheme")
        if handle == nil then
            return false
        end
        local result = handle:read("*a") -- Read all output
        handle:close()
        return string.find(result, "prefer-dark", 1, true) ~= nil
    end
    function SetColors()
        if getColor() then
            vim.cmd [[ colorscheme duskfox ]]
        else
            vim.cmd [[ colorscheme dayfox ]]
        end
        -- Make bar background transparent.
        vim.cmd(":hi statusline guibg=NONE")
    end

    SetColors()
end
