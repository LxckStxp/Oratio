local LogLevels = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/Core/Components/LogLevels.lua", true))()
local Formatters = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/Core/Components/Formatters.lua", true))()

local Logger = {}
Logger.__index = Logger

function Logger.new(options)
    local self = setmetatable({}, Logger)
    
    options = options or {}
    self.moduleName = options.moduleName or "Unknown"
    self.minLevel = options.minLevel or 0
    self.formatter = options.formatter or Formatters.default
    
    return self
end

function Logger:_log(level, message)
    if not LogLevels[level] then return end
    
    local formattedMessage = self.formatter(self.moduleName, LogLevels[level], message)
    print(formattedMessage)
end

function Logger:Info(message)
    self:_log("INFO", message)
end

function Logger:Warn(message)
    self:_log("WARNING", message)
end

function Logger:Error(message)
    self:_log("ERROR", message)
end

function Logger:Debug(message)
    self:_log("DEBUG", message)
end

return Logger
