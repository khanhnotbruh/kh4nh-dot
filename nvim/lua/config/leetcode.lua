local ok, err = pcall(function()
  require("leetcode").setup({
    lang = "c",
  })
end)

if not ok then
  vim.schedule(function()
    vim.notify(
      "Leetcode setup failed:\n" .. err,
      vim.log.levels.ERROR
    )
  end)
end

