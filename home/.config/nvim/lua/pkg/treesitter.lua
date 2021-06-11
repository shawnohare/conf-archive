require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",      -- one of "all", "maintained", "language", or a list of languages
  -- ensure_installed = {"python"},      -- one of "all", "language", or a list of languages
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
