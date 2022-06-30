" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
let g:webdevicons_enable_startify = 1

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:ascii_image = [
            \'',  
            \'███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗', 
            \'████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║',
            \'██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║',
            \'██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║',
            \'██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║',
            \'╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝',
            \ ]
let g:startify_custom_header = 'startify#pad(g:ascii_image + startify#fortune#boxed())'

let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['▶   '. getcwd()] },
        \ { 'type': 'files',     'header': ['▶   Recent Files' ]},
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['▶  Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['▶   Git Modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['▶  git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
