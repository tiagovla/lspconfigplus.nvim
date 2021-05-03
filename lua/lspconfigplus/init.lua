local utils = require('lspconfigplus.utils')
local servers = require('lspconfigplus.servers')
local lspconfigs = require('lspconfig/configs')

local M = require('lspconfig')
M._root.configured_servers = {}

local local_path = utils.current_dir()

function M._root.install_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        print("lspconfig+: " .. server_name .. " not found.")
        return
    end
    local install_path = utils.install_path(server_name)
    print("lspconfig+: " .. server_name .. " is being installed.")
    vim.fn.mkdir(install_path, "p")
    handle = vim.loop.spawn('sh', {
        args = {local_path .. servers[server_name].script_path, 'install'},
        cwd = install_path
    }, function(code, _)
        handle:close()
        if code ~= 0 then
            print("lspconfig+: " .. server_name .. " could not be installed.")
        else
            print("lspconfig+: " .. server_name ..
                      " was successfully installed.")
        end
    end)
end

function M._root.uninstall_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        print("lspconfig+: " .. server_name .. " not found.")
        return
    end
    local install_path = utils.install_path(server_name)
    print("lspconfig+: " .. server_name .. " is being uninstalled.")
    vim.fn.mkdir(install_path, "p")
    handle = vim.loop.spawn('sh', {
        args = {local_path .. servers[server_name].script_path, 'uninstall'},
        cwd = install_path
    }, vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            print("lspconfig+: " .. server_name .. " could not be uninstalled.")
        else
            if vim.fn.delete(install_path, "rf") ~= 0 then
                print("lspconfig+: directory " .. install_path ..
                          " could not be deleted.")
            else
                print("lspconfig+: " .. server_name ..
                          " was successfully uninstalled.")
            end
        end
    end))
end

function M._root.update_server(server_name)
    local handle = nil
    if servers[server_name] == nil then
        print("lspconfig+: " .. server_name .. " not found.")
        return
    end
    local install_path = utils.install_path(server_name)
    print("lspconfig+: " .. server_name .. " is being updated.")
    vim.fn.mkdir(install_path, "p")
    handle = vim.loop.spawn('sh', {
        args = {local_path .. servers[server_name].script_path, 'update'},
        cwd = install_path
    }, function(code, _)
        handle:close()
        if code ~= 0 then
            print("lspconfig+: " .. server_name .. " could not be updated.")
        else
            print("lspconfig+: " .. server_name .. " was successfully updated.")
        end
    end)
end

function M._root.install_all_servers()
    for server, _ in pairs(servers) do
        if not utils.is_server_installed(server) then
            M._root.install_server(server)
        end
    end
end

function M._root.update_all_servers()
    for _, server in pairs(utils.installed_servers(servers)) do
        M._root.update_server(server)
    end
end

function M._root.uninstall_all_servers()
    for _, server in pairs(utils.installed_servers(servers)) do
        M._root.uninstall_server(server)
    end
end

function M._root.install_configured_servers()
    for _, server in pairs(M._root.configured_servers) do
        if utils.is_server_installed(server) then
            print("lspconfig+: " .. server .. " is already installed.")
        else
            M._root.install_server(server)
        end

    end
end

local mt = {}
function mt:__index(k)
    if lspconfigs[k] == nil then
        pcall(require, 'lspconfig/' .. k)
        local doc_config = vim.deepcopy(lspconfigs[k].document_config)
        if servers[k] ~= nil and utils.is_server_installed(k) then
            local default_config = doc_config.default_config
            lspconfigs[k] = nil
            if default_config.cmd then
                default_config.cmd[1] = servers[k].executable
            else
                default_config.cmd = {servers[k].executable}
            end
            lspconfigs[k] = doc_config

        end
    end
    if servers[k] ~= nil then table.insert(M._root.configured_servers, k) end
    return lspconfigs[k]
end

M = setmetatable(M, mt)

M.all = {}
function M.all.setup(config)
    for _, server in pairs(utils.installed_servers(servers)) do
        M[server].setup(config)
    end
end

return M
