local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

mason.setup({
    ui = {
        check_duplicates = true,
    },
    ---@type table
    ensure_installed = {}, -- You will install LSPs manually with :MasonInstall <server>
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end
mason_lspconfig.setup({
    ensure_installed = {},
    handlers = {
        function (server_name)
            print("Server " .. server_name .. " is handled by nvim-lspconfig")
        end,
    },
})
