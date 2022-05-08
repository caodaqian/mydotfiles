require('plugs.dap.dap-config').setup()
require('plugs.dap.dap-ui')
require('plugs.dap.dap-virtual-text')
require('plugs.dap.dap-util')

local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap
-- debug keymap
keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap('n', '<F10>', '<cmd>lua require"plugs.dap.dap-util".reload_continue()<CR>', opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap('n', '<S-F5>', "<cmd>lua require'dap'.close()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<S-F11>", "<cmd>lua require'dap'.step_out()<cr>", opts)

