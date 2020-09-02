" --------------------------------------------------------------------------
" coc config
" Accept completion snippets with <CR> instead of standard <C-y>.
" But, need to have autoselect enabled.
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gh <Plug>(coc-action-doHover)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
vmap <leader>fmt  <Plug>(coc-format-selected)
nmap <leader>fmt  <Plug>(coc-format-selected)
