local strengthTrain = {

}
local ServerScriptService = game:GetService("ServerScriptService")

local replicated = game:GetService('ReplicatedStorage')

local dataManager = require(ServerScriptService.Server.data.dataManager)
local levelModule = require(replicated.Shared.levelModule)

local levelNew = levelModule.new()

function strengthTrain:train(player: Player,multiple:number,amount:number)
    local wins = player:GetAttribute('Wins') or 0
    local winsMultiple = wins * 0.01 
    local multiplies = winsMultiple + multiple
    dataManager:AddValue(player,amount*multiplies, 'Strength')
    dataManager:AddValue(player,amount*multiplies, 'currentStrength')
    levelNew:upLvl(player)
    warn('добавлено ' .. amount*multiplies .. ' силы')
    warn(player:GetAttribute('currentStrength'),'/',player:GetAttribute('needStrength'),' силы', player:GetAttribute('Level'), ' уровень')

end



return strengthTrain