local strengthTrain = {

}
local ServerScriptService = game:GetService("ServerScriptService")

local replicated = game:GetService('ReplicatedStorage')

local dataManager = require(ServerScriptService.Server.data.dataManager)
local levelModule = require(replicated.Shared.levelModule)

function strengthTrain:train(player: Player,multiple:number,amount:number)
    dataManager:AddValue(player,amount*multiple, 'Strength')
    dataManager:AddValue(player,amount*multiple, 'currentStrength')
    warn('добавлено ' .. amount*multiple .. ' силы')
end




return strengthTrain