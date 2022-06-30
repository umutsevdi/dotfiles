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
nnoremap <A-t> :NERDTreeToggle \| TagbarToggle <CR>
nnoremap <A-f> :NERDTreeFind<CR>

" format code
nnoremap <silent> <A-f> :Format <CR>
" Coc Diagnostic Menu
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
" emoji keyboard
" <C-X><C-E> Emoji Keyboard
" Git Status
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>


" Go Compiler Settings
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>n

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

" Jump definition
nmap <silent> jd :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>

" Telescope finder
" Find files using Telescope command-line sugar.
" nnoremap  <leader> <ff>: Telescope find_files<cr>
nnoremap ff : Telescope find_files <CR>
" nnoremap ff : Telescope find_files <CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
"For C, pressing K on the keyword will pull up the built-in manpage directly. For instance, place the cursor on the printf keyword:

" Snippet runner
vnoremap rr : SnipRun <CR>
