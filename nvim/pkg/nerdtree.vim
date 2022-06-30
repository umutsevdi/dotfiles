" NERDTree Config
" autocmd VimEnter * NERDTree | Tagbar | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd Bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif

let NERDTreeMinimalUI=1
let NERDTreeCascadeChildDir=1
let NERDTreeCascadeOpenSingleChildDir=1
let NERDTreeDirArrowExpandable="▶"
let NERDTreeDirArrowCollapsible="▼"
let NERDTreeWinPos="left"
let NERDTreeMinimalMenu=0
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\\.swo$', '\\.swp$', '\\.git']
let NERDTreeChDirMode=0
" let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let NERDTreeBookmarksFile=expand("$HOME/.dotfiles/nvim/.NERDTreeBookmarks")
