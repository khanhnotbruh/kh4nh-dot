-- mason
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
    },
})
--capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- diagnostics
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
--globals
vim.lsp.config("*",{
    capabilities=capabilities,
    root_markers = { '.git' },
})

-- lua
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

-- python
vim.lsp.config("pyright", {
    filetypes = { "python" },
})

-- c / cpp
vim.lsp.config("clangd", {
    filetypes = { "c", "cpp" },
    root_markers = { '.clangd', 'compile_commands.json' },
})

-- ENABLE servers 
vim.lsp.enable({
    "lua_ls",
    "pyright",
    "clangd",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
        require("keymap").lsp_keymap({ buffer = ev.buf })
    end
})


