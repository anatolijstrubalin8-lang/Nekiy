local DataManager = {}

DataManager.Profiles = {}


local dataTemplate = require(game.ServerScriptService.Server.data.dataTemplate)






local replicatedStorage = game:GetService("ReplicatedStorage")

local keys = {
    "Strength",
    "Wins",
    "Rebirths",
    "Level",
    "currentStrength",
    'needStrength',

}

function DataManager:GetValue(player: Player, key: dataTemplate.dataKeys)
    local profile = DataManager.Profiles[player]
    if profile and profile.Data[key] ~= nil then
        return profile.Data[key]
    end
    return
end

function DataManager:AddValue(player: Player, amount: number, key: dataTemplate.dataKeys)
    local profile = DataManager.Profiles[player]
    if profile and profile.Data[key] ~= nil then
        profile.Data[key] += amount
    
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then

            local value = leaderstats:FindFirstChild(key) :: any
            if value then
                value.Value = profile.Data[key]
            end

        end
    end
end

function DataManager:SetValue(player: Player, Value: number, key: dataTemplate.dataKeys)
    local profile = DataManager.Profiles[player]
    if profile and profile.Data[key] ~= nil then
        profile.Data[key] = Value
        local leaderstats = player:FindFirstChild("leaderstats")
    
        if leaderstats then
            local value = leaderstats:FindFirstChild(key) :: any
            if value then
                value.Value = profile.Data[key]
            end
        end
    end
end



function DataManager:SubtractValue(player: Player,amount: number, key: dataTemplate.dataKeys)
    local profile = DataManager.Profiles[player]
    if profile and profile.Data[key] ~= nil then
        profile.Data[key] -= amount

        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then

            local value = leaderstats:FindFirstChild(key) :: any
            if value then
                value.Value = profile.Data[key]
            end

        end
    end
end

return DataManager