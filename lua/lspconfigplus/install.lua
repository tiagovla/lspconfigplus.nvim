local servers = require("lspconfigplus.servers")
local utils = require("lspconfigplus.utils.helpers")
local display = require("lspconfigplus.display")
local logger = require("lspconfigplus.logger")

local M = {}
local local_path = utils.current_dir()

function M.install_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        logger.warning(server_name .. " not found.")
        return
    end
    local install_path = utils.install_path(server_name)
    vim.fn.mkdir(install_path, "p")
    local async
    async = vim.loop.new_async(function()
        display:task_start(server_name, "installing...")()
        async:close()
    end)
    async:send()
    handle = vim.loop.spawn("sh", {
        args = {local_path .. servers[server_name].script_path, "install"},
        cwd = install_path,
    }, function(code, _)
        handle:close()
        if code ~= 0 then
            logger.error(server_name, "failed to install.")
            display:task_failed(server_name, "failed to install.")()
        else
            logger.debug(server_name, "successfully installed.")
            display:task_succeeded(server_name, "successfully installed.")()
        end
    end)
end

function M.install()
    display:open()
    for server_name, _ in pairs(servers) do M.install_server(server_name) end
end

return M
