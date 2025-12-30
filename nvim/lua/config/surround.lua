local keymap=require("keymap")
require("nvim-surround").setup({
    -- Number of lines within which surrounding can be searched for
    move_cursor = true,  -- move cursor to end of added/changed surrounds
    keymaps = keymap.surround,
    aliases = {},             -- custom aliases for surround characters
    surrounds = {},           -- custom surrounds
    highlight = {
        duration = 200,       -- highlight duration for visual feedback
        group = "Search",     -- highlight group
    },
})
