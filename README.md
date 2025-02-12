Oratio Logging System

A lightweight logging system for Roblox. Below you'll find instructions on how to integrate and use it in your project.



Installation

Host the Oratio repository on GitHub.
Use Roblox's HTTP-get functionality to load the main entry point (Oratio.lua) from the GitHub URL.



Usage

Loading the Logging System

To start using Oratio, load the main script using the following Lua code in your executor or game script:

local Oratio = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/Oratio.lua", true))()

This command fetches and executes the Oratio.lua file, which in turn loads all required components.

Creating a Logger Instance

Create a new logger by calling the new method on the Logger module. Optionally pass configuration settings like moduleName and minLevel:

local logger = Oratio.Logger.new({
    moduleName = "InjectedScript"
})

The moduleName allows you to identify the source of logged events, and you can customize the minimum log level and formatter if needed.

Logging Messages

Use the logger instance to log messages at various levels:

logger:Info("Script started successfully")
logger:Warn("Potential issue detected")
logger:Error("An error occurred")
logger:Debug("Debug message")

Each logging function formats and prints a message to the output, making it easy to trace events, warnings, errors, and debug information.



Configuration

Customization:  
  Adjust the default formatter by passing your custom function in the Logger configuration. Example:

  local customFormatter = function(moduleName, level, message)
      return string.format("<< %s >> [%s]: %s", moduleName, level, message)
  end

  local logger = Oratio.Logger.new({
      moduleName = "CustomModule",
      formatter = customFormatter
  })

HTTP Request Requirement:  
  Ensure that your Roblox executor allows HTTP requests because this system loads its modules remotely.



Example Integration

Below is a complete example to demonstrate how to integrate the logging system into your Roblox script:

-- Load the logging system
local Oratio = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/Oratio/main/Oratio.lua", true))()

-- Initialize the logger
local logger = Oratio.Logger.new({
    moduleName = "GameScript",
    minLevel = 1  -- Optional, defaults can be adjusted as needed
})

-- Log various types of messages
logger:Info("Game initialization complete")
logger:Warn("Minor delay encountered in loading assets")
logger:Error("Failed to load essential asset")
logger:Debug("Player X coordinates updated")

Simply copy this script into your game, and the logging system will handle the rest.



Happy scripting! If you run into issues or have suggestions, feel free to open an issue or contribute to the repository.
