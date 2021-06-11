-- Load by calling `lua require('packages')` from your init.vim
-- Many packages, especially those for neovim written in lua, support
-- configurations within packer.
--
-- ---------------------------------------------------------------------------
-- boostrap
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end


-- ---------------------------------------------------------------------------
-- Only required if you have packer configured as `opt`
-- Apparently it's only loaded on require now anyway?
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
          ensure_installed = "maintained",      -- one of "all", "maintained", "language", or a list of languages
          highlight = {
            enable = true,
            -- disable = { "c", "rust" },  -- list of language that will be disabled
          },
          -- incremental_selection = {
          --   enable = true,
          --   keymaps = {
          --     init_selection = "gnn",
          --     node_incremental = "grn",
          --     scope_incremental = "grc",
          --     node_decremental = "grm",
          --   },
          -- },
          -- refactor = {
          --   highlight_definitions = {
          --    enable = true,
          --   },
          -- },
        }
    end
  }


  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }

  use {
    'rafamadriz/neon',
    config = function()
      vim.g.neon_style = "default"
      vim.g.neon_italic_keyword = true
      vim.g.neon_italic_function = true
    end
  }

  use {
    'neovim/nvim-lspconfig',
    -- requires = "kabouzeid/nvim-lspinstall",
    config = function()
      local lspinstall = require('lspinstall')
      lspinstall.setup()
      local servers = lspinstall.installed_servers()

      -- Specific server configurations.
      local configs = {
        lua = {
            -- ... other configs
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        }
      }

      for _, server in pairs(servers) do
        local config = configs[server]
        if config == nil then
          config = {}
        end
        require('lspconfig')[server].setup(config)
      end

    end

  }

  use {
    'kabouzeid/nvim-lspinstall',
    -- TODO See if we can configure which lsps get installed here.
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'folke/lsp-colors.nvim',
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  }

  use 'folke/tokyonight.nvim'


  use {
      'steelsojka/pears.nvim',
      config = function()
          require('pears').setup()
      end
  }

  -- -- FIXME: Empty file finding. Look into this plugin later.
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
  --   -- config = function()
  --   --   require('telescope').setup {
  --   --     defaults = {
  --   --       vimgrep_arguments = {
  --   --         'rg',
  --   --         '--color=never',
  --   --         '--no-heading',
  --   --         '--with-filename',
  --   --         '--line-number',
  --   --         '--column',
  --   --         '--smart-case'
  --   --       },
  --   --       prompt_position = "bottom",
  --   --       prompt_prefix = "> ",
  --   --       selection_caret = "> ",
  --   --       entry_prefix = "  ",
  --   --       initial_mode = "insert",
  --   --       selection_strategy = "reset",
  --   --       sorting_strategy = "descending",
  --   --       layout_strategy = "horizontal",
  --   --       layout_defaults = {
  --   --         horizontal = {
  --   --           mirror = false,
  --   --         },
  --   --         vertical = {
  --   --           mirror = false,
  --   --         },
  --   --       },
  --   --       file_sorter =  require'telescope.sorters'.get_fuzzy_file,
  --   --       file_ignore_patterns = {},
  --   --       generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
  --   --       shorten_path = true,
  --   --       winblend = 0,
  --   --       width = 0.75,
  --   --       preview_cutoff = 120,
  --   --       results_height = 1,
  --   --       results_width = 0.8,
  --   --       border = {},
  --   --       borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  --   --       color_devicons = true,
  --   --       use_less = true,
  --   --       set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  --   --       file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
  --   --       grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
  --   --       qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

  --   --       -- Developer configurations: Not meant for general override
  --   --       buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  --   --     }
  --   --   }
  --   -- end
  -- }
  --
  -- tpope plugins
  use {
    'tpope/vim-commentary',
    'tpope/vim-repeat',
    'tpope/vim-endwise',
  }

  use 'mhinz/vim-signify'
  use 'ntpeters/vim-better-whitespace'

  -- Simple plugins can be specified as strings
  -- use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  -- use {
  --   'w0rp/ale',
  --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }

  -- Plugins can have dependencies on other plugins
  -- use {
  --   'haorenW1025/completion-nvim',
  --   opt = true,
  --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  -- }

  -- Plugins can also depend on rocks from luarocks.org:
  -- use {
  --   'my/supercoolplugin',
  --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  -- }

  -- You can specify rocks in isolation
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use specific branch, dependency and run lua file after load
  -- use {
  --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- }

  -- Use dependency and run lua function after load
  -- use {
  --   'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
  --   config = function() require('gitsigns').setup() end
  -- }

  -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}
end)
