local config = require("lspconfigplus.config")
local Log = { CRITICAL = 50, ERROR = 40, WARNING = 30, INFO = 20, DEBUG = 10, NOTSET = 0 }
Log.__index = Log

function Log:create()
    local log = {}
    self.handlers = config.logger.handlers
    return setmetatable(log, Log)
end

function Log:debug(message)
    Log:dispatch("DEBUG", message)
end
function Log:warning(message)
    Log:dispatch("WARNING", message)
end
function Log:info(message)
    Log:dispatch("INFO", message)
end
function Log:error(message)
    Log:dispatch("ERROR", message)
end
function Log:critical(message)
    Log:dispatch("CRITICAL", message)
end

function Log:dispatch(level, message)
    local data = {
        level = level,
        message = message,
        info = debug.getinfo(3, "Sl"),
        plugin = "lspconfigplus",
    }
    for _, handler in pairs(self.handlers) do
        if self[level] > self[handler.level:upper()] then
            handler.func(data)
        end
    end
end

local log = Log:create()

return log
