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
