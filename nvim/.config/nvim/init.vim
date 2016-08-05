
" ==========================================================================
" Python 
" Initially we had some issues with getting neovim to work with the python
" host, but this appeared to be more of a pyenv issue.  We need to ensure
" that multiple versions of python 2 and 3 are globally available.
" A good resource is: https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
" pyenv install 2.7.11
" pyenv install 3.4.4

" pyenv virtualenv 2.7.11 neovim2
" pyenv virtualenv 3.4.4 neovim3

" pyenv activate neovim2
" pip install neovim
" pyenv which python  # Note the path

" pyenv activate neovim3
" pip install neovim
" pyenv which python  # Note the path

" # The following is optional, and the neovim3 env is still active
" # This allows flake8 to be available to linter plugins regardless
" # of what env is currently active.  Repeat this pattern for other
" # packages that provide cli programs that are used in Neovim.
" pip install flake8
" ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH 
" ==========================================================================
" NOTE: The standard env expansion is odd with setting the Python hosts.
" For example '$PYENV_ROOT/versions/neovim3/bin/python' does not work.
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'


source ~/.vim/vimrc

" ==========================================================================
" Colors 
" ==========================================================================
"
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



