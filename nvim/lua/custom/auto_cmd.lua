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

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local name = vim.api.nvim_buf_get_name(args.buf)

    if not name:match("^zipfile:") then
      return
    end

    if not name:match("word/document.xml$") then
      return
    end

    -- prevent re-running
    if vim.b[args.buf].docx_formatted then
      return
    end
    vim.b[args.buf].docx_formatted = true

    -- get content
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local input = table.concat(lines, "\n")

    -- run xmllint safely
    local output = vim.fn.systemlist({ "xmllint", "--format", "-" }, input)

    if vim.v.shell_error ~= 0 then
      vim.notify("xmllint failed; document.xml left untouched", vim.log.levels.WARN)
      return
    end

    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, output)
    vim.bo[args.buf].filetype = "xml"

    vim.notify("Formatted docx document.xml", vim.log.levels.INFO)
  end,
})

