# **Precision Net**

**Precision Net** is a **Lua-based module developed primarily for use in Roblox basketball aimbot scripts.** This module is typically used in **enables precise goal detection and shot calculations by analyzing distances, arc ranges, and player positioning in real-time.**, and it helps developers achieve **Goal Detection, Arc Calculation, RemoteEvent Interaction, and other Customiziable features**.

## Features
- **Goal Detection**: Automatically finds and returns the nearest goal or target.
- **Distance Calculation**: Calculates the distance between the player and the target.
- **Remote Event Handling**: Manages interactions with RemoteEvents, including retries and fallback mechanisms.

## Usage
> Loader
```lua
local PrecisionNet = getgenv().PrecisionNet
```

> Customize Settings
```lua
local settings = {
    Player = game.Players.LocalPlayer,
    Goal = {
        { Name = "here", ClassName = "BasePart" }
    },
    ArcRanges = {
        [75] = {
            { minDist = 57, maxDist = 59, arc = 50 },
            { minDist = 59, maxDist = 60, arc = 45 },
        }
    }
}
```
> Constructor Class
```lua
local Net = PrecisionNet.new(settings)
```

> Retrieve Goal
```lua
local GetGoal = Net:GetGoal()
```

> Payload Remote
```lua
local BasketballRemoteEvent = game.ReplicatedStorage:WaitForChild("BasketballRemoteEvent")

-- Define the arguments to pass with the RemoteEvent
local args = {
    Vector3.new(0, 100, 0), -- Direction for the shot
    Vector3.new(10, 20, 30), -- Player's position
    75 -- Shot power
}

-- Define the options for the Payload function
local options = {
    Encrypt = "Base64",   -- Optional: Encrypt the arguments with Base64 encoding
    Retries = 3,          -- Retry up to 3 times if the event fails
    Delay = 0.5,          -- Wait 0.5 seconds before firing the event
    Logging = true,       -- Log the event firing to the console
    Condition = function() -- Optional: Only fire if certain conditions are met
        return game.Players.LocalPlayer.Character ~= nil
    end,
    Fallback = function()  -- Optional: A fallback function if the condition is not met
        print("Condition not met, RemoteEvent not fired.")
    end
}

-- Fire the RemoteEvent using the Payload function
net:Payload(BasketballRemoteEvent, args, options)
```
> Payload Remote w/ Response
```lua
local BasketballRemoteEvent = game.ReplicatedStorage:WaitForChild("BasketballRemoteEvent")

-- Define the arguments to pass with the RemoteEvent
local args = {
    Vector3.new(0, 100, 0), -- Direction for the shot
    Vector3.new(10, 20, 30), -- Player's position
    75 -- Shot power
}

-- Define the options for the Payload function
local options = {
    Encrypt = "Base64",   -- Optional: Encrypt the arguments with Base64 encoding
    Retries = 3,          -- Retry up to 3 times if the event fails
    Delay = 0.5,          -- Wait 0.5 seconds before firing the event
    Logging = true,       -- Log the event firing to the console
    Condition = function() -- Optional: Only fire if certain conditions are met
        return game.Players.LocalPlayer.Character ~= nil
    end,
    Fallback = function()  -- Optional: A fallback function if the condition is not met
        print("Condition not met, RemoteEvent not fired.")
    end
}

-- Fire the RemoteEvent using the PayloadWithResponse function and directly handle the response
net:PayloadWithResponse(BasketballRemoteEvent, args, options, function(responseArgs)
    -- Directly handle the response from the server
    if #responseArgs > 0 then
        print("Received response from server!")
        
        -- Loop through and print each response argument
        for i, response in ipairs(responseArgs) do
            print("Response[" .. i .. "]:", response)
        end
    else
        print("No response received from the server.")
    end
end)
```

> Full-Example
```lua
-- Load the PrecisionNet module globally (assuming it's available in the global environment)
local PrecisionNet = getgenv().PrecisionNet

-- Define the settings for PrecisionNet, including the player, goals, and arc ranges
local settings = {
    Player = game.Players.LocalPlayer, -- The local player instance
    Goal = { -- Define the goals (hoops or targets) with their properties
        { Name = "here", ClassName = "BasePart" }, -- Example goal
        { Name = "goal", ClassName = "MeshPart" }  -- Another example goal
    },
    ArcRanges = { -- Arc ranges based on distance for shot calculation
        [75] = {
            { minDist = 57, maxDist = 59, arc = 50 },
            { minDist = 59, maxDist = 60, arc = 45 }
        },
        [80] = {
            { minDist = 60, maxDist = 65, arc = 40 },
            { minDist = 65, maxDist = 70, arc = 35 }
        }
    }
}

-- Create an instance of PrecisionNet
local net = PrecisionNet.new(settings)

-- Get the closest goal using the GetGoal function
local closestGoal = net:GetGoal(settings)
    -- Calculate the distance and arc using GetDistanceInfo
    local arc, distance = net:GetDistanceInfo(closestGoal, settings)
end

-- Define the RemoteEvent for shooting the basketball (replace with your actual RemoteEvent)
local ShootEvent = game.ReplicatedStorage:WaitForChild("ShootEvent")

-- Define the arguments to send to the server when firing the RemoteEvent
local args = {
    "shoot", -- Action type
    Vector3.new(0, arc or 50, 0), -- Shot direction with calculated arc (or default 50)
    Vector3.new(10, 20, 30), -- Player's position
    75 -- Shot power
}

-- Define options for the Payload function, including encryption, retries, delay, and logging
local options = {
    Encrypt = "Base64",   -- Encrypt the arguments using Base64 encoding
    Retries = 3,          -- Retry up to 3 times if the RemoteEvent fails to fire
    Delay = 0.5,          -- Wait 0.5 seconds before firing the event
    Logging = true,       -- Log the RemoteEvent firing to the console
    Condition = function() -- Only fire if the player has a character in the game
        return game.Players.LocalPlayer.Character ~= nil
    end,
    Fallback = function()  -- Fallback function if the condition is not met
        print("Condition not met, RemoteEvent not fired.")
    end
}

-- Fire the RemoteEvent using PayloadWithResponse and handle the server's response
net:PayloadWithResponse(ShootEvent, args, options, function(responseArgs)
    -- Handle the response from the server
    if #responseArgs > 0 then
        print("Response received from server!")
        
        -- Loop through and print each response argument
        for i, response in ipairs(responseArgs) do
            print("Response[" .. i .. "]:", response)
        end
    else
        print("No response received from the server.")
    end
end)
```
