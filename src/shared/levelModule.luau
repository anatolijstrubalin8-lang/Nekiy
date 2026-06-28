local levelModule = {

}

function levelModule.new()
    local self = setmetatable({}, levelModule)
    self.baseValue = 1000
    self.exponent = 2.75
    return self
end

local ServerScriptService = game:GetService("ServerScriptService")

local dataManager = require(ServerScriptService.Server.data.dataManager)

function levelModule:manager(player: Player,amount: number)
    local currentStrength = player:GetAttribute('currentStrength')
    dataManager:AddValue(player,amount, 'currentStrength')
    local level = player:GetAttribute('Level')
    local needStrength = self.baseValue * (level ^ self.exponent)

end
return levelModule