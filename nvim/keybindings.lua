--
-- ╭───────────────────╮
-- │  keybindings.lua  │
-- ╰───────────────────╯
--╭──────────────────────────────────────────────────────────────────────────────╮
--│  keybindings.lua contains custom keybindings for various things.             │
--╰──────────────────────────────────────────────────────────────────────────────╯
-- @author umutsevdi

vim.cmd([[
" Go Compiler Settings
autocmd BufWritePre *.go :silent call CocAction('runCommand',  'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>n

" Window Movement
" Change vim window focus
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-Left> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Right> <C-w>l

" Tabs
" Move around tabs
noremap <silent> <A-h> :tabprevious<CR> 
noremap <silent> <A-l> :tabnext<CR>
noremap <silent> <A-Left> :tabprevious<CR>
noremap <silent> <A-Right> :tabnext<CR>
noremap <silent> <A-1> 1gt
noremap <silent> <A-2> 2gt
noremap <silent> <A-3> 3gt
noremap <silent> <A-4> 4gt
noremap <silent> <A-5> 5gt
noremap <silent> <A-6> 6gt
noremap <silent> <A-7> 7gt
noremap <silent> <A-8> 8gt
noremap <silent> <A-9> 9gt
noremap <silent> <A-0> :tablast<cr>

" Jump definition
nmap <silent> jd :call CocAction('jumpDefinition',  'split')<CR>
nmap <silent> gd :call CocAction('jumpDefinition',  'vsplit')<CR>
nmap <silent> gt :call CocAction('jumpDefinition',  'tabe')<CR>
]])

--quit without saving
vim.keymap.set("n", "qq", ":q!<CR>")
--quit after saving
vim.keymap.set("n", "qw", ":wq<CR>")
--source $MYVIMRC
vim.keymap.set("n", "<leader>ss", ":source $MYVIMRC<CR>")
-- tab management
vim.keymap.set("n", "<A-n>", ":tabnew .<CR>")
vim.keymap.set("n", "<A-q>", ":tabclose <CR>")
vim.keymap.set("n", "<A-t>", ":vsplit .<CR>")
vim.keymap.set("n", "<C-t>", ":vsplit .<CR>")

--NerdTree
vim.keymap.set("n", "<leader>n", ":NERDTreeFocus<CR>")
vim.keymap.set("n", "<A-Tab>", ":NERDTreeToggle | TagbarToggle <CR>")
-- vim.keymap.set('n', "<A-f>", ":NERDTreeFind<CR>")

--format code
vim.keymap.set("n", "<A-f>", "<CR>   :Format <CR>")
--Coc Diagnostic Menu
vim.keymap.set("n", "<silent> <A-d>", "<CR>  :CocDiagnostics <CR>")

--Mappings for CoCList
--Show all diagnostics.
vim.keymap.set("n", "<A-d>", ":CocDiagnostics <cr>")

vim.keymap.set("n", "<silent><nowait> <space>a", ":<C-u>CocList diagnostics<cr>")
--Manage extensions.
vim.keymap.set("n", "<silent><nowait> <space>e", ":<C-u>CocList extensions<cr>")
--Show commands.
vim.keymap.set("n", "<silent><nowait> <space>c", ":<C-u>CocList commands<cr>")
--Find symbol of current document.
vim.keymap.set("n", "<silent><nowait> <space>o", ":<C-u>CocList outline<cr>")
--Search workspace symbols.
vim.keymap.set("n", "<silent><nowait> <space>s", ":<C-u>CocList -I symbols<cr>")
--Do default action for next item.
vim.keymap.set("n", "<silent><nowait> <space>j", ":<C-u>CocNext<CR>")
--Do default action for previous item.
vim.keymap.set("n", "<silent><nowait> <space>k", ":<C-u>CocPrev<CR>")
--Resume latest coc list.
vim.keymap.set("n", "<silent><nowait> <space>p", ":<C-u>CocListResume<CR>")
--Git Status
vim.keymap.set("n", "<silent> <space>g", ":<C-u>CocList --normal gstatus<CR>")
-- autofill
vim.keymap.set("i", '"', '""<left>')
vim.keymap.set("i", "'", "''<left>")
vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "(<CR>", "(<CR>)<ESC>O")
vim.keymap.set("i", "(;<CR>", "(<CR>);<ESC>O")
vim.keymap.set("i", "[<CR>", "[<CR>]<ESC>O")
vim.keymap.set("i", "[;<CR>", "[<CR>];<ESC>O")
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O")
vim.keymap.set("i", "{;<CR>", "{<CR>};<ESC>O")
vim.keymap.set("i", '"<CR>', '"<CR>"<ESC>O')
vim.keymap.set("i", '";<CR>', '"<CR>";<ESC>O')
vim.keymap.set("i", "'<CR>", "'<CR>'<ESC>O")
vim.keymap.set("i", "';<CR>", "'<CR>';<ESC>O")
--Telescope finder
--Find files using Telescope command-line sugar.
--vim.keymap.set('n',   <leader> <ff>: Telescope find_files<cr>
vim.keymap.set("n", "ff", ":Telescope find_files <CR>")
--vim.keymap.set('n',  ff : Telescope find_files <CR>
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- For C,  pressing K on the keyword will pull up the built-in manpage directly. For instance, place the cursor on the printf keyword:
--Snippet runner
vim.keymap.set("v", "rr", ":SnipRun <CR>")
-- Better multiple lines tabbing with < and >
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
