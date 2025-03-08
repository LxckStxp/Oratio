-- Oratio/src/Core/Logger.lua
local Logger = {}
Logger.__index = Logger

-- Dependencies will be passed directly
local Config
local LogLevels
local Formatters
local StringUtils

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
    
    local levelName = LogLevels.getName(level)
    -- Fallback to a simple string if formatter fails
    local formatter = self.config.formatter or (Formatters and Formatters.default) or function(_, _, msg) return msg end
    local formatted = formatter(self.config, levelName, message, ...)
    
    if self.config.outputEnabled then
        print(formatted)
    end
    
    if self._history then
        table.insert(self._history, {
            level = levelName,
            message = formatted
        })
    end
    
    for _, callback in pairs(self._callbacks) do
        pcall(callback, levelName, formatted)
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
        for k in pairs(self._history) do
            self._history[k] = nil
        end
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

-- Dependency injection
Logger._setDependencies = function(config, logLevels, formatters, stringUtils)
    Config = config
    LogLevels = logLevels
    Formatters = formatters
    StringUtils = stringUtils
end

return Logger
