local replicated = game:GetService('ReplicatedStorage')


local trainPart = game.Workspace.TrainPart

local strengthTrain = require(replicated.Shared.strengthTrain)

trainPart.Touched:connect(strengthTrain:train(trainPart)
)