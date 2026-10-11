-- file manager
local MiniExtra = require("mini.extra")
local MiniFiles=require("mini.files")
local MiniPick=require("mini.pick")
vim.keymap.set("n","<leader>eo",function()
  local bufname=vim.api.nvim_buf_get_name(0)
  if bufname=="" then return end
  local uv = vim.uv or vim.loop
  local stat=uv.fs_stat(bufname)
  if not stat then return end
  if stat.type=="directory" or stat.type=="file" then
    MiniFiles.open(bufname)
  end
end,{desc="open file explorer"})
local c_util=require("custom.utils")
local t_func=require("custom.theme_set")
if not c_util.state_exists() then
  c_util.save_state({theme_idx=1})
end
-- theme switching
vim.keymap.set({"n","i","x"},"<F5>",t_func.next_theme,{desc="switch to next theme"})
vim.keymap.set({"n","i","x"},"<F17>",t_func.prev_theme,{desc="switch to prev theme"})
vim.keymap.set({"n","i","x"},"<S-F5>",t_func.prev_theme,{desc="switch to prev theme"})
vim.keymap.set({"n","i","x"},"<C-s>","<Cmd>w<CR>",{desc="save file"})
-- regex,finding
vim.keymap.set('n','<leader>ff',function()
  local root=vim.fs.root(0,{"CMakeLists.txt",".git",".gitignore"})or vim.fn.getcwd()
  MiniPick.builtin.files({},{source={cwd=root}})
end,{desc='find file'})
vim.keymap.set('n','<leader>fg',function()
  local root=vim.fs.root(0,{"CMakeLists.txt",".git",".gitignore"})or vim.fn.getcwd()
  MiniPick.builtin.grep({},{source={cwd=root}})
end,{desc='grep live'})
vim.keymap.set('v','<leader>=','<Cmd>s/\\v%V\\s*([\\=\\{\\}\\(\\)\\[\\)\\,])\\s*%V/\\1/g\n<Cmd>noh<CR>gv=',{silent=true})
vim.keymap.set('n','<leader>cf',function()
  vim.cmd('vsplit | edit ' .. vim.fn.fnameescape(vim.fn.stdpath('config')))
end,{desc="open config folder"})

--completion
local map_multistep=require('mini.keymap').map_multistep
map_multistep('i','<Tab>',{'minisnippets_next','minisnippets_expand','pmenu_next'})
map_multistep('i','<S-Tab>',{'minisnippets_prev','pmenu_prev'})
map_multistep('i','<CR>',{'pmenu_accept','minipairs_cr'})

-- file manipulation
for i=1,9 do
  vim.keymap.set('n','<M-' .. i .. '>',function()
    local bufs=vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_is_valid(bufnr)and vim.bo[bufnr].buflisted
    end,vim.api.nvim_list_bufs())
    if bufs[i] then
      vim.api.nvim_set_current_buf(bufs[i])
    end
  end,{desc="Go to tab position " .. i})
end
vim.keymap.set('n','<S-M-c>',function()
  vim.cmd('bdelete')
end,{desc="Close current buffer"})

vim.api.nvim_create_user_command('Wso','<Cmd>w!<CR><Cmd>so<CR>',{desc="alias to save and shout out"})
-- terminal manipulation
vim.keymap.set('t','<Esc>',[[<C-\><C-n>]],{desc="Exit terminal mode via prefix"})
--lsp stuff
vim.keymap.set("n","<leader>go",function()
  MiniExtra.pickers.diagnostic({scope="current"})
end,{desc="Buffer Diagnostics"})
vim.keymap.set("n","<leader>gd",function()
  MiniExtra.pickers.lsp({scope="definition"})
end,{desc="LSP Definition"})
vim.keymap.set("n","<leader>gr",function()
  MiniExtra.pickers.lsp({scope="references"})
end,{desc="LSP References"})
vim.keymap.set("n","<leader>gi",function()
  MiniExtra.pickers.lsp({scope="implementation"})
end,{desc="LSP Implementation"})
vim.keymap.set("n","<leader>gD",function()
  MiniExtra.pickers.lsp({scope="declaration"})
end,{desc="LSP Declaration"})
vim.keymap.set("n","]e",function()
  vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})
end,{desc="Next Error"})
vim.keymap.set("n","[e",function()
  vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})
end, { desc = "Previous Error" })
--treesitter object:
local ts_keybind={
  f="function",
  c="class",
  b="block",
  a="parameter",--argument
  i="conditional",
  l="loop",
}
local ts_select_keymaps={}
local ts_next_start={}
local ts_prev_start={}
local ts_next_end={}
local ts_prev_end={}

for ku,capture in pairs(ts_keybind) do
  local kU=ku:upper()
  local capa="@"..capture..".outer"
  local capi="@"..capture..".inner"
  local keyau, keyiu="a"..ku,"i"..ku
  local keyaU, keyiU="a"..kU,"i"..kU
  local commpref="<leader>"
  local prevpref="<leader>["
  local nextpref="<leader>]"
  ts_select_keymaps[commpref..ku]=capa
  ts_next_start[nextpref..keyau]= capa
  ts_next_end[  nextpref..keyaU]= capa
  ts_prev_start[prevpref..keyau]= capa
  ts_prev_end[  prevpref..keyaU]= capa
  ts_select_keymaps[commpref..ku]=capi
  ts_next_start[nextpref..keyiu]= capi
  ts_next_end[  nextpref..keyiU]= capi
  ts_prev_start[prevpref..keyiu]= capi
  ts_prev_end[  prevpref..keyiU]= capi
end
require('nvim-treesitter').setup({
  textobjects = {
    select={
      enable=true,
      lookahead=true,
      keymaps=ts_select_keymaps,
    },
    move={
      enable=true,
      set_jumps=true,
      goto_next_start=ts_next_start,
      goto_previous_start=ts_prev_start,
      goto_next_end=ts_next_end,
      goto_previous_end=ts_prev_end,
    },
  },
})

