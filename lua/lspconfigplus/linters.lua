local utils = require("lspconfigplus.utils.helpers")

local linters = {}

linters["markdownlint"] = {
    script_path = "linters/markdownlint.sh",
    executable = utils.install_linter_path("markdownlint") .. "/node_modules/.bin/markdownlint -s",
    default_config = {
        lintCommand = utils.install_linter_path("markdownlint") .. "/node_modules/.bin/markdownlint -s",
        lintStdin = true,
        lintFormats = { "%f:%l MD%n/%m [Conte%r", "%f:%l:%c %m", "%f: %l: %m" },
    },
}

linters["rst_lint"] = {
    script_path = "linters/rst_lint.sh",
    executable = utils.install_linter_path("rst_lint") .. "/venv/bin/rst-lint ",
    default_config = {
        lintCommand = utils.install_linter_path("rst_lint") .. "/venv/bin/rst-lint ",
        lintFormats = { "%tNFO %f:%l %m", "%tARNING %f:%l %m", "%tRROR %f:%l %m", "%tEVERE %f:%l %m" },
    },
}

linters["flake8"] = {
    script_path = "linters/flake8.sh",
    executable = utils.install_linter_path("flake8") .. "/venv/bin/flake8",
    default_config = {
        lintCommand = utils.install_linter_path("flake8")
            .. "/venv/bin/flake8"
            .. " --max-line-length 80 --stdin-display-name ${INPUT} -",
        lintStdin = true,
        lintIgnoreExitCode = true,
        lintFormats = { "%f=%l:%c: %m" },
        lintSource = "flake8",
    },
}

linters["shellcheck"] = {
    script_path = "linters/shellcheck.sh",
    executable = utils.install_linter_path("shellcheck") .. "/bin/shellcheck",
    default_config = {
        lintCommand = utils.install_linter_path("shellcheck") .. "/bin/shellcheck" .. " -f gcc -x",
        lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
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
