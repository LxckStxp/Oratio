-- Oratio/src/Core/Logger.lua
local Config = require(script.Parent.Parent.Config)
local LogLevels = require(script.Parent.LogLevels)
local Formatters = require(script.Parent.Formatters)

local Logger = {}
Logger.__index = Logger

function Logger.new(config)
    local self = setmetatable({}, Logger)
    
    self.config = Config.new(config)
    self._minLevelValue = LogLevels.getValue(self.config.minLevel)
    self._history = self.config.storeHistory and {} or nil
    self._callbacks = {}
    
    return self
end

function Logger:_log(level, message, ...)
    local levelValue = LogLevels.getValue(level)
    if levelValue < self._minLevelValue then
        return
    end
    
    local timestamp = os.time()
    local levelName = LogLevels.getName(level)
    local formatter = self.config.formatter or Formatters.default
    local formatted = formatter(self.config, levelName, message, timestamp, ...)
    
    if self.config.outputEnabled then
        print(formatted)
    end
    
    if self._history then
        table.insert(self._history, {
            timestamp = timestamp,
            level = levelName,
            message = formatted
        })
    end
    
    for _, callback in pairs(self._callbacks) do
        pcall(callback, levelName, formatted, timestamp)
    end
end

-- Logging methods
Logger.debug = function(self, msg, ...) self:_log("DEBUG", msg, ...) end
Logger.info = function(self, msg, ...) self:_log("INFO", msg, ...) end
Logger.warn = function(self, msg, ...) self:_log("WARNING", msg, ...) end
Logger.error = function(self, msg, ...) self:_log("ERROR", msg, ...) end
Logger.critical = function(self, msg, ...) self:_log("CRITICAL", msg, ...) end

-- Configuration methods
function Logger:setMinLevel(level)
    self._minLevelValue = LogLevels.getValue(level)
    self.config.minLevel = level
end

function Logger:setFormatter(formatter)
    self.config.formatter = formatter
end

function Logger:enableOutput(enabled)
    self.config.outputEnabled = enabled
end

function Logger:configure(config)
    self.config = self.config:merge(config)
    self._minLevelValue = LogLevels.getValue(self.config.minLevel)
end

-- History management
function Logger:getHistory()
    return self._history or {}
end

function Logger:clearHistory()
    if self._history then
        table.clear(self._history)
    end
end

-- Callback management
function Logger:onLog(callback)
    local id = tostring(#self._callbacks + 1) .. tostring(os.clock())
    self._callbacks[id] = callback
    return id
end

function Logger:removeCallback(id)
    self._callbacks[id] = nil
end

return Logger
