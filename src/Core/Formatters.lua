-- Oratio/src/Core/Formatters.lua
local Formatters = {}

-- StringUtils will be passed directly
local StringUtils

function Formatters.default(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        "[%s] [%s]: %s",
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.compact(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        "[%s-%s]: %s",
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.json(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    return string.format(
        '{"module":"%s","level":"%s","message":"%s"}',
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.exploit(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    local status = (level == "SUCCESS" or level == "FAILURE") and string.upper(level) or "UNKNOWN"
    return string.format(
        "[%s] [%s] [%s]: %s",
        config.moduleName,
        status,
        os.time(), -- Simple timestamp for exploit logs
        formattedMessage
    )
end

-- Dependency injection
Formatters._setStringUtils = function(stringUtils)
    StringUtils = stringUtils
end

return Formatters
