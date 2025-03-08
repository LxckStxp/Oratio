-- Oratio/src/Core/LogTargets.lua
local LogTargets = {}

-- Default targets
LogTargets.targets = {
    console = function(message)
        print(message)
    end
}

-- Add a new target
function LogTargets:addTarget(name, callback)
    if type(name) == "string" and type(callback) == "function" then
        LogTargets.targets[name] = callback
    else
        warn("Invalid target: name must be string, callback must be function")
    end
end

-- Remove a target
function LogTargets:removeTarget(name)
    LogTargets.targets[name] = nil
end

-- Log to all active targets
function LogTargets:log(message)
    for _, target in pairs(LogTargets.targets) do
        pcall(target, message)
    end
end

return LogTargets
