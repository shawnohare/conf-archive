vim.g.lua_tree_side = "left"
vim.g.lua_tree_width = 40
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
