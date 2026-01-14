local keymap = require("keymap")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

for key, map in pairs(keymap.telescope_builtin(builtin)) do
    vim.keymap.set("n", key, map.action, { desc = map.desc })
end

require("telescope").setup {
    defaults = {
        mappings = keymap.telescope_default(actions, action_layout)
    },
    pickers = {
        buffers = {
            mappings = keymap.telescope_buffer(actions, action_layout)
        },
    },
}
