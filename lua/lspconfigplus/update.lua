local servers = require("lspconfigplus.servers")
local formatters = require("lspconfigplus.formatters")
local linters = require("lspconfigplus.linters")
local utils = require("lspconfigplus.utils.helpers")
local display = require("lspconfigplus.display")
local logger = require("lspconfigplus.logger")

local M = {}

function M.update_item(item_name, script_path, cwd_path)
    local handle = nil
    vim.fn.mkdir(cwd_path, "p")
    local async
    async = vim.loop.new_async(function()
        display:task_start(item_name, "updating...")()
        async:close()
    end)
    async:send()
    handle = vim.loop.spawn("sh", { args = { script_path, "update" }, cwd = cwd_path }, function(code, _)
        handle:close()
        if code ~= 0 then
            logger.error(item_name, "failed to update.")
            display:task_failed(item_name, "failed to update.")()
        else
            logger.debug(item_name, "successfully updated.")
            display:task_succeeded(item_name, "successfully updated.")()
        end
    end)
end

function M.update()
    display:open()
    local local_path = utils.current_dir()
    for server_name, server_config in pairs(servers) do
        local script_path = local_path .. server_config.script_path
        local cwd_path = utils.install_server_path(server_name)
        M.update_item(server_name, script_path, cwd_path)
    end

    for formatter_name, formatter_config in pairs(formatters) do
        local script_path = local_path .. formatter_config.script_path
        local cwd_path = utils.install_formatter_path(formatter_name)
        M.update_item(formatter_name, script_path, cwd_path)
    end

    for linter_name, linter_config in pairs(linters) do
        local script_path = local_path .. linter_config.script_path
        local cwd_path = utils.install_linter_path(linter_name)
        M.update_item(linter_name, script_path, cwd_path)
    end
end

return M
