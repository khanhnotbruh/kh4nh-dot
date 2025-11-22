local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then return false end
  local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  return text:sub(col, col):match("%s") == nil
end
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),

  -- Define keymaps for interaction
  mapping = cmp.mapping.preset.insert({
    ['<S-k>'] = cmp.mapping.select_prev_item(),
    ['<S-j>'] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true }) -- confirm the highlighted completion
      elseif has_words_before() then
        cmp.complete() -- open completion menu
      else
        fallback() -- indent
      end
    end, { "i", "s" }),
  }),

  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end
  }
})
