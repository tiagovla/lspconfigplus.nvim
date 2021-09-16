local servers = require("lspconfigplus.servers")
local formatters = require("lspconfigplus.formatters")
local linters = require("lspconfigplus.linters")
local utils = require("lspconfigplus.utils.helpers")
local display = require("lspconfigplus.display")
local logger = require("lspconfigplus.logger")
local tasks = require("lspconfigplus.tasks")

local M = {}

function M.install_item(item_name, script_path, cwd_path)
    vim.fn.mkdir(cwd_path, "p")
    display:task_start(item_name, "installing...")
    local function on_exit(code, _)
        if code ~= 0 then
            logger:error(item_name .. " failed to install.")
            display:task_failed(item_name, " failed to install.")
        else
            logger:debug(item_name .. " successfully installed.")
            display:task_succeeded(item_name, " successfully installed.")
        end
    end
    tasks.run({ args = { script_path, "install" }, cwd = cwd_path }, on_exit)
end

function M.install()
    display:open()
    local local_path = utils.current_dir()
    for server_name, server_config in pairs(servers) do
        if not utils.is_server_installed(server_name) then
            local script_path = local_path .. server_config.script_path
            local cwd_path = utils.install_server_path(server_name)
            M.install_item(server_name, script_path, cwd_path)
        end
    end

    for formatter_name, formatter_config in pairs(formatters) do
        if not utils.is_formatter_installed(formatter_name) then
            local script_path = local_path .. formatter_config.script_path
            local cwd_path = utils.install_formatter_path(formatter_name)
            M.install_item(formatter_name, script_path, cwd_path)
        end
    end

    for linter_name, linter_config in pairs(linters) do
        -- if not utils.is_linter_installed(linter_name) then
        local script_path = local_path .. linter_config.script_path
        local cwd_path = utils.install_linter_path(linter_name)
        M.install_item(linter_name, script_path, cwd_path)
        -- end
    end
end

return M
