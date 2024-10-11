type DistanceEntry = {
    minDist: number,
    maxDist: number,
    arc: number
}

type DistanceCalculation = {
    [number]: DistanceEntry[]
}

type GoalEntry = {
    Size: Vector3?,      
    ClassName: string,   
    Name: string         
}

type Settings = {
    Player: Player,      
    Goal: GoalEntry[],   
    ArcRanges: DistanceCalculation
}

local PrecisionNet = {}
PrecisionNet.__index = PrecisionNet

local HttpService = game:GetService("HttpService")

local function logInfo(message)
    print("[INFO]: " .. message)
end

local function logError(message)
    warn("[ERROR]: " .. message)
end

local function compareProperties(Obj, Property, Value)
    if typeof(Value) == "Vector3" then
        return Obj[Propery] and Obj[Property].Magnitude == Value.Magnitude
    else
        return Obj[Property] == Value
    end
end

function PrecisionNet:InitializeGoals(settings: Settings)
    self.Goals = {}
    self.Initialized = true

    for _, Obj in next, Workspace:GetDescendants() do
        for _, GoalEntry in next, settings.Goal do
            for Property, Value in pairs(GoalEntry) do
                if Obj[Propety] ~= Value then
     table.insert(self.Goals, Obj)
     logInfo("Goal initialized: " .. Obj.Name)
if #self.Goals == 0 then
        logError("No valid goals found during initialization.")
                end
             end
          end
       end
    end
end

function PrecisionNet:GetGoal(settings)
    if not self.Initialized then
        self:InitializeGoals(settings)
    end

    local Player = settings.Player
    local Torso = Player.Character:FindFirstChild("Torso")

    local MinDist, ClosestGoal= 9e9

    for _, Obj in next, self.Goals do
        local Distance = (Torso.Position - Obj.Position).Magnitude
        if Distance < MinDist then
            MinDist = Distance
            ClosestGoal = Obj
        end
    end
    return ClosestGoal
end

function PrecisionNet:GetDistanceInfo(goal, settings)
    local Player = settings.Player
    local Character = Player.Character

    local Torso = Character.Torso
    local Distance = (Torso.Position - goal.Position).Magnitude

    for range, entries in next, settings.ArcRanges do
        if Distance <= range then
            for _, entry in next, entries do
                if Distance >= entry.minDist and Distance <= entry.maxDist then
                    return entry.arc, Distance
                end
            end
        end
    end

    return nil, Distance
end

local function Base64EncodeArgs(Args)
    local EncodedArgs = {}
    for _, Arg in ipairs(Args) do
        local Encoded = HttpService:Base64Encode(Arg)
        table.insert(encodedArgs, Encoded)
    end
    return EncodedArgs
end

local function SubCipher(Args)
    local Key = { a = "m", b = "n", c = "o", d = "p", e = "q" }
    local CipherArgs = {}
    
    for _, Arg in ipairs(Args) do
        local Transformed = ""
        for i = 1, #Arg do
            local Char = Arg:sub(i, i)
            Transformed = Transformed .. (Key[Char] or Char)
        end
        table.insert(CipherArgs, Transformed)
    end
    return CipherArgs
end

local function RetryRE(RemoteEvent, Args, Retries, MaxTimeOut)
    local Attempts = 0
    local Success, Result
    local StartTime = tick()

    while Attempts < Retries do
        Success, Result = pcall(function()
            RemoteEvent:FireServer(table.unpack(Args))
        end)

        if Success then
            break
        else
            Attempts = Attempts + 1
            print("Retrying RemoteEvent, attempt " .. Attempts)
            task.wait(1)
        end

        if tick() - StartTime > MaxTimeout then
            error("Max timeout exceeded while attempting to fire RemoteEvent.")
        end
    end

    if not Success then
        error("Failed to fire RemoteEvent after " .. Retries .. " retries")
    end
end

local function CustomEH(Message)
    local Timestamp = os.date("%X")
    print("[ERROR] " .. Timestamp .. " - " .. Message)
end

function PrecisionNet:Payload(RemoteEvent, Args, Options)
    Options = Options or {}

    if Options.Encrypt == "Base64" then
        Args = Base64EncodeArgs(Args)
    elseif Options.Encrypt == "Substitution" then
        Args = SubCipher(Args)
    end

    if Options.Delay then
        task.wait(type(Options.Delay) == "function" and Options.Delay() or Options.Delay)
    end

    if Options.Condition and not Options.Condition() then
        if Options.Fallback then
            Options.Fallback() -- Run the fallback function if the condition isn't met
        else
            CustomEH("Condition not met, firing aborted.") -- Custom error handler
        end
        return
    end

    local Retries = Options.Retries or 1
    local MaxTimeOut = Options.MaxTimeout or 10
    local Attempts = 0
    local Success = false
    local StartTime = tick()

    while Attempts < Retries and not Success do
        Success, Result = pcall(function()
            RemoteEvent:FireServer(table.unpack(Args))
        end)

        if Success then
            break
        else
            Attempts = Attempts + 1
            print("Retrying RemoteEvent, attempt " .. Attempts)

            if tick() - StartTime > MaxTimeOut then
                error("Max timeout exceeded while attempting to fire RemoteEvent.")
                return
            end
            task.wait(1)
        end
    end

    if Success and Options.Logging then
        local TimeStamp = os.date("%X")
        print("[INFO] " .. TimeStamp .. " - RemoteEvent fired successfully with arguments: ", table.unpack(Args))
    elseif not Success then
        CustomEH("Failed to fire RemoteEvent after " .. Retries .. " retries.")
    end
end

function PrecisionNet:PayloadWithResponse(RemoteEvent, Args, Options, ResponseCallBack)
    self:Payload(RemoteEvent, Args, Options)
    RemoteEvent.OnClientEvent:Connect(function(...)
        local ResponseArgs = {...}
        if ResponseCallback then
            ResponseCallback(ResponseArgs)
        end
    end)

return PrecisionNet
