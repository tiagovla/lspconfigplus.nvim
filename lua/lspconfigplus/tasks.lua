local logger = require("lspconfigplus.logger")
local loop = vim.loop

local M = {}

local function onread(err, data, results)
    if err then
        logger.error(err)
    end
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d == "" then
                goto continue
            end
            table.insert(results, d)
            ::continue::
        end
    end
end

function M.run(options, on_exit)
    local results = { stderr = {}, stdout = {}, exit_code = nil, signal = nil }
    local handle = nil
    local stdout = loop.new_pipe(false)
    local stderr = loop.new_pipe(false)
    options.stdio = { nil, stdout, stderr }
    handle = loop.spawn("sh", options, function(exit_code, signal)
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        handle:close()
        results.exit_code = exit_code
        results.signal = signal
        logger:debug(vim.inspect(results))
        if on_exit then
            on_exit(exit_code, signal)
        end
    end)
    local on_read_stdout = function(err, data)
        onread(err, data, results.stdout)
    end
    local on_read_stderr = function(err, data)
        onread(err, data, results.stderr)
    end
    vim.loop.read_start(stdout, on_read_stdout)
    vim.loop.read_start(stderr, on_read_stderr)
end

return M
