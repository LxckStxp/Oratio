-- Oratio/src/Core/Formatters.lua
local Formatters = {}

-- StringUtils will be passed directly
local StringUtils

function Formatters.default(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    local prefix = ""
    if level == "ERROR" or level == "CRITICAL" then
        prefix = "[!]"
    elseif level == "WARNING" then
        prefix = "[~]"
    elseif level == "INFO" then
        prefix = "[+]"
    elseif level == "DEBUG" then
        prefix = "[-]"
    elseif level == "SUCCESS" then
        prefix = "[✓]"
    elseif level == "FAILURE" then
        prefix = "[✗]"
    end
    return string.format(
        "%s [%s] [%s]: %s",
        prefix,
        config.moduleName,
        level,
        formattedMessage
    )
end

function Formatters.compact(config, level, message, ...)
    local formattedMessage = StringUtils.format(message, ...)
    local prefix = ""
    if level == "ERROR" or level == "CRITICAL" then
        prefix = "[!]"
    elseif level == "WARNING" then
        prefix = "[~]"
    elseif level == "INFO" then
        prefix = "[+]"
    elseif level == "DEBUG" then
        prefix = "[-]"
    elseif level == "SUCCESS" then
        prefix = "[✓]"
    elseif level == "FAILURE" then
        prefix = "[✗]"
    end
    return string.format(
        "%s [%s-%s]: %s",
        prefix,
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
    local prefix = level == "SUCCESS" and "[✓]" or level == "FAILURE" and "[✗]" or "[?]"
    return string.format(
        "%s [%s] [%s]: %s",
        prefix,
        config.moduleName,
        status,
        formattedMessage
    )
end

-- Dependency injection
Formatters._setStringUtils = function(stringUtils)
    StringUtils = stringUtils
end

return Formatters
