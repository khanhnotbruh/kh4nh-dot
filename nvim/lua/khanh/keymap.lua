local map=vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------
-- navigation
-----------------------------------------------------

map("v","i","c",{ noremap = true })

-----------------------------------------------------
--indent
-----------------------------------------------------
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
-----------------------------------------------------
-- text tools
-----------------------------------------------------
map("v","J",":m '>+1<CR>gv=gv")
map("v","K",":m '>-2<CR>gv=gv")
map("v", "<C-c>", ':%y+<CR>', { noremap = true, silent = true })
map("x","<leader>p","\"_dP")

-----------------------------------------------------
-- Buffer navigation
-----------------------------------------------------
map("n", "<leader>zh", ":bprevious<CR>", { noremap = true, silent = true })
map("n", "<leader>zl", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<leader>zd", ":bdelete<CR>", { noremap = true, silent = true })
map("n", "<leader>zp", "<C-w>p", { silent = true })
-----------------------------------------------------
--err log
-----------------------------------------------------
map("n", "<leader>lo", function()
  vim.diagnostic.setloclist()
  vim.cmd("lopen")
end, { noremap = true, silent = true })

map("n","<leader>lc", function ()
    vim.cmd("lclose")
end, { noremap = true, silent = true })
-----------------------------------------------------------------
--terminal
-----------------------------------------------------------------
-- Open terminal in horizontal split
map("n", "<leader>`oh", ":split | terminal<CR>", { noremap = true, silent = true })
-- Open terminal in vertical split
map("n", "<leader>`ov", ":vsplit | terminal<CR>", { noremap = true, silent = true })



-----------------------------------------------------
-- Neo-tree
------------------------------------------------------
local ok_tree, neotree = pcall(require, "neo-tree")
if ok_tree then
    map("n", "<leader>ef", ":Neotree reveal_force_cwd<CR>", { silent = true })
    map("n", "<leader>eo", ":Neotree toggle<CR>", { silent = true })

    neotree.setup({
        window = {
            mappings = {
                ["<Tab>"] = "expand_all_nodes",
                ["<S-Tab>"] = "close_all_nodes",

                ["o"] = "toggle_node",
                ["<cr>"]="open",


                ["a"] = { "add", config = { show_path = "relative" } },
                ["d"] = { "add_directory", config = { show_path = "relative" } },

                -- Delete, rename
                ["D"] = "delete",
                ["r"] = "rename",
            },
        },
    })
end

------------------------------------------------------
-- Fugitive
------------------------------------------------------

map("n", "<leader>gs", vim.cmd.Git)

------------------------------------------------------
-- Harpoon 2
------------------------------------------------------
local ok_harpoon, harpoon = pcall(require, "harpoon")
if ok_harpoon then
    harpoon:setup()

    map("n", "<leader>a", function()
        harpoon:list():add()
        vim.notify("Buffer added to harpoon!", vim.log.levels.INFO)
    end)
    map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end,{ noremap = true, silent = true })

    -- select
    map("n", "<leader>1", function() harpoon:list():select(1) end)
    map("n", "<leader>2", function() harpoon:list():select(2) end)
    map("n", "<leader>3", function() harpoon:list():select(3) end)
    map("n", "<leader>4", function() harpoon:list():select(4) end)

    -- prev / next
    map("n", "<leader>[", function() harpoon:list():prev() end)
    map("n", "<leader>]", function() harpoon:list():next() end)
end

------------------------------------------------------
-- Telescope
------------------------------------------------------
local ok_telescope, builtin = pcall(require, "telescope.builtin")
if ok_telescope then
    map("n", "<leader>tf", builtin.find_files, {})
    map("n", "<leader>tg", builtin.live_grep, {})
    map("n", "<leader>tb", builtin.buffers, {})
    map("n", "<leader>th", builtin.help_tags, {})

    map("n", "<leader>ts", function()
        builtin.grep_string({
            search = vim.fn.input("Grep > "),
        })
    end)
end

------------------------------------------------------
-- Undo Tree
------------------------------------------------------
map("n", "<leader>u", vim.cmd.UndotreeToggle)


------------------------------------------------------
-- comment && replace
------------------------------------------------------
local function comment_with_prompt()
    local sign = vim.fn.input("Comment sign: ")
    if sign == "" then return end
    sign = sign .. " "

    local mode = vim.fn.mode()
    if mode:match("[vV\22]") then -- Matches v, V, or Ctrl-v
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'x', false)
        vim.schedule(function()
            local b_start = vim.api.nvim_buf_get_mark(0, "<")
            local b_end = vim.api.nvim_buf_get_mark(0, ">")
            local start_line = b_start[1] - 1
            local end_line = b_end[1] -- exclusive end for get_lines? No, end is count. 
            local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
            for i, line in ipairs(lines) do
                lines[i] = sign .. line
            end
            vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
        end)
    else
        -- NORMAL MODE LOGIC
        local row = vim.api.nvim_win_get_cursor(0)[1] - 1
        local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
        vim.api.nvim_buf_set_lines(0, row, row + 1, false, {sign .. line})
    end
end

vim.keymap.set({"n", "v"}, "<leader>rc", comment_with_prompt, { desc = "Comment with custom prompt" })

local function replace_word()
    local from = vim.fn.input("Replace: ")
    if from == "" then return end
    local to = vim.fn.input("With: ")

    local search_pattern = "\\V" .. vim.fn.escape(from, "/\\")
    local replace_pattern = vim.fn.escape(to, "/\\&~")

    -- 'g' = global (all occurrences in line)
    -- 'I' = case sensitive (remove 'I' and add 'i' if you want case-insensitive)
    -- 'c' = confirm
    local cmd = string.format("%%s/%s/%s/gIc", search_pattern, replace_pattern)
    local success, err = pcall(vim.cmd, cmd)
    if success then
        print("Replaced '" .. from .. "' with '" .. to .. "'")
    else
        if not string.match(err, "Interrupted") then
            print("Error: " .. err)
        end
    end
end

vim.keymap.set("n", "<leader>rw", replace_word, { desc = "Search and Replace (Literal)" })
