local config = require("lspconfigplus.config")
local U = {}

-- current directory
function U.current_dir()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*[/\\])")
end

-- path of lsp server
function U.install_server_path(server_name) return config.install_path .. "servers/" .. server_name end
function U.install_formatter_path(formatter_name)
    return config.install_path .. "formatters/" .. formatter_name
end
function U.install_linter_path(linter_name) return config.install_path .. "linters/" .. linter_name end

-- check if lsp server is installed
function U.is_server_installed(server_name)
    return vim.fn.isdirectory(U.install_server_path(server_name)) == 1
end

-- table with available lsp servers
function U.available_servers(servers) return vim.tbl_keys(servers) end

-- table with installed servers
function U.installed_servers(servers)
    return vim.tbl_filter(function(key) return U.is_server_installed(key) end,
                          U.available_servers(servers))
end

-- table with non installed servers
function U.not_installed_servers(servers)
    return vim.tbl_filter(function(key) return not U.is_server_installed(key) end,
                          U.available_servers(servers))
end

return U
