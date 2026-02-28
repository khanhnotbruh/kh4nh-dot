local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.semantic_tokens.enable(false)
vim.lsp.config("lua_ls",{
  capabilities = capabilities,
})
-- clangd config
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
})

-- pyright config
vim.lsp.config("pyright", {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})
-- Enable them
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
