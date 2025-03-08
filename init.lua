-- Oratio/init.lua
local baseUrl = "https://raw.githubusercontent.com/LxckStxp/Oratio/main/"

-- Set up global Oratio table if it doesn't exist
_G.OratioGlobal = _G.OratioGlobal or {
    VERSION = "2.0.0",
    Services = {},
    Modules = {},
    Data = {} -- General-purpose data storage
}

local Oratio = _G.OratioGlobal

-- Load dependencies only if not already loaded
if not Oratio.Modules.Config then
    Oratio.Modules.Config = loadstring(game:HttpGet(baseUrl .. "src/Config.lua", true))()
end
if not Oratio.Modules.LogLevels then
    Oratio.Modules.LogLevels = loadstring(game:HttpGet(baseUrl .. "src/Core/LogLevels.lua", true))()
end
if not Oratio.Modules.Formatters then
    Oratio.Modules.Formatters = loadstring(game:HttpGet(baseUrl .. "src/Core/Formatters.lua", true))()
end
if not Oratio.Modules.Logger then
    Oratio.Modules.Logger = loadstring(game:HttpGet(baseUrl .. "src/Core/Logger.lua", true))()
end
if not Oratio.Modules.StringUtils then
    Oratio.Modules.StringUtils = loadstring(game:HttpGet(baseUrl .. "src/Utilities/StringUtils.lua", true))()
end

-- Inject dependencies into Logger and Formatters
Oratio.Modules.Logger._setDependencies(
    Oratio.Modules.Config,
    Oratio.Modules.LogLevels,
    Oratio.Modules.Formatters,
    Oratio.Modules.StringUtils
)
Oratio.Modules.Formatters._setStringUtils(Oratio.Modules.StringUtils)

-- Convenience method to create a new logger
function Oratio.new(config)
    return Oratio.Modules.Logger.new(config or {})
end

-- Service registration for advanced usage
function Oratio:RegisterService(name, service)
    self.Services[name] = service
    return service
end

function Oratio:GetService(name)
    return self.Services[name]
end

-- Global data access methods
function Oratio:SetData(key, value)
    self.Data[key] = value
end

function Oratio:GetData(key)
    return self.Data[key]
end

return Oratio
