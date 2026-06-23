local strengthTrain = {

}
local ServerScriptService = game:GetService("ServerScriptService")

local dataManager = require(ServerScriptService.Server.data.dataManager)

function strengthTrain:train(player: Player,multiple:number,amount:number)
    dataManager:AddValue(player,amount*multiple, 'Strength')
    warn('добавлено ' .. amount*multiple .. ' силы')
end




return strengthTrain