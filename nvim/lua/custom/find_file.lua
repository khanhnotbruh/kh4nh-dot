-- this also useless
local M={}
function M.find_c_file(builtin)
    builtin.find_files({
    find_command = {
      "rg",
      "--files",
      "--glob",
      "*.c",
      "--glob",
      "*.cpp",
      "--glob",
      "*.h",
    },
  })
end
function M.find_python_file(builtin)
    builtin.find_files({
    find_command = {
      "rg",
      "--files",
      "--glob",
      "*.py",
    },
  })
end
function M.find_lua_file(builtin)
    builtin.find_files({
    find_command = {
      "rg",
      "--files",
      "--glob",
      "*.lua",
    },
  })
end
return M
