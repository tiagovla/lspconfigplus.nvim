local utils = require("lspconfigplus.utils")

local linters = {}

linters["isort"] = {
    script_path = "linters/flake8.sh",
    executable = utils.install_path("flake8") .. "/venv/bin/flake8"
}
