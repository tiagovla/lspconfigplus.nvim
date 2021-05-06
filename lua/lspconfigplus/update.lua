local servers = require('lspconfigplus.servers')
local utils = require('lspconfigplus.utils')
local display = require('lspconfigplus.display')

local M = {}
local configured_servers = servers._configured
local local_path = utils.current_dir()

function M.update_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        print("lspconfig+: " .. server_name .. " not found.")
        return
    end
    local install_path = utils.install_path(server_name)
    vim.fn.mkdir(install_path, "p")
    display:task_start(server_name, "updating...")()
    handle = vim.loop.spawn('sh', {
        args = {local_path .. servers[server_name].script_path, 'update'},
        cwd = install_path
    }, function(code, _)
        handle:close()
        if code ~= 0 then
            display:task_failed(server_name, "failed to update.")()
        else
            display:task_succeeded(server_name, "successfully updated.")()
        end
    end)
end

function M.update()
    display:open()
    for _, server_name in pairs(configured_servers) do M.update_server(server_name) end
end

return M
