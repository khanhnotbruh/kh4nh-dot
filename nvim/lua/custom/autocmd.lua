vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "completeopt",
  callback = function()
    local target = 'menuone,noselect,fuzzy,nosort'
    if vim.o.completeopt ~= target then vim.o.completeopt = target end
  end,
})
vim.api.nvim_create_autocmd("FileType",{
    pattern="markdown",
    callback=function()
        vim.opt_local.conceallevel=2
    end,
})
-- Set makeprg to use build directory based on project root
vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
  pattern = {"*.c", "*.cpp"},
  callback = function()
    if vim.fn.executable("cmake")~=1 then return end
    local root = vim.fs.root(0, "CMakeLists.txt")
    if root then
      local build_dir = vim.fs.joinpath(root, "build")
      vim.opt_local.makeprg = "cmake --build " .. vim.fn.fnameescape(build_dir)
    end
  end
})

local function get_executable_info()
  local root = vim.fs.root(0, "CMakeLists.txt")
  if not root then return nil, nil end
  local cmake_file = vim.fs.joinpath(root, "CMakeLists.txt")
  local f = io.open(cmake_file, "r")
  if not f then return nil, nil end
  local content = f:read("*a")
  f:close()

  local project_name = content:match("project%s*%(%s*([%w_%-]+)")
  local exec_name = content:match("add_executable%s*%(%s*([%w_%-%$%{%}]+)")
  if not exec_name then return nil, nil end

  if exec_name:match("%$%{?PROJECT_NAME%}") then
    exec_name = project_name or vim.fn.fnamemodify(root, ":t")
  end
  return root, exec_name
end

local function find_executable(root, name)
  local is_win = vim.fn.has("win32") == 1
  local uv = vim.uv or vim.loop
  local candidates = {
    vim.fs.joinpath(root, "build", name .. ".exe"),
    vim.fs.joinpath(root, "build", name),
    vim.fs.joinpath(root, "build", "Debug", name .. ".exe"),
    vim.fs.joinpath(root, "build", "Release", name .. ".exe"),
    vim.fs.joinpath(root, "build", "RelWithDebInfo", name .. ".exe"),
    vim.fs.joinpath(root, "build", "MinSizeRel", name .. ".exe"),
    vim.fs.joinpath(root, "build", "Debug", name),
    vim.fs.joinpath(root, "build", "Release", name),
  }
  for _, path in ipairs(candidates) do
    local stat = uv.fs_stat(path)
    if stat and stat.type == "file" then
      return path
    end
  end
  return is_win and vim.fs.joinpath(root, "build", name .. ".exe") or vim.fs.joinpath(root, "build", name)
end

vim.api.nvim_create_autocmd("QuickFixCmdPost",{
  pattern="make",
  callback=function()
    local qf_list=vim.fn.getqflist()
    local has_errors = false
    for _, item in ipairs(qf_list) do
      if item.type == "E" or (item.valid == 1 and item.bufnr > 0) then
        has_errors = true
        break
      end
    end
    if not has_errors then
      local root, name = get_executable_info()
      if root and name then
        local exe = find_executable(root, name)
        if vim.fn.has("win32") == 1 then
          vim.cmd('split | terminal cmd.exe /c "' .. vim.fn.fnameescape(exe) .. ' & pause"')
        else
          vim.cmd('split | terminal sh -c "' .. vim.fn.fnameescape(exe) .. '; printf \'\\nPress Enter to close...\'; read _"')
        end
      end
    end
  end
})
