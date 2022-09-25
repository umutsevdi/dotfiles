--
-- ╭────────────╮
-- │  init.lua  │
-- ╰────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  init.lua is the primary configuration file that initializes                 │
-- │ basic settings and initializes basic Lua configurations.                     │
-- │ It also links the configuration files of plugins respectively.               │
-- │  - {@link plugins.lua} manages all plugins and their configuration.          │
-- │  - {@link keybinding.lua} manages most of the keybindings.                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- @author umutsevdi

local o = vim.o

vim.cmd([[
set shell=$SHELL
set encoding=UTF-8

" Colors
syntax on
" Enable syntax highlighting
set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum        " set background color

set t_Co=256                         " Enable 256 colors

" Recommended by CoC
set cmdheight=1 " height of command-line at the bottom
set shortmess+=c
set showtabline=2
" set manual folding for functions, conditions etc.
set foldmethod=manual

" set mouse=extend
set mousemodel=extend

set inccommand=nosplit

set conceallevel=0

set shiftwidth=4
set expandtab
set smarttab
set smartindent

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set termguicolors

]])
o.termguicolors = true

-- Recommended by CoC
o.hidden = true
o.updatetime = 200
o.timeoutlen = 500

-- Disable backup files
o.backup = false
o.writebackup = false
-- set cmdheight=1 -- height of commandline at the bottom
-- shortmess +=c
o.signcolumn = "yes"
-- showtabline=2

-- set manual folding for functions, conditions etc
-- set foldmethod=manual

-- show line numbers
o.number = true
o.cursorline = false
o.cursorcolumn = false

o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.undofile = true
o.undodir = "/home/umutsevdi/.config/nvim/undodir"
o.swapfile = false
o.history = 50
-- set inccommand=nosplit
o.splitright = true
o.splitbelow = true
-- set conceallevel=0

-- Whitespace configuration
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
--  set expandtab
--  set smarttab

--  set smartindent
--  set number
o.relativenumber = true
o.clipboard = "unnamedplus"

-- Better editor UI
o.numberwidth = 6
o.scrolloff = 8
o.wrap = true
o.textwidth = 300
o.list = true
o.jumpoptions = "view"

require("plugins")
require("keybindings")
