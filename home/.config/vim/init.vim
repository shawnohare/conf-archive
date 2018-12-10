" ============================================================================
" Initialization
" Packages load immediately after initialization.
" TODO:
" - [ ] Use native package manager or minpac wrapper.
" - [ ] Further package audit.
" - [ ] Explore whether using packadd with opt packages.
" ============================================================================
"
" ============================================================================
" Packages / Plugins
" Loading handled by the builtin package loader, cf., :h packages
" Management (install / update / clean) handled by minpac.
" minpac is lazily loaded, since runtime path augmentation is handled natively.
" To enable lazy loading, it is installed in minpac/opt/
"
" The main disadvantage of utilizing the native package loader and lazy
" package management is that packages cannot be easily toggled on or off
" within the rc file. This can probably be accomplished by simply calling
" packadd directly and making all packages optionally loaded.
" ----------------------------------------------------------------------------
"
" Update packpath to utilize same packages for vim8+/neovim.
set packpath^=$XDG_DATA_HOME/vim/site
let minpac_home = "$XDG_DATA_HOME/vim/site/pack/minpac/opt/minpac"

function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('dyng/ctrlsf.vim')
    call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('lifepillar/vim-solarized8')
    call minpac#add('morhetz/gruvbox')
    call minpac#add('romainl/flattened')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    call minpac#add('w0rp/ale')

    " call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': {-> system('bash install.sh')}})
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#clean() | call minpac#update() | call minpac#status()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()


" Bootstrap minpac
if empty(glob(minpac_home))
    execute '!git clone https://github.com/k-takata/minpac.git ' . minpac_home
    call PackInit()
    call minpac#update()
    " Assumes MYVIMRC is previously set.
    autocmd VimEnter * packloadall | source $MYVIMRC
endif
" ============================================================================

" python hosts are neovim specific.
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'

let g:is_bash = 1
" set shell=zsh
let mapleader = "\<Space>"

"==========================================================================
" TODO: Delete vim-plug config

" Browsing
" call minpac#add('tpope/vim-vinegar'  " enhanced netrw file browser
" call minpac#add('majutsushi/tagbar'  " display tags in a window
" call minpac#add('ludovicchabant/vim-gutentags'

" Colorscheme
" call minpac#add('rafi/awesome-vim-colorschemes'
" call minpac#add('chriskempson/base16-vim'
" call minpac#add('igungor/schellar'
" call minpac#add('lifepillar/vim-solarized8'
" call minpac#add('morhetz/gruvbox'
" " call minpac#add('rakr/vim-one'
" " call minpac#add('robertmeta/nofrils'
" " call minpac#add('romainl/Apprentice'
" " call minpac#add('shawnohare/singularity', { 'rtp': 'vim/' }
" call minpac#add('romainl/flattened'

" " Completion
" " call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

" " Search and replace
" " call minpac#add('mileszs/ack.vim'  " Can support ag or rg too.
" call minpac#add('dyng/ctrlsf.vim'  " Allows in place editing like vim-ags
" call minpac#add('gabesoft/vim-ags' " Fast find/replace across all files.
" " call minpac#add('eugen0329/vim-esearch'
" " The fzf binary is installed by nix.
" " call minpac#add('junegunn/fzf'
" " call minpac#add('junegunn/fzf.vim'


" " Editing Enhancement
" call minpac#add('tpope/vim-surround'      " Easy handling of surrounding brackets etc.
" call minpac#add('jiangmiao/auto-pairs'    " Automatic closing of parentheses etc.
" " call minpac#add('junegunn/vim-easy-align' " Easy alignment of text blocks
" call minpac#add('tpope/vim-commentary'    " Easy toggling of comment markers
" call minpac#add('tpope/vim-repeat')        " Make vim-surround and vim-commentary repeatable
" " call minpac#add('kshenoy/vim-signature'   " Make marks and navigate between.
" call minpac#add('w0rp/ale'                " buffer syntax checking, conflicts with neomake

" " Source Code Management Tools
" " call minpac#add('tpope/vim-fugitive'      " git integration for VIM
" call minpac#add('airblade/vim-gitgutter'  " display git diffs in the gutter

" " Filetype Specific
" " One disadvantage of selective loading is that help files are unavailable
" " when working on a different file-type.  This is an minor annoyance when
" " configuring a plugin while the init file is open. Most filetype specific
" " plugins tend to not load very much initially, so it could be
" " advantageous to load all plugins.
" " use vim-latex instead?
" " NOTE: lazy-loading the julia-vim plugin causes issues
" " call minpac#add('chrisbra/csv.vim',     { 'for': 'csv' }
" " call minpac#add('ensime/ensime-vim' " had issues getting ensime to work
" " call minpac#add('python-mode/python-mode', { 'for': 'python' }
" " call minpac#add('JuliaLang/julia-vim'
" " call minpac#add('LnL7/vim-nix',         { 'for': 'nix' }
" " call minpac#add('Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" " call minpac#add('cespare/vim-toml',     { 'for': 'toml' }
" " call minpac#add('derekwyatt/vim-scala', { 'for': 'scala' }
" " call minpac#add('fatih/vim-go',         { 'for': 'go' }
" " call minpac#add('lervag/vimtex',        { 'for': 'tex' }
" " call minpac#add('mattn/emmet-vim',      { 'for': 'html' }
" " call minpac#add('mechatroner/rainbow_csv'
" " call minpac#add('neovimhaskell/haskell-vim',     { 'for': 'haskell' }
" " call minpac#add('othree/html5.vim',     { 'for': 'html' }
" " call minpac#add('plasticboy/vim-markdown'
" " call minpac#add('rust-lang/rust.vim',   { 'for': 'rust' }
" " semshi is a semantic python syntax highlighter. But it slows things down.
" " In the future, the various language servers might provide this feature.
" " call minpac#add('numirias/semshi', {'do': ':UpdateRemotePlugins'}
" call minpac#add('sheerun/vim-polyglot'

" " Neovim specific plugins
" if has('nvim')
"   " Plugins can go here.
" else
"   " Plugins can go here.
" endif


" call plug#end()
"==========================================================================

" ==========================================================================
" PACKAGE / PLUGIN CONFIG
" ==========================================================================
"
" --------------------------------------------------------------------------
" ack
" --------------------------------------------------------------------------
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading -uu'
endif

" ---
" lsp
" ---

" --------------------------------------------------------------------------
" ale
" 2018-10-18T17:24:26+0000: ALE now serves as a (limited) LSP client, and
" provides things such as basic autocompletion.
" - Currently no way to make completion manual.
" - Deoplete and Jedi offer better completion (e.g., self.<complete>)
" - Linter severity is often already reported in menu.
" --------------------------------------------------------------------------
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

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <leader>fix <Plug>(ale_fix)
nmap <leader>lint <Plug>(ale_lint)
nmap <leader>find <Plug>(ale_find_references)
nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>gh <Plug>(ale_hover)
nmap <leader>info <Plug>(ale_hover)


" --------------------------------------------------------------------------
" LanguageClient-neovim
" --------------------------------------------------------------------------
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }


" Use <Tab> to call omnicomplete and scroll through results.
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <Leader>lss :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> <Leader>lsd :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> <Leader>lsr :call LanguageClient_textDocument_rename()<CR>



" --------------------------------------------------------------------------
" netrw (built-in)
" --------------------------------------------------------------------------
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
" polyglot
" --------------------------------------------------------------------------
let g:polyglot_disabled = ['latex']

" --------------------------------------------------------------------------
" vim-easy-align
" --------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)


" --------------------------------------------------------------------------
" tagbar
" --------------------------------------------------------------------------
nmap <Leader>tag :TagbarToggle<CR>


" =========================================================================
" SETTINGS
" =========================================================================

" --------------------------------------------------------------------------
" align vim and nvim: settings that nvim toggles / removes by deafult.
" --------------------------------------------------------------------------
if has('vim')
  set autoindent
  set autoread           " reread files that have been changed while open
  set backspace   = indent,eol,start " backspace over line breaks, insertion, start
  set display    += lastline        " display as much as possible of the last line
  set encoding    = utf-8
  set history     = 10000
  set hlsearch
  set incsearch
  set listchars   = tab:>-,trail:.,extends:#,nbsp:. ",tab:>-,eol:¶ " customize whitespace look
  set nocompatible
  set smarttab
  set tabpagemax  = 50
endif

if has('nvim')
    set inccommand=nosplit
endif

" --------------------------------------------------------------------------
" Abbreviations
" --------------------------------------------------------------------------
" Abbreviation for date and time stamp in RFC822 format
" iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")
" Abbreviation for ISO 8061 format.
" NOTE: The RFC 3339 format specifies that time-zones be of the form -09:37.
" Some versions of strftime support the %:z format, but not on a
" circa 2016-05-06 OS X machine.
nmap<leader>date :put=strftime('%FT%T%z')<return>
" --------------------------------------------------------------------------
" Buffers & Windows
" --------------------------------------------------------------------------
set hidden      " don't close windowless buffers
set confirm     " get confirmation to discard unwritten buffers
set splitbelow  " open new buffers below
set splitright  " and to the right of the current.  Default is opposite.

" --------------------------------------------------------------------------
" Completion
" --------------------------------------------------------------------------
"  FIXME Fri, 12 Feb 2016 09:40:54 -0800
"  The preview option for completeopt worked weird with neovim and deoplete.
" See https://github.com/zchee/deoplete-go/issues/40
set completeopt=longest,menuone,preview,noselect,noinsert
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
" Display
" --------------------------------------------------------------------------
syntax on                    " enable syntax highlighting
" set cursorline               " highlight current line, but slow
set showmode                 " show current mode at bottom of screen
set showcmd                  " show (partial) commands below statusline
" set showmatch                " show matching delimiters
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
" set guifont=SFMono
set shortmess+=A       " don't show warning for existing swapfiles


" --------------------------------------------------------------------------
" Colorscheme
" --------------------------------------------------------------------------

set termguicolors
set background=dark

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
    colorscheme flattened_dark
catch /^Vim\%((\a\+)\)\=:E185/
    set notermguicolors
    colorscheme desert
endtry


" --------------------------------------------------------------------------
" Editing
" --------------------------------------------------------------------------

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
" --------------------------------------------------------------------------

set foldenable          " default to folding on, can be toggled with 'zi'
set foldlevelstart=99   " open files completely unfolded
set foldnestmax=8       " no more than 8 levels of folds
set foldmethod=indent   " default folding method. syntax method is SLOW.
" set foldcolumn=1        " gutter fold marks

" --------------------------------------------------------------------------
" Key mapping
" --------------------------------------------------------------------------
inoremap <C-h> <BS>

" Switch between light and dark backgrounds.
nmap<leader>bgs :let &background = ( &background == "dark"? "light" : "dark")<CR>


" --------------------------------------------------------------------------
" Indentation
" --------------------------------------------------------------------------
set expandtab  " <Tab> converted to softtabstop # spaces
set softtabstop=4 " number of spaces <Tab> converted to
set tabstop=4  " number of visual spaces per <Tab> character
set shiftwidth=4 " <Tab> converts to this # spaces at beginning of line
" set smartindent " dumbindent?
" set cindent " also dumb?
filetype indent on

" --------------------------------------------------------------------------
" Search
" --------------------------------------------------------------------------
set ignorecase
set smartcase

" --------------------------------------------------------------------------
" STATUSLINE
" --------------------------------------------------------------------------
set laststatus=2        " Always display statusline.
set statusline+=%n\ \|\  " Buffer number.
set statusline+=%f\ \|\  "tail of the filename if f or full path if F
set statusline+=%{mode()}  " Current mode.
" set statusline+=%{fugitive#statusline()}  " git branch
set statusline+=%(\ %)%#ModeMsg#%{&paste?'\ PASTE\ ':''}%*  " paste mode
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
