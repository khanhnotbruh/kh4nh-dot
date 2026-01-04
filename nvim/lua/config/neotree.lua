local keymap = require("keymap")

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    bind_to_cwd = false,
    follow_current_file = {
      enabled = false,
    },
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },

  window = {
    width = 30,
    mappings = keymap.neotree,
  },
})

