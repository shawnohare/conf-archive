
" ==========================================================================
" Python
" As part of config install, venvs are created for neovim2 and neovim3.

" # The following is optional, and the neovim3 env is still active
" # This allows flake8 to be available to linter plugins regardless
" # of what env is currently active.  Repeat this pattern for other
" # packages that provide cli programs that are used in Neovim.
" pip install flake8
" ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
" ==========================================================================

let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'


source ~/.vim/vimrc

" ==========================================================================
" PLUGIN CONFIG
" ==========================================================================
"
"---------------------------------------------------------------------------
" Deoplete
" NOTE: ALE provides completion via LSP, which potentially deprecates this.
" Fri, 05 Feb 2016 10:52:51 -0800
" https://github.com/Shougo/deoplete.nvim
"---------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" :
" \ deoplete#mappings#manual_complete()
" inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
