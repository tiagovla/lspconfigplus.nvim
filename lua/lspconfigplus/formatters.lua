local utils = require("lspconfigplus.utils.helpers")

local formatters = {}

formatters["yapf"] = {
    script_path = "formatters/yapf.sh",
    executable = utils.install_path("yapf") .. "/venv/bin/yapf",
    default_config = {
        formatCommand = utils.install_path("yapf") .. "/venv/bin/yapf" .. " --quiet",
        formatStdin = true,
    },
}

formatters["isort"] = {
    script_path = "formatters/isort.sh",
    executable = utils.install_path("isort") .. "/venv/bin/isort",
    default_config = {
        formatCommand = utils.install_path("isort") .. "/venv/bin/isort" .. " --quiet -",
        formatStdin = true,
    },
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
