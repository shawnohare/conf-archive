" .vimrc
" Settings for VIM
" last modified: Tue, 10 Feb 2015 09:24:38 -0800 
"======================================================================"
set nocompatible  " make VIM iMproved rather than legacy compatible
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'altercation/vim-colors-solarized' 
" Plug 'chriskempson/base16-vim'

" Completion & Search
Plug 'kien/ctrlp.vim'          " full path fuzzy file/buffer/MRU/tag finder
" use '<Tab>' for smart omnicompletions
Plug 'ervandew/supertab'
Plug 'rking/ag.vim'
Plug 'Shougo/neocomplete', {'on': 'NeocompleteOn'}
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Plug 'SirVer/utilsnips'
Plug 'tpope/vim-vinegar'       " enhanced netrw file browser
Plug 'majutsushi/tagbar'  " display tags in a window

" Editing Enhancement 
" Plug 'mbbill/undotree'         " visual navigation of VIM undotree
Plug 'tpope/vim-surround'      " easy handling of surrounding brackets etc.
Plug 'Raimondi/delimitMate'    " automatic closing of parentheses etc.
Plug 'junegunn/vim-easy-align' " easy alignment of text blocks
Plug 'tpope/vim-commentary'    " easy toggling of comment markers
Plug 'tpope/vim-repeat'        " make vim-surround and vim-commentary repeatable

" Source Code Management Tool 
Plug 'tpope/vim-fugitive'      " git integration for VIM
Plug 'scrooloose/syntastic'    " syntax checking for many languages

" Filetype Specific 
" use vim-latex instead?
Plug 'lervag/vimtex' ", {'for': 'tex'}
Plug 'fatih/vim-go'
Plug 'chrisbra/csv.vim'

" Other
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/unite.vim'

" Visual
" lightline is similar to airline, but it
" requires more setup in vimrc (e.g., for fugitive integration).
" However, it is orthgonal to other plugins.
" Plug 'itchyny/lightline.vim'  
Plug 'bling/vim-airline'

call plug#end()

""
" PLUGIN CONFIG
"""

"""
" delimitMate
"""
" pressing return between delimiters results in an indent
let g:delimitMate_expand_cr=2
let g:delimitMate_expand_space=1
let g:delimitMate_jump_expansion=1
" don't expand <cr> in pop-up menus
 imap <expr> <CR> pumvisible()
                     \ ? "\<C-Y>"
                     \ : "<Plug>delimitMateCR"

""
" netrw (built-in)
""

let g:netrw_banner    = 0      " Do not display info on top
let g:netrw_liststyle = 3      " default to tree-style file listing
let g:netrw_winsize   = 30     " use 30% of columns for list
let g:netrw_preview   = 1      " default to vertical splitting for preview

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Change directory to the current buffer when opening files.
set autochdir

" How Lexplore command behaves
" com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)

" fun! Lexplore(dir, right)
"   if exists("t:netrw_lexbufnr")
"   " close down netrw explorer window
"   let lexwinnr = bufwinnr(t:netrw_lexbufnr)
"   if lexwinnr != -1
"     let curwin = winnr()
"     exe lexwinnr."wincmd w"
"     close
"     exe curwin."wincmd w"
"   endif
"   unlet t:netrw_lexbufnr

"   else
"     " open netrw explorer window in the dir of current file
"     " (even on remote files)
"     let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
"     exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
"     if a:dir != ""
"       exe "Explore ".a:dir
"     else
"       exe "Explore ".path
"     endif
"     setlocal winfixwidth
"     let t:netrw_lexbufnr = bufnr("%")
"   endif
" endfun

 " Toggle Lexplore with Ctrl-E
map <silent> <C-E> :Lexplore <CR>


""
" ctrlp
""
if executable("ag")
    " Use Ag in CtrlP for listing files
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

    " Ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

""
" neocomplete
""
" " Taken from the Neocomplete Github page.
" " Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }

" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" " Close popup by <Space>.
" "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" " For cursor moving in insert mode(Not recommended)
" "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
" "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
" "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
" "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" " Or set this.
" "let g:neocomplete#enable_cursor_hold_i = 1
" " Or set this.
" "let g:neocomplete#enable_insert_char_pre = 1

" " AutoComplPop like behavior.
" "let g:neocomplete#enable_auto_select = 1

" " Shell like behavior(not recommended).
" "set completeopt+=longest
" "let g:neocomplete#enable_auto_select = 1
" "let g:neocomplete#disable_auto_complete = 1
" "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
" "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" " For perlomni.vim setting.
" " https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

""
" neosnippet
""

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

" " For snippet_complete marker.
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif

""
" supertab
""

let g:SuperTabDefaultCompletionType = "context"

""
" tagbar
""

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constats',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

""
" undotree
""
nnoremap <Leader>u :UndotreeToggle<cr>

""
" utilsnips
"
" Trigger configuration.
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

""
" vim-easy-align
""

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

""
" vim-colors-solarized
""

" Toggle solarized colorscheme background between dark and light
call togglebg#map("<F5>")

""
" vim-go
""
" By default syntax-highlighting for funcs, methods, structs is disable.
let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_structs           = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1
" play nice with neosnippet
" let g:go_disable_autoinstall = 1
" let g:go_loaded_gosnippets = 1
let g:go_snippet_engine              = "neosnippet"
" let g:go_auto_type_info = 1

""
" syntastic
""
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
" Pull up syntastic errors easily
nnoremap <Leader>e :Errors<CR>
" Reset syntastic easily in both normal and insert mode
imap <F3> <C-O><F3>
nnoremap <F3> :SyntasticReset<CR>

""
" tagbar
""
nmap <F12> :TagbarToggle<CR>

""
" SETTINGS
""

""
" Abbreviations
""

" Abbreviation for date and time stamp in RFC822 format
iabbrev <expr> dts strftime("%a, %d %b %Y %H:%M:%S %z")


""
" Buffers & Windows
""

set hidden      " don't close windowless buffers
set confirm     " get confirmation to discard unwritten buffers
set splitbelow  " open new buffers below
set splitright  " and to the right of the current.  Default is opposite.


""
" Completion
""

set completeopt+=longest
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


""
" Display
""

syntax on                    " enable syntax highlighting
set cursorline               " highlight current line
set showmode                 " show current mode at bottom of screen
set showcmd                  " show (partial) commands below statusline
" set showmatch                " show matching delimiters
" set relativenumber           " show relative line numbers
set number                   " show line number of cursor
" au InsertEnter * :set number " absolute numbers in insert mode
" au InsertLeave * :set rnu    " relative numbers when leaving insert mode
" au FocusLost   * :set nu     " absolute numbers when focus lost
" au FocusGained * :set rnu    " relative numbrers when focus gain
set numberwidth=4            " always make room for 4-digit line numbers
set display+=lastline        " display as much as possible of the last line
set hlsearch                 " highlight search on "
set colorcolumn=79           " show where lines should end
set lazyredraw               " don't redraw unnecessarily during macros etc.
set tf                       " fast term connection.  
set wrap                     " wrap long lines
set linebreak                " don't break words at wrap; disabled by list
"  set list                     " show whitespace
set listchars=tab:>-,trail:.,extends:#,nbsp:. ",tab:>-,eol:¶ " customize whitespace look
set visualbell         " flash screen instead of audio bell for alert
" set visualbell t_vb=         " turn off visualbell effect
" set title                    " update terminal window title
set shortmess+=A       " don't show warning for existing swapfiles
set background=dark
let g:solarized_bold=0 " force Solarized to not bold things
colorscheme solarized
" colorscheme base16-default
" When using solarized without custom terminal colors use the following
" let g:solarized_termcolors=256
" When running without plugins use the desert colorscheme
" colorscheme desert " a nice dark built-in colorscheme

""
" Editing
""

set backspace=indent,eol,start " backspace over line breaks, insertion, start
set history=1000               " increase history level
set undolevels=1000            " enable many levels of undo
set undofile                   " save undo tree to file for persistent undos
set clipboard+=unnamed         " make yanked text available in system clipboard
set scrolloff=5                " always show n lines above or below cursor
set scrolljump=1               " scroll n lines when the cursor leaves screen
set mouse=a


""
" File Handling
""

set nomodeline         " modelines are a security risk
set autoread           " reread files that have been changed while open
set autowrite          " write when moving to other buffers/windows
set encoding=utf-8     " the encoding displayed


""
" Files (VIM)
""

set directory=/var/tmp//,/tmp//    "  swap file directory
set backupdir=/var/tmp//,/tmp//    "  backup file directory
set undodir=/var/tmp//,/tmp//      "  undo file directory


""
" Folding
""

set foldenable          " default to folding on, can be toggled with 'zi'
set foldlevelstart=99   " open files completely unfolded
set foldnestmax=8       " no more than 8 levels of folds
set foldmethod=indent   " default folding method. syntax method is SLOW.
" set foldcolumn=1        " gutter fold marks


""
" Indentation
"
set smarttab   " <Tab> interpretation depends on cursor and siftwidth, tabstop, softtabstop
set expandtab  " <Tab> converted to softtabstop # spaces
set tabstop=2  " number of visual spaces per <Tab> character
set softtabstop=2 " number of spaces <Tab> converted to
set shiftwidth=2 " <Tab> converts to this # spaces at beginning of line
" set smartindent " dumbindent?
set autoindent
" set cindent " also dumb?
filetype indent on
" indent when between delimeters by typing <C-Return>
" Now using delimitMate to handle this.
" imap <C-Return> <CR><CR><C-o>k<C-t>

""
" STATUSLINE
"
set laststatus=2
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'} "file encoding
set statusline+=%{&ff}]         "file format
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " read only flag
set statusline+=%y              " filetype
set statusline+=%=              " left/right separator
set statusline+=%P\ :\ %l:\ %c " % through file : line num: column num
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

""
" Various
""

" map esc to in insert mode, don't interpret the map
" inoremap ;; <Esc>