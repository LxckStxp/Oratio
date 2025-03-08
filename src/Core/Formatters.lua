-- Oratio/src/Core/Formatters.lua
local Formatters = {}

-- StringUtils will be accessed from the global table
local StringUtils

function Formatters.default(config, level, message, timestamp, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        "[%s] [%s] [%s]: %s",
        os.date("%H:%M:%S", timestamp),
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.compact(config, level, message, timestamp, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        "[%s-%s]: %s",
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.json(config, level, message, timestamp, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        '{"timestamp":"%s","module":"%s","level":"%s","message":"%s"}',
        os.date("%Y-%-m-%dT%H:%M:%SZ", timestamp),
        config.moduleName,
        level,
        formattedMessage
    )
end

-- Dependency injection
Formatters._setStringUtils = function(stringUtils)
    StringUtils = stringUtils
end

return Formatters
