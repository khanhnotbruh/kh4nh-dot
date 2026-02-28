require("nvim-treesitter.configs").setup({
  ensure_installed = {}, -- empty = manual control
  auto_install = false,  -- no auto downloads
  highlight = {
    enable = true,
  },
})
vim.api.nvim_set_hl(0, "@markup.italic", { link = "Normal" })
vim.api.nvim_set_hl(0, "@markup.underline", { link = "Normal" })
vim.api.nvim_set_hl(0, "@punctuation.special", { link = "Delimiter" })
