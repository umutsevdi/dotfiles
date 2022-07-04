-- NERDTree Config
-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd [[
autocmd Bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
let NERDTreeBookmarksFile=expand("$HOME/.dotfiles/nvim/.NERDTreeBookmarks")
]]
vim.NERDTreeMinimalUI=1
vim.NERDTreeCascadeChildDir=1
vim.NERDTreeCascadeOpenSingleChildDir=1
vim.NERDTreeDirArrowExpandable="▶"
vim.NERDTreeDirArrowCollapsible="▼"
vim.NERDTreeWinPos="left"
vim.NERDTreeMinimalMenu=0
vim.NERDTreeShowBookmarks=1
vim.NERDTreeIgnore='\\.swo$', '\\.swp$', '\\.git'
vim.NERDTreeChDirMode=0
-- vim.NERDTreeQuitOnOpen=1
vim.NERDTreeShowHidden=0
vim.NERDTreeKeepTreeInNewTab=1
vim.NERDTreeBookmarksFile = "$HOME/.dotfiles/nvim/.NERDTreeBookmarks"
