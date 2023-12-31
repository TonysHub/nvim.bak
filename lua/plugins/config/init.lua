local M = {}

M.setup = function()
    local config_files = vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins/config')

    for _, file in ipairs(config_files) do
        local file_name = file:match('(.+)%.lua$')
        if file_name then
            require('plugins.config.' .. file_name)
        end
    end
end

return M

