-------------------------------------------------------------------------------
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
vim.o.signcolumn = "yes"
vim.o.updatetime = 200
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.cursorline = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
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
vim.o.winborder = "none"

local function tabinfo()
    local tabs = vim.api.nvim_list_tabpages()
    if #tabs > 1 then
        local p = {}
        local cur = vim.api.nvim_get_current_tabpage()
        for i in pairs(tabs) do
            if i == cur then
                table.insert(p, "[" .. i .. "]")
            else
                table.insert(p, i)
            end
        end
        return table.concat(p, " ")
    else
        return ""
    end
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "LudoPinelli/comment-box.nvim",    opts = {} },
    { "m4xshen/autoclose.nvim",          opts = {} },
    { "vigoux/notifier.nvim",            opts = {} },
    { "lewis6991/gitsigns.nvim",         opts = { current_line_blame = true } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "nvim-telescope/telescope.nvim",
        opts = { defaults = { layout_config = { vertical = { width = 0.5 } } } },
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Telescope" },
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        cmd = { "Oil" },
        dependencies = { "echasnovski/mini.nvim" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig"
        },
        opts = {
            ensure_installed = { "astro", "bashls", "clangd", "cssls",
                "cmake", "gopls", "html", "lua_ls", "pylsp", "rust_analyzer",
                "ts_ls" }
        }
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            }
        },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = true } },
            sources = { default = { "snippets", "lsp", "path", "buffer" } },
            snippets = { preset = "luasnip" },
        },
        opts_extend = { "sources.default" }
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim"
        },
        opts = {
            completions = { lsp = { enabled = true } },
            code = {
                position = "right",
                width = "block",
                left_pad = 1,
                language_pad = 2,
                right_pad = 1,
            },
        },
    },
    {
        'nvim-mini/mini.statusline',
        version = false,
        opts = {
            content = {
                active = function()
                    local line          = MiniStatusline
                    local mode, mode_hl = line.section_mode({ trunc_width = 120 })
                    local git           = line.section_git({ trunc_width = 40 })
                    local diff          = line.section_diff({ trunc_width = 75, icon = "" })
                    local diagnostics   = line.section_diagnostics({
                        trunc_width = 75,
                        icon = "",
                        signs = { ERROR = "󰅝 ", WARN = " ", INFO = "󰳦 ", HINT = " " }
                    })
                    local search        = line.section_searchcount({ trunc_width = 75 })
                    return line.combine_groups({
                        { hl = mode_hl,  strings = { mode } },
                        { hl = 'String', strings = { git, diff } },
                        '%<%=',
                        { hl = "String", strings = { diagnostics } },
                        {
                            hl = mode_hl,
                            strings = {
                                vim.bo.filetype, vim.bo.fileformat,
                                "%l/%L", search,
                            }
                        },
                        { hl = "Search", strings = { tabinfo() } },
                    })
                end
            }
        }
    },
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    ensure_installed = {
        "c", "cmake", "comment", "cpp", "dart", "dockerfile", "go", "gomod",
        "gdscript", "html", "http", "java", "javascript", "jsdoc", "json",
        "lua", "make", "perl", "python", "regex", "rust", "sql", "toml",
        "tsx", "typescript", "yaml", "vim", "vimdoc" },
})
vim.diagnostic.config {
    virtual_lines = true,
    loclist = { open = true, severity = { min = vim.diagnostic.severity.INFO } },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅝 ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = "󰳦 ",
        }
    }
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
vim.keymap.set("n", "ff", "<cmd>Telescope find_files theme=dropdown <CR>")
vim.keymap.set("n", "<A-s>", "<cmd>Telescope spell_suggest theme=cursor<CR>")
vim.keymap.set("n", "fd", "<cmd>Telescope lsp_references theme=cursor <CR>")
vim.keymap.set("n", "fg", "<cmd>Telescope live_grep theme=dropdown<CR>")
vim.keymap.set("n", "fh", "<cmd>Telescope man_pages sections=2,3<CR>")
vim.keymap.set("n", "<A-d>", "<cmd>lua vim.diagnostic.setloclist()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-q>", ":lua vim.lsp.buf.code_action() <CR>")
vim.keymap.set("n", "<A-f>", ":lua vim.lsp.buf.format() <CR>")
vim.keymap.set("n", "<A-r>", ":lua vim.lsp.buf.rename() <CR>")

local function defaultColor()
    if vim.fn.has('linux') == 1 then
        local handle = io.popen(
            "/usr/bin/gsettings get org.gnome.desktop.interface color-scheme")
        if handle then
            local darkstr = string.find(handle:read("*a"), "prefer-dark", 1, true)
            handle:close()
            return darkstr ~= nil and "dark" or "light"
        end
    end
    return "dark"
end
function SetColors(bg)
    if bg == nil then bg = defaultColor() end
    vim.cmd("colorscheme default")
    vim.cmd("set background=" .. bg)
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "Comment", { italic = true, fg = "Gray" })
    set_hl(0, "Keyword", {})
    set_hl(0, "Type", { bold = true })
    set_hl(0, "Search", { reverse = true })
    set_hl(0, "Function", { bold = true, italic = true, fg = "DarkCyan" })
    set_hl(0, "Constant", { bold = true, fg = "Red" })
    set_hl(0, "String", { fg = "DarkYellow" })
    set_hl(0, "Normal", { bg = "NONE" })
    set_hl(0, "EndOfBuffer", { bg = "NONE" })
    set_hl(0, "StatusLine", { bg = "NONE" })
    set_hl(0, "StatusLineNC", { bg = "NONE" })
end

SetColors()
