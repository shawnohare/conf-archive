"  ncm2 config
"  Meant primarily as a backup, since we have largely moved away
"  from using ncm2.
"
let g:ncm2#auto_popup = 0
let g:ncm2#manual_complete_length=[[1,3],[7,1]]
let g:ncm2_pyclang#library_path = '/usr/local/opt/llvm/lib'

autocmd BufEnter * call ncm2#enable_for_buffer()
inoremap <c-space> <c-r>=ncm2#force_trigger()<cr>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <C-x><C-o> <Plug>(ncm2_manual_trigger)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<c-r>=ncm2#force_trigger()<cr>"

