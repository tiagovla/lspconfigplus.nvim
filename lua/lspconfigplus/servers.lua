local utils = require("lspconfigplus.utils.helpers")

local servers = {}

servers["bashls"] = {
    script_path = "servers/bashls.sh",
    executable = utils.install_server_path("bashls") .. "/node_modules/.bin/bash-language-server",
}

servers["clangd"] = {
    script_path = "servers/clangd.sh",
    executable = utils.install_server_path("clangd") .. "/clangd/bin/clangd",
}
servers["cmake"] = {
    script_path = "servers/cmake.sh",
    executable = utils.install_server_path("cmake") .. "/venv/bin/cmake-language-server",
}
servers["dockerls"] = {
    script_path = "servers/dockerls.sh",
    executable = utils.install_server_path("dockerls") .. "/node_modules/.bin/docker-langserver",
}
servers["efm"] = {
    script_path = "servers/efm.sh",
    executable = utils.install_server_path("efm") .. "/efm-langserver",
}
servers["pyright"] = {
    script_path = "servers/pyright.sh",
    executable = utils.install_server_path("pyright") .. "/node_modules/.bin/pyright-langserver",
}
servers["sumneko_lua"] = {
    script_path = "servers/sumneko_lua.sh",
    executable = utils.install_server_path("sumneko_lua") .. "/sumneko-lua-language-server",
}
servers["rust_analyzer"] = {
    script_path = "servers/rust_analyzer.sh",
    executable = utils.install_server_path("rust_analyzer") .. "/rust-analyzer",
}
servers["texlab"] = {
    script_path = "servers/texlab.sh",
    executable = utils.install_server_path("texlab") .. "/texlab",
}
servers["tsserver"] = {
    script_path = "servers/tsserver.sh",
    executable = utils.install_server_path("tsserver") .. "/node_modules/.bin/typescript-language-server",
}
servers["vimls"] = {
    script_path = "servers/vimls.sh",
    executable = utils.install_server_path("vimls") .. "/node_modules/.bin/vim-language-server",
}
servers["yamlls"] = {
    script_path = "servers/yamlls.sh",
    executable = utils.install_server_path("yamlls") .. "/node_modules/.bin/yaml-language-server",
}
servers["yamlls"] = {
    script_path = "servers/yamlls.sh",
    executable = utils.install_server_path("yamlls") .. "/node_modules/.bin/yaml-language-server",
}

local configured_servers = {}
local mt = {}
function mt:__index(k)
    local server_found = servers[k]
    if server_found then
        configured_servers[k] = server_found
        return server_found
    end
end
return setmetatable(configured_servers, mt)
