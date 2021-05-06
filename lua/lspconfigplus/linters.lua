local utils = require("lspconfigplus.utils.helpers")

local linters = {}

linters["flake8"] = {
    script_path = "linters/flake8.sh",
    executable = utils.install_linter_path("flake8") .. "/venv/bin/flake8",
    default_config = {
        lintCommand = utils.install_linter_path("flake8") .. "/venv/bin/flake8" ..
            " --max-line-length 80 --stdin-display-name ${INPUT} -",
        lintStdin = true,
        lintIgnoreExitCode = true,
        lintFormats = {"%f=%l:%c: %m"},
        lintSource = "flake8",
    },
}

local configured_linters = {}
local mt = {}
function mt:__index(k)
    local linter_found = linters[k]
    if linter_found then
        function linter_found.setup(config)
            return vim.tbl_extend("force", linter_found.default_config, config)
        end
        configured_linters[k] = linter_found
        return linter_found
    end
end

return setmetatable(configured_linters, mt)
