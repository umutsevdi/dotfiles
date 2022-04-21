
" NERDTree Config
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd Bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif


let NERDTreeCascadeChildDir=1
let NERDTreeCascadeOpenSingleChildDir=1
let NERDTreeDirArrowExpandable="▶"
let NERDTreeDirArrowCollapsible="▼"
