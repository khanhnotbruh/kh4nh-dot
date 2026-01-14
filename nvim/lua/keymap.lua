local M = {}

local map = vim.keymap.set
------------------------------------------------------------
-- BASIC EDITING
------------------------------------------------------------

map("v", "<leader>c", '"+y', { desc = "Copy selection to system clipboard" })
map("x", "<leader>p", "\"_dP", { desc = "Paste without overwriting clipboard" })

map("v", "K", ":m '<-2<CR>gv=gv", {
    noremap = true,
    silent = true,
    desc = "Move selected lines up",
})

map("v", "J", ":m '>+1<CR>gv=gv", {
    noremap = true,
    silent = true,
    desc = "Move selected lines down",
})

map("v", "<", "<gv", {
    noremap = true,
    silent = true,
    desc = "Indent left (stay in visual)",
})

map("v", ">", ">gv", {
    noremap = true,
    silent = true,
    desc = "Indent right (stay in visual)",
})

map("n", "<leader>v", "<C-v>", { desc = "Enter visual block mode" })

map("n", "<leader>bp", ":bprevious<CR>", {
    noremap = true,
    silent = true,
    desc = "Go to previous buffer",
})
------------------------------------------------------------
-- LOG / DIAGNOSTICS
------------------------------------------------------------

map("n", "<leader>lo", function()
    vim.diagnostic.setloclist()
    vim.cmd("lopen")
end, {
    noremap = true,
    silent = true,
    desc = "Open LSP diagnostics (location list)",
})

map("n", "<leader>cc", function()
    vim.cmd("make")
    vim.cmd("copen")
end, {
    desc = "Run make and open quickfix",
})

map("n", "<leader>lc", function()
    vim.cmd("lclose")
end, {
    noremap = true,
    silent = true,
    desc = "Close location list",
})

------------------------------------------------------------
-- TERMINAL
------------------------------------------------------------
map("n", "<leader>th", ":vsplit | terminal<CR>", {
    noremap = true,
    silent = true,
    desc = "Open terminal (vertical split)",
})

map("n", "<leader>tv", ":split |terminal<CR>", {
    noremap = true,
    silent = true,
    desc = "Open terminal (horizontal split)",
})

------------------------------------------------------------
-- NEOGIT
------------------------------------------------------------

map("n", "<leader>gg", ":Neogit<CR>", { silent = true, desc = "Open neo git ui" })

------------------------------------------------------------
-- WHICH KEY
------------------------------------------------------------

function M.wk_keymap(wk)
    map("n", "<leader>?", function()
        wk.show({ global = false })
    end, { desc = "Open which key (show keybind)" })
end

------------------------------------------------------------
--undo tree
------------------------------------------------------------

map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open undotree" })

------------------------------------------------------------
--VISUAL MULTI
------------------------------------------------------------

-- Start multicursor (like Ctrl+D in VSCode)
map("n", "<C-d>", "<Plug>(VM-Find-Under)")
map("v", "<C-d>", "<Plug>(VM-Find-Subword-Under)")

-- Select all matches
map("n", "<C-S-d>", "<Plug>(VM-Select-All)")

-- Add cursor above / below
map("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
map("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")

-- Skip current match
map("n", "<C-x>", "<Plug>(VM-Skip)")

-- Exit multicursor
map("n", "<Esc>", "<Plug>(VM-Exit)")

------------------------------------------------------------
-- CUSTOM
------------------------------------------------------------
local theme = require("custom.theme")
map({ "n", "i" }, "<F5>", theme.theme_next, { desc = "Next theme" })
map("n", "<leader>F5>", theme.theme_prev, { desc = "Previous theme" })

------------------------------------------------------------
-- NEOTREE
------------------------------------------------------------
map("n", "<leader>ef", ":Neotree reveal_force_cwd<CR>", {
    silent = true,
    desc = "Reveal current file in Neotree",
})

map("n", "<leader>eo", ":Neotree toggle<CR>", {
    silent = true,
    desc = "Toggle Neotree",
})
M.neotree = {
    ["<Tab>"] = "expand_all_nodes",
    ["<S-Tab>"] = "close_all_nodes",

    ["o"] = "toggle_node",
    ["<cr>"] = "open",

    ["a"] = { "add", config = { show_path = "relative" } },
    ["d"] = { "add_directory", config = { show_path = "relative" } },

    ["D"] = "delete",
    ["r"] = "rename",
}

------------------------------------------------------------
--HARPOON
------------------------------------------------------------
local ok_harpoon, harpoon = pcall(require, "harpoon")
if ok_harpoon then
    harpoon:setup()

    map("n", "<leader>a", function()
        harpoon:list():add()
        vim.notify("Buffer added to harpoon!", vim.log.levels.INFO)
    end, { desc = "Harpoon: add current buffer" })

    map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {
        noremap = true,
        silent = true,
        desc = "Harpoon: toggle quick menu",
    })

    map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: go to file 1" })
    map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: go to file 2" })
    map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: go to file 3" })
    map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: go to file 4" })

    map("n", "<leader>[", function() harpoon:list():prev() end, { desc = "Harpoon: previous file" })
    map("n", "<leader>]", function() harpoon:list():next() end, { desc = "Harpoon: next file" })
end

------------------------------------------------------------
-- TELESCOPE
------------------------------------------------------------

function M.telescope_builtin(builtin)
    return {
        ["<leader>ff"] = { action = builtin.find_files, desc = "Find Files" },
        ["<leader>fg"] = { action = builtin.live_grep, desc = "Live Grep" },
        ["<leader>fb"] = { action = builtin.buffers, desc = "Buffers" },
        ["<leader>fh"] = { action = builtin.help_tags, desc = "Help Tags" },
    }
end

function M.telescope_default(actions, action_layout)
    return {
        i = {
            ["<C-u>"] = false, -- clear promt !
            ["<M-p>"] = action_layout.toggle_preview,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
        },
        n = {
            ["<M-p>"] = action_layout.toggle_preview,
            ["q"] = require('telescope.actions').close,
        },
    }
end

function M.telescope_buffer(actions, action_layout)
    return {
        i = {
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top, -- delete buffer ;-;
        },
    }
end

------------------------------------------------------------
-- CMP
------------------------------------------------------------

function M.cmp(cmp, luasnip)
    return {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(),

        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }
end

------------------------------------------------------------
-- TEXT SURROUND
------------------------------------------------------------


M.surround = {
    insert = "<C-g>s",      -- add surround in insert mode
    insert_line = "<C-g>S", -- add surround to entire line in insert mode
    normal = "ys",          -- add surround in normal mode
    normal_cur = "yss",     -- add surround to current line
    normal_line = "yS",     -- add surround to line(s)
    visual = "S",           -- add surround in visual mode
    delete = "ds",          -- delete surrounding
    change = "cs",          -- change surrounding
}

------------------------------------------------------------
-- LSP
------------------------------------------------------------
function M.lsp_keymap(opts)
    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    map("n", "<leader>df", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostic float" }))

    map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
end

------------------------------------------------------------
-- TREE SITTER
------------------------------------------------------------

M.ts_incremental_selection = {
    init_selection = "gnn",
    node_incremental = "grn",
    node_decremental = "grm",
    scope_incremental = "grc",
}

M.ts_textobjects_select = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",

    ["as"] = "@struct.outer",
    ["is"] = "@struct.inner",

    ["ad"] = "@typedef.outer",
    ["id"] = "@typedef.inner",

    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",

    ["ab"] = "@block.outer",
    ["ib"] = "@block.inner",
}

M.ts_textobjects_move = {
    enable = true,
    set_jumps = true, -- record jumps in jumplist
    goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]b"] = "@block.outer",
        ["]s"] = "@struct.outer",
    },
    goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer",
        ["]s"] = "@struct.outer",
    },
    goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer",
        ["]s"] = "@struct.outer",
    },
    goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer",
        ["]s"] = "@struct.outer",
    },
}
return M
