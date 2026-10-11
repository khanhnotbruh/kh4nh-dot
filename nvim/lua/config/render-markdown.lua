require("render-markdown").setup({
  latex={
    enabled=true,
    converter = { "utftex", "latex2text" },
  }
})
