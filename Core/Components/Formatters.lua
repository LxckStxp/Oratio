local Formatters = {}

function Formatters.default(moduleName, level, message)
    return string.format("[ %s ] [ %s ]: %s", 
        moduleName,
        level,
        message
    )
end

return Formatters
