local replicated = game:GetService('ReplicatedStorage')
local players = game:GetService('Players')

local trainPart = game.Workspace.TrainPart
local strengthTrain = require(replicated.Shared.strengthTrain)

trainPart.Touched:connect(function(hit)

    local character = hit.Parent
    local player = players:GetPlayerFromCharacter(character)

    strengthTrain:train(player)
end)
