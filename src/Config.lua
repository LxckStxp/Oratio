-- Oratio/src/Config.lua
local Config = {}

function Config.new(defaults)
    local self = {}
    defaults = defaults or {}
    
    self.moduleName = defaults.moduleName or "Unnamed"
    self.minLevel = defaults.minLevel or "INFO"
    self.formatter = defaults.formatter
    self.storeHistory = defaults.storeHistory or false
    self.outputEnabled = defaults.outputEnabled ~= false
    
    return self
end

function Config:merge(config)
    local newConfig = {}
    for k, v in pairs(self) do
        newConfig[k] = config[k] ~= nil and config[k] or v
    end
    return Config.new(newConfig)
end

return Config
