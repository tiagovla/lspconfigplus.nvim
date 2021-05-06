local utils = require("lspconfigplus.utils.helpers")
local servers = require("lspconfigplus.servers")
local formatters = require("lspconfigplus.formatters")
local linters = require("lspconfigplus.linters")
local lspconfigs = require("lspconfig/configs")

local M = require("lspconfig")

function M.bulk_setup(items, config) for _, item in pairs(items) do M[item].setup(config) end end

local mt = {}
function mt:__index(k)
    if k == "formatters" then return formatters end
    if k == "linters" then return linters end
    if lspconfigs[k] == nil then
        pcall(require, "lspconfig/" .. k)
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
    return lspconfigs[k]
end

return setmetatable(M, mt)
