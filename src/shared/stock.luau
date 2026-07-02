local stockModule = {

}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)

local chancesTable = {}

for key, value in pairs(chancesModule) do
    table.insert(chancesTable, key)
end

table.sort(chancesTable)


local function selectRandom(randomInstance: Random)
    local totalWeight = 0
    for _, value in pairs(chancesTable) do
        totalWeight = totalWeight + chancesModule[value]
    end

    local rand = randomInstance:NextNumber(0, totalWeight)
    local cumulative = 0

    for index, value in pairs(chancesTable) do
        cumulative = cumulative + chancesModule[value]
        if rand <= cumulative then
            return index
        end
    end

    return nil
end

function stockModule:getStock()
    local updateInterval = 300
    local seed = math.floor(os.time() / updateInterval)
    local random = Random.new(seed)

    local itemShop = {}
    local maxItems = 5

    for i = 1, maxItems do
        local item = selectRandom(random)
        if item then
            table.insert(itemShop, item)
        end
    end

    return itemShop
end


return stockModule