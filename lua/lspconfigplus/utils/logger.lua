local U = {}
-- logger handlers
local console_handler_highlights = {
    DEBUG = "Comment",
    INFO = "None",
    WARNING = "WarningMsg",
    ERROR = "ErrorMsg",
    CRITICAL = "ErrorMsg",
}

function U.console_handler(data)
    local line_info = vim.fn.fnamemodify(data.info.short_src, ":t") .. ":" .. data.info.currentline
    local strout = string.format("[%-6s %s] %s: %s", data.level, os.date("%H:%M:%S"), line_info,
                                 data.message)
    vim.cmd(string.format("echohl %s", console_handler_highlights[data.level]))
    local split_console = vim.split(strout, "\n")
    for _, v in ipairs(split_console) do
        vim.cmd(string.format([[echom "[%s] %s"]], data.plugin:upper(), vim.fn.escape(v, "\"")))
    end
    vim.cmd("echohl NONE")
end

function U.file_handler(data)
    local outfile = string.format("%s/%s.log", vim.fn.stdpath("cache"), data.plugin)
    local fp, err = io.open(outfile, "a")
    if not fp then
        print(err)
        return
    end
    local line_info = vim.fn.fnamemodify(data.info.short_src, ":t") .. ":" .. data.info.currentline
    local strout = string.format("%-8s [ %s ] %s: %s", data.level, os.date("%Y-%m-%d %H:%M:%S"),
                                 line_info, data.message .. "\n")
    fp:write(strout)
    fp:close()
end

return U
