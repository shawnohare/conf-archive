return require("packer").startup(
    function(use)

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("indent_blankline").setup {
                    -- for example, context is off by default, use this to turn it on
                    show_current_context = true,
                    show_current_context_start = true,
                }
            end

        }

        -- ------------------------------------------------------------------------
        -- Treesitter
        -- ------------------------------------------------------------------------

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

        -- NOTE: Accepting autocomplete suggestion caused extranous carraige return.
        use {
            'windwp/nvim-autopairs',
            config = function()
                local remap = vim.api.nvim_set_keymap
                local npairs = require('nvim-autopairs')
                  -- skip it, if you use another global object
                _G.MUtils= {}

                vim.g.completion_confirm_key = ""
                MUtils.completion_confirm = function()
                  if vim.fn.pumvisible() ~= 0  then
                    if vim.fn.complete_info()["selected"] ~= -1 then
                      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
                    else
                      return npairs.esc("<cr>")
                    end
                  else
                    return npairs.autopairs_cr()
                  end
                end
                remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
            end
        }

        -- NOTE: kommentary seems to prefer block comments.
        -- NOTE: Also issues multiple commands to comment.
        use {
          'b3nj5m1n/kommentary',
          config = function()
            local conf = require('kommentary.config')
            conf.use_extended_mappings()
            conf.configure_language(
              "default",
              {
                prefer_single_line_comments = true,
                use_consistent_indentation = true,
                ignore_whitespace = true,
              }
            )
          end
        }

        use {
          'ntpeters/vim-better-whitespace',
          config = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.better_whitespace = 1
            vim.g.show_spaces_that_precede_tabs = 1
            vim.g.strip_max_file_size = 100000
            vim.g.strip_whitespace_confirm = 0
            vim.g.strip_whitespace_on_save = 1
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
            "nvim-lualine/lualine.nvim",
            config = function()
                -- require('lualine').setup()
                require "lualine".setup {
                    icons_enabled = false,
                    theme = "auto"
                }
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


        -- - polyglot includes LaTeX-box, which is incompatible with vimtex.
        -- - 2109-04-05: polyglot includes old pgsql syntax, use lifepillar's.
        --   Confer https://github.com/sheerun/vim-polyglot/issues/391
        --   But, using polyglot with pgsql leads to no highlighting. Removing polyglot
        --   from the packpath solves this.
        use {
          'sheerun/vim-polyglot',
          config = function()
              vim.g.polyglot_disabled = {'latex', 'pgsql'}
          end
        }

        -- -------------------------------------------------------------------------
        -- key remmaping
        -- TODO:We could probably just write our own that loops through a dict.
        -- -------------------------------------------------------------------------

        -- NOTE: This will autochdir to project root, which I do not care for.
        use {
          "ahmedkhalf/project.nvim",
          config = function()
            vim.g.nvim_tree_update_cwd = 1
            vim.g.nvim_tree_respect_buf_cwd = 1
            require("project_nvim").setup {}
          end
        }

        -- ------------------------------------------------------------------------
        -- themes, colorschemes
        -- ------------------------------------------------------------------------

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

        use {
            "projekt0n/github-nvim-theme",
            after = "lualine.nvim",
            config = function()
                -- require('github-theme').setup({
                --     theme_style = "dark",
                --     comment_style = "italic",
                --     function_style = "NONE",
                --     keyword_style = "bold",
                --     sidebars = { "qf", "vista_kind", "terminal", "packer"},
                --   })
            end
        }

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

    end
)
