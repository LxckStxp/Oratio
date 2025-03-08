-- Oratio/src/Utilities/StringUtils.lua
local StringUtils = {}

function StringUtils.format(str, ...)
    if select("#", ...) == 0 then
        return str
    end
    return string.format(str, ...)
end

return StringUtils
