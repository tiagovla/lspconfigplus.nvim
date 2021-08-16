local utils = require("lspconfigplus.utils.helpers")

local formatters = {}

formatters["yapf"] = {
    script_path = "formatters/yapf.sh",
    executable = utils.install_formatter_path("yapf") .. "/venv/bin/yapf",
    default_config = {
        formatCommand = utils.install_formatter_path("yapf") .. "/venv/bin/yapf" .. " --quiet",
        formatStdin = true,
    },
}

formatters["black"] = {
    script_path = "formatters/black.sh",
    executable = utils.install_formatter_path("black") .. "/venv/bin/black",
    default_config = {
        formatCommand = utils.install_formatter_path("black") .. "/venv/bin/black" .. " --quiet -",
        formatStdin = true,
    },
}

formatters["stylua"] = {
    script_path = "formatters/stylua.sh",
    executable = utils.install_formatter_path("stylua") .. "/stylua",
    default_config = {
        formatCommand = utils.install_formatter_path("stylua") .. "/stylua -",
        formatStdin = true,
    },
}

formatters["isort"] = {
    script_path = "formatters/isort.sh",
    executable = utils.install_formatter_path("isort") .. "/venv/bin/isort",
    default_config = {
        formatCommand = utils.install_formatter_path("isort") .. "/venv/bin/isort" .. " --quiet -",
        formatStdin = true,
    },
}

formatters["lua_format"] = {
    script_path = "formatters/lua_format.sh",
    executable = utils.install_formatter_path("lua_format") .. "/build/lua-format",
    default_config = {
        formatCommand = utils.install_formatter_path("lua_format") .. "/build/lua-format",
        formatStdin = true,
    },
}

formatters["cmakelang"] = {
    script_path = "formatters/cmakelang.sh",
    executable = utils.install_formatter_path("cmakelang") .. "/venv/bin/cmakelang",
}

local configured_formatters = {}
local mt = {}
function mt:__index(k)
    local formatter_found = formatters[k]
    if formatter_found then
        function formatter_found.setup(config)
            return vim.tbl_deep_extend("force", formatter_found.default_config, config)
        end
        configured_formatters[k] = formatter_found
        return formatter_found
    end
end

return setmetatable(configured_formatters, mt)
