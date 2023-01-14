local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lspsaga.setup{
	symbol_in_winbar = {
		enable = false -- https://github.com/glepnir/lspsaga.nvim/issues/554
	}
}

