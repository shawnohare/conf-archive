" --------------------------------------------------------------------------
" LanguageClient config
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = 'all'
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['clangd'],
            \ 'sh': ['bash-language-server', 'start'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ }

" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <Leader>lss :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> <Leader>lsd :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> <Leader>lsr :call LanguageClient_textDocument_rename()<CR>
" set completefunc=LanguageClient#complete
" inoremap <silent> <c-space> <c-x><c-o>
