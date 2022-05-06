local M = {}
local dap = require 'dap'

function M.reload_continue()
    package.loaded['plugs.dap.dap-config'] = nil
    require('plugs.dap.dap-config').setup()
    dap.continue()
end

return M
