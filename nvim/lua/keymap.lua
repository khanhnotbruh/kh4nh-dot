vim.keymap.set("n","<leader>eo",function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then return end

  local stat = vim.loop.fs_stat(bufname)
  if not stat then return end

  if stat.type == "directory" then
    MiniFiles.open(bufname)
  elseif stat.type == "file" then
    MiniFiles.open(bufname)
  end
end,{desc="open file explorer"})
local c_util=require("custom.utils")
local t_func=require("custom.theme_set")
if  not c_util.state_exists() then
  c_util.save_state({theme_idx=1})
end
vim.keymap.set({"n","i","x"},"<F5>",t_func.next_theme,{desc="switch to next theme"})
vim.keymap.set({"n","i","x"},"<F17>",t_func.prev_theme,{desc="switch to prev theme"})
vim.keymap.set({"n","i","x"},"<C-s>",":w<CR>",{desc="save file"})
--completion
local map_multistep = require('mini.keymap').map_multistep

map_multistep('i', '<Tab>',  { 'minisnippets_next','minisnippets_expand','pmenu_next' })
map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
