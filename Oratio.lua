local function loadModule(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)
    if not success then
        error("Failed to load module from " .. url .. ": " .. tostring(result))
    end
    return result
end

local baseURL = "https://raw.githubusercontent.com/LxckStxp/Oratio/main/Core/"

local Oratio = {
    Logger = loadModule(baseURL .. "Logger.lua"),
    LogLevels = loadModule(baseURL .. "Components/LogLevels.lua"),
    Formatters = loadModule(baseURL .. "Components/Formatters.lua")
}

return Oratio
