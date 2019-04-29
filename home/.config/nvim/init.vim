" ============================================================================
" Initialization
" ISSUES:
" - [ ] polyglot is a nice conglomeration of syntax files, but it tends to
"   conflict with language-specific packages. See issues below with latex and
"   pgsql.
" - [ ] vim-pandoc is very opinionated.

" python hosts are neovim specific.
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:is_bash = 1
" set shell=zsh
let g:initialized = get(g:, 'initialized', 0)

command! Conf :e $MYVIMRC
command! ConfRefresh :source $MYVIMRC

:source $XDG_CONFIG_HOME/nvim/pkg.vim


" ==========================================================================
" PACKAGE CONFIGS
"
" --------------------------------------------------------------------------
" ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading -uu'
endif

" --------------------------------------------------------------------------
" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" --------------------------------------------------------------------------
"  better whitespace
let g:better_whitespace_enabled     = 1
let g:better_whitespace_verbosity   = 1
let g:show_spaces_that_precede_tabs = 1
let g:strip_max_file_size           = 10000
let g:strip_whitespace_confirm      = 0
let g:strip_whitespace_on_save      = 1



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

" --------------------------------------------------------------------------
"  ncm2 config
let g:ncm2#auto_popup = 0
let g:ncm2#manual_complete_length=[[1,3],[7,1]]
let g:ncm2_pyclang#library_path = '/usr/local/opt/llvm/lib'

" Comment below to disable ncm2"
autocmd BufEnter * call ncm2#enable_for_buffer()
" imap <C-x><C-o> <Plug>(ncm2_manual_trigger)
inoremap <C-space> <c-r>=ncm2#force_trigger()<cr>
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<c-r>=ncm2#force_trigger()<cr>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

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


" --------------------------------------------------------------------------
" coc config
" Accept completion snippets with <CR> instead of standard <C-y>.
" But, need to have autoselect enabled.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" let g:coc_snippet_next = '<TAB>'
" let g:coc_snippet_prev = '<S-TAB>'
" inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <c-x><c-o> coc#refresh()

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
" vmap <leader>fmt  <Plug>(coc-format-selected)
" nmap <leader>fmt  <Plug>(coc-format-selected)
" --------------------------------------------------------------------------
" LanguageClient config
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['clangd'],
            \ 'sh': ['bash-language-server', 'start'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ }
" set completefunc=LanguageClient#complete

" Let gq invoke LSC formatter.
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
" Use <Tab> to call omnicomplete and scroll through results.
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <Leader>lss :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> <Leader>lsd :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> <Leader>lsr :call LanguageClient_textDocument_rename()<CR>

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
    au User lsp_setup call lsp#register_server({
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

" --------------------------------------------------------------------------
" netrw (built-in)
" let g:netrw_banner    = 0      " Do not display info on top
let g:netrw_liststyle = 3      " default to tree-style file listing
let g:netrw_winsize   = 30     " use 30% of columns for list
let g:netrw_preview   = 1      " default to vertical splitting for preview

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
" let g:netrw_browse_split = 4
let g:netrw_altv = 1
set autochdir

 " Toggle Lexplore with Ctrl-E
" map <silent> <C-E> :Lexplore <CR>

" --------------------------------------------------------------------------
" syntax / polyglot config
" - polyglot includes LaTeX-box, which is incompatible with vimtex.
" - 2109-04-05: polyglot includes old pgsql syntax, use lifepillar's.
"   Confer https://github.com/sheerun/vim-polyglot/issues/391
"   But, using polyglot with pgsql leads to no highlighting. Removing polyglot
"   from the packpath solves this.
let g:polyglot_disabled = ['latex', 'pgsql']

" Can use autocmd in your ~/.config/nvim/filetype.vim
" to enable pgsql filetype for all it for all .sql files or some finer pattern:
" autocmd BufNewFile,BufRead *.sql setf pgsql
let g:sql_type_default = 'pgsql'

" --------------------------------------------------------------------------
"  pandoc config
let g:pandoc#syntax#conceal#use             = 0
let g:pandoc#syntax#codeblocks#embeds#use   = 1
let g:pandoc#modules#disabled               = ["folding"]
let g:pandoc#spell#enabled                  = 0
let g:pandoc#syntax#codeblocks#embeds#langs = [
    \ 'python',
    \ 'bash=sh',
    \ 'sh',
    \ 'html',
    \ 'sql',
    \ ]

" --------------------------------------------------------------------------
" commentary config
autocmd FileType cfg setlocal commentstring=#\ %s
autocmd FileType sql setlocal commentstring=--\ %s
autocmd FileType pgsql setlocal commentstring=--\ %s
" --------------------------------------------------------------------------
" signify config
" Can set guibg colors for Diff* to make the sign column more colorful.
"

" =========================================================================
" SETTINGS
"
" --------------------------------------------------------------------------
" filetype settings
let g:markdown_fenced_languages = [
    \ 'html',
    \ 'python',
    \ 'bash=sh',
    \ 'sql',
    \ ]


set inccommand=nosplit

" --------------------------------------------------------------------------
" Abbreviations
" Abbreviation for date and time stamp in RFC822 format
" iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")
" Abbreviation for ISO 8061 format.
" NOTE: The RFC 3339 format specifies that time-zones be of the form -09:37.
" Some versions of strftime support the %:z format, but not on a
" circa 2016-05-06 OS X machine.
nmap<leader>dts :put=strftime('%FT%T%z')<return>

" --------------------------------------------------------------------------
" Buffers & Windows config
set hidden      " don't close windowless buffers
set confirm     " get confirmation to discard unwritten buffers
set splitbelow  " open new buffers below
set splitright  " and to the right of the current.  Default is opposite.

" --------------------------------------------------------------------------
" generic completion config
" set completeopt=noinsert,menuone,noselect,preview
set completeopt=menuone,preview,noinsert
" Close preview window after selection.
autocmd CompleteDone * pclose

" --------------------------------------------------------------------------
" wildmenu config
set wildmenu               " command-line completion
set wildmode    =longest,full " shell-style completion behavior
set wildoptions =pum       " Show completions in popup-menu

" File types to ignore for command-line completion
set wildignore+=*.DS_Store               " OSX folder meta-data file
set wildignore+=.git,.hg,.svn            " version control system files
set wildignore+=*.o,*.obj,*.exe          " compiled object files
set wildignore+=*.jpg,*.gif,*.png,*.jpeg "binary image files
set wildignore+=*.aux,*.out,*.toc,*.pdf  "LaTeX intermediate/output files
set wildignore+=*.pyc                    " python object codes
set wildignore+=*.luac                   " lua byte code
set wildignore+=*.class                  " java/scala class files
set wildignore+=*/target/*               " sbt target directory

" --------------------------------------------------------------------------
" Display config
" set cursorline               " highlight current line, but slow
set showmode                 " show current mode at bottom of screen
set showcmd                  " show (partial) commands below statusline
set relativenumber           " show relative line numbers
set number                   " show line number of cursor
set numberwidth=4            " always make room for 4-digit line numbers
set textwidth=79
set colorcolumn=+1           " show where lines should end.
set formatoptions-=tc         " do not auto-wrap text at textwidth columns.
set lazyredraw               " don't redraw unnecessarily during macros etc.
" set nowrap                     " do not visually wrap long lines
set linebreak                " don't break words at wrap; disabled by list
" set list                     " show whitespace
set visualbell         " flash screen instead of audio bell for alert
" set visualbell t_vb=         " turn off visualbell effect
set title                    " update terminal window title
set shortmess+=A       " don't show warning for existing swapfiles
set signcolumn="yes"


" --------------------------------------------------------------------------
" Colorscheme

set termguicolors
set background=dark
" if has('nvim')
"     set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"               \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"               \,sm:block-blinkwait175-blinkoff150-blinkon175
" endif

" Attempt to get italics to work in various emulators. vim specific:
" let &t_ZH = "\e[3m"
" let &t_ZR = "\e[23m"

" --- gruvbox
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1
" let g:gruvbox_italicize_strings = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_underline = 1
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'medium'


" --- one
" NOTE: (2017-06-05) Alacritty renders italics with a gray background.
let g:one_allow_italics = 1

" --- solarized
let g:solarized_enable_extra_hi_groups = 1
" let g:solarized_old_cursor_style = 0
" let g:solarized_termtrans = 1

try
    colorscheme sim
catch /^Vim\%((\a\+)\)\=:E185/
    echom "Could not find colorscheme."
    set notermguicolors
    " set noguicursor
    colorscheme desert
endtry


" --------------------------------------------------------------------------
" Editing
set undolevels=1000            " enable many levels of undo
set undofile                   " save undo tree to file for persistent undos
set clipboard+=unnamedplus     " make yanked text available in system clipboard
set scrolloff=5                " always show n lines above or below cursor
set scrolljump=1               " scroll n lines when the cursor leaves screen
set mouse=a
set nomodeline         " modelines are a security risk
set autowrite          " write when moving to other buffers/windows


" --------------------------------------------------------------------------
" Folding
set foldenable          " default to folding on, can be toggled with 'zi'
set foldlevelstart=99   " open files completely unfolded
set foldnestmax=8       " no more than 8 levels of folds
set foldmethod=indent   " default folding method. syntax method is SLOW.
" set foldcolumn=1        " gutter fold marks

" --------------------------------------------------------------------------
" Key mapping
inoremap <C-h> <BS>
" The snippet below should let CR behave intelligently, but some plugin screws
" it up. ncm2 maybe?
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" --------------------------------------------------------------------------
" Indentation
set expandtab  " <Tab> converted to softtabstop # spaces
set softtabstop=4 " number of spaces <Tab> converted to
set tabstop=4  " number of visual spaces per <Tab> character
set shiftwidth=4 " <Tab> converts to this # spaces at beginning of line
" set smartindent " dumbindent?
" set cindent " also dumb?
filetype indent on

" --------------------------------------------------------------------------
" Search
set ignorecase
set smartcase

" --------------------------------------------------------------------------
" STATUSLINE
if !g:initialized
    set laststatus=2        " Always display statusline.
    " set paste is obsolete in neovim
    " set statusline+=%(%)%#ModeMsg#%{&paste?'\ PASTE\ ':''}%*  " paste mode
    set statusline+=%{mode()}\ \| " Current mode.
    set statusline+=\ b:\%n\ \| " Buffer number.
    set statusline+=\ %F\ \| "tail of the filename if f or full path if F
    " set statusline+=%{fugitive#statusline()}  " git branch
    set statusline+=%=              " left/right separator
    set statusline+=%{&fenc}\ \|\        " file encoding
    set statusline+=%{&ff}\ \|\           "file format
    set statusline+=%h              " help file flag
    set statusline+=%m              " modified flag
    set statusline+=%w              " preview windowflag: [Preview]
    set statusline+=%r              " read only flag
    set statusline+=%y\ \|\          " filetype
    set statusline+=%p%%\ %l:%c " % through file : line num: column num
    set statusline+=%#warningmsg#
    set statusline+=%*
endif

let g:initialized = 1
