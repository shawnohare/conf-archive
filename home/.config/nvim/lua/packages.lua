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
--
return require("packer").startup(
    function(use)
        -- Packer can manage itself
        use "wbthomason/packer.nvim"
        -- use {
        --     "lukas-reineke/indent-blankline.nvim",
        --     config = function()
        --         require("indent_blankline").setup {
        --             -- for example, context is off by default, use this to turn it on
        --             show_current_context = true,
        --             show_current_context_start = true,
        --         }
        --     end

        -- }

        use "shawnohare/hadalized.nvim"

        -- ------------------------------------------------------------------------
        -- Treesitter
        -- ------------------------------------------------------------------------

        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = "maintained", -- one of "all", "maintained", "language", or a list of languages
                    highlight = {
                        enable = true
                        -- disable = { "c", "rust"},  -- list of language that will be disabled
                    }
                    -- indent = {
                    --   enable = true,
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
                    --  },
                    --},
                }
            end
        }

        use {
            "RRethy/nvim-treesitter-textsubjects",
            config = function()
                require "nvim-treesitter.configs".setup(
                    {
                        textsubjects = {
                            enable = true,
                            keymaps = {
                                ["."] = "textsubjects-smart",
                                [";"] = "textsubjects-container-outer"
                            }
                        }
                    }
                )
            end
        }

        -- ------------------------------------------------------------------------
        -- LSP
        -- ------------------------------------------------------------------------
        use {
            "williamboman/nvim-lsp-installer"
        }

        use {
            "neovim/nvim-lspconfig",
            requires = "williamboman/nvim-lsp-installer",
            config = function()
                local installer = require("nvim-lsp-installer")
                installer.on_server_ready(
                    function(server)
                        local configs = {
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

                        local opts = configs[server.name]
                        if opts == nil then
                            opts = {}
                        end

                        -- This setup() function is exactly the same as lspconfig's setup function.
                        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                        server:setup(opts)
                        vim.cmd([[ do User LspAttach Buffers ]])
                    end
                )

                -- Disable virtual text in diagnostics.
                -- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                --   vim.lsp.diagnostic.on_publish_diagnostics,
                --   {
                --     underline = true,
                --     signs = true,
                --     virtual_text = false,
                --   }
                -- )
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
            "hrsh7th/nvim-compe",
            config = function()
                require("compe").setup {
                    enabled = true,
                    autocomplete = true,
                    debug = false,
                    min_length = 1,
                    preselect = "enable",
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
                        ultisnips = true
                    }
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
            "steelsojka/pears.nvim",
            config = function()
                require "pears".setup(
                    function(conf)
                        conf.on_enter(
                            function(pears_handle)
                                if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
                                    return vim.fn["compe#confirm"]("<CR>")
                                else
                                    pears_handle()
                                end
                            end
                        )
                    end
                )
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
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("gitsigns").setup()
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

        -- Prettyish icons in lsp menus (such as completion)
        use {
            "onsails/lspkind-nvim",
            config = function()
                require("lspkind").init(
                    {
                        with_text = true,
                        preset = "default",
                        symbol_map = {}
                    }
                )
            end
        }

        -- use {
        --     'glepnir/galaxyline.nvim',
        --     branch = 'main',
        --     config = function()
        --         require('statusline')
        --     end
        -- }

        -- use {
        --     "nvim-lualine/lualine.nvim",
        --     config = function()
        --         -- require('lualine').setup()
        --         require "lualine".setup {
        --             icons_enabled = false,
        --             theme = "auto"
        --         }
        --     end
        -- }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
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
                require("nvim-tree").setup(
                    {
                        disable_netrw = true,
                        hijack_netrw = true,
                        open_on_setup = false,
                        ignore_ft_on_setup = {},
                        auto_close = false,
                        open_on_tab = false,
                        hijack_cursor = false,
                        update_cwd = false,
                        update_to_buf_dir = {
                            enable = true,
                            auto_open = true
                        },
                        diagnostics = {
                            enable = false,
                            icons = {
                                hint = "",
                                info = "",
                                warning = "",
                                error = ""
                            }
                        },
                        update_focused_file = {
                            enable = false,
                            update_cwd = false,
                            ignore_list = {}
                        },
                        system_open = {
                            cmd = nil,
                            args = {}
                        },
                        filters = {
                            dotfiles = false,
                            custom = {}
                        },
                        git = {
                            enable = true,
                            ignore = true,
                            timeout = 500
                        },
                        view = {
                            width = 60,
                            height = 30,
                            hide_root_folder = false,
                            side = "left",
                            auto_resize = false,
                            mappings = {
                                custom_only = false,
                                list = {}
                            },
                            number = false,
                            relativenumber = false
                        },
                        trash = {
                            cmd = "trash",
                            require_confirm = true
                        }
                    }
                )
            end
        }

        -- use {
        --     'akinsho/nvim-bufferline.lua',
        --     requires = 'kyazdani42/nvim-web-devicons',
        --     config = function()
        --         vim.opt.termguicolors = true
        --         require('bufferline').setup {
        --             diagnostics = 'nvim_lsp',
        --         }
        --     end
        -- }

        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {}
            end
        }

        -- use {
        --   'sheerun/vim-polyglot',
        --   config = function()
        --       -- - polyglot includes LaTeX-box, which is incompatible with vimtex.
        --       -- - 2109-04-05: polyglot includes old pgsql syntax, use lifepillar's.
        --       --   Confer https://github.com/sheerun/vim-polyglot/issues/391
        --       --   But, using polyglot with pgsql leads to no highlighting. Removing polyglot
        --       --   from the packpath solves this.
        --       -- vim.g.polyglot_disabled = {'latex', 'pgsql'}
        --   end
        -- }

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

        -- NOTE: This will autochdir to project root, which I do not care for.
        -- use {
        --   "ahmedkhalf/project.nvim",
        --   config = function()
        --     vim.g.nvim_tree_update_cwd = 1
        --     vim.g.nvim_tree_respect_buf_cwd = 1
        --     require("project_nvim").setup {}
        --   end
        -- }

        -- ------------------------------------------------------------------------
        -- themes, colorschemes
        -- ------------------------------------------------------------------------

        use {
            "rktjmp/lush.nvim"
        }

        use {
            "olimorris/onedarkpro.nvim",
            -- config = function ()
            --   require('onedarkpro').load()
            -- end
            config = function()
                local onedarkpro = require("onedarkpro")
                onedarkpro.setup(
                    {
                        -- theme = function(), -- Override with "onedark" or "onelight". Alternatively, remove the option and the theme uses `vim.o.background` to determine
                        colors = {}, -- Override default colors. Can specify colors for "onelight" or "onedark" themes
                        hlgroups = {}, -- Override default highlight groups
                        styles = {
                            strings = "NONE", -- Style that is applied to strings
                            comments = "NONE", -- Style that is applied to comments
                            keywords = "bold", -- Style that is applied to keywords
                            functions = "italic", -- Style that is applied to functions
                            variables = "NONE" -- Style that is applied to variables
                        },
                        options = {
                            bold = true, -- Use the themes opinionated bold styles?
                            italic = true, -- Use the themes opinionated italic styles?
                            underline = true, -- Use the themes opinionated underline styles?
                            undercurl = true, -- Use the themes opinionated undercurl styles?
                            cursorline = false, -- Use cursorline highlighting?
                            transparency = false, -- Use a transparent background?
                            terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
                            window_unfocussed_color = false -- When the window is out of focus, change the normal background?
                        }
                    }
                )
                -- onedarkpro.load()
            end
        }

        -- use {
        --     "projekt0n/github-nvim-theme",
        --     after = "lualine.nvim",
        --     config = function()
        --         -- require('github-theme').setup({
        --         --     theme_style = "dark",
        --         --     comment_style = "italic",
        --         --     function_style = "NONE",
        --         --     keyword_style = "bold",
        --         --     sidebars = { "qf", "vista_kind", "terminal", "packer"},
        --         --   })
        --     end
        -- }

        use {
            "catppuccin/nvim",
            config = function()
                local catppuccin = require("catppuccin")
                catppuccin.setup(
                    {
                        transparent_background = false,
                        term_colors = false,
                        styles = {
                            comments = "italic",
                            functions = "italic",
                            keywords = "italic",
                            strings = "NONE",
                            variables = "NONE"
                        },
                        integrations = {
                            treesitter = true,
                            native_lsp = {
                                enabled = true,
                                virtual_text = {
                                    errors = "italic",
                                    hints = "italic",
                                    warnings = "italic",
                                    information = "italic"
                                },
                                underlines = {
                                    errors = "underline",
                                    hints = "underline",
                                    warnings = "underline",
                                    information = "underline"
                                }
                            },
                            lsp_trouble = true,
                            lsp_saga = false,
                            gitgutter = false,
                            gitsigns = false,
                            telescope = true,
                            nvimtree = {
                                enabled = true,
                                show_root = false
                            },
                            which_key = true,
                            indent_blankline = {
                                enabled = true,
                                colored_indent_levels = true
                            },
                            dashboard = false,
                            neogit = false,
                            vim_sneak = false,
                            fern = false,
                            barbar = false,
                            bufferline = false,
                            markdown = true,
                            lightspeed = false,
                            ts_rainbow = false,
                            hop = false
                        }
                    }
                )
            end
        }

        use {
            "rafamadriz/neon",
            config = function()
                vim.g.neon_style = "default"
                vim.g.neon_italic_keyword = true
                vim.g.neon_italic_function = true
            end
        }

        use "folke/tokyonight.nvim"

        use {
            "folke/lsp-colors.nvim",
            config = function()
                require("lsp-colors").setup(
                    {
                        Error = "#db4b4b",
                        Warning = "#e0af68",
                        Information = "#0db9d7",
                        Hint = "#10B981"
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
