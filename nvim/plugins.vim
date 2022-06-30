source $HOME/.dotfiles/nvim/pkg/coc.vim
source $HOME/.dotfiles/nvim/pkg/coc-snippets.vim
source $HOME/.dotfiles/nvim/pkg/colorscheme.vim
source $HOME/.dotfiles/nvim/pkg/lightline.vim
source $HOME/.dotfiles/nvim/pkg/markdown.vim
source $HOME/.dotfiles/nvim/pkg/nerdtree.vim
source $HOME/.dotfiles/nvim/pkg/startify.vim
source $HOME/.dotfiles/nvim/pkg/tagbar.vim
source $HOME/.dotfiles/nvim/pkg/bracey.vim
source $HOME/.dotfiles/nvim/pkg/test.vim

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
call plug#begin()
" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
" Plug '~/my-prototype-plugin' local plugin
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/vim-easy-align'                                                           " Auto align
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                                      " Snippet support
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                        " FZF
Plug 'ryanoasis/vim-devicons'                                                            " Vim NerdFont icons
Plug 'preservim/nerdtree'                                                                " NERDTree is the file tree on right
Plug 'nvim-lua/plenary.nvim'                                                             " Telescope requires this package
Plug 'nvim-telescope/telescope.nvim'                                                     " Telescope is a FZF extension that displays preview
Plug 'itchyny/lightline.vim'                                                             " Lightline is the bar on the bottom that displays variues elements
Plug 'niklaas/lightline-gitdiff'                                                         " Lightline git extension
Plug 'mhinz/vim-startify'                                                                " Start page
Plug 'tpope/vim-fugitive'                                                                " Git Integration
Plug 'preservim/tagbar'                                                                  " Tag bar displays functions, classes and variables of files on the left 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                              " Syntax highlighting 
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}          " Conqueror of Completions: Language server for any language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                                       " Go official vim plugin
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}  " live markdown renderer server
Plug 'rakr/vim-one'                                                                      " colorscheme
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}                          " Run live web server to test HTML, CSS, JS
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}                                       " Instant code runner
Plug 'rcarriga/nvim-notify'                                                              " Neovim's notification plugin
Plug 'vim-test/vim-test'                                                                 " Test plugin for Vim

call plug#end()

colorscheme one

lua <<EOF
require'nvim-treesitter.configs'.setup {
--  ensure_installed = "maintained",
  ensure_installed = { "c", "cmake", "comment", "cpp", "dockerfile",
  "go", "gomod","gdscript", "html", "http", "java", "javascript", "jsdoc", "json",
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
\ 'coc-godot',
\ 'coc-html',
\ 'coc-html-css-support',
\ 'coc-htmlhint',
\ 'coc-java',
\ 'coc-json',
\ 'coc-markdown-preview-enhanced',
\ 'coc-markdownlint',
\ 'coc-prettier',
\ 'coc-rls',
\ 'coc-rust-analyzer',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-stylelintplus',
\ 'coc-stylua',
\ 'coc-sumneko-lua',
\ 'coc-sql',
\ 'coc-svelte',
\ 'coc-tailwindcss',
\ 'coc-tsserver',
\ 'coc-ultisnips',
\ 'coc-vimlsp',
\ 'coc-webview',
\ 'coc-xml',
\ 'coc-yaml',
\ ]

" Snippet Runner Config
lua << EOF
require'sniprun'.setup({
  selected_interpreters = {},                 --# use those instead of the default for the current filetype
  repl_enable = {},                           --# enable REPL-like behavior for the given interpreters
  repl_disable = {},                          --# disable REPL-like behavior for the given interpreters
  interpreter_options = {                     --# interpreter-specific options, see docs / :SnipInfo <name>
                                              -- use the interpreter name as key
    GFM_original = {
      use_on_filetypes = {"markdown.pandoc"}  --# the 'use_on_filetypes' configuration key is
                                              --# available for every interpreter
    },
    Python3_original = {
        error_truncate = "auto"               --# Truncate runtime errors 'long', 'short' or 'auto'
                                              --# the hint is available for every interpreter
                                              --# but may not be always respected
    }
  },      
                                              --# you can combo different display modes as desired
  display = {
    -- "Classic",                             --# display results in the command-line  area
    "VirtualTextOk",                          --# display ok results as virtual text (multiline is shortened)

    -- "VirtualTextErr",                      --# display error results as virtual text
    "TempFloatingWindow",                     --# display results in a floating window
    -- "LongTempFloatingWindow",              --# same as above, but only long results. To use with VirtualText__
    -- "Terminal",                            --# display results in a vertical split
    -- "TerminalWithCode",                    --# display results and code history in a vertical split
    -- "NvimNotify",                          --# display with the nvim-notify plugin
    -- "Api"                                  --# return output to a programming interface
  },
  display_options = {
    terminal_width = 45,                      --# change the terminal display option width
    notification_timeout = 5                  --# timeout for nvim_notify output
  },
  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  show_no_output = {
    "Classic",
    "TempFloatingWindow",                     --# implies LongTempFloatingWindow, which has no effect on its own
  },
  --# customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
  },
  --# miscellaneous compatibility/adjustement settings
  inline_messages = 0,                      --# inline_message (0/1) is a one-line way to display messages
                                            --# to workaround sniprun not being able to display anything

  borders = 'single',                       --# display borders around floating windows
                                            --# possible values are 'none', 'single', 'double', or 'shadow'
  live_mode_toggle='off'                    --# live mode toggle, see Usage - Running for more info   
})
EOF


lua << EOF
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
EOF
