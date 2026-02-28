--transparent ui--
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require("options")

local packagePath = vim.fn.stdpath('data') .. '/site'
local miniPath = packagePath .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(miniPath) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone = {
    'git', 'clone', '--filter=blob:none',
    -- '--branch', 'stable',
    'https://github.com/nvim-mini/mini.nvim', miniPath
  }
  vim.fn.system(clone)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
-- setup mini.deps
require("mini.deps").setup({path={package=packagePath}})

-- setup a function for add many plugins
local function addPlugins(table)
  for _,item in ipairs(table) do
    MiniDeps.add(item)
  end
end
_G.Deps=_G.Deps or {}
Deps.now,Deps.later=MiniDeps.now, MiniDeps.later

-- plugins table
local plugins=require("plugins")
local themes=require("themes")
-- add it
addPlugins(plugins)
addPlugins(themes)


require("config.leetcode")
require("config.mini")
require("config.lsp")
require("config.treesitter")
require("keymap")

