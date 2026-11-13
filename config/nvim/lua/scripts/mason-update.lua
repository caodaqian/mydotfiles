-- ~/.config/nvim/lua/scripts/mason-update.lua
-- 在 Neovim headless 模式下更新所有已安装的 Mason 二进制工具
-- 无需安装任何第三方插件，仅依赖 mason.nvim 原生 API

local function load_mason()
	local ok = pcall(require, "mason")
	if ok then
		return true
	end

	-- LazyVim / lazy.nvim 环境：headless 模式下 VeryLazy 不会触发，
	-- Mason 的命令和模块不会自动加载，需显式加载
	local lazy_ok, lazy = pcall(require, "lazy")
	if lazy_ok then
		lazy.load({ plugins = { "mason.nvim" } })
		-- 等待模块加载完成（最多等 3 秒）
		for _ = 1, 30 do
			if pcall(require, "mason") then
				return true
			end
			vim.wait(100)
		end
	end
	return false
end

if not load_mason() then
	vim.schedule(function()
		vim.notify("mason.nvim not available", vim.log.levels.ERROR)
		vim.cmd("qa")
	end)
	return
end

local registry = require("mason-registry")
local installed = registry.get_installed_package_names()

if #installed == 0 then
	vim.schedule(function()
		print("[mason-update] No Mason packages installed.")
		vim.cmd("qa")
	end)
	return
end

local remaining = #installed
local quitting = false

local function finish()
	remaining = remaining - 1
	if remaining <= 0 and not quitting then
		quitting = true
		vim.schedule(function()
			print("[mason-update] Headless update finished.")
			vim.cmd("qa")
		end)
	end
end

-- 超时保护：防止网络卡死导致 headless 进程永远不退出
vim.defer_fn(function()
	if not quitting and remaining > 0 then
		quitting = true
		vim.schedule(function()
			print("[mason-update] Timeout reached, forcing quit.")
			vim.cmd("qa!")
		end)
	end
end, 30000)

for _, name in ipairs(installed) do
	local ok_pkg, pkg = pcall(registry.get_package, name)
	if not ok_pkg or not pkg then
		print("[mason-update] Skip " .. name .. ": package not found in registry")
		finish()
	elseif pkg:is_installing() then
		print("[mason-update] Skip " .. name .. ": already installing")
		finish()
	else
		local current = pkg:get_installed_version()
		local latest = pkg:get_latest_version()

		if latest and current and latest ~= current then
			print("[mason-update] Updating " .. name .. " " .. current .. " -> " .. latest)
			pkg:install({ version = latest }, function()
				print("[mason-update] Updated " .. name)
				finish()
			end)
		else
			print("[mason-update] Up to date: " .. name .. " " .. (current or "unknown"))
			finish()
		end
	end
end
