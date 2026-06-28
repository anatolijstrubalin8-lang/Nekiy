local levelModule = {

}
levelModule.__index = levelModule
function levelModule.new()
    local self = setmetatable({}, levelModule)
    self.baseValue = 1000
    self.exponent = 2.75
    return self
end

local ServerScriptService = game:GetService("ServerScriptService")

local dataManager = require(ServerScriptService.Server.data.dataManager)

function levelModule:upLvl(player: Player,amount: number)
    local currentStrength = player:GetAttribute('currentStrength')
    local level = player:GetAttribute('Level')
    local needStrength = self.baseValue * (level ^ self.exponent)
    if currentStrength >= needStrength then
        dataManager:AddValue(player,1, 'Level')
        dataManager:AddValue(player,-currentStrength, 'currentStrength')
        local newLevel = player:GetAttribute('Level')
        needStrength = self.baseValue * (newLevel ^ self.exponent)
        player:SetAttribute('needStrength',needStrength)
    end


end
return levelModule