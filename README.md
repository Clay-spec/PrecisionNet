# [Precision Net]

[Precision Net] is a [Lua-based module developed primarily for use in Roblox basketball aimbot scripts.]. This module is typically used in [enables precise goal detection and shot calculations by analyzing distances, arc ranges, and player positioning in real-time.], and it helps developers achieve [Goal Detection, Arc Calculation, RemoteEvent Interaction, and other Customiziable features].

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
