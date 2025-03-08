-- Oratio/init.lua
local baseUrl = "https://raw.githubusercontent.com/LxckStxp/Oratio/main/"

-- Set up global Oratio table for data and services only
_G.OratioGlobal = _G.OratioGlobal or {
    VERSION = "2.1.0", -- Increment version for new features
    Services = {},
    Data = {}, -- General-purpose data storage
    CustomLevels = {} -- Store custom log levels
}

local Oratio = _G.OratioGlobal

-- Load dependencies with error handling
local function loadModule(path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(baseUrl .. path, true))()
    end)
    if not success or not result then
        warn("Failed to load module " .. path .. ": " .. tostring(result))
        return nil
    end
    return result
end

-- Load all modules
local Config = loadModule("src/Config.lua")
local LogLevels = loadModule("src/Core/LogLevels.lua")
local Formatters = loadModule("src/Core/Formatters.lua")
local StringUtils = loadModule("src/Utilities/StringUtils.lua")
local Logger = loadModule("src/Core/Logger.lua")
local LogTargets = loadModule("src/Core/LogTargets.lua") -- New module

-- Ensure all modules loaded successfully before proceeding
if not (Config and LogLevels and Formatters and StringUtils and Logger and LogTargets) then
    warn("Oratio initialization failed: One or more modules could not be loaded.")
    return nil
end

-- Pass dependencies directly to Logger and Formatters
Logger._setDependencies(Config, LogLevels, Formatters, StringUtils, LogTargets)
Formatters._setStringUtils(StringUtils)

-- Store modules in Oratio for access
Oratio.Modules = {
    Config = Config,
    LogLevels = LogLevels,
    Formatters = Formatters,
    Logger = Logger,
    StringUtils = StringUtils,
    LogTargets = LogTargets
}

-- Convenience method to create a new logger
function Oratio.new(config)
    return Logger.new(config or {})
end

-- Register custom log level
function Oratio:RegisterLogLevel(name, value)
    if type(name) == "string" and type(value) == "number" and value >= 0 then
        Oratio.CustomLevels[name] = { value = value, name = name }
    else
        warn("Invalid log level registration: name must be string, value must be number >= 0")
    end
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
