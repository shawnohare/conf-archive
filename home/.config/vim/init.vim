" =========================================================================
" Initialization
" Packages load immediately after initialization.
" ==========================================================================

let g:is_bash = 1
" set shell=zsh
let mapleader = "\<Space>"

" --------------------------------------------------------------------------
"  ale init
" --------------------------------------------------------------------------
let g:ale_completion_enabled = 1

"==========================================================================
" Plugins
" Using vim-plug
" NOTE: We do not really make use of too many features in vim-plug. The
" async updating of packages is handy, but we could potentially replace a lot
" this with a simple bash script and the native vim8/neovim package manager.
" See :help packages
"==========================================================================
if has('nvim')
  " NOTE: Some guis do not see the environment, so we might want to
  " hardcode XDG_DATA_HOME=~/.local/share, since we use default values anyway.
  let vimplug = "$XDG_DATA_HOME/nvim/site/autoload/plug.vim"
else
  let vimplug = "~/.vim/autoload/plug.vim"
endif


" Store vim and nvim plugins in the same location. This works for dein too.
" Consider using nvim/site/pack.
let plugins = "$XDG_DATA_HOME/nvim/site/plugins"

" Auto install vim-plug if it doesn't already exist.
if empty(glob(vimplug))
  execute ' !curl -fLo ' . vimplug . ' --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin(plugins)

" Browsing
" Plug 'tpope/vim-vinegar'  " enhanced netrw file browser
" Plug 'majutsushi/tagbar'  " display tags in a window
" Plug 'ludovicchabant/vim-gutentags'

" Colorscheme
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'chriskempson/base16-vim'
" Plug 'igungor/schellar'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
" Plug 'rakr/vim-one'
" Plug 'robertmeta/nofrils'
" Plug 'romainl/Apprentice'
" Plug 'shawnohare/singularity', { 'rtp': 'vim/' }
Plug 'romainl/flattened'

" Completion
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

" Search and replace
" Plug 'mileszs/ack.vim'  " Can support ag or rg too.
Plug 'dyng/ctrlsf.vim'  " Allows in place editing like vim-ags
Plug 'gabesoft/vim-ags' " Fast find/replace across all files.
" Plug 'eugen0329/vim-esearch'
" The fzf binary is installed by nix.
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'


" Editing Enhancement
Plug 'tpope/vim-surround'      " Easy handling of surrounding brackets etc.
Plug 'jiangmiao/auto-pairs'    " Automatic closing of parentheses etc.
" Plug 'junegunn/vim-easy-align' " Easy alignment of text blocks
Plug 'tpope/vim-commentary'    " Easy toggling of comment markers
Plug 'tpope/vim-repeat'        " Make vim-surround and vim-commentary repeatable
" Plug 'kshenoy/vim-signature'   " Make marks and navigate between.
Plug 'w0rp/ale'                " buffer syntax checking, conflicts with neomake

" Source Code Management Tools
" Plug 'tpope/vim-fugitive'      " git integration for VIM
Plug 'airblade/vim-gitgutter'  " display git diffs in the gutter

" Filetype Specific
" One disadvantage of selective loading is that help files are unavailable
" when working on a different file-type.  This is an minor annoyance when
" configuring a plugin while the init file is open. Most filetype specific
" plugins tend to not load very much initially, so it could be
" advantageous to load all plugins.
" use vim-latex instead?
" NOTE: lazy-loading the julia-vim plugin causes issues
" Plug 'chrisbra/csv.vim',     { 'for': 'csv' }
" Plug 'ensime/ensime-vim' " had issues getting ensime to work
" Plug 'python-mode/python-mode', { 'for': 'python' }
" Plug 'JuliaLang/julia-vim'
" Plug 'LnL7/vim-nix',         { 'for': 'nix' }
" Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" Plug 'cespare/vim-toml',     { 'for': 'toml' }
" Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
" Plug 'fatih/vim-go',         { 'for': 'go' }
" Plug 'lervag/vimtex',        { 'for': 'tex' }
" Plug 'mattn/emmet-vim',      { 'for': 'html' }
" Plug 'mechatroner/rainbow_csv'
" Plug 'neovimhaskell/haskell-vim',     { 'for': 'haskell' }
" Plug 'othree/html5.vim',     { 'for': 'html' }
" Plug 'plasticboy/vim-markdown'
" Plug 'rust-lang/rust.vim',   { 'for': 'rust' }
" semshi is a semantic python syntax highlighter. But it slows things down.
" In the future, the various language servers might provide this feature.
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'sheerun/vim-polyglot'

" Neovim specific plugins
if has('nvim')
  " Plugins can go here.
else
  " Plugins can go here.
endif


call plug#end()

" ==========================================================================
" PLUGIN CONFIG
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
let g:ale_completion_delay = 100
let g:ale_echo_msg_format = '[%linter%]% code%: %s'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_set_ballons = 1
let g:ale_sign_error = "✖" " ☓, ⚐
let g:ale_sign_warning = "⚠"

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
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

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

colorscheme flattened_dark


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
