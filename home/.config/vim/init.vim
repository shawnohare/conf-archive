" ============================================================================ 
" Initialization

" python hosts are neovim specific.
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:is_bash = 1
" set shell=zsh
let mapleader = "\<Space>"
let g:initialized = get(g:, 'initialized', 0)

" --------------------------------------------------------------------------
" align vim and nvim: settings that nvim toggles / removes by deafult.
if !has('nvim')
    syntax on
    set termguicolors
    set autoindent
    set autoread           " reread files that have been changed while open
    set backspace=indent,eol,start " backspace over line breaks, insertion, start
    set display+=lastline        " display as much as possible of the last line
    set encoding=utf-8
    set history=10000
    set hlsearch
    set incsearch
    set listchars   =tab:>-,trail:.,extends:#,nbsp:. ",tab:>-,eol:¶ " customize whitespace look
    set nocompatible
    set smarttab
    set tabpagemax=50

    " italics
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"

    set runtimepath ^=$XDG_CONFIG_HOME/vim
    set runtimepath +=$XDG_CONFIG_HOME/vim/after
    set packpath    ^=$XDG_DATA_HOME/vim/site
    set packpath    +=$XDG_DATA_HOME/vim/site/after
endif


" ============================================================================
" Packages / Plugins
" Loading handled by the builtin package loader, cf., :h packages
" Management (install / update / clean) handled by minpac.
" minpac is lazily loaded, since runtime path augmentation is handled natively.
"
" The main disadvantage of utilizing the native package loader and lazy
" package management is that packages cannot be easily toggled on or off
" within the rc file. This can probably be accomplished by simply calling
" packadd directly and making all packages optionally loaded.
"
" Update packpath to utilize same packages for vim8+/neovim.
" As of 2019-01-17 there are a few competing Language Server Client 
" implementations. The main ones:
"
" 1. vim-lsp. Pure vimscript, integrates with ncm2. Incremental updates.
"    Barebones config.
" 2. vim-lsc. Pure vimscript. Highlights errors. Incremental updates.
" 3. ale. Linting / formatting engine that can provide completion from
"    language servers. 
" 4. LanguageClient-neovim. Rust, ncm2 integration, no incremental update.
" 5. coc (Conquer of Completion). Tries to emulate vscode more fully, and
"    claims to support snippets and the like out of the box.
" 6. Native neovim (slated for version 0.5). Probably would be low level
"    and utilized by one of the above plugins.

" FIXME: Updating the packpath to share packages between vim and nvim
" leads to some runtimepath issues. These can likely be resolved, e.g.,
" see h: nvim-from-vim, but it's easy to just duplicate the package code.
if has('nvim')
    let s:pack_home = $XDG_DATA_HOME . '/nvim/site'
    " let s:minpac_home = "$XDG_DATA_HOME/nvim/site/pack/minpac/opt/minpac"
    " set packpath^=$XDG_DATA_HOME/nvim/site/
else
    let s:pack_home = $XDG_DATA_HOME . '/vim/site'
    " let s:minpac_home = "$XDG_DATA_HOME/vim/site/pack/minpac/opt/minpac"
    " set packpath^=$XDG_DATA_HOME/vim/site
endif

function! s:coc_install_extensions() abort
    " This could also be controlled via specifying 
    " $XDG_DATA_HOME/coc/extensions/package.json
    packadd coc.nvim
    call coc#add_extension(
                \ 'coc-json',
                \ 'coc-pairs',
                \ 'coc-snippets',
                \ 'coc-pyls',
                \ 'coc-html',
                \ 'coc-css',
                \ 'coc-yaml',
                \ 'coc-emmet',
                \ 'coc-dictionary',
                \)
endfunction

" minpac post-update hook for coc
" The coc#util#install command fetches a prebuilt binary.
" Alternatively, `yarn install`` can called the post_update hook.
" Extensions rely on yarn being installed. 
" Extensions defined in $XDG_DATA_HOME/coc/extensions/package.json 
" are fetched by :CocUpdate, if yarn is installed.
" Since extensions and coc config are external files, it makes sense to
" version them for the time being. 
" yarn itself can be installed via npm. The architecture independent 
" yarn install script unfortunately dumps it into ~/.yarn, 
" Can install node via nvm or brew or pkgsrc. 
" For now, it's probably easiest to just install node manually since
" we do not develope javascript.
function! s:coc_init(hooktype, name) abort
    " Ensure yarn package manager is installed.
    if !executable('yarn') 
        execute '!npm install --global yarn'
    endif

    " Get prebuilt binary for macOS or Linux or build from source via yarn.
    try
        call coc#util#install()
    catch
        execute '!yarn install'
    endtry

    call s:coc_install_extensions()
endfunction

function! PackInit() abort
    packadd minpac
    " minpac uses the first dir of packpath unless configured by `dir`.
    call minpac#init({'dir': s:pack_home})
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.
    " call minpac#add('airblade/vim-gitgutter')
    " call minpac#add('dyng/ctrlsf.vim')
    " call minpac#add('jiangmiao/auto-pairs')
    
    " Colorscheme plugins
    call minpac#add('icymind/NeoSolarized', {'type': 'opt'})
    " call minpac#add('dracula/vim', {'name': 'dracula', 'type': 'opt'})
    call minpac#add('morhetz/gruvbox')
    call minpac#add('romainl/flattened')
    call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})

    call minpac#add('brooth/far.vim')
    call minpac#add('SidOfc/mkdx')
    " Using builtin package manager seems to call polyglot to not load.
    call minpac#add('sheerun/vim-polyglot')
    " call minpac#add('vim-python/python-syntax')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-dadbod')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-endwise')
    " call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    " call minpac#add('vim-airline/vim-airline')
    call minpac#add('wellle/targets.vim')
    call minpac#add('lervag/vimtex')
    call minpac#add('mhinz/vim-signify')

    " Experiment with ncm2.
    " NOTE: ncm2 suffers from requiring multiple dependencies.
    if has('nvim')
        call minpac#add('ncm2/ncm2') | call minpac#add('roxma/nvim-yarp')
        call minpac#add('ncm2/ncm2-path')
        call minpac#add('ncm2/ncm2-bufword')
        call minpac#add('ncm2/ncm2-pyclang')
        "  " call minpac#add('ncm2/ncm2-ultisnips') | call minpac#add('SirVer/ultisnips')
        call minpac#add('ncm2/ncm2-vim') | call minpac#add('Shougo/neco-vim')
        call minpac#add('ncm2/ncm2-vim-lsp')
    endif

    " Optional packages here. Useful when experimenting.
    call minpac#add('w0rp/ale', {'type': 'opt'})
    call minpac#add('autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': {-> system('bash install.sh')},
                \ 'type': 'opt'
                \ })
    call minpac#add('natebosch/vim-lsc', {'type': 'opt'})
    call minpac#add('prabirshrestha/vim-lsp', {'type': 'opt'})
    call minpac#add('prabirshrestha/async.vim', {'type': 'opt'})

    " CoC (node based LSC)
    " NOTE:
    " - Installation requires yarn.
    " - Some extensions are installed via coc commands.
    " - coc utilizes its own config. Can extensions be listed there?
    "   - :CocInstall is basically same as yarn add extension.
    "   - So could version manage the extensions explicitly in git by
    "     defining the package.json file
    
    " call minpac#add('neoclide/coc.nvim', {'type': 'opt', 'do': function('s:coc_init')})
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#clean() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! CocInstallExtensions call PackInit() | call s:coc_install_extensions()
command! ConfEdit :vs $MYVIMRC 
command! ConfRefresh :source $MYVIMRC 


" Bootstrap minpac
let s:minpac_home = s:pack_home . '/pack/minpac/opt/minpac'
if empty(glob(s:minpac_home))
    execute '!git clone https://github.com/k-takata/minpac.git ' . s:minpac_home
    call PackInit()
    call minpac#update()
    " Assumes MYVIMRC is previously set.
    " autocmd VimEnter * packloadall | source $MYVIMRC
    autocmd VimEnter * source $MYVIMRC
endif

" Load optional packages.
" packadd ale
" packadd coc.nvim
" packadd LanguageClient-neovim
" packadd vim-lsc
" packadd vim-lsp | packadd async.vim



" ==========================================================================
" PACKAGE CONFIGS
"
" --------------------------------------------------------------------------
" ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading -uu'
endif

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
if has('nvim')
    autocmd BufEnter * call ncm2#enable_for_buffer()
    imap <C-x><C-o> <Plug>(ncm2_manual_trigger)
    imap <C-SPACE> <Plug>(ncm2_manual_trigger)
endif


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
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_echo_msg_format = '[%linter%]% code%: %s'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_set_ballons = 1
let g:ale_sign_error = "✖" " ☓, ⚐
let g:ale_sign_warning = "⚠"
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

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '✖'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '•'}

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
" polyglot config
" polyglot includes LaTeX-box, which is incompatible with vimtex.
let g:polyglot_disabled = ['latex']

" --------------------------------------------------------------------------
" signify config 
" Can set guibg colors for Diff* to make the sign column more colorful. 
"

" =========================================================================
" SETTINGS

if has('nvim')
  set inccommand=nosplit
endif

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
set completeopt=noinsert,menuone,noselect,preview
" Close preview window after selection.
autocmd CompleteDone * pclose

" --------------------------------------------------------------------------
" wildmenu config 
set wildmenu                             " command-line completion
set wildmode=list:longest,full           " shell-style completion behavior
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
if has('nvim')
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
              \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
              \,sm:block-blinkwait175-blinkoff150-blinkon175
endif

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
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
    set statusline+=\ b%n\ \| " Buffer number.
    set statusline+=\ %f\ \| "tail of the filename if f or full path if F
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
