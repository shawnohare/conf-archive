"======================================================================"
" .vimrc
" Last changed: Sun, 26 Oct 2014 09:06:37 -0700
"
"----------------------------------------------------------------------"

set nocompatible " this is actually assumed when this .vimrc file exists

" Load Plugins first to ensure that they are available to settings

"======================================================================"
" Plugins
"

" Plugins are managed with Vundle.vim

filetype off " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim " required for Vundle
call vundle#begin() " required for Vundle

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle; required for Vundle

" GitHub-served plugins managed by Vundle are specified in the format:
" Plugin 'github_account/repository_name'

" Completion & Search Plugins
Plugin 'kien/ctrlp.vim' " full path fuzzy file, buffer, MRU, tag finder
Plugin 'ervandew/supertab' " use '<Tab>' for smart omnicompletions

" Editing Enhancement Plugins
Plugin 'mbbill/undotree' " visual navigation of VIM undotree
Plugin 'tpope/vim-surround' " easy handling of surrounding brackets etc.
Plugin 'Raimondi/delimitMate' " automatic closing of parentheses etc.
Plugin 'junegunn/vim-easy-align' " easy alignment of text blocks
Plugin 'tpope/vim-commentary' " easy toggling of comment markers

" Source Code Management Tool Plugins
Plugin 'tpope/vim-fugitive' " git integration for VIM
Plugin 'scrooloose/syntastic' " syntax checking for many languages

" Appearance Plugins
Plugin 'altercation/vim-colors-solarized' " high-contrast colorscheme

" Filetype Specific Plugins
Plugin 'LaTeX-Box-Team/LaTeX-Box' " LaTeX support

" All plugins must be added before the following lines
call vundle#end() " required for Vundle
filetype plugin indent on " enable filetype detection after Vundle is done

"======================================================================"
" Plugin Configuration
"

" netrw (built-in)
let g:netrw_liststyle = 3 " default to tree-style file listing
let g:netrw_winsize   = 30 " use 30% of columns for list
let g:netrw_preview   = 1 " default to vertical splitting for preview
 
" ctrlp
if executable("ag")
    " Use Ag in CtrlP for listing files
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

    " Ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" supertab
let g:SuperTabDefaultCompletionType = "context"

" undotree
nnoremap <Leader>u :UndotreeToggle<cr>

" vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" vim-colors-solarized

" Toggle solarized colorscheme background between dark and light
call togglebg#map("<F5>")

" syntastic
let g:syntastic_mode_map = { "mode":"passive",
            \"active_filetypes": ["haskell", "tex", "python",
            \ "ruby", "scala"],
            \"passive_filetypes": [ ]}
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']
let g:syntastic_tex_checkers = ['chktex', 'lacheck']
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_ruby_checkers = ['mri', 'ruby']
let g:syntastic_scala_checkers = ['scalac', 'scalastyle']
let g:syntastic_markdown_checkers = ['mdl']

let g:syntastic_enable_signs=1

"======================================================================"
" Settings
"

"----------------------------------------------------------------------"
" Display
"

syntax enable " enable syntax highlighting
set showmode " show current mode at bottom of screen
set showcmd " show (partial) commands below statusline
set showmatch " show matching paretheses, brackets, and braces
set relativenumber " display relative line numbers
set number " display line number of cursor location
set numberwidth=4 " always make room for 4-digit line numbers
" set colorcolumn=+1 " show where lines should end
set display+=lastline " display as much as possible of the last line
set lazyredraw " don't redraw unnecessarily during macros etc.
set ttyfast " indicate that the terminal connection is fast
set wrap " wrap long lines
set linebreak " don't break words when wrapping; will be disabled by list
set listchars=tab:>-,trail:.,eol:$,extends:#,nbsp:. " show whitespace
set visualbell " flash screen instead of audio bell for alert
" set visualbell t_vb= " turn off visualbell effect
" set title " update terminal window title
set shortmess+=A " don't show "ATTENTION" warning for existing swapfiles
set background=dark
colorscheme solarized
" When using solarized without custom terminal colors use the following
" let g:solarized_termcolors=256
" When running without plugins use the desert colorscheme
" colorscheme desert " a nice dark built-in colorscheme

"----------------------------------------------------------------------"
" Editing
"

set backspace=indent,eol,start " backspace over line breaks, insertion start
set history=1000 " by default command history is only the last 20
set undolevels=1000 " enable many levels of undo
set undofile " save undo tree to file for persistent undos
set clipboard+=unnamed " make yanked text avilable in system clipboard
set scrolloff=3 " always show 3 lines above or below cursor when scrolling
set scrolljump=3 " scroll 3 lines when the cursor would leave the screen

"----------------------------------------------------------------------"
" File Handling
"

set nomodeline " don't use modelines, they are a security risk
set autoread " reread files that have been changed while open
set autowrite " write modified files when moving to other buffers/windows
set encoding=utf-8  " the encoding displayed

"----------------------------------------------------------------------"
" VIM Files
"

set directory=/var/tmp//,/tmp// " set swap file directory
set backupdir=/var/tmp//,/tmp// " set backup file directory
set undodir=/var/tmp//,/tmp// " set undo file directory

"----------------------------------------------------------------------"
" Indentation & Formatting
"

set autoindent " retain indentation on next line for non-specific filetypes
set shiftwidth=4 " by default indent 4 spaces using '>>'
" set tabstop=4 " show tabs as 4 spaces (default is 8)
set softtabstop=4 " when editing tabs are 4 spaces wide
set expandtab " all tabs are converted to spaces
set smarttab " use 'shiftwidth' for tabs rather than 'tabstop'
set shiftround " round all indentation to multiples of 'shiftwidth'
set nojoinspaces " make 'J' and 'gq' only add one space after a period
set textwidth=79 " default format of no more than 79 characters in a line
" set formatoptions=tcq " this is the default, add 'a' for auto-rewrap

"----------------------------------------------------------------------"
" Buffers & Windows
"

set hidden " don't close windowless buffers
set confirm " get confirmation to discard unwritten buffers
" Open new windows below and to the right (default is opposite)
set splitbelow
set splitright

"----------------------------------------------------------------------"
" Search & Substitution
"

set hlsearch " highlight search results
set incsearch " incremental search begins as you type
set ignorecase " use case insensitive search
set smartcase " except when capital letters are entered in the pattern
set gdefault " make substitutions global (full-line) by default

" Use Ag, The Silver Searcher, for grep
if executable("ag")
    " Use Ag as grep program
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --hidden

    " Set a more complete grepformat
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Add an 'Ag' command
    com! -nargs=+ -complete=file_in_path -bar Ag silent grep! <args>|cw|redr!
endif

"----------------------------------------------------------------------"
" Completion
"

set completeopt+=longest
set wildmenu " command-line completion
set wildmode=list:longest,full " shell-style completion behavior
" File types to ignore for command-line completion
set wildignore+=*.DS_Store " OSX folder meta-data file
set wildignore+=.git,.hg,.svn " version control system files
set wildignore+=*.o,*.obj,*.exe " compiled object files
set wildignore+=*.jpg,*.gif,*.png,*.jpeg "binary image files
set wildignore+=*.aux,*.out,*.toc, *.pdf "LaTeX intermediate/output files
set wildignore+=*.pyc " python object codes
set wildignore+=*.luac " lua byte code
set wildignore+=*.class " java/scala class files
set wildignore+=*/target/* " sbt target directory

"----------------------------------------------------------------------"
" Folding
"

set foldenable " default to folding on, can be toggled with 'zi'
set foldlevelstart=99 " open files completely unfolded
set foldnestmax=8 " no more than 8 levels of folds
set foldmethod=indent "default to indentation-based folding

"----------------------------------------------------------------------"
" Statusline
"

set laststatus=2 " always display statusline
set ruler " display cursor position even with empty statusline

" Buffer number and truncation point
set statusline=%#WildMenu#%(\ %n\ \|%)%<
" Filename
set statusline+=%#WildMenu#%(\ %f\ %)
" Readonly flag: [RO]
set statusline+=%r
" Modified flag: [+][-]
set statusline+=%m%*
" Right-align the rest of the statusline flags
set statusline+=%=
" File format
set statusline+=[%{&fileformat}]
" File encoding
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
" Filetype: [filetype] (this includes help files)
set statusline+=[%{strlen(&filetype)?&filetype:'no\ ft'}]
" Preview window flag: [Preview], N.B. [help] is a filetype
set statusline+=%w
" Paste mode warning
set statusline+=%(\ %)%#Identifier#%{&paste?'\ PASTE\ ':''}%*
" Scroll percentage
set statusline+=%#WildMenu#%(\ %3p%%\ \|%)
" (l:line, v:virtcol)
set statusline+=%(\ %3l:%-2v\ %)%*
" Syntastic warning message
set statusline+=%#WarningMsg#%SyntasticStatuslineFlag()}%*

" Display git status provided fugitive is loaded
" set statusline+=[%{exists('g:loaded_fugitive')?fugitive#head():''}]

"======================================================================"
" Key Bindings
"

" Make Space the leader key
" let mapleader="\<Space>"

" Make Backspace the localleader
" let maplocalleader="\<BS>"

" Alternative manner of mapping leader makes it appear in Showcmd
" map <Space> <Leader>
" map <BS> <LocalLeader>

"----------------------------------------------------------------------"
" Movement & Editing
"

" Recall that 'Ctrl-[' is already equivalent to '<Esc>'
" Make Shift-Enter act as Escape to exit Insert-Mode
inoremap <S-CR> <Esc> 
" Move around wrapped long lines more naturally
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap $ g$
" Make Y behave analagously to C and D
nnoremap Y y$
" Retain visual mode selection while changing indenting
vnoremap > >gv
vnoremap < <gv
" Reselect just pasted text in visual mode
nnoremap <Leader>v V`]
" Allow sudo writing of protected files using 'w!!'
cmap w!! w !sudo tee % >/dev/null
" Protect against accidentally winding up in Ex mode
nnoremap Q <Nop>

"----------------------------------------------------------------------"
" Toggles 
"

" Toggle and echo paste mode easily
nnoremap <Leader>p :set paste!<CR>:set paste?<CR>
" Toggle and echo display of some whitespace characters
nnoremap <Leader>l :set list!<CR>:set list?<CR>
" Toggle and echo dislpay of relative line numbers
nnoremap <Leader>r :set relativenumber!<CR>:set relativenumber?<CR>
" Toggle English spell checking in local buffer only
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>:setlocal spell?<CR>
" Toggle highlighting of textwidth column
nnoremap <Leader>cc :set colorcolumn=+1<CR>
nnoremap <Leader>CC :set colorcolumn=<CR>
" Toggle highlighting of cursor position
nnoremap <Leader>cp :set cursorline!<Bar>:set cursorcolumn!<CR>

"----------------------------------------------------------------------"
" Searching
"

" Map search '/' key to always be very-magic, i.e. full regex support
nnoremap / /\v
vnoremap / /\v
" Map 'CRTL-L' to also clear search highlights before clearing screen
nnoremap <Silent> <C-L> :nohlsearch<CR><C-L>
" Bind Ctrl-K to grep word under cursor
nnoremap <C-K> :silent! grep! "\b<C-r><C-w>\b"<CR>:cw<CR>:redr!<CR>

"----------------------------------------------------------------------"
" Formatting
"

" Strip all trailing whitespace without losing search history
nnoremap <Silent> <Leader>$ :let _s=@/<Bar>:%s/\s\+$//e<Bar>
    \ :let @/=_s<Bar>:nohl<CR> 
" Reindent the entire file while fixing cursor (indentation only)
nnoremap <Silent> <Leader>= :let l=line(".")<Bar>:let c=virtcol(".")<Bar>
    \ :normal gg=G<Bar>:call cursor(l, c)<Bar>:unlet l<Bar>:unlet c<CR> 
" Reformat the entire file while fixing cursor (indentation and linebreaks)
nnoremap <Silent> <Leader>gq :let l=line(".")<Bar>:let c=virtcol(".")<Bar>
    \ :normal gggqG<Bar>:call cursor(l, c)<Bar>:unlet l<Bar>:unlet c<CR> 
" As for gq above, but gw fixes cursor by default and ignores 'formatprg'
nnoremap <Silent> <Leader>gw :let l=line(".")<Bar>:let c=virtcol(".")<Bar>
    \ :normal gggwG<Bar>:call cursor(l, c)<Bar>:unlet l<Bar>:unlet c<CR> 
" Reindent the current paragraph
nnoremap <Leader>q gqip

"----------------------------------------------------------------------"
" Windows & Buffers
"

" See a list of buffers and hit a number to select one
nnoremap <Leader>b :buffers<CR>:buffer<Space>
" Move to next or previous window easily
noremap <C-J> <C-W>w
noremap <C-K> <C-W>W
" Split current window and move to new split (w: vertical, W: horizontal)
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

"======================================================================"
" Filetype Specific Settings
"

" Be certain to check the ftplugin for a given filetype before assuming
" that local settings must be included here.

augroup Filetypes " define an auto-command group for filetypes
" idiomatic removal of all auto-commands for this group
autocmd!

" Force *.md to be considered Markdown as I never use Modula-2
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Make certain that .txt files are identified as filetype Text
autocmd BufNewFile,BufRead *.txt set filetype=text

" Turn on spell check for certain filetypes automatically
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType text setlocal spell spelllang=en_us

" Set textwidth automatically for certain filetypes
" Note that for many filetypes ftplugin files already handle this
autocmd FileType markdown setlocal textwidth=72
autocmd FileType text setlocal textwidth=72

" Set formatoptions automatically for certain filetypes
" autocmd Filetype text setlocal formatoptions=

" Idomatic seletion of default auto-command group
augroup END 

"======================================================================"
" Abbreviations
"

" Abbreviation for date and time stamp in RFC822 format
iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")

" Abbreviations for horizontal rules: 70 each so comment characters on each
" end make for 72 character rules
iabbrev --- ----------------------------------------------------------------------
iabbrev === ======================================================================
iabbrev *** **********************************************************************
iabbrev ___ ______________________________________________________________________
