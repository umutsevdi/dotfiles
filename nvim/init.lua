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

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
-- vim.o.clipboard = "unnamedplus"

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
        }
    },
    {
        'rebelot/kanagawa.nvim',
        opts = {
            compile        = true,
            functionStyle  = { italic = true, bold = true },
            keywordStyle   = { italic = false, bold = false },
            statementStyle = { italic = true, bold = false },
            typeStyle      = { italic = false, bold = true },
            transparent    = true,
            dimInactive    = false,
            terminalColors = true,
            theme          = "wave",
            background     = { dark = "wave", light = "lotus" },
            colors         = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
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
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                globalstatus = true,
                theme = "16color",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { {
                    "filename",
                    symbols = {
                        modified = " * ",
                        readonly = "  ",
                        unnamed = "",
                    },
                } },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic", "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = {
                            error = " ⊗ ",
                            warn = " ",
                            info = "🛈 ",
                            hint = "⚑ "
                        },
                    },
                },
                lualine_y = { "location", "filetype" },
                lualine_z = { "tabs" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'filename' }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    }
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
            local menu_icon =
                IS_WINDOWS and {
                    nvim_lsp = '⎀',
                    luasnip = '⎓',
                    buffer = '⎙',
                    path = '⌘',
                } or {
                    nvim_lsp = '󰌷',
                    luasnip = '󱡠',
                    buffer = '',
                    path = '',
                }
            item.menu = menu_icon[entry.source.name]
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
        'astro', 'bashls', 'clangd', 'cssls', 'cmake', 'gopls', 'html',
        'lua_ls', 'marksman', 'pylsp', 'rust_analyzer', 'ts_ls',
    },
    handlers = { function(srvr)
        require('lspconfig')[srvr].setup {
            diagnostics = { enable = true, }
        }
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

vim.cmd("colorscheme kanagawa")

require("telescope").setup {
    defaults = { layout_config = { vertical = { width = 0.5 } } },
    opts = {
        extensions = {
            ["ui-select"] = require("telescope.themes").get_cursor {}
        },
    }
}
require("telescope").load_extension("ui-select")

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "⊗",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "⚑",
            [vim.diagnostic.severity.INFO]  = "🛈",
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
vim.keymap.set("n", "ff", ":Telescope find_files theme=ivy <CR>")
vim.keymap.set("n", "fs", ":Telescope live_grep theme=dropdown<CR>")
vim.keymap.set("n", "fd", ":Telescope lsp_references theme=cursor <CR>")
vim.keymap.set("n", "fg", "<cmd>Telescope buffers theme=ivy<CR>")
vim.keymap.set("n", "fh", "<cmd>Telescope man_pages sections=2,3<CR>")
vim.keymap.set("n", "<A-d>", "<cmd>:Telescope diagnostics theme=ivy<CR>",
    { silent = true, noremap = true })
vim.keymap.set("n", "<A-f>", ":lua vim.lsp.buf.format() <CR>")
vim.keymap.set("n", "<A-q>", ":lua vim.lsp.buf.code_action() <CR>")
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
            vim.cmd [[ set background=dark ]]
        else
            vim.cmd [[ set background=light ]]
        end
    end

    SetColors()
end
