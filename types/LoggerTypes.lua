-- Oratio/types/LoggerTypes.lua (Optional - for tooling/documentation)
return {
    LoggerConfig = {
        moduleName = "string?",
        minLevel = "string?",
        formatter = "function?",
        storeHistory = "boolean?",
        outputEnabled = "boolean?"
    },
    
    LogEntry = {
        timestamp = "number",
        level = "string",
        message = "string"
    }
}
