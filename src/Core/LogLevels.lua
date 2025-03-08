-- Oratio/src/Core/LogLevels.lua
local LogLevels = {
    DEBUG = { value = 10, name = "DEBUG" },
    INFO = { value = 20, name = "INFO" },
    WARNING = { value = 30, name = "WARNING" },
    ERROR = { value = 40, name = "ERROR" },
    CRITICAL = { value = 50, name = "CRITICAL" }
}

function LogLevels.getValue(level)
    return (LogLevels[level] and LogLevels[level].value) or 0
end

function LogLevels.getName(level)
    return (LogLevels[level] and LogLevels[level].name) or "UNKNOWN"
end

return LogLevels
