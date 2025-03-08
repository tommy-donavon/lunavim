local M = {}

M.mkdef = function(tbl, default)
  if default == nil then
    default = true
  end
  for i, v in ipairs(tbl) do
    if type(v) ~= 'table' then
      tbl[i] = { v, default }
    end
  end
  return tbl
end

M.setopts = function(vimo, tbl)
  for _, v in ipairs(tbl) do
    vimo[v[1]] = v[2]
  end
end

M.runcmds = function(cmds)
  for _, v in ipairs(cmds) do
    vim.cmd(v)
  end
end

return M
