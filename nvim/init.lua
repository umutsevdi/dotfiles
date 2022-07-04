vim.cmd([[
set shell=$SHELL
set encoding=UTF-8

" Colors
syntax on
" Enable syntax highlighting
set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum        " set background color

set t_Co=256                         " Enable 256 colors
set termguicolors                    " Enable GUI colors for the terminal to get truecolor

" Recommended by CoC
set hidden
set updatetime=300
set nobackup    " Disables backup files
set nowritebackup   " Disables backup files
set cmdheight=1 " height of command-line at the bottom
set shortmess+=c
set signcolumn=yes "always show sign column, otherwise it will shift text
set showtabline=2

" set manual folding for functions, conditions etc.
set foldmethod=manual

" Show line numbers
set nocursorline
set nocursorcolumn

set ignorecase
set smartcase
set mouse=a
set scrolloff=4 " number of screen lines to always keep above and below the cursor

set undofile
set undodir=~.config/nvim/undodir

set inccommand=nosplit
set splitright
set splitbelow

set conceallevel=0

" Whitespace configs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set number
set relativenumber
set clipboard=unnamedplus
]])
require('plugins')
require("keybindings")
