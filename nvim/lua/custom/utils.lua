local M = {}

M.tmp = vim.fn.stdpath("data") .. "/theme_index"

-- helpers -------------------------------------------------

function M.write_to_line(path, line, text)
    local lines = {}

    local f = io.open(path, "r")
    if f then
        for l in f:lines() do
            table.insert(lines, l)
        end
        f:close()
    end

    while #lines < line do
        table.insert(lines, "")
    end

    lines[line] = tostring(text)

    f = io.open(path, "w")
    if f==nil then return end
    for _, l in ipairs(lines) do
        f:write(l .. "\n")
    end
    f:close()
end

function M.read_line(path, line)
    local f = io.open(path, "r")
    if not f then
        return {}
    end

    local n = 1
    for l in f:lines() do
        if n == line then
            f:close()
            return l
        end
        n = n + 1
    end

    f:close()
    return  {}
end

return M
