-- mason
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
    },
})
-- lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global diagnostics
vim.diagnostic.config({
    virtual_text = {
        severity = vim.diagnostic.severity.ERROR,
        spacing = 4,
        prefix = "+"
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- lua_ls
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- pyright
vim.lsp.config("pyright", {
    capabilities = capabilities,
    filetypes = { "py" },
})

-- clangd
vim.lsp.config("clangd", {
    capabilities = capabilities,
    filetypes = { "c", "c++" },
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = require("keymap").lsp_on_attach
})
