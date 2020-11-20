require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",      -- one of "all", "language", or a list of languages
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
