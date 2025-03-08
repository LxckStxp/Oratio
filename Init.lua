-- Oratio/init.lua
local Oratio = {
    VERSION = "2.0.0",
    _services = {}
}

-- Load core components
local src = script.src
Oratio.Config = require(src.Config)
Oratio.Logger = require(src.Core.Logger)
Oratio.LogLevels = require(src.Core.LogLevels)
Oratio.Formatters = require(src.Core.Formatters)

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
