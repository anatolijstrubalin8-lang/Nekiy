local levelModule = {

}

function levelModule.new()
    local self = setmetatable({}, levelModule)
    self.baseValue = 25
    self.exponent = 4.3
    return self
end

function levelModule:manager(player: Player,amount)
    local strength = player:GetAttribute('Strenght')

end
return levelModule