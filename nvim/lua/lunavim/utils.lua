-- Utility functions for vimo.nvim
local M = {}

---@param tbl table
---Create a table of key-value pairs from a list of values.
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

---@param vimo table
---@param tbl table
---Set options for a vimo object from a table of key-value pairs.
M.setopts = function(vimo, tbl)
	for _, v in ipairs(tbl) do
		vimo[v[1]] = v[2]
	end
end

---@param cmds table
---Execute a list of Vim commands.
M.runcmds = function(cmds)
	for _, v in ipairs(cmds) do
		vim.cmd(v)
	end
end

return M
