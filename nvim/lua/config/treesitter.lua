require("nvim-treesitter").setup({
  ensure_installed={},
  auto_install=false,
  highlight={
    enable=true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
vim.api.nvim_set_hl(0,"@markup.italic",{link="Normal"})
vim.api.nvim_set_hl(0,"@markup.underline",{link="Normal"})
vim.api.nvim_set_hl(0,"@punctuation.special",{link="Delimiter"})
