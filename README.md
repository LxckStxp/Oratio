# Oratio Logging Library

```lua
-- Load Oratio with a single loadstring call
local Oratio = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/init.lua", true))()
```

## Overview
Oratio is a lightweight, customizable logging library designed for Roblox environments, particularly for use with exploit scripts executed via an executor. It provides a robust way to log messages to the Roblox console with enhanced formatting, including section headers, visual indicators, and separators. Version 2.1.0 introduces improved text display and support for custom log levels.

## Features
- **Section Headers**: Add bordered section titles for better organization.
- **Visual Indicators**: Simulate color coding with prefixes (e.g., `[!]` for errors, `[✓]` for success).
- **Custom Separators**: Add custom strings to separate log entries.
- **Custom Log Levels**: Register user-defined log levels (e.g., `SUCCESS`, `FAILURE`).
- **Stack Traces**: Optionally include stack traces for debugging.
- **Global Data Storage**: Store and retrieve data across scripts.
- **Flexible Formatters**: Choose from `default`, `compact`, `json`, or `exploit` styles.

## Installation
1. Ensure your executor supports `game:HttpGet` and `loadstring`.
2. Copy the loadstring at the top of this README into your script to initialize Oratio.
3. The library will automatically fetch all dependencies from the GitHub repository.

## Usage
### Basic Logging
```lua
local logger = Oratio.new({ moduleName = "MyCheat" })
logger:info("Cheat loaded")
logger:error("Failed to inject")
```

### Section Headers
```lua
logger:section("Cheat Initialization")
logger:info("Starting process")
```

### Custom Log Levels
```lua
Oratio:RegisterLogLevel("SUCCESS", 15)
logger:log("SUCCESS", "Exploit activated")
```

### Configuration
```lua
logger:configure({
    minLevel = "DEBUG",
    formatter = Oratio.Modules.Formatters.compact,
    separator = "---"
})
logger:debug("Debug message")
```

### Global Data
```lua
Oratio:SetData("CheatStatus", "Running")
print("Status:", Oratio:GetData("CheatStatus"))
```

### Available Formatters
- `default`: `[Module] [Level]: Message` with indicators (e.g., `[!] [MyCheat] [ERROR]: Failed`)
- `compact`: `[Module-Level]: Message` with indicators
- `json`: `{"module":"Module","level":"Level","message":"Message"}`
- `exploit`: `[Module] [SUCCESS/FAILURE]: Message` with status indicators

### Full Example
```lua
local Oratio = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/init.lua", true))()
if not Oratio then return end

Oratio:RegisterLogLevel("SUCCESS", 15)
local logger = Oratio.new({
    moduleName = "ExploitScript",
    minLevel = "INFO",
    separator = "~~~"
})

logger:section("Exploit Start")
logger:info("Initializing exploit")
logger:log("SUCCESS", "Bypass complete")
logger:error("Anticheat detected")
Oratio:SetData("ExploitActive", true)
print("Exploit Active:", Oratio:GetData("ExploitActive"))
```

## Customization
- **Formatters**: Modify `src/Core/Formatters.lua` to create new styles.
- **Log Levels**: Add custom levels via `Oratio:RegisterLogLevel(name, value)`.
- **Separators**: Set `separator` in the config to customize log separation.

## Repository
- **Location**: [https://github.com/LxckStxp/Oratio](https://github.com/LxckStxp/Oratio)
- **Default Branch**: main
- **Version**: 2.1.0

## Contributing
Feel free to fork this repository and submit pull requests with enhancements or bug fixes. Please ensure compatibility with Roblox executors.

## License
Oratio is provided as-is without a formal license. Use it at your own discretion.

### Explanation
1. **Loadstring at Top**: The README starts with the loadstring command, making it immediately accessible for users to copy and paste into their scripts.
2. **Overview**: Briefly describes Oratio's purpose and version.
3. **Features**: Highlights the key enhancements (sections, indicators, separators, etc.).
4. **Installation**: Simple instructions tailored for executor use.
5. **Usage**: Provides practical examples, including basic logging, sections, custom levels, configuration, and global data.
6. **Customization**: Encourages users to tweak formatters and log levels.
7. **Repository and License**: Links to your GitHub and notes the informal license status.

### Instructions
- Save this content as `README.md` in your "LxckStxp/Oratio" repository.
- Ensure all files (including the enhanced versions of `init.lua`, `Logger.lua`, `Formatters.lua`, and `demo.lua`) are uploaded to match the documentation.
- The README is now ready to guide users on how to use Oratio effectively in their cheat scripts!
