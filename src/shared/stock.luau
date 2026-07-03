local stockModule = {

}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)


local updateInterval = 15
local replicatedStorage = game.ReplicatedStorage
local chancesTable = {}

for key, value in pairs(chancesModule) do
    table.insert(chancesTable, key)
end

table.sort(chancesTable)


local function selectRandom(randomInstance: Random)
    local totalWeight = 0
    for _, value in ipairs(chancesTable) do
        totalWeight = totalWeight + chancesModule[value]
    end

    local rand = randomInstance:NextNumber(0, totalWeight)
    local cumulative = 0

    for index, value in ipairs(chancesTable) do
        cumulative = cumulative + chancesModule[value]
        if rand <= cumulative then
            return value
        end
    end

    return nil
end

function stockModule:getStock()
    local seed = math.floor(os.time() / updateInterval)
    replicatedStorage:SetAttribute("currentSeed", seed)
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