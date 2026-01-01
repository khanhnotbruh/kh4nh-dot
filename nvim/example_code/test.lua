local M = {}

function M.factorial(n)
    if n <= 1 then
        return 1
    else
        return n * M.factorial(n - 1)
    end
end

function M.greet(names)
    for _, name in ipairs(names) do
        print("Hello, " .. name .. "!")
    end
end

local people = {"Alice", "Bob", "Charlie"}
M.greet(people)
print("5! = " .. M.factorial(5))

return M

