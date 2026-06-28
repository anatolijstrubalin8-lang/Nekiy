local strengthTrain = {

}
local ServerScriptService = game:GetService("ServerScriptService")

local replicated = game:GetService('ReplicatedStorage')

local dataManager = require(ServerScriptService.Server.data.dataManager)
local levelModule = require(replicated.Shared.levelModule)

local levelNew = levelModule.new()

function strengthTrain:train(player: Player,multiple:number,amount:number)
    dataManager:AddValue(player,amount*multiple, 'Strength')
    dataManager:AddValue(player,amount*multiple, 'currentStrength')
    levelNew:upLvl(player,amount*multiple)
    warn('добавлено ' .. amount*multiple .. ' силы')
    warn('текущее силы ' , player:GetAttribute('currentStrength'))
    warn('текущий уровень ' , player:GetAttribute('Level'))
    warn('требуемое силы ' , player:GetAttribute('needStrength'))
end




return strengthTrain