local DataManager = {}

DataManager.Profiles = {}

local replicatedStorage = game:GetService("ReplicatedStorage")

function DataManager.AddGold(player: Player, amount: number)
    local profile = DataManager.Profiles[player]
    if profile then
        profile.Data.Gold += amount
        

        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then

            local gold = leaderstats:FindFirstChild("Gold") :: any
            if gold then
                gold.Value = profile.Data.Gold
            end
            if replicatedStorage:FindFirstChild("UpdateGold") then
                replicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold)
            end
        end
    end
end

function DataManager.AddGems(player: Player, amount: number)
    local profile = DataManager.Profiles[player]
    if profile then
        profile.Data.Gems += amount
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then

            local gems = leaderstats:FindFirstChild("Gems") :: any
            if gems then
                gems.Value = profile.Data.Gems
            end
        end
    end
end

return DataManager