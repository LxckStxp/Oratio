-- Oratio/src/Utilities/StringUtils.lua
local StringUtils = {}

function StringUtils.format(str, ...)
    local args = {...}
    if #args == 0 then
        return str
    end
    return string.format(str, unpack(args))
end

return StringUtils
