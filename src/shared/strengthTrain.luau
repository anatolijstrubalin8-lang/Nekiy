local strengthTrain = {

}
local ServerScriptService = game:GetService("ServerScriptService")

local dataManager = require(ServerScriptService.Server.data.dataManager)

function strengthTrain:train(player: Player)
    dataManager:AddValue(player,10000, 'Strength')
end




return strengthTrain