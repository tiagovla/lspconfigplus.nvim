local servers = require("lspconfigplus.servers")
local utils = require("lspconfigplus.utils.helpers")

local M = {}
local local_path = utils.current_dir()

function M._root.uninstall_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        print("lspconfig+: " .. server_name .. " not found.")
        return
    end
    local install_path = utils.install_server_pather_path(server_name)
    print("lspconfig+: " .. server_name .. " is being uninstalled.")
    vim.fn.mkdir(install_path, "p")
    handle = vim.loop.spawn("sh", {
        args = {local_path .. servers[server_name].script_path, "uninstall"},
        cwd = install_path,
    }, vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            print("lspconfig+: " .. server_name .. " could not be uninstalled.")
        else
            if vim.fn.delete(install_path, "rf") ~= 0 then
                print("lspconfig+: directory " .. install_path .. " could not be deleted.")
            else
                print("lspconfig+: " .. server_name .. " was successfully uninstalled.")
            end
        end
    end))
end

function M._root.uninstall_all_servers()
    for _, server in pairs(utils.installed_servers(servers)) do M._root.uninstall_server(server) end
end
