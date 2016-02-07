" enable true colors in vim.  This is also enabled in .zshenv.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal


" ---------------------------------------------------------------------------
" Colorschemes in neovim's terminal emulation mode (:terminal)
" NOTE: (Sun, 31 Jan 2016 10:30:10 -0800)
" It seems that neovim's terminal emulator does not support true color.
" For the issue, see:  https://github.com/chriskempson/base16-vim/issues/69
" and https://github.com/neovim/neovim/issues/2571
" ---------------------------------------------------------------------------
" let g:terminal_color_0 = '#2b303b'
" let g:terminal_color_1 = '#bf616a'
" let g:terminal_color_2 = '#a3be8c'

source ~/.vim/vimrc

" ==========================================================================
" PLUGIN CONFIG
" ==========================================================================
"
"--------------------------------------------------------------------------- 
" Deoplete (dark powered completion for neovom)
" Fri, 05 Feb 2016 10:52:51 -0800 
" https://github.com/Shougo/deoplete.nvim
"--------------------------------------------------------------------------- 
let g:deoplete#enable_at_startup = 1

" Manually trigger completion and auto insert
let g:deoplete#disable_auto_complete = 1
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" ==========================================================================
" Python 
" ==========================================================================
" let g:python_host_pro="/usr/local/var/pyenv/shims/python"


