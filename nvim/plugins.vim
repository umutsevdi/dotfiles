source $HOME/.dotfiles/nvim/pkg/coc.vim
source $HOME/.dotfiles/nvim/pkg/coc-snippets.vim
source $HOME/.dotfiles/nvim/pkg/startify.vim
source $HOME/.dotfiles/nvim/pkg/lightline.vim
source $HOME/.dotfiles/nvim/pkg/nerdtree.vim
source $HOME/.dotfiles/nvim/pkg/tagbar.vim

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
" vim icons
Plug 'ryanoasis/vim-devicons'
" Syntax helper
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Tree on left
Plug 'preservim/nerdtree'
" Telescope
Plug 'nvim-lua/plenary.nvim'
" Bottom line
Plug 'itchyny/lightline.vim'

Plug 'niklaas/lightline-gitdiff'
" Theme
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" COC Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Start page
Plug 'mhinz/vim-startify'

Plug 'tpope/vim-fugitive'
" Emoji Keyboard
Plug 'kyuhi/vim-emoji-complete'
" Tag bar on the left
Plug 'preservim/tagbar' 

call plug#end()


"colorscheme fleetish
"let g:fleetish_italics=1
"let g:lightline = { 'colorscheme': 'fleetish' }
" { default, palenight, ocean, lighter, darker, default-community, palenight-community,
"   ocean-community, lighter-community, darker-community }
colorscheme material
let g:material_theme_style = 'ocean'
let g:material_terminal_italics = 1

" nvim-tresitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
--  ensure_installed = "maintained",
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

