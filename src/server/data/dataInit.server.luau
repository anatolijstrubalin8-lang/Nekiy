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

local tests = {
    'Test',
    'Test1',
    'Test2',
}

local ProfileStore = require(ServerScriptService.Server.profileStore)
local DataManager = require(ServerScriptService.Server.data.dataManager)
local Template = require(ServerScriptService.Server.data.dataTemplate)

local PlayerStore = ProfileStore.New('Test2', Template)


local function Initialize(player: Player, profile)

    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local strength = Instance.new("NumberValue")
    strength.Name = "Strength"
    strength.Value = profile.Data.Strength
    strength.Parent = leaderstats
    player:SetAttribute("Strength", profile.Data.Strength)


    local wins = Instance.new("NumberValue")
    wins.Name = "Wins"
    wins.Value = profile.Data.Wins
    wins.Parent = leaderstats
    player:SetAttribute("Wins", profile.Data.Wins)

    local rebirths = Instance.new("NumberValue")
    rebirths.Name = "Rebirths"
    rebirths.Value = profile.Data.Rebirths
    rebirths.Parent = leaderstats
    player:SetAttribute("Rebirths", profile.Data.Rebirths)

    local level = Instance.new("NumberValue")
    level.Name = 'Level'
    level.Value = profile.Data.Level
    level.Parent = leaderstats
    player:SetAttribute('Level', profile.Data.Level)
    player:SetAttribute('currentStrength',profile.Data['currentStrength'])
    player:SetAttribute('needStrength',profile.Data['needStrength'])

   --- if ReplicatedStorage:FindFirstChild("UpdateGold") then
  --      ReplicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold) -- !!! НА БУДУЩЕЕ ИНТЕРФЕЙС
   -- end
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