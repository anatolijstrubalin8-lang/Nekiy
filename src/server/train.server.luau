local replicated = game:GetService('ReplicatedStorage')
local players = game:GetService('Players')

local trainZone = game.Workspace.trainZone
local strengthTrain = require(replicated.Shared.strengthTrain)

local trainCd = 0.5

local trainTable = {
    DirtTrain = {
        multiple = 1,
        amount = 1000
    },
    GoldTrain = {
        multiple = 3,
        amount = 5000
    },
    DiamondTrain = {
        multiple = 5,
        amount = 10_000
    },
}

while task.wait(trainCd) do

    for i, zone in ipairs(trainZone:GetChildren()) do
        local processedPlayers = {}
        for _, part in ipairs(workspace:GetPartsInPart(zone)) do
            local character = part:FindFirstAncestorOfClass('Model')
            local player = players:GetPlayerFromCharacter(character)
            if player and not processedPlayers[player] then
                local trainPart = trainTable[zone.Name]
                processedPlayers[player] = true
                strengthTrain:train(player, trainPart.multiple, trainPart.amount)
                continue
            end
        end
    end
end
