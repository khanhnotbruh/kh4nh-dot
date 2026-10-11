local M={}

local utils=require("custom.utils")
local themes=require("themes")
local theme_names={}
for i,t in ipairs(themes) do
  theme_names[i]=t.name
end

local data=utils.load_state() or {theme_idx=1}
local function apply_theme(idx)
  local t=theme_names[idx]
  if not t then return end
  vim.cmd.colorscheme(t)
end
function M.next_theme()
  data.theme_idx=data.theme_idx%#theme_names+1 or 1
  apply_theme(data.theme_idx)
  utils.save_state(data)
end
function M.prev_theme()
  data.theme_idx=(data.theme_idx-2)%#theme_names+1 or 1
  apply_theme(data.theme_idx)
  utils.save_state(data)
end
apply_theme(data.theme_idx)
return M
