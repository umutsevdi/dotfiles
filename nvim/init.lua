-------------------------------------------------------------------------------
-- File: init.lua
--
-- Author: Umut Sevdi
-- Created: 04/07/22
-- Description: init.lua is the primary configuration file that initializes
-- basic settings and initializes basic Lua configurations.
-- It also links the configuration files of plugins respectively.
-------------------------------------------------------------------------------
IS_WINDOWS = vim.fn.executable("clip.exe") == 1 and true or false

local ICON_ERROR = "󰅝 "
local ICON_WARN = " "
local ICON_HINT = " "
local ICON_INFO = "󰳦 "
local ICON_MENU = IS_WINDOWS
    and { nvim_lsp = '⎀', luasnip = '⎓', buffer = '⎙', path = '⌘' }
    or { nvim_lsp = '󰌷', luasnip = '󱡠', buffer = '', path = '' }

vim.cmd([[
    set shell=$SHELL
    set encoding=UTF-8
    syntax on
    set t_Co=256
    set cmdheight=1
    set shortmess+=c
    set showtabline=0
    set foldmethod=manual
    set mousemodel=extend
    set inccommand=nosplit
    set conceallevel=0
    set expandtab
    set smarttab
    set smartindent
    set spell
    set colorcolumn=80
]])

vim.o.number = true
vim.o.relativenumber = true
vim.opt.showmode = false

vim.opt.clipboard = ""
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

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

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
vim.o.wrap = false

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
        { "vigoux/notifier.nvim",  opts = {} },
        { "m4xshen/hardtime.nvim", lazy = false, opts = { disable_mouse = false } },
    },
    {
        "EdenEast/nightfox.nvim",
        opts = {
            options = {
                colorblind = {
                    enable = true,
                    simulate_only = false,
                    severity = {
                        deutan = 1,
                        tritan = 1,
                    },
                },
                transparent = true,
                styles = {
                    comments = "italic",
                    constants = "bold",
                    functions = "bold,italic",
                    keywords = "italic",
                    types = "bold",
                    -- conditionals = "NONE",
                    -- numbers = "NONE",
                    -- operators = "NONE",
                    -- strings = "NONE",
                    -- variables = "NONE",
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
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "L3MON4D3/LuaSnip",
            'hrsh7th/nvim-cmp',
            'saadparwaiz1/cmp_luasnip',
            "rafamadriz/friendly-snippets",
        }
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
            }
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
--                theme = custom_theme,
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
                lualine_y = { 'location' },
                lualine_z = { 'tabs' },
            }
        }
    },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({
    paths = { "~/.dotfiles/nvim/snippets/" }
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            item.menu = ICON_MENU[entry.source.name]
            return item
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-f>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
        end, { 'i', 's' }),
    },
})

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup {}
require('mason-lspconfig').setup {
    ensure_installed = {
        'astro', 'bashls', 'clangd', 'cssls',
        'cmake', 'gopls', 'grammarly', 'html',
        'lua_ls', 'pylsp', 'rust_analyzer', 'ts_ls',
    },
    handlers = { function(srvr)
        require('lspconfig')[srvr].setup { diagnostics = { enable = true, } }
    end,
    }
}

require('lspconfig').lua_ls.setup({
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or
                vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end
        client.config.settings.Lua = vim.tbl_deep_extend('force',
            client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
    end,
    settings = { diagnostics = { globals = { "vim" } } }
})

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
            [vim.diagnostic.severity.ERROR] = ICON_ERROR,
            [vim.diagnostic.severity.WARN]  = ICON_WARN,
            [vim.diagnostic.severity.HINT]  = ICON_HINT,
            [vim.diagnostic.severity.INFO]  = ICON_INFO,
        }
    },
    virtual_text = true,
}

vim.cmd([[
    map <silent> <A-h> :tabprevious<CR>
    map <silent> <A-l> :tabnext<CR>
    map <silent> <A-Left> :tabprevious<CR>
    map <silent> <A-Right> :tabnext<CR>
    map <silent> <A-1> :tabfirst <cr>
    map <silent> <A-0> :tablast<cr>
]])

vim.keymap.set("n", "qq", ":q! <CR>")
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
if IS_WINDOWS then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
    vim.cmd [[ colorscheme carbonfox ]]
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
            vim.cmd [[ colorscheme carbonfox ]]
        else
            vim.cmd [[ colorscheme dayfox ]]
        end
    end

    SetColors()
end
