if vim.fn.executable("git") == 0 then
  vim.notify("Git not found on system", vim.log.levels.WARN)
  if vim.fn.executable("curl") == 0 then
    vim.notify("Curl not found on system. Cannot auto-download Git.", vim.log.levels.ERROR)
    return
  end
  vim.notify("Downloading Git via curl...", vim.log.levels.INFO)
  local cmd = {}
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    local url = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe"
    local output_path = vim.fn.stdpath("cache") .. "/git-installer.exe"
    cmd = { "curl", "-sSL", url, "-o", output_path }
  else
    vim.notify("Cant download Git automatically in MacOS or linux-based OS", vim.log.levels.ERROR)
    return
  end
  vim.system(cmd, {}, function(obj)
    if obj.code == 0 then
      vim.schedule(function()
        vim.notify("Git installer downloaded successfully to cache!", vim.log.levels.INFO)
      end)
    else
      vim.schedule(function()
        vim.notify("Failed to download Git via curl.", vim.log.levels.ERROR)
      end)
    end
  end)
end
--transparent ui--
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
require("options")
local uv = vim.uv or vim.loop
local packagePath = vim.fs.joinpath(vim.fn.stdpath('data'), 'site')
local miniPath = vim.fs.joinpath(packagePath, 'pack', 'deps', 'start', 'mini.nvim')
if not uv.fs_stat(miniPath) then
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
require("mini.deps").setup({ path = { package = packagePath } })
-- setup a function for add many plugins
local function addPlugins(table)
  for _,item in ipairs(table) do
    MiniDeps.add(item)
  end
end
_G.Deps=_G.Deps or {}
Deps.now,Deps.later=MiniDeps.now,MiniDeps.later

-- plugins table
local plugins=require("plugins")
local themes=require("themes")
-- add it
addPlugins(plugins)
addPlugins(themes)

require("config.mini")
require("config.lsp")
if vim.fn.executable("treesitter")==1 then require("config.treesitter") end
if vim.fn.executable("utftex")==1 and vim.fn.executable("latex2text")==1 then require("config.render-markdown") end
require("config.smear-cursor")
require("keymap")
require("custom.autocmd")
