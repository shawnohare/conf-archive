" --------------------------------------------------------------------------
" ale
" 2018-10-18T17:24:26+0000: ALE now serves as a (limited) LSP client, and
" provides things such as basic autocompletion.
" - Currently no way to make completion manual.
" - Deoplete and Jedi offer better completion (e.g., self.<complete>)
" - Linter severity is often already reported in menu.
let g:ale_linters = {
      \ 'c': ['cquery'],
      \ 'go': ['golangserver'],
      \ 'python': ['pyls', 'flake8', 'mypy'],
      \ 'sh': ['language_server', 'shellcheck', 'shfmt'],
      \ }
let g:ale_fixers= {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'sh': ['shfmt'],
      \ 'python': ['black'],
      \ }
let g:ale_fix_on_save          = 1
let g:ale_completion_enabled   = 1
let g:ale_completion_delay     = 100
let g:ale_echo_msg_format      = '[%linter%]% code%: %s'
let g:ale_lint_on_enter        = 0
let g:ale_lint_on_save         = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list            = 1
let g:ale_set_ballons          = 1
let g:ale_sign_error           = "✖" " ☓, ⚐
let g:ale_sign_warning         = "⚠"
let g:ale_python_black_options = "--py36"

" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <leader>fix <Plug>(ale_fix)
" nmap <leader>lint <Plug>(ale_lint)
" nmap <leader>find <Plug>(ale_find_references)
" nmap <leader>gd <Plug>(ale_go_to_definition)
" nmap <leader>gh <Plug>(ale_hover)
" nmap <leader>info <Plug>(ale_hover)
