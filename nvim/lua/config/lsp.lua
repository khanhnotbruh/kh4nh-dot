-- mason
require("mason").setup()

require("mason-registry").refresh(function()
    local servers = {
        clangd = "clangd",
        pyright = "pyright",
        lua_ls = "lua-language-server",
    }

    local mr = require("mason-registry")
    for _, pkg in pairs(servers) do
        local p = mr.get_package(pkg)
        if not p:is_installed() then
            p:install()
        end
    end
end)

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

-- lua
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
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
    capabilities = capabilities,
    filetypes = { "python" },
})

-- c / cpp
vim.lsp.config("clangd", {
    capabilities = capabilities,
    filetypes = { "c", "cpp" },
})

-- ENABLE servers 
vim.lsp.enable({
    "lua_ls",
    "pyright",
    "clangd",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = require("keymap").lsp_on_attach
})


