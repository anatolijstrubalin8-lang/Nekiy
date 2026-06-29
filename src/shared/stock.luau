local stockModule = {

}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)

local function selectRandom(randomInstance: Random)
    local totalWeight = 0
    for _, value in pairs(chancesModule) do
        totalWeight = totalWeight + value
    end

    local rand = randomInstance:NextNumber(0, totalWeight)
    local cumulative = 0

    for index, value in ipairs(chancesModule) do
        cumulative = cumulative + value[2]
        if rand <= cumulative then
            return index
        end
    end
    return 0
end

return stockModule