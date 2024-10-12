local HttpService = game:GetService("HttpService")

local Url = "https://raw.githubusercontent.com/Clay-spec/PrecisionNet.lua/refs/heads/main/PrecisionNet"

getgenv().PrecisionNet = function()
    local success, response = pcall(function()
        return HttpService:GetAsync(Url)
    end)

    if success then
        getgenv().PrecisionNet = loadstring(response)()
        print("PrecisionNet module loaded successfully.")
        return
    else
        warn("Failed to load PrecisionNet module: " .. response)
    end
end
