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

local mt = {}
function mt:__index(k)
    if formatters[k] ~= nil then
        local M = formatters[k]
        function M.setup(config)
            return vim.tbl_deep_extend("force", formatters[k].default_config, config)
        end
        return M
    end
end

return setmetatable({}, mt)
