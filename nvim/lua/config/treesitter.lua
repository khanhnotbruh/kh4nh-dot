local keymap = require("keymap")
local gt = keymap.ts_textobjects_move

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua", "c", "cpp", "python", "bash",
    },

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf)
            return vim.api.nvim_buf_line_count(buf) > 5000
        end,
    },

    indent = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = keymap.ts_incremental_selection
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = keymap.ts_textobjects_select
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = gt.goto_next_start,
            goto_next_end = gt.goto_next_end,
            goto_previous_start = gt.goto_previous_start,
            goto_previous_end = gt.goto_previous_end,
        },
    },
})

