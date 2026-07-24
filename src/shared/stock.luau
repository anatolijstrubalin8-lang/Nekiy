local stockModule = {
    updateInterval = 30,
    maxItems = 3
}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)


local replicatedStorage = game.ReplicatedStorage
local chancesTable = {}

local http = game:GetService('HttpService')
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

function stockModule:getStock(attribute : boolean)
    local seed = math.floor(os.time() / self.updateInterval)

    local random = Random.new(seed)

    local itemShop = {

    }
    for i,v in pairs(chancesModule) do
        itemShop[i] = 0
    end

    for i = 1, self.maxItems do
        local item = selectRandom(random)

        if item then
            itemShop[item] = itemShop[item] + 1
        end
    end

    local items = http:JSONEncode(itemShop)
    if attribute then
        replicatedStorage:SetAttribute("currentStock", items)
    end

    return itemShop,seed
end


return stockModule