-- actually this thing is useless now bc nvim doesnt require it
-- it dont work too bc lazy always overide it ;-;


local utils=require("custom.utils")
local theme=require("plugins.theme")
local addition=require("plugins.addtion")

local M={}

local function usr_choice(plugin_content,plugin_name,line)
    local result=utils.read_line(utils.tmp,line)
    if result==nil then
        local done=false;
        vim.ui.select({"Yes", "No"}, {prompt = "Install " .. plugin_name .. "?"},function (c)
            if c=="Yes" then
                utils.write_to_line(utils.tmp,line,"y")
                table.insert(M, plugin_content)
                vim.notify("Added " .. plugin_name)
                done=true
            else
                utils.write_to_line(utils.tmp,line,"n")
                vim.notify("Skipped " .. plugin_name)
                done=true
            end
        end)
        while not done do
            vim.wait(10)
        end
    elseif result:lower()=="y" then
        table.insert(M,plugin_content)
    end
end

usr_choice(theme,"theme",2)
usr_choice(addition,"addition",3)


return M
