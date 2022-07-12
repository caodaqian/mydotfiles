local status_ok, scroll = pcall(require, "scrollview")
if not status_ok then
	return
end

scroll.setup({
	excluded_filetypes ={"toggleterm", "telescope", "floaterm", "aerial", "NvimTree"},
	current_only = false,
	winblend = 75,
	base = 'right',
	column = 1
})
