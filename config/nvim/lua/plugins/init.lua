local starts_with = function(str, start)
	return str:sub(1, #start) == start
end

local ends_with = function(str, ending)
	return ending == "" or str:sub(- #ending) == ending
end

local M = {}
local plugs = {}

M.setup = function()
	local config_dir = vim.fn.stdpath('config') .. '/lua/plugins'
	for _, fname in pairs(vim.fn.readdir(config_dir)) do
		if vim.fn.isdirectory(vim.fn.stdpath('config') .. '/lua/plugins/' .. fname) ~= 0 then
			local module = "plugins." .. fname
			local status_ok, plugin = pcall(require, module)
			if not status_ok then
				vim.notify('Failed loading ' .. module, vim.log.levels.ERROR)
			else
				for i = 1, #plugin do
					table.insert(plugs, plugin[i])
				end
			end
		elseif ends_with(fname, ".lua") and fname ~= "init.lua" then
			local cut_suffix_fname = fname:sub(1, #fname - #'.lua')
			local file = "plugins." .. cut_suffix_fname
			local status_ok, plugin = pcall(require, file)
			if not status_ok then
				vim.notify('Failed loading ' .. fname, vim.log.levels.ERROR)
			else
				for i = 1, #plugin do
					table.insert(plugs, plugin[i])
				end
			end
		end
	end
end

M.setup()
return plugs
