source $HOME/.dotfiles/nvim/pkg/coc.vim
source $HOME/.dotfiles/nvim/pkg/coc-snippets.vim
source $HOME/.dotfiles/nvim/pkg/startify.vim
source $HOME/.dotfiles/nvim/pkg/lightline.vim
source $HOME/.dotfiles/nvim/pkg/nerdtree.vim
source $HOME/.dotfiles/nvim/pkg/tagbar.vim
source $HOME/.dotfiles/nvim/pkg/markdown.vim
source $HOME/.dotfiles/nvim/pkg/colorscheme.vim

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align' 

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
" Plug '~/my-prototype-plugin' local plugin
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/vim-easy-align' 
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " fzf
Plug 'ryanoasis/vim-devicons'                                       " Vim NerdFont icons
Plug 'preservim/nerdtree'                                           " NERDTree is the file tree on right
Plug 'nvim-lua/plenary.nvim'                                        " Telescope requires this package
Plug 'nvim-telescope/telescope.nvim'                                " Telescope is a FZF extension that displays preview
Plug 'itchyny/lightline.vim'                                        " Lightline is the bar on the bottom that displays variues elements
Plug 'niklaas/lightline-gitdiff'                                    " Lightline git extension
" Plug 'kaicataldo/material.vim', { 'branch': 'main' }                " Material Theme with aditional 
Plug 'mhinz/vim-startify'                                           " Start page
Plug 'tpope/vim-fugitive'                                           " Git Integration
Plug 'preservim/tagbar'                                             " Tag bar displays functions, classes and variables of files on the left 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}         " Syntax highlighting 
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}                    " Conqueror of Completions: Language server for any language
" Plug 'mattn/emmet-vim'                                              " Better html tags
Plug 'othree/html5.vim', {'for': ['html', 'html5', 'htm']}          " HTML5 support for html tags
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'lervag/vimtex',
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' },
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}", live markdown renderer server
Plug 'rakr/vim-one' " colorscheme

call plug#end()

colorscheme one

lua <<EOF
require'nvim-treesitter.configs'.setup {
--  ensure_installed = "maintained",
  ensure_installed = { "c", "cmake", "comment", "cpp", "dockerfile",
  "go", "gomod", "html", "http", "java", "javascript", "jsdoc", "json",
  "kotlin", "latex", "lua", "make", "perl", "python", "regex", "ruby",
  "rust", "scheme", "scss", "svelte", "todotxt", "toml", "tsx","typescript",
  "vim", "vue", "yaml"},
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    -- list of language that will be disabled
    disable = {},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Coc Extensions
let g:coc_global_extensions = [
\ 'coc-clangd',
\ 'coc-cmake',
\ 'coc-css',
\ 'coc-cssmodules',
\ 'coc-diagnostic',
\ 'coc-docker',
\ 'coc-emmet',
\ 'coc-eslint',
\ 'coc-explorer',
\ 'coc-html',
\ 'coc-html-css-support',
\ 'coc-htmlhint',
\ 'coc-java',
\ 'coc-json',
\ 'coc-just-complete',
\ 'coc-markdown-preview-enhanced',
\ 'coc-markdownlint',
\ 'coc-prettier',
\ 'coc-rls',
\ 'coc-rust-analyzer',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-stylelintplus',
\ 'coc-sql',
\ 'coc-svelte',
\ 'coc-tailwindcss',
\ 'coc-tsserver',
\ 'coc-ultisnips',
\ 'coc-vimlsp',
\ 'coc-vue',
\ 'coc-webview',
\ 'coc-xml',
\ 'coc-yaml',
\ ]

