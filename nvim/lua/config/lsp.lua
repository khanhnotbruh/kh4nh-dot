local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})
vim.lsp.config("pyright", {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = { typeCheckingMode = "basic" },
    },
  },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
