--------------------- dependency-------------------------
require("mini.basics").setup()
require("mini.icons").setup()

-------------------- QoL ------------------
require("mini.git").setup()
require("mini.bufremove").setup()
local miniclue=require("mini.clue")
miniclue.setup({
  triggers={

    { mode = 'n', keys= 'Leader>'},
    { mode = 'n', keys= '<Leader>e'},
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    config = {},
    delay = 100,
    scroll_down = '<Up>',
    scroll_up = '<Down>',
  }
})
require("mini.pick").setup()
require("mini.tabline").setup()
require("mini.keymap").setup()
-------------------- text editing ------------------
require("mini.ai").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.splitjoin").setup()
require("mini.jump").setup()

-------------------- completion ------------------
require('mini.diff').setup()
require("mini.snippets").setup()
require("mini.completion").setup({
  lsp_completion={
    source_func="omnifunc",
    auto_setup=false
  },
  delay = { completion = 100, info = 100, signature = 50 },
})
require("mini.files").setup({})

-------------------- statusline ------------------
local sl=require("mini.statusline")
--helper
local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function fixed_width(str, width)
  local len = vim.fn.strdisplaywidth(str)
  if len < width then
    return str .. string.rep(" ", width - len)
  end
  return str
end
local function clock()
  return 
end
-- set color for each block
local function set_hl(mode_hl)
  --mode
  vim.api.nvim_set_hl(0,"modeSeparator",{
    bg=hl(mode_hl).bg,
    fg=hl("StatusLine").bg,
  })
  --file
  vim.api.nvim_set_hl(0,"fileSeparator",{
    bg=hl("StatusLine").bg,
    fg=hl("MiniStatuslineFilename").bg
  })
  --clock
  vim.api.nvim_set_hl(0,"clockSeparator",{
    fg = hl("Visual").bg,
    bg = hl("MiniStatuslineLocation").fg,
  })
end
-- content layout
local content_active = function()
  local mode, mode_hl = sl.section_mode({})
  local file = vim.fn.expand("%:t")--sl.section_filename({trunc_width=10})
  local pos=sl.section_location({{trunc_width=10}})
  set_hl(mode_hl)
  return table.concat({
    '%#', mode_hl, '# ', fixed_width(mode,8),
    "%#modeSeparator#🭦", 
    '%#StatusLine#'," ",
    "%#fileSeparator#🭦",
    "%#MiniStatuslineFilename# - ",fixed_width(file,11),
    "%#fileSeparator#🭀",
    "%#StatusLine#",
    "%#MiniStatuslineLocation# ",fixed_width(pos,20),
    "%#StatusLine#",
    "%=",
    "%#clockSeparator#🭦",
    "%#Visual# ",fixed_width(os.date("%H:%M"),5),'  ',
    "%#StatusLine#",
  },'')
end
sl.setup({
  content={active=content_active}
})



