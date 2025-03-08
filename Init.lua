-- Oratio/init.lua
local baseUrl = "https://raw.githubusercontent.com/LxckStxp/Oratio/main/"

local Oratio = {
    VERSION = "2.0.0",
    _services = {}
}

-- Load dependencies using loadstring and game:HttpGet
Oratio.Config = loadstring(game:HttpGet(baseUrl .. "src/Config.lua", true))()
Oratio.LogLevels = loadstring(game:HttpGet(baseUrl .. "src/Core/LogLevels.lua", true))()
Oratio.Formatters = loadstring(game:HttpGet(baseUrl .. "src/Core/Formatters.lua", true))()
Oratio.Logger = loadstring(game:HttpGet(baseUrl .. "src/Core/Logger.lua", true))()

-- Inject dependencies into Logger (since it needs them)
Oratio.Logger.Config = Oratio.Config
Oratio.Logger.LogLevels = Oratio.LogLevels
Oratio.Logger.Formatters = Oratio.Formatters
Oratio.Logger.StringUtils = loadstring(game:HttpGet(baseUrl .. "src/Utilities/StringUtils.lua", true))()

-- Convenience method to create a new logger
function Oratio.new(config)
    return Oratio.Logger.new(config or {})
end

-- Service registration for advanced usage
function Oratio:RegisterService(name, service)
    self._services[name] = service
    return service
end

function Oratio:GetService(name)
    return self._services[name]
end

return Oratio
