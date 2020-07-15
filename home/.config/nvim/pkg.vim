" Packages / Plugins
" Loading handled by the builtin package loader, cf., :h packages
" Management (install / update / clean) handled by minpac.
" minpac is lazily loaded, since runtime path augmentation is handled natively.
"
" The main disadvantage of utilizing the native package loader and lazy
" package management is that packages cannot be easily toggled on or off
" within the rc file. This can probably be accomplished by simply calling
" packadd directly and making all packages optionally loaded.
"
" Update packpath to utilize same packages for vim8+/neovim.
" As of 2019-01-17 there are a few competing Language Server Client
" implementations. The main ones:
"
" 1. vim-lsp. Pure vimscript, integrates with ncm2. Incremental updates.
"    Barebones config.
" 2. vim-lsc. Pure vimscript. Highlights errors. Incremental updates.
" 3. ale. Linting / formatting engine that can provide completion from
"    language servers.
" 4. LanguageClient-neovim. Rust, ncm2 integration, no incremental update.
" 5. coc (Conquer of Completion). Tries to emulate vscode more fully, and
"    claims to support snippets and the like out of the box. Looks nice, but
"    FIXME: cannot seem to find pyenv interpreter.
" 6. Native neovim (slated for version 0.5). Probably would be low level
"    and utilized by one of the above plugins.

" NOTE: Updating the packpath to share packages between vim and nvim
" leads to some runtimepath issues. These can likely be resolved, e.g.,
" see h: nvim-from-vim, but it's easy to just duplicate the package code.
" See h:packpath and :set packpath? for more. We choose to install packages
" in outside of the main ~/.config dir.
" set packpath      ^=$XDG_DATA_HOME/nvim/site/
" set packpath      +=$XDG_DATA_HOME/nvim/site/after/
let s:pack_home = $XDG_DATA_HOME . '/nvim/site'
let s:minpac_home = s:pack_home . '/pack/minpac/opt/minpac/'

function! s:coc_install_extensions() abort
    " This could also be controlled via specifying
    " $XDG_DATA_HOME/coc/extensions/package.json
    packadd coc.nvim
    call coc#add_extension(
        \ 'coc-json',
        \ 'coc-snippets',
        \ 'coc-python',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-yaml',
        \ 'coc-emmet',
        \ 'coc-vimlsp',
        \ 'coc-dictionary',
        \)
endfunction

" minpac post-update hook for coc
" The coc#util#install command fetches a prebuilt binary.
" Alternatively, `yarn install`` can called the post_update hook.
" Extensions rely on yarn being installed.
" Extensions defined in $XDG_DATA_HOME/coc/extensions/package.json
" are fetched by :CocUpdate, if yarn is installed.
" Since extensions and coc config are external files, it makes sense to
" version them for the time being.
" yarn itself can be installed via npm. The architecture independent
" yarn install script unfortunately dumps it into ~/.yarn,
" Can install node via nvm or brew or pkgsrc.
" For now, it's probably easiest to just install node manually since
" we do not develope javascript.
function! s:coc_init(hooktype, name) abort
    " Ensure yarn package manager is installed.
    "
    if !executable('npm')
        execute '!curl -sL install-node.now.sh/lts | bash'
    endif
    if !executable('yarn')
        execute '!npm install --user yarn'
    endif

    " Get prebuilt binary for macOS or Linux or build from source via yarn.
    try
        call coc#util#install()
    catch
        execute '!yarn install'
    endtry

    call s:coc_install_extensions()
endfunction


function! s:firenvim_install(hooktype, name) abort
    call firenvim#install(0)
endfunction

function! s:ghost_install(hooktype, name) abort
    " FIXME: https://github.com/raghur/vim-ghost/issues/35
    " TODO: Install the vim-ghost python deps in the neovim3 virtualenv?
    " :GhostInstall
endfunction


function! s:pack_init() abort
    packadd minpac
    " minpac uses the first dir of packpath unless configured by `dir`.
    call minpac#init({'dir': s:pack_home })
    call minpac#add('k-takata/minpac', {'type': 'opt'})


    " call minpac#add('dyng/ctrlsf.vim')
    " call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('ntpeters/vim-better-whitespace')

    " Colorscheme plugins
    " call minpac#add('icymind/NeoSolarized', {'type': 'opt'})
    " call minpac#add('morhetz/gruvbox')
    " call minpac#add('romainl/flattened')
    " call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})

    " call minpac#add('vim-airline/vim-airline')
    " call minpac#add('wellle/targets.vim')
    " call minpac#add('SidOfc/mkdx')
    call minpac#add('brooth/far.vim')
    call minpac#add('junegunn/vim-easy-align')
    call minpac#add('lervag/vimtex')
    call minpac#add('lifepillar/pgsql.vim')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('sheerun/vim-polyglot')
    " call minpac#add('vim-pandoc/vim-pandoc')
    call minpac#add('vim-pandoc/vim-pandoc-syntax')
    call minpac#add('tpope/vim-commentary')
    " call minpac#add('tpope/vim-dadbod')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-endwise')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')

    " Experiment with ncm2.
    " NOTE: ncm2 suffers from requiring multiple dependencies.
    call minpac#add('ncm2/ncm2') | call minpac#add('roxma/nvim-yarp')
    call minpac#add('ncm2/ncm2-path')
    call minpac#add('ncm2/ncm2-bufword')
    call minpac#add('ncm2/ncm2-pyclang')
    call minpac#add('ncm2/float-preview.nvim')
    " call minpac#add('ncm2/ncm2-ultisnips') | call minpac#add('SirVer/ultisnips')
    call minpac#add('ncm2/ncm2-vim') | call minpac#add('Shougo/neco-vim')
    call minpac#add('ncm2/ncm2-vim-lsp')

    " Optional packages here. Useful when experimenting.
    call minpac#add('w0rp/ale', {'type': 'opt'})
    call minpac#add('autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': {-> system('bash install.sh')},
                \ 'type': 'opt'
                \ })
    call minpac#add('junegunn/fzf', { 'do': {-> system('bash install --all')}})
    " call minpac#add('glacambre/firenvim', { 'do': {-> function('s:firenvim_install')}})
    " call minpac#add('raghur/vim-ghost', { 'do': {-> function('s:ghost_install'}})
    call minpac#add('natebosch/vim-lsc', {'type': 'opt'})
    call minpac#add('prabirshrestha/vim-lsp', {'type': 'opt'})
    call minpac#add('prabirshrestha/async.vim', {'type': 'opt'})

    " CoC (node based LSC)
    " NOTE:
    " - Installation requires yarn.
    " - Some extensions are installed via coc commands.
    " - coc utilizes its own config. Can extensions be listed there?
    "   - :CocInstall is basically same as yarn add extension.
    "   - So could version manage the extensions explicitly in git by
    "     defining the package.json file
    "
    " call minpac#add('neoclide/coc.nvim', {'type': 'opt', 'do': function('s:coc_init')})
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls s:pack_init() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call s:pack_init() | call minpac#clean() | call minpac#update()
command! PackClean  call s:pack_init() | call minpac#clean()
command! CocInstallExtensions call s:pack_init() | call s:coc_install_extensions()


" Bootstrap minpac
if empty(glob(s:minpac_home))
    execute '!git clone https://github.com/k-takata/minpac.git ' . s:minpac_home
    call s:pack_init()
    call minpac#update()
    " Assumes MYVIMRC is previously set.
    " autocmd VimEnter * packloadall | source $MYVIMRC
    autocmd VimEnter * source $MYVIMRC
endif

" Load optional packages.
" packadd ale
" packadd coc.nvim
packadd LanguageClient-neovim
" packadd vim-lsc
" packadd vim-lsp | packadd async.vim
