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
          -- indent = {
          --     enable = true,
          -- },
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


  -- FIXME: Checking comments too much.
  -- use {
  --   'lewis6991/spellsitter.nvim',
  --   config = function()
  --     require('spellsitter').setup({
  --         hl = 'SpellBad',
  --         captures = {'comment'},
  --       })
  --   end
  -- }

  use {
    'rafamadriz/neon',
    config = function()
      vim.g.neon_style = "default"
      vim.g.neon_italic_keyword = true
      vim.g.neon_italic_function = true
    end
  }

  use {
    'kabouzeid/nvim-lspinstall',
    -- TODO: See if we can configure which lsps get installed here.
  }


  use {
    'neovim/nvim-lspconfig',
    -- requires = "kabouzeid/nvim-lspinstall",
    config = function()
      local lspconfig = require('lspconfig')
      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          --Enable completion triggered by <c-x><c-o>
          -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          -- lsp handler keys are
          -- callHierarchy/incomingCalls
          -- callHierarchy/outgoingCalls
          -- textDocument/codeAction
          -- textDocument/completion
          -- textDocument/declaration*
          -- textDocument/definition
          -- textDocument/documentHighlight
          -- textDocument/documentSymbol
          -- textDocument/formatting
          -- textDocument/hover
          -- textDocument/implementation*
          -- textDocument/publishDiagnostics
          -- textDocument/rangeFormatting
          -- textDocument/references
          -- textDocument/rename
          -- textDocument/signatureHelp
          -- textDocument/typeDefinition*
          -- window/logMessage
          -- window/showMessage
          -- window/showMessageRequest
          -- workspace/applyEdit
          -- workspace/symbol

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- TODO: Define keybindings to use other packages, e.g., Trouble.
          -- Helper packages such as lsputils and lspsaga can provide
          -- handlers that will be used by vim.lsp.buf. Thus the keymappings
          -- below should work with any package providing such handlers.
          local opts = { noremap=true, silent=true }
          buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', '<leader>el', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '<leader>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
          buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          -- lspsaga maps
      end

      local lspinstall = require('lspinstall')
      lspinstall.setup()

      -- Specific server configurations.
      local configs = {
        lua = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'hs' }
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

      -- Disable virtual text in diagnostics.
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          underline = true,
          signs = true,
          virtual_text = false,
          -- signs = true,
        }
      )

    end
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
              enabled = true,
              autocomplete = true,
              debug = false,
              min_length = 1,
              preselect = 'enable',
              throttle_time = 80,
              source_timeout = 200,
              incomplete_delay = 400,
              max_abbr_width = 100,
              max_kind_width = 100,
              max_menu_width = 100,
              documentation = true,

              source = {
                path = true,
                buffer = true,
                calc = true,
                nvim_lsp = true,
                nvim_lua = true,
                vsnip = true,
                ultisnips = true,
              },
            }
        end
    }


  -- NOTE: Accepting autocomplete suggestion caused extranous carraige return.
  -- use {
  --     'windwp/nvim-autopairs',
  --     config = function()
  --         local remap = vim.api.nvim_set_keymap
  --         local npairs = require('nvim-autopairs')
  --           -- skip it, if you use another global object
  --         _G.MUtils= {}

  --         vim.g.completion_confirm_key = ""
  --         MUtils.completion_confirm = function()
  --           if vim.fn.pumvisible() ~= 0  then
  --             if vim.fn.complete_info()["selected"] ~= -1 then
  --               return vim.fn["compe#confirm"](npairs.esc("<cr>"))
  --             else
  --               return npairs.esc("<cr>")
  --             end
  --           else
  --             return npairs.autopairs_cr()
  --           end
  --         end
  --         remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
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
  --
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  -- TODO: Empty file finding. Look into this plugin later.
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
        require('telescope').setup {
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = 'smart_case',
            },
          },
        }
        -- require('telescope').load_extension('projects')
        require('telescope').load_extension('fzf')
    --   require('telescope').setup {
    --     defaults = {
    --       vimgrep_arguments = {
    --         'rg',
    --         '--color=never',
    --         '--no-heading',
    --         '--with-filename',
    --         '--line-number',
    --         '--column',
    --         '--smart-case'
    --       },
    --       prompt_position = "bottom",
    --       prompt_prefix = "> ",
    --       selection_caret = "> ",
    --       entry_prefix = "  ",
    --       initial_mode = "insert",
    --       selection_strategy = "reset",
    --       sorting_strategy = "descending",
    --       layout_strategy = "horizontal",
    --       layout_defaults = {
    --         horizontal = {
    --           mirror = false,
    --         },
    --         vertical = {
    --           mirror = false,
    --         },
    --       },
    --       file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    --       file_ignore_patterns = {},
    --       generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    --       shorten_path = true,
    --       winblend = 0,
    --       width = 0.75,
    --       preview_cutoff = 120,
    --       results_height = 1,
    --       results_width = 0.8,
    --       border = {},
    --       borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    --       color_devicons = true,
    --       use_less = true,
    --       set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    --       file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    --       grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    --       qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    --       -- Developer configurations: Not meant for general override
    --       buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    --     }
    --   }
    end
  }

  -- tpope plugins
  use {
    'tpope/vim-commentary',
    'tpope/vim-repeat',
    'tpope/vim-endwise',
  }

  -- NOTE: kommentary seems to prefer block comments.
  -- NOTE: Also issues multiple commands to comment.
  -- use {
  --   'b3nj5m1n/kommentary',
  --   config = function()
  --     local conf = require('kommentary.config')
  --     conf.use_extended_mappings()
  --     conf.configure_language(
  --       "default",
  --       {
  --         prefer_single_line_comments = true,
  --         use_consistent_indentation = true,
  --         ignore_whitespace = true,
  --       }
  --     )
  --   end
  -- }

  -- use 'mhinz/vim-signify'
  use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
          require('gitsigns').setup()
      end
  }

  -- use {
  --   'ntpeters/vim-better-whitespace',
  --   config = function()
  --     vim.g.better_whitespace_enabled = 1
  --     vim.g.better_whitespace = 1
  --     vim.g.show_spaces_that_precede_tabs = 1
  --     vim.g.strip_max_file_size = 100000
  --     vim.g.strip_whitespace_confirm = 0
  --     vim.g.strip_whitespace_on_save = 1
  --   end
  -- }

  use {
    'lewis6991/spaceless.nvim',
    config = function()
      require('spaceless').setup()
    end
  }

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


  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        vim.g.lua_tree_side = "left"
        vim.g.lua_tree_width = 60
        -- vim.o.lua_tree_ignore = [".git", "node_modules", ".cache"]
        vim.g.lua_tree_auto_open = 1  -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
        -- vim.o.lua_tree_auto_close = 1 "0 by default, closes the tree when it"s the last window
        -- vim.o.lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
        -- vim.o.lua_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
        -- vim.o.lua_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
        vim.g.lua_tree_git_hl = 1  -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
        -- vim.o.lua_tree_root_folder_modifier =  =~" "This is the default. See :help filename-modifiers for more options
        -- vim.o.lua_tree_tab_open = 1 -- open tree when entering new tab and tree was
        -- open
        --
        -- vim.g.lua_tree_bindings = {
        --   edit = ["<CR>", "o"],
        --   edit_vsplit =     "<C-v>",
        --   edit_split =      "<C-x>",
        --   edit_tab =        "<C-t>",
        --   toggle_ignored =  "I",
        --   toggle_dotfiles = "H",
        --   refresh =         "R",
        --   preview =         "<Tab>",
        --   cd =              "<C-]>",
        --   create =          "a",
        --   remove =          "d",
        --   rename =          "r",
        --   cut =             "x",
        --   copy =            "c",
        --   paste =           "p",
        --   prev_git_item =   "[c",
        --   next_git_item =   "]c",
        -- }
        --
        vim.cmd([[nnoremap <silent><leader>fe :NvimTreeToggle<cr>]])
    end
  }

  use {
      'akinsho/nvim-bufferline.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
          vim.opt.termguicolors = true
          require('bufferline').setup {
              diagnostics = 'nvim_lsp',
          }
      end
  }

  use {
      'folke/which-key.nvim',
      config = function()
          require('which-key').setup {}
      end
  }

  use {
    'sheerun/vim-polyglot',
    config = function()
        -- - polyglot includes LaTeX-box, which is incompatible with vimtex.
        -- - 2109-04-05: polyglot includes old pgsql syntax, use lifepillar's.
        --   Confer https://github.com/sheerun/vim-polyglot/issues/391
        --   But, using polyglot with pgsql leads to no highlighting. Removing polyglot
        --   from the packpath solves this.
        vim.g.polyglot_disabled = {'latex', 'pgsql'}
    end
  }

  -- key remmaping
  use {
    'LionC/nest.nvim',
    config = function()
      local nest = require('nest')

      nest.applyKeymaps {
          -- Remove silent from ; : mapping, so that : shows up in command mode
          -- { ';', ':' , options = { silent = false } },
          -- { ':', ';' },

          { '<leader>', {
              -- Finding
              { 'f', {
                  { 'f', '<Cmd>Telescope find_files<CR>' },
                  { 'l', '<Cmd>Telescope live_grep<CR>' },
                  { 'g', {
                      { 'b', '<Cmd>Telescope git_branches<CR>' },
                      { 'c', '<Cmd>Telescope git_commits<CR>' },
                      { 's', '<Cmd>Telescope git_status<CR>' },
                  }},
              }},

              -- LSP.
              { 'l', {
                  { 'c', '<Cmd>lua vim.lsp.buf.code_actions()<CR>' },
                  { 'r', '<Cmd>lua vim.lsp.buf.rename()<CR>' },
                  { 's', '<Cmd>lua vim.lsp.buf.signature_help()<CR>' },
                  { 'h', '<Cmd>lua vim.lsp.buf.hover()<CR>' },
              }},

              -- Package management.
              { 'p', {
                  { 's', '<Cmd>PackerSync'},
               }},
              },
          },

          -- Use insert mode for all nested keymaps
          { mode = 'i', {

              -- Set <expr> option for all nested keymaps
              { options = { expr = true }, {
                  { "<CR>",       "compe#confirm('<CR>')" },
                  -- This is equivalent to viml `inoremap <C-Space> <expr>compe#complete()`
                  { "<C-Space>",  "compe#complete()" },
              }},

              -- { '<C-', {
              --     { 'h>', '<left>' },
              --     { 'l>', '<right>' },
              --     { 'o>', '<Esc>o' },
              -- }},
          }},
      }
    end
  }

  -- NOTE: This will autochdir to project root, which I do not care for.
  -- use {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     vim.g.nvim_tree_update_cwd = 1
  --     vim.g.nvim_tree_respect_buf_cwd = 1
  --     require("project_nvim").setup {}
  --   end
  -- }

  -- TODO: Determine if we should use this plugin.
  -- Not generally pleased with many of the interface choices.
  -- use {
  --     'glepnir/lspsaga.nvim',
  --     requires = 'neovim/nvim-lspconfig',
  --     config = function()
  --         local saga = require('lspsaga')
  --         saga.init_lsp_saga()
  --         vim.lsp.handlers['textDocument/codeAction'] = require('lspsaga.codeaction').code_action_handler
  --         -- vim.lsp.handlers['textDocument/definition'] = require('lspsaga.provider').preview_definition
  --         -- vim.lsp.handlers['textDocument/hover'] = require('lspsaga.hover').render_hover_doc
  --         -- vim.lsp.handlers['textDocument/references'] = require('lspsaga.provider').lsp_finder
  --         vim.lsp.handlers['textDocument/rename'] = require('lspsaga.rename').rename
  --         vim.lsp.handlers['textDocument/signatureHelp'] = require('lspsaga.signaturehelp').signature_help
  --         -- scroll down hover doc or scroll in definition preview
  --         vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
  --         vim.cmd([[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
  --     end
  -- }

  -- TODO: Determine if we should use this plugin.
  -- use {
  --     'RishabhRD/nvim-lsputils',
  --     requires = 'RishabhRD/popfix',
  --     config = function()
  --         vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  --         vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  --         vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  --         vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  --         vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  --         vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  --         vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  --         vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  --     end
  -- }



end)
