local stockModule = {
    updateInterval = 15,
    maxItems = 2
}

local chancesModule = require(game.ReplicatedStorage.Shared.chancesModule)


local replicatedStorage = game.ReplicatedStorage
local chancesTable = {}

local runService = game:GetService("RunService")

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
    local seed = math.floor(os.time() / self.updateInterval)

    warn(replicatedStorage:GetAttribute("currentStock"))
    local random = Random.new(seed)

    local itemShop = {}

    for i = 1, self.maxItems do
        local item = selectRandom(random)
        if item then
            table.insert(itemShop, item)
        end
    end
    local items = table.concat(itemShop,',')
    replicatedStorage:SetAttribute("currentStock", items)
    warn('harus')
    return itemShop
end


return stockModule