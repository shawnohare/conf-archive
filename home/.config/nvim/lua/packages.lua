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
          indent = {
              enable = true,
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
      local lspconfig = require('lspconfig')
      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          --Enable completion triggered by <c-x><c-o>
          -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap=true, silent=true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- TODO: Define keybindings to use other packages, e.g., Trouble.
          buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end

      local lspinstall = require('lspinstall')
      lspinstall.setup()

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

      for _, server in pairs(lspinstall.installed_servers()) do
        local config = configs[server]
        if config == nil then
          config = {}
        end
        config.on_attach = on_attach
        lspconfig[server].setup(config)
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
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use {
        'hrsh7th/nvim-compe',
        config = function()
            require('compe').setup {
              enabled = true;
              autocomplete = true;
              debug = false;
              min_length = 1;
              preselect = 'enable';
              throttle_time = 80;
              source_timeout = 200;
              incomplete_delay = 400;
              max_abbr_width = 100;
              max_kind_width = 100;
              max_menu_width = 100;
              documentation = true;

              source = {
                path = true;
                buffer = true;
                calc = true;
                nvim_lsp = true;
                nvim_lua = true;
                vsnip = true;
                ultisnips = true;
              };
            }
        end
    }


  -- use {
  --     'windwp/nvim-autopairs',
  --     config = function()
  --         require('nvim-autopairs').setup()
  --     end
  -- }

  use {
      'steelsojka/pears.nvim',
      config = function()
          require "pears".setup(function(conf)
              conf.on_enter(function(pears_handle)
                if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
                  return vim.fn["compe#confirm"]("<CR>")
                else
                  pears_handle()
                end
              end)
            end)
      end
  }

  -- use {
  --     'shaunsingh/solarized.nvim',
  --     config = function()
  --         vim.g.solarized_italic_comments = false
  --         vim.g.solarized_italic_keywords = true
  --         vim.g.solarized_italic_functions = true
  --         vim.g.solarized_italic_variables = false
  --         vim.g.solarized_contrast = false
  --         vim.g.solarized_borders = false
  --         vim.g.solarized_disable_background = false
  --         require('solarized').set()
  --     end
  --   }

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

  -- tpope plugins
  use {
    'tpope/vim-commentary',
    'tpope/vim-repeat',
    'tpope/vim-endwise',
  }

  -- use 'mhinz/vim-signify'
  use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
          require('gitsigns').setup()
      end
  }
  use 'ntpeters/vim-better-whitespace'

  -- Prettyish icons in lsp menus (such as completion)
  use {
    'onsails/lspkind-nvim',
    config = function()
        require('lspkind').init({
            with_text = true,
            preset = 'default',
            symbol_map = {},
        })
    end
  }

  use {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function()
          require('statusline')
      end
  }

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
