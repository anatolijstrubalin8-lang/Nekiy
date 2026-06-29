local stockModule = {

}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)

local function selectRandom()
    local totalWeight = 0
    for _, value in ipairs(ChancesModule) do
        totalWeight = totalWeight + value[2] 
    end

    local rand = random:NextNumber(0, totalWeight)
    local cumulative = 0

    for index, value in ipairs(ChancesModule) do
        cumulative = cumulative + value[2]
        if rand <= cumulative then
            return index
        end
    end

end

return stockModule