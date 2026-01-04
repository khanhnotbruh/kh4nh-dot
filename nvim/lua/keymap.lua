local M = {}

local map = vim.keymap.set

-- copy and paste
map("v", "<leader>c", '"+y')
map("x", "<leader>p", "\"_dP")

-- Move selected lines up/down and re-select after
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Indent/dedent and stay in visual mode
map("v", "<", "<gv", { remap = false, noremap = true, silent = true })
map("v", ">", ">gv", { remap = false, noremap = true, silent = true })

map("n", "<leader>v", "<C-v>")
map("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true })

------------------------------------
-- LOG (compiler err)
------------------------------------
-- there is le for open lsp log down below
map("n", "<leader>lo", function()
    vim.diagnostic.setloclist()
    vim.cmd("lopen")
end, { noremap = true, silent = true })

map("n", "<leader>cc", function()
    vim.cmd("make")
    vim.cmd("copen")
end)

map("n", "<leader>lc", function()
    vim.cmd("lclose")
end, { noremap = true, silent = true })

------------------------------------
-- TERMINAL
------------------------------------

map("n", "<leader>th", ":vsplit | terminal<CR>", { noremap = true, silent = true })
map("n", "<leader>tv", ":split |terminal<CR>", { noremap = true, silent = true })

------------------------------------------------------------------------------
-- NEOTREE
------------------------------------------------------------------------------
map("n", "<leader>ef", ":Neotree reveal_force_cwd<CR>", { silent = true })
map("n", "<leader>eo", ":Neotree toggle<CR>", { silent = true })

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
------------------------------------------------------------------------------
-- PLUGIN KEYBIND
------------------------------------------------------------------------------

-------------
-- fugitive
-------------

map("n", "<leader>gs", vim.cmd.Git)

-------------
--harpoon
-------------

local ok_harpoon, harpoon = pcall(require, "harpoon")
if ok_harpoon then
    harpoon:setup()

    map("n", "<leader>a", function()
        harpoon:list():add()
        vim.notify("Buffer added to harpoon!", vim.log.levels.INFO)
    end)
    map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { noremap = true, silent = true })

    -- select
    map("n", "<leader>1", function() harpoon:list():select(1) end)
    map("n", "<leader>2", function() harpoon:list():select(2) end)
    map("n", "<leader>3", function() harpoon:list():select(3) end)
    map("n", "<leader>4", function() harpoon:list():select(4) end)

    -- prev / next
    map("n", "<leader>[", function() harpoon:list():prev() end)
    map("n", "<leader>]", function() harpoon:list():next() end)
end

-------------
--telescope
-------------
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

-------------
--undo tree
-------------

map("n", "<leader>u", vim.cmd.UndotreeToggle)

------------------------------------------------------------------------------
-- CMP
------------------------------------------------------------------------------

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

------------------------------------------------------------------------------
-- TEXT SURROUND
------------------------------------------------------------------------------

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

------------------------------------------------------------------------------
-- CUSTOM
------------------------------------------------------------------------------
local theme = require("custom.theme")
map({ "n", "i" }, "<F5>", theme.theme_next)
map("n", "<leader>F5>", theme.theme_prev)

------------------------------------------------------------------------------
-- LSP
------------------------------------------------------------------------------
function M.lsp_keymap(opts)
    -- LSP navigation
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "la", vim.lsp.buf.document_symbol, opts)
    map("n", "K", vim.lsp.buf.hover, opts)

    -- LSP actions
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Diagnostics
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
    map("n", "<leader>df", vim.diagnostic.open_float, opts)

    -- Format
    map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

------------------------------------------------------------------------------
-- TREE SITTER
------------------------------------------------------------------------------

M.ts_incremental_selection = {
    init_selection = "gnn",
    node_incremental = "grn",
    node_decremental = "grm",
    scope_incremental = "grc",
}

M.ts_textobjects_select = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
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
    },
    goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer",
    },
    goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer",
    },
    goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer",
    },
}
------------------------------------------------------------------------------
-- NEOGIT 
------------------------------------------------------------------------------
map("n","<leader>gg",":Neogit<CR>",{silent=true})

return M
