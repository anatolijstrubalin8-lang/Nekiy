local DataManager = {}

DataManager.Profiles = {}

local replicatedStorage = game:GetService("ReplicatedStorage")

function DataManager.AddValue(player: Player, amount: number, key: string)
    local profile = DataManager.Profiles[player]
    if profile and profile.Data[key] ~= nil then
        profile.Data[key] += amount
        

        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then

            local value = leaderstats:FindFirstChild(key) :: any
            if value then
                value.Value = profile.Data[key]
            end
          --  if replicatedStorage:FindFirstChild("UpdateGold") then
              --  replicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold) -- ! НА БУДУЩЕЕ
           --end
        end
    end
end

return DataManager