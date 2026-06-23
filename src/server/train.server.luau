local replicated = game:GetService('ReplicatedStorage')
local players = game:GetService('Players')

local trainPart = game.Workspace.TrainPart
local strengthTrain = require(replicated.Shared.strengthTrain)


local processedPlayers = {}
while task.wait(1) do
    local parts = workspace:GetPartsInPart(trainPart)

    for _, part in pairs(parts) do
        local character = part:FindFirstAncestorOfClass('Model')
        local player = players:GetPlayerFromCharacter(character)
        if player and not processedPlayers[player] then
            processedPlayers[player] = true
            strengthTrain:train(player)
            continue
        end
    end
    processedPlayers = {}
end
