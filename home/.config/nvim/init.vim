" ============================================================================
" Initialization
" ISSUES:
" - [ ] polyglot is a nice conglomeration of syntax files, but it tends to
"   conflict with language-specific packages. See issues below with latex and
"   pgsql.
" - [ ] Consider extracting out LSP configs until we settle on one.

" python hosts are neovim specific.

if executable('conda')
    let s:python_host_prefix = $CONDA_ENVS_HOME
else
    let s:python_host_prefix = $PYENV_ROOT . '/versions'
endif

let g:python_host_prog  = s:python_host_prefix . '/neovim2/bin/python'
let g:python3_host_prog  = s:python_host_prefix . '/neovim3/bin/python'
let g:loaded_python_provider = 0

if exists('g:vscode')
    " TODO: Could source code values here.
    " Or could maintain two different rcs.
    finish
endif


let g:is_bash = 1
" set shell=zsh
let mapleader = "\<Space>"
let g:initialized = get(g:, 'initialized', 0)

" --------------------------------------------------------------------------
"  commands
command! Conf :e $MYVIMRC
command! Reload :source $MYVIMRC

" Lazily load package management functions.
try
    :source $XDG_CONFIG_HOME/nvim/pkg.vim
catch
endtry


" ==========================================================================
" package loading
" Load optional packages
" --- language server protocol (lsp) clients
" packadd ale
packadd coc.nvim
" packadd LanguageClient-neovim
" packadd vim-lsc
" packadd vim-lsp | packadd async.vim

" FIXME: nvim-treesitter is a lua plugin, and it does not seem that
" packages in the start dir are searched for lua code (not part of rtp?).
" So the question is whether we should make all packages optional. That way
" loading can be more easily configured which packages we load, without
" deleting the source.
packadd nvim-treesitter


" ==========================================================================
" PACKAGE CONFIGS
"
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
"  ncm2 config
" let g:ncm2#auto_popup = 0
" let g:ncm2#manual_complete_length=[[1,3],[7,1]]
" let g:ncm2_pyclang#library_path = '/usr/local/opt/llvm/lib'

" Comment below to disable ncm2"
" begin experiment
" autocmd BufEnter * call ncm2#enable_for_buffer()
" inoremap <c-space> <c-r>=ncm2#force_trigger()<cr>
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" end experiment
" imap <C-x><C-o> <Plug>(ncm2_manual_trigger)
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<c-r>=ncm2#force_trigger()<cr>"

" --------------------------------------------------------------------------
" LSP
" Source one of the config files in the lsp subdir


try
    :source $XDG_CONFIG_HOME/lsp/coc.vim
    " :source $XDG_CONFIG_HOME/lsp/languageClient.vim
catch
endtry

" --------------------------------------------------------------------------
"  treesitter
"  FIXME: Has some interesting features that compete with lsp, but slow load.
lua require('treesitter')

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
    \ 'xml',
    \ 'sql',
    \ 'ini=dosini',
    \ 'cfg',
    \ 'json',
    \ ]

"  --------------------------------------------------------------------------
"  vimtex
let g:tex_flavor = 'latex'

" --------------------------------------------------------------------------
" comment config
autocmd FileType cfg setlocal commentstring=#\ %s
autocmd FileType sql setlocal commentstring=--\ %s
autocmd FileType pgsql setlocal commentstring=--\ %s
autocmd FileType xdefaults setlocal commentstring=!\ %s
autocmd FileType groovy setlocal commentstring=//\ %s
autocmd FileType Jenkinsfile setlocal commentstring=//\ %s
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
    \ 'json',
    \ 'yaml',
    \ ]


set inccommand=nosplit

" --------------------------------------------------------------------------
" Abbreviations
nmap<leader>dts :put=strftime('%FT%T%z')<return>

" --------------------------------------------------------------------------
" Buffers & Windows config
set hidden      " don't close windowless buffers
set confirm     " get confirmation to discard unwritten buffers
set splitbelow  " open new buffers below
set splitright  " and to the right of the current.  Default is opposite.

" --------------------------------------------------------------------------
" generic completion config
set completeopt=noinsert,menuone,noselect
" Close preview window after selection.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" FIXME: inserts textpumvisible() ? "\-" : "\\
" #inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" --------------------------------------------------------------------------
" wildmenu config
set wildmenu     " command-line completion
" set wildmode    =longest,full " shell-style completion behavior
set wildoptions=pum       " Show completions in popup-menu, uses completeopt
set pumblend=10

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
set nowrap                     " do not visually wrap long lines
set linebreak                " don't break words at wrap; disabled by list
" set list                     " show whitespace
set visualbell         " flash screen instead of audio bell for alert
" set visualbell t_vb=         " turn off visualbell effect
set title                    " update terminal window title
set shortmess+=A       " don't show warning for existing swapfiles
set signcolumn="yes"


" --------------------------------------------------------------------------
" Colorschemes
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
let g:one_allow_italics = 1

try
    colorscheme sim
catch /^Vim\%((\a\+)\)\=:E185/
    echom "Could not find colorscheme."
    set notermguicolors
    set noguicursor
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
