vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "markdown" },
    callback = function(ev)
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
        local opts = { buffer = ev.buf, silent = true }

        -- Suggestions
        vim.keymap.set("n", "<leader>cl", "z=", opts)

        -- Add / mark word
        vim.keymap.set("n", "<leader>wa", "zg", opts)
        vim.keymap.set("n", "<leader>wm", "zw", opts)
        vim.keymap.set("n", "<leader>wua", "zug", opts)
    end,
})
vim.g.markdown_fenced_languages = {
    "c",
    "cpp",
    "lua",
    "python",
    "bash",
}

