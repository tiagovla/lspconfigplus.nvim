local utils = require("lspconfigplus.utils.logger")

local config = {
    install_path = vim.fn.stdpath("data") .. "/lspconfigplus/",
    display = {
        non_interactive = false,
        working_sym = "⟳",
        error_sym = "✗",
        done_sym = "✓",
        removed_sym = "-",
        moved_sym = "→",
        header_sym = "━",
        header_lines = 2,
        title = "lspconfigplus",
        show_all_info = true,
        keybindings = { quit = "q", toggle_info = "<CR>" },
    },
    logger = {
        handlers = {
            -- levels: critical > error > warning > info > debug > noset
            console = { level = "debug", func = utils.console_handler },
            file = { level = "error", func = utils.file_handler },
        },
    },
}

return config
