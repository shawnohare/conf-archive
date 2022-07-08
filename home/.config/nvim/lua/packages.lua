---------------------------------------------------------------------------
-- boostrap
-- ---------------------------------------------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.api.nvim_command("packadd packer.nvim")
end

-- Only required if you have packer configured as `opt`
-- Apparently it's only loaded on require now anyway?
-- vim.cmd [[packadd packer.nvim]]
-- ret
return require("packer").startup(
    function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- colorscheme
        use {
            "shawnohare/hadalized.nvim",
            requires = {
                "rktjmp/lush.nvim",
            }
        }

        -- ------------------------------------------------------------------------
        -- Treesitter
        -- ------------------------------------------------------------------------

        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = "all", -- one of "all", "language", or a list of languages
                    highlight = {
                        enable = true
                        -- disable = { "c", "rust"},  -- list of language that will be disabled
                    },
                    indent = {
                      enable = true,
                      disable = {"python"},
                      -- disable = {'yaml'},
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
                    --  },
                    --},
                }
            end
        }

        use {
            'windwp/nvim-autopairs',
            config = function()
                require("nvim-autopairs").setup({})
            end

        }

        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'saadparwaiz1/cmp_luasnip',
                'petertriho/cmp-git',
                "onsails/lspkind-nvim",
            },
            config = function()
                local cmp = require("cmp")
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local lspkind = require("lspkind")

                cmp.setup({
                    formatting = {
                        format = lspkind.cmp_format({
                            mode = "symbol_text",
                            -- preset = 'codicons'
                            -- Can add more control.
                            before = function(entry, vim_item)
                                return vim_item
                            end

                        })
                    },
                    snippet = {
                      -- REQUIRED - you must specify a snippet engine
                      expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                      end,
                    },
                    window = {
                      completion = cmp.config.window.bordered(),
                      documentation = cmp.config.window.bordered(),
                    },
                    mapping = cmp.mapping.preset.insert({
                      -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                      ['<C-Space>'] = cmp.mapping.complete(),
                      ['<C-e>'] = cmp.mapping.abort(),
                      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                      { name = 'nvim_lsp' },
                      { name = 'nvim_lua' },
                      -- { name = 'vsnip' }, -- For vsnip users.
                      { name = 'luasnip' }, -- For luasnip users.
                      -- { name = 'ultisnips' }, -- For ultisnips users.
                      -- { name = 'snippy' }, -- For snippy users.
                    }, {
                      { name = 'buffer' },
                    })
                  })

                  -- Set configuration for specific filetype.
                  cmp.setup.filetype('gitcommit', {
                    sources = cmp.config.sources({
                      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                    }, {
                      { name = 'buffer' },
                    })
                  })

                  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
                  cmp.setup.cmdline('/', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                      { name = 'buffer' }
                    }
                  })

                  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                  cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                      { name = 'path' }
                    }, {
                      { name = 'cmdline' }
                    })
                  })

                  cmp.event:on(
                    'confirm_done',
                    cmp_autopairs.on_confirm_done()
                  )
            end
        }


        -- ------------------------------------------------------------------------
        -- LSP
        -- ------------------------------------------------------------------------

        use {
            "neovim/nvim-lspconfig",
            requires = {
                "williamboman/nvim-lsp-installer",
            },
            after = "nvim-cmp",
            config = function()
                local installer = require("nvim-lsp-installer")
                local lspconfig = require("lspconfig")

                -- NOTE: This can probably go into defaults?
                -- Disable virtual text in diagnostics.
                -- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                --   vim.lsp.diagnostic.on_publish_diagnostics,
                --   {
                --     underline = true,
                --     signs = true,
                --     virtual_text = false,
                --   }
                -- )

                -- Default args to merge into global lsp configs.
                local defaults = {
                    flags = {
                        debounce_text_changes = 150,
                    },
                    capabilities = require('cmp_nvim_lsp').update_capabilities(
                        vim.lsp.protocol.make_client_capabilities()
                    ),
                    on_attach = function(client, bufnr)
                        vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
                    end
                }

                -- Update global default config to apply to all servers.
                lspconfig.util.default_config = vim.tbl_deep_extend(
                  'force',
                  lspconfig.util.default_config,
                  defaults
                )

                -- Server specific overrides.
                local server_configs = {
                    sumneko_lua = {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {"vim", "hs"}
                                }
                            }
                        }
                    }
                }

                installer.on_server_ready(
                    function(server)

                        -- Get server specific configuration.
                        local conf = server_configs[server.name]
                        if conf == nil then
                            conf = {}
                        end

                        -- This setup() function is exactly the same as lspconfig's setup function.
                        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                        server:setup(conf)
                        -- Do we need to attach?
                        vim.cmd([[ do User LspAttach Buffers ]])
                    end
                )

            end
        }

        -- -------------------------------------------------------------------
        -- snippets
        -- -------------------------------------------------------------------
        use {
            'L3MON4D3/LuaSnip',
            requires = {
                'rafamadriz/friendly-snippets',

            },
            -- after = 'nvim-cmp',
            config = function()
                -- FIXME: loaders nil
                -- local luasnip = require("luasnip")
                -- luasnip.loaders.from_vscode.lazy_load()
            end
        }

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {}
            end
        }

        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        }

        -- TODO: Empty file finding. Look into this plugin later.
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
            config = function()
                require("telescope").setup {
                    extensions = {
                        fzf = {
                            fuzzy = true,
                            override_generic_sorter = true,
                            override_file_sorter = true,
                            case_mode = "smart_case"
                        }
                    }
                }
                -- require('telescope').load_extension('projects')
                require("telescope").load_extension("fzf")
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
                --      },
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
                --        },
                --         vertical = {
                --           mirror = false,
                --        },
                --      },
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
                --       borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
                --       color_devicons = true,
                --       use_less = true,
                --       set_env = { ['COLORTERM'] = 'truecolor'}, -- default = nil,
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
            "tpope/vim-commentary",
            "tpope/vim-repeat",
            "tpope/vim-endwise"
        }


        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("gitsigns").setup()
            end
        }

        use {
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                local neogit = require('neogit')
                neogit.setup()
            end
        }

        use {
            "lewis6991/spaceless.nvim",
            config = function()
                require("spaceless").setup()
            end
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-tree").setup({})
            end
        }

        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup({})
            end
        }

        -- -------------------------------------------------------------------------
        -- key remmaping
        -- TODO:We could probably just write our own that loops through a dict.
        -- -------------------------------------------------------------------------
        use {
            "LionC/nest.nvim",
            config = function()
                local nest = require("nest")

                nest.applyKeymaps(
                    {
                        -- Remove silent from ; : mapping, so that : shows up in command mode
                        -- { ';', ':' , options = { silent = false }},
                        -- { ':', ';'},
                        {
                            "<leader>",
                            {
                                -- quit buffer
                                {"qb", "<cmd>:q<CR>"},
                                {"qwa", "<cmd>qwa<CR>"},
                                {"w", "<cmd>w<CR>"},
                                -- finding
                                {
                                    "f",
                                    {
                                        {"e", "<Cmd>NvimTreeToggle<CR>"},
                                        {"b", "<Cmd>Telescope buffers<CR>"},
                                        {"f", "<Cmd>Telescope find_files<CR>"},
                                        {"l", "<Cmd>Telescope live_grep<CR>"},
                                        {
                                            "g",
                                            {
                                                {"b", "<Cmd>Telescope git_branches<CR>"},
                                                {"c", "<Cmd>Telescope git_commits<CR>"},
                                                {"s", "<Cmd>Telescope git_status<CR>"}
                                            }
                                        }
                                    }
                                },
                                -- language servers.
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
                                {
                                    "l",
                                    {
                                        {"a", "<cmd>lua vim.lsp.buf.code_action()<CR>"},
                                        {"s", "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
                                        {"h", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
                                        -- diagnostics
                                        {
                                            "d",
                                            {
                                                {"l", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
                                                {"n", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},
                                                {"p", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},
                                                {"q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"}
                                            }
                                        },
                                        -- movement
                                        {
                                            "g",
                                            {
                                                {"D", "<Cmd>lua vim.lsp.buf.declaration()<CR>"},
                                                {"d", "<Cmd>lua vim.lsp.buf.definition()<CR>"},
                                                {"h", "<cmd>lua vim.lsp.buf.references()<CR>"},
                                                {"i", "<cmd>lua vim.lsp.buf.implementation()<CR>"},
                                                {"r", "<cmd>lua vim.lsp.buf.rename()<CR>"},
                                                {"s", "<cmd>lua vim.lsp.buf.signature_help()<CR>"},
                                                {"t", "<cmd>lua vim.lsp.buf.type_definition()<CR>"}
                                            }
                                        },
                                        -- refactoring
                                        {
                                            "r",
                                            {
                                                {"r", "<Cmd>lua vim.lsp.buf.rename()<CR>"},
                                                {"f", "<cmd>lua vim.lsp.buf.formatting()<CR>"}
                                            }
                                        },
                                        -- workspace
                                        {
                                            "w",
                                            {
                                                {"a", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"},
                                                {
                                                    "l",
                                                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
                                                },
                                                {"r", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"},
                                                {"s", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"}
                                            }
                                        }
                                    }
                                },
                                -- Package management.
                                {
                                    "pkg",
                                    {
                                        {"c", "<Cmd>PackerCompile<CR>"},
                                        {"i", "<Cmd>PackerInstall<CR>"},
                                        {"s", "<Cmd>PackerSync<CR>"}
                                    }
                                }
                            }
                        },
                        -- Use insert mode for all nested keymaps
                        {
                            mode = "i",
                            {
                                -- Set <expr> option for all nested keymaps
                                {
                                    options = {expr = true},
                                    {
                                        {"<CR>", "compe#confirm('<CR>')"},
                                        -- This is equivalent to viml `inoremap <C-Space> <expr>compe#complete()`
                                        {"<C-Space>", "compe#complete()"}
                                    }
                                },
                                {"<C-h>", "<left>"},
                                {"<C-l>", "<right>"},
                                {"<C-o>", "<Esc>o"}
                            }
                        }
                    }
                )
            end
        }

        -- TODO:
        -- NOTE: Want to like this, but can't disable highlights.
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup (
                    {
                        highlight = {
                            keyword = 'fg',
                            after = '',
                            comments_only = true,
                        },
                    }
                )
            end
        }
    end
)
