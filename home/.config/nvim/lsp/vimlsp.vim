" --------------------------------------------------------------------------
" vim-lsp config
" NOTE: buggy, a:args can't be passed to lsp#register_server
" function! s:register_language_server(args) abort
"     if executable(a:args["name"])
"         echo a:args
"         autocmd User lsp_setup call lsp#register_server(a:args)
"     endif
" endfunction
"
" call s:register_language_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ })
if executable('pyls')
    " pip install python-language-server
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

let g:lsp_signs_enabled           = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error             = {'text': '✖'}
let g:lsp_signs_warning           = {'text': '⚠'}
let g:lsp_signs_hint              = {'text': '•'}

