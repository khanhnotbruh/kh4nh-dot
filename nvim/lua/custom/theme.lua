local M={}
local utils=require("custom.utils")
local themes = {
    "tokyonight-night",
    "gruvbox",
    "catppuccin-mocha",
    "dracula-soft",
    "monokai",
    "terafox",
    "carbonfox",
    "duskfox",
}

function M.theme_switch()
    local index = tonumber(utils.read_line(utils.tmp, 1)) or 1
    if index > #themes then
        index = 1
    end

    local theme = themes[index]
    pcall(vim.cmd.colorscheme, theme)
    vim.notify("Switched to " .. theme)

    utils.write_to_line(utils.tmp, 1,index+1)
end
function M.apply_last_theme()
    local index = tonumber(utils.read_line(utils.tmp,1))

    if index > #themes then
        index = 1
    end

    local theme = themes[index-1]
    pcall(vim.cmd.colorscheme, theme)
end

return M

