" --------------------------------------------------------------------------
" vim-lsc config
" NOTE: 2019-01-06T15:01:47-0800
" Completion works for class attributes, but type info not provided.
" This appears to be true also for LanguageClient-Neovim.
" The default invokations mimic vim commands, which is a plus.
" Seems to call python3complete?
" set completefunc=lsc#complete#complete
let g:lsc_enable_autocomplete = v:true
" let g:lsc_auto_map = v:true " Use defaults
let g:lsc_auto_map = {
    \ 'defaults': v:true,
    \ 'GoToDefinition': '<C-]>',
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'ShowHover': 'v:true',
    \ 'SignatureHelp': '<C-m>',
    \ 'Completion': 'completefunc',
    \}

" Default mappings.
" <C-]>                   |:LSClientGoToDefinition|
" gr                      |:LSClientFindReferences|
" <C-n>                   |:LSClientNextReference|
" <C-p>                   |:LSClientPreviousReference|
" gI                      |:LSClientFindImplementations|
" go                      |:LSClientDocumentSymbol|
" gS                      |:LSClientWorkspaceSymbol|
" ga                      |:LSClientFindCodeActions|
" gR                      |:LSClientRename|
" |K| (via |keywordprg|)  |:LSClientShowHover|
"
let g:lsc_server_commands = {
        \ 'python': 'pyls',
        \ }

