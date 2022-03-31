set shell=$SHELL
set encoding=UTF-8
" Colors
syntax on
" Enable syntax highlighting
set t_Co=256                         " Enable 256 colors
set cmdheight=1 " height of command-line at the bottom
set shortmess+=c
set showtabline=1
" set manual folding for functions, conditions etc.
set foldmethod=manual
" set mouse=extend
" set mousemodel=extend
" set inccommand=nosplit
set conceallevel=0
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set spell
set colorcolumn=80

" Enable termguicolors
set termguicolors
" Enable hidden files
set hidden
" Set updatetime
set updatetime=200
" Set timeoutlen
" set timeoutlen=500
set ttimeout ttimeoutlen=50
" Disable backup files
set nobackup
set nowritebackup
" Set cmdheight
set cmdheight=1
" Show sign column
set signcolumn=yes
" Show line numbers
set number
" Highlight cursor line
" set cursorline
" Disable cursor column highlighting
set nocursorcolumn
" Ignore case when searching
set ignorecase
set smartcase
" Undo and backup options
set undofile
" set undodir=/home/umutsevdi/.config/vim/undodir
set noswapfile
set history=50
" Set split options
set splitright
set splitbelow
" Set conceallevel
set conceallevel=0
" Set tab and indent settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set relativenumber
" Use system clipboard
set clipboard=unnamedplus
" Set number width
set numberwidth=6
" Set scrolloff
set scrolloff=8
" Enable line wrapping
set wrap
" Set textwidth
set textwidth=300
" Show invisible characters
" set list
" Set jump options
" set jumpoptions=view
" Disable last status
set laststatus=0
set ch=1

"    map <C-h> <C-w>h
"    map <C-l> <C-w>l
"    map <C-j> <C-w>j
"    map <C-k> <C-w>k
"    " Tabs
"    " Move around tabs
"    map <silent> <A-h> :tabprevious<CR>
"    map <silent> <A-l> :tabnext<CR>
"    map <silent> <A-Left> :tabprevious<CR>
"    map <silent> <A-Right> :tabnext<CR>
"    map <silent> <A-1> :tabfirst <cr>
"    map <silent> <A-0> :tablast<cr>
"    " Jump definition
"    " source $MYVIMRC
"    nnoremap <leader>ss :source $MYVIMRC<CR>
"    " tab management
"    nnoremap qq :q!<CR>
"    " quit after saving
"    nnoremap qw :wq<CR>
" Better multiple lines tabbing with < and >
vnoremap < <gv
vnoremap > >gv
" source $MYVIMRC
nnoremap <leader>ss :source $MYVIMRC<CR>
