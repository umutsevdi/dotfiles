" Lightline Configuration

let g:coc_symbol_line_render = 'echo'
let g:lightline = { 'colorscheme': 'material_vim' }
let g:lightline#gitdiff#indicator_added = '⊕ '
let g:lightline#gitdiff#indicator_modified = '⊛ '
let g:lightline#gitdiff#indicator_deleted = '⊖ '
let g:lightline#gitdiff#separator = ' | '

let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste'],
  \     ['gitbranch','filename'],
  \     ['readonly','currentfunction'],
  \   ],
  \   'right':[
  \     [ 'lineinfo','filetype', 'fileencoding'],
  \     [ 'lint' ],
  \     ['gitdiff'],
  \   ],
  \ },
  \ 'component':{
  \ 'gitbranch': ' %{fugitive#head()}',
  \},
  \ 'component_expand': {
  \   'gitdiff': 'lightline#gitdiff#get',
  \ },
  \ 'component_function': {
  \   'blame': 'lightlineGitBlame',
  \   'lint' : 'LintInfo',
  \   'filename' : 'LightlineFilename',
  \   'filetype': 'Filetype',
  \   'readonly': 'LightlineReadonly',
  \   'currentfunction': 'CurrentFunction',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
\ }

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? '*' : ''
    return filename . modified
endfunction

function! CurrentFunction() abort
    let data = get(b:,'coc_current_function',"")
    return empty(data) ? '' :  'ƒ '.data.'()'
endfunction

function! LintInfo() abort 
    let data = get(b:,'coc_diagnostic_info',{})
    if empty(data)
        return ''
    endif
    let error = !empty(data['error']) ? printf('⊗ %d ',data['error']) : ''
    let warning = !empty(data['warning']) ? printf('⚠ %d ',data['warning']) : ''
    let info = !empty(data['information']) || !empty(data['hint'])  ? printf('🛈 %d ', data['information']+data['hint']) : ''
    return error . warning . info
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler' && &readonly ? '' : ''
endfunction

function! Filetype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
  

