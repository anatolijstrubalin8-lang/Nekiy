local timeUpdate = 15

local stockRemain = timeUpdate - os.time() % timeUpdate
local players = game:GetService('Players')

local dataManager = require(game.ServerScriptService.Server.data.dataManager)
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local sessionData = {}

local replicated = game:GetService('ReplicatedStorage')
local http = game:GetService('HttpService')

local stockBuyEvent = replicated:WaitForChild('StockBuyEvent')

local function updateStock(currentStock)
    for id,stock in pairs(sessionData) do
        local currentStockCopy = table.clone(currentStock)
        sessionData[id] = currentStockCopy
        local player = players:GetPlayerByUserId(id)
        if player then
            dataManager:SetValue(player, currentStockCopy, 'lastStock')
            player:SetAttribute('lastStock', http:JSONEncode(currentStockCopy))
        end
    end
end



players.PlayerAdded:Connect(function(player: Player)
    local profile = dataManager.Profiles[player]
    while not profile do
        task.wait()
        profile = dataManager.Profiles[player]
    end
    local lastStock = profile.Data.lastStock
    local lastSeed = profile.Data.lastSeed

  --  if not lastStock and not lastSeed then
      --  lastStock, lastSeed = stockModule:getStock(false)
    --end
    local currentStock, currentSeed = stockModule:getStock(false)
    if lastSeed ~= currentSeed then

        lastStock = currentStock
        lastSeed = currentSeed
    end

    sessionData[player.UserId] = lastStock

    dataManager:SetValue(player, lastStock, 'lastStock')
    dataManager:SetValue(player, lastSeed, 'lastSeed')
    player:SetAttribute('lastStock', http:JSONEncode(lastStock))
    player:SetAttribute('lastSeed', lastSeed)
end)

players.PlayerRemoving:Connect(function(player)
    local playerStock = sessionData[player.UserId]

    if playerStock then
     --   dataManager:SetValue(player, sessionData[player.UserId], 'lastStock')
        sessionData[player.UserId] = nil
    end
end)

stockBuyEvent.OnServerEvent:Connect(function(player: Player, item: string)
    local playerStock = sessionData[player.UserId]
   -- warn(playerStock)
   -- warn(playerStock[item])
    if playerStock[item] > 0 then
        playerStock[item] -= 1
        dataManager:SetValue(player, playerStock, 'lastStock')
       -- dataManager:SetValue(player, Value, key)
        player:SetAttribute('lastStock', http:JSONEncode(playerStock))
        stockBuyEvent:FireClient(player, item)
        --print()
       -- player:SetAttribute(table.concat(play))
    end
end)

task.spawn(function()

    task.wait(stockRemain)
    
    local currentStock,currentSeed = stockModule:getStock(true)
    updateStock(currentStock)

    while true do
        task.wait(timeUpdate)
        currentStock,currentSeed = stockModule:getStock(true)
        updateStock(currentStock)
        warn("Сток обновлен в цикле: ", currentStock)
    end
end)



