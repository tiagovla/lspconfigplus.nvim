local utils = require("lspconfigplus.utils")

local formatters = {}

formatters["yapf"] = {
    script_path = "formatters/yapf.sh",
    executable = utils.install_path("yapf") .. "/venv/bin/yapf"
}
formatters["isort"] = {
    script_path = "formatters/isort.sh",
    executable = utils.install_path("isort") .. "/venv/bin/isort"
}

formatters["cmakelang"] = {
    script_path = "formatters/cmakelang.sh",
    executable = utils.install_path("cmakelang") .. "/venv/bin/cmakelang"
}

return formatters
