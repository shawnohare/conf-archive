" ============================================================================
" Initialization

" python hosts are neovim specific.
let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:is_bash = 1
" set shell=zsh
let mapleader = "\<Space>"

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
"
" Update packpath to utilize same packages for vim8+/neovim.
set packpath^=$XDG_DATA_HOME/vim/site
let minpac_home = "$XDG_DATA_HOME/vim/site/pack/minpac/opt/minpac"

function! PkgInit() abort
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
    call minpac#add('wellle/targets.vim')
    call minpac#add('lervag/vimtex')

    " call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': {-> system('bash install.sh')}})
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PkgUpdate call PackInit() | call minpac#clean() | call minpac#update() | call minpac#status()
command! PkgClean  call PackInit() | call minpac#clean()
command! PkgStatus call PackInit() | call minpac#status()


" Bootstrap minpac
if empty(glob(minpac_home))
    execute '!git clone https://github.com/k-takata/minpac.git ' . minpac_home
    call PkgInit()
    call minpac#update()
    " Assumes MYVIMRC is previously set.
    autocmd VimEnter * packloadall | source $MYVIMRC
endif


" ==========================================================================
" PACKAGE CONFIGS
"
" --------------------------------------------------------------------------
" ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading -uu'
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
" polyglot includes LaTeX-box, which is incompatible with vimtex.
let g:polyglot_disabled = ['latex']

" --------------------------------------------------------------------------
" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" --------------------------------------------------------------------------
" tagbar
nmap <Leader>tag :TagbarToggle<CR>


" =========================================================================
" SETTINGS

" --------------------------------------------------------------------------
" align vim and nvim: settings that nvim toggles / removes by deafult.
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
" Abbreviation for date and time stamp in RFC822 format
" iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")
" Abbreviation for ISO 8061 format.
" NOTE: The RFC 3339 format specifies that time-zones be of the form -09:37.
" Some versions of strftime support the %:z format, but not on a
" circa 2016-05-06 OS X machine.
nmap<leader>dts :put=strftime('%FT%T%z')<return>

" --------------------------------------------------------------------------
" Buffers & Windows
set hidden      " don't close windowless buffers
set confirm     " get confirmation to discard unwritten buffers
set splitbelow  " open new buffers below
set splitright  " and to the right of the current.  Default is opposite.

" --------------------------------------------------------------------------
" Completion
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
