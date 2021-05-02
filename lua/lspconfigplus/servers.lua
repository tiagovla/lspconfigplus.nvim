local utils = require("lspconfigplus.utils")

local servers = {}

servers["cmake"] = {
    script_path = "servers/cmake.sh",
    executable = utils.install_path("cmake") ..
        "/venv/bin/cmake-language-server"
}
servers["clangd"] = {
    script_path = "servers/clangd.sh",
    executable = utils.install_path("clangd") .. "/clangd/bin/clangd"
}
servers["pyright"] = {
    script_path = "servers/pyright.sh",
    executable = utils.install_path("pyright") ..
        "/node_modules/.bin/pyright-langserver"
}
servers["tsserver"] = {
    script_path = "servers/tsserver.sh",
    executable = utils.install_path("tsserver") ..
        "/node_modules/.bin/typescript-language-server"
}
servers["sumneko_lua"] = {
    script_path = "servers/sumneko_lua.sh",
    executable = utils.install_path("sumneko_lua") ..
        "/sumneko-lua-language-server"
}
servers["texlab"] = {
    script_path = "servers/texlab.sh",
    executable = utils.install_path("texlab") .. "/texlab"
}
servers["efm"] = {
    script_path = "servers/efm.sh",
    executable = utils.install_path("efm") .. "/efm-langserver"
}
servers["vimls"] = {
    script_path = "servers/vimls.sh",
    executable = utils.install_path("vimls") ..
        "/node_modules/.bin/vim-language-server"
}
servers["bashls"] = {
    script_path = "servers/bashls.sh",
    executable = utils.install_path("bashls") ..
        "/node_modules/.bin/bash-language-server"
}
servers["yamlls"] = {
    script_path = "servers/yamlls.sh",
    executable = utils.install_path("yamlls") ..
        "/node_modules/.bin/yaml-language-server"
}

return servers
