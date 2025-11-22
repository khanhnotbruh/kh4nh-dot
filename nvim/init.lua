require("khanh.keymap")
require("khanh.packer")
require("khanh.setting")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

local lines = {
  " ███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
  " ████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
  " ██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
  " ██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
  " ██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
  "",
  "             ┌( ಠ‿ಠ )┘",
  "        Welcome to Neovim",
}

local colors = {
  "#ff5555", -- red
  "#ffb86c", -- orange
  "#f1fa8c", -- yellow
  "#50fa7b", -- green
  "#8be9fd", -- cyan
  "#bd93f9", -- purple
  "#ff79c6", -- pink
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local width = 42
    local height = #lines

    local buf = vim.api.nvim_create_buf(false, true)

    -- apply lines + highlights
    for i, line in ipairs(lines) do
      vim.api.nvim_buf_set_lines(buf, i-1, i, false, { line })

      -- pick rainbow color based on line index
      local color = colors[(i % #colors) + 1]

      vim.api.nvim_set_hl(0, "Rainbow" .. i, { fg = color })
      vim.api.nvim_buf_add_highlight(buf, -1, "Rainbow" .. i, i-1, 0, -1)
    end

    -- window options
    local opts = {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      style = "minimal",
      border = "rounded",
    }

    vim.api.nvim_open_win(buf, false, opts)

    -- auto close after delay (optional)
    vim.defer_fn(function()
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end, 3000)
  end
})

