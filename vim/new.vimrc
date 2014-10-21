"======================================================================"
" .vimrc
" Last changed: Sat, 11 Oct 2014 21:48:42 -0700
"
" TODO textwidth & format, copy/paste w/ osx clipboard
"======================================================================"

" Before setting potentially VIM-only options, enable full VIM features
set nocompatible " make VIM iMproved rather than legacy compatible

"-----< Plugins >------------------------------------------------------"
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

"-----< General Interface >--------------------------------------------"

syntax enable " enable syntax highlighting
set nomodeline " don't use modelines, they are a security risk
set wildmenu " command-line completion
set wildmode=list:longest,full " shell-style completion behavior
" set wildignore=*.o,*.obj,*.bak,*.exe " ignore binary files
set confirm " get confirmation to discard unwritten buffers
set autoread " reread files that have been changed while open
set autowrite " write modified files when moving to other buffers/windows
set hidden " don't close windowless buffers
set history=1000 " by default command history is only the last 20
set undolevels=1000 " enable many levels of undo
set backspace=indent,eol,start " backspace over line breaks, insertion start
set scrolloff=3 " always show 5 lines above or below cursor when scrolling
set scrolljump=3 " scroll 3 lines when the cursor would leave the screen
set title " update terminal window title
set visualbell " flash screen instead of audio bell for alert
" set no errorbells " don't beep
set shortmess+=A " don't show "ATTENTION" warning for existing swapfiles
fixdel " ensure that delete works as expected in the terminal
set encoding=utf-8  " The encoding displayed.
"set fileencoding=utf-8  " The encoding written to file.

"-----< Display >------------------------------------------------------"

set showmode " show current mode at bottom of screen
set showcmd " show (partial) commands in statusline
set showmatch " show matching paretheses, brackets, and braces
set relativenumber " display relative line numbers
set number " display line number of cursor location
set numberwidth=4 " always make room for 4-digit line numbers
set ruler " display cursor position even with empty statusline
" set colorcolumn=+1 " show where lines should end
" set cursorline " highlight line where cursor is positioned
" set cursorcolumn " see indentation easily
set display+=lastline " display as much as possible of the last line
set lazyredraw " don't redraw unnecessarily during macros etc.
set background=dark
colorscheme solarized
" When using solarized without custom terminal colors use the following
" let g:solarized_termcolors=256

" colorscheme desert " a nice dark built-in colorscheme
set ttyfast " indicate that the terminal connection is fast
set wrap " wrap long lines
set linebreak " don't break words when wrapping; will be disabled by list
set listchars=tab:>-,trail:.,eol:$,extends:#,nbsp:. " show whitespace

"-----< Search & Substitution >----------------------------------------"

set hlsearch " highlight search results
set incsearch " incremental search begins as you type
set ignorecase " use case insensitive search
set smartcase " except when capital letters are entered in the pattern
set gdefault " make substitutions global (full-line) by default

" Use Ag, The Silver Searcher, for grep and CtrlP
if executable("ag")
    " Use Ag as grep program
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --hidden

    " Set a more complete grepformat
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Add an 'Ag' command
    com! -nargs=+ -complete=file_in_path -bar Ag silent grep! <args>|cw|redr!
endif

"-----< Indentation & Formatting >-------------------------------------"

set autoindent " retain indentation level on next line for non-specific filetypes
set shiftwidth=4 " by default indent 4 spaces using '>>'
" set tabstop=4 " show tabs as 4 spaces (default is 8)
set softtabstop=4 " when editing tabs are 4 spaces wide
set expandtab " all tabs are converted to spaces
set smarttab " use 'shiftwidth' for tabs rather than 'tabstop'
set shiftround " round all indentation to multiples of 'shiftwidth'
set nojoinspaces " make 'J' and 'gq' only add one space after a period
set textwidth=79 " default format of no more than 79 characters in a line
" set formatoptions=tcq " this is the default, add 'a' for auto-rewrap
set clipboard+=unnamed " make yanked text avilable in system clipboard

"-----< Folding >------------------------------------------------------"

set foldenable " default to folding on, can be toggled with 'zi'
set foldlevelstart=99 " open files completely unfolded
set foldnestmax=8 " no more than 8 levels of folds
set foldmethod=indent "default to indentation-based folding

"-----< Buffers & Windows >--------------------------------------------"

" Open new windows below and to the right (default is opposite)
set splitbelow
set splitright

"-----< Statusline >---------------------------------------------------"

set laststatus=2 " always display statusline

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

" Display git status provided fugitive is loaded
" set statusline+=[%{exists('g:loaded_fugitive')?fugitive#head():''}]

"-----< VIM Files >----------------------------------------------------"

set undofile " save undo tree to file for persistent undos
set directory=~/.vim/swap//,/var/tmp//,/tmp// " set swap file directory
set backupdir=~/.vim/backup//,/var/tmp//,/tmp// " set backup file directory
set undodir=~/.vim/undo//,/var/tmp//,/tmp// " set undo file directory

"-----< Key Bindings >-------------------------------------------------"

" Make Space the leader key
" let mapleader="\<Space>"

" Make Backspace the localleader
" let maplocalleader="\<BS>"

" Alternative manner of mapping leader makes it appear in Showcmd
" map <Space> <Leader>
" map <BS> <LocalLeader>


" General Movement & Editing

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

" Toggles 

" Toggle paste mode easily
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

" Searching

" Map search '/' key to always be very-magic, i.e. full regex support
nnoremap / /\v
vnoremap / /\v

" Map 'CRTL-L' to also clear search highlights before clearing screen
nnoremap <Silent> <C-L> :nohlsearch<CR><C-L>

" Bind Ctrl-K to grep word under cursor
nnoremap <C-K> :silent! grep! "\b<C-r><C-w>\b"<CR>:cw<CR>:redr!<CR>

" Formatting

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

" Windows & Buffers

" See a list of buffers and hit a number to select one
nnoremap <Leader>b :buffers<CR>:buffer<Space>

" Move to next or previous window easily
noremap <C-J> <C-W>w
noremap <C-K> <C-W>W

" Split current window and move to new split (w: vertical, W: horizontal)
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

"-----< Plugin Configuration >-----------------------------------------" 

" ctrlp
if executable("ag")
    " Use Ag in CtrlP for listing files
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

    " Ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" supertab
let g:SuperTabDefaultCompletionType = "context"

" Toggle the undo-tree panel
nnoremap <Leader>u :UndotreeToggle<cr>

"-----< Filetype Specific Settings >-----------------------------------"

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

augroup END " idomatic seletion of default auto-command group

"-----< Abbreviations >------------------------------------------------"

" Abbreviation for date and time stamp in RFC822 format
iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")

" Abbreviations for horizontal rules: 70 each so comment characters on each
" end make for 72 character rules
iabbrev --- ----------------------------------------------------------------------
iabbrev === ======================================================================
iabbrev *** **********************************************************************
