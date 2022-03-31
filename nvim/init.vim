source $HOME/.dotfiles/nvim/plug-config/plugins.vim

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
set background=dark
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
set undodir=~/.config/nvim/undodir

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
set clipboard=unnamedplus

" Shortcuts 

" quit without saving
nnoremap qq :q!<CR>
" quit after saving
nnoremap qw :wq<CR>
" Better multiple lines tabbing with < and >
vnoremap < <gv
vnoremap > >gv
" source $MYVIMRC
nnoremap <leader>ss :source $MYVIMRC<CR>

" Window Movement
" Change vim window focus
map <A-h> <C-w>h
map <A-l> <C-w>l
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-Left> <C-w>h
map <A-Down> <C-w>j
map <A-Up> <C-w>k
map <A-Right> <C-w>l

" Tabs
" Move around tabs
noremap <silent> <C-h> :tabprevious<CR> 
noremap <silent> <C-l> :tabnext<CR>
noremap <silent> <C-Left> :tabprevious<CR>
noremap <silent> <C-Right> :tabnext<CR>
noremap <silent> <C-1> 1gt
noremap <silent> <C-3> 3gt
noremap <silent> <C-4> 4gt
noremap <silent> <C-5> 5gt
noremap <silent> <C-6> 6gt
noremap <silent> <C-7> 7gt
noremap <silent> <C-8> 8gt
noremap <silent> <C-9> 9gt
noremap <silent> <C-0> :tablast<cr>
nnoremap <silent> <C-n> :tabnew . <CR>  
nnoremap <A-n> :vsplit .<CR>

" NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <A-t> :NERDTreeToggle<CR>
nnoremap <A-f> :NERDTreeFind<CR>

" Coc
nnoremap <silent> <A-f> :Format <CR>
nnoremap <silent> <A-d> :CocDiagnostics <CR>
 
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Autofill
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap (<CR> (<CR>)<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap "<CR> "<CR>"<ESC>O
inoremap ";<CR> "<CR>";<ESC>O
inoremap '<CR> '<CR>'<ESC>O
inoremap ';<CR> '<CR>';<ESC>O

nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>

