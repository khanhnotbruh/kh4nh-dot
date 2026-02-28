local M = {}

M.path = vim.fn.stdpath("state") .. "/custom.json"
function M.state_exists()
  return vim.loop.fs_stat(M.path) ~= nil
end
function M.load_state()
  local f = io.open(M.path, "r")
  if not f then
    return {}
  end
  local content = f:read("*a")
  f:close()
  local ok, data = pcall(vim.json.decode, content)
  return ok and data or {}
end
function M.save_state(state)
  vim.fn.mkdir(vim.fn.stdpath("state"), "p")
  local f = io.open(M.path, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(state))
  f:close()
end
return M

