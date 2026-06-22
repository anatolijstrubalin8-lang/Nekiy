local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local function GetStoreName()
    if RunService:IsStudio() then
        return "Test"
    else
        return "Live"
    end
end

local ProfileStore = require(ServerScriptService.Server.profileStore)
local DataManager = require(ServerScriptService.Server.data.dataManager)
local Template = require(ServerScriptService.Server.data.dataTemplate)

local PlayerStore = ProfileStore.New(GetStoreName(), Template)


local function Initialize(player: Player, profile)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local gold = Instance.new("NumberValue")
    gold.Name = "Gold"
    gold.Value = profile.Data.Gold
    gold.Parent = leaderstats

    local gems = Instance.new("NumberValue")
    gems.Name = "Gems"
    gems.Value = profile.Data.Gems
    gems.Parent = leaderstats

    if ReplicatedStorage:FindFirstChild("UpdateGold") then
        ReplicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold)
    end
end

local function PlayerAdded(player: Player)
    local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
        Cancel = function()
            return player.Parent ~= Players
        end
    })

    if profile ~= nil then

        profile:AddUserId(player.UserId) 
        profile:Reconcile()

        profile.OnSessionEnd:Connect(function()
            DataManager.Profiles[player] = nil
            player:Kick("Данные были загружены на другом сервере. Перезайдите.")
        end)

        if player.Parent == Players then
            DataManager.Profiles[player] = profile
            Initialize(player, profile)
        else
            profile:EndSession()
        end
    else

        player:Kick("Ошибка данных. Попробуйте зайти позже.")
    end
end

Players.PlayerRemoving:Connect(function(player)
    local profile = DataManager.Profiles[player]
    if profile then
        profile:EndSession()
        DataManager.Profiles[player] = nil
    end
end)


Players.PlayerAdded:Connect(PlayerAdded)

for _, player in Players:GetPlayers() do
    task.spawn(PlayerAdded, player)
end