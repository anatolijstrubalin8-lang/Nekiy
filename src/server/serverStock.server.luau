local dataManager = require(game.ServerScriptService.Server.data.dataManager)
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local timeUpdate = stockModule.updateInterval

local players = game:GetService('Players')

--local timeUpdate = stockModule.updateInterval
local sessionData = {}--

local replicated = game:GetService('ReplicatedStorage')
local http = game:GetService('HttpService')

local stockBuyEvent = replicated:WaitForChild('StockBuyEvent')
local buySoundEvent = replicated:WaitForChild('BuySoundEvent')

local function updateStock(currentStock, currentSeed)
    for playerId,stock in pairs(sessionData) do
        local currentStockCopy = table.clone(currentStock)
        sessionData[playerId] = currentStockCopy
        local player = players:GetPlayerByUserId(playerId)
        if player then
            dataManager:SetValue(player, currentStockCopy, 'lastStock')
            player:SetAttribute('lastStock', http:JSONEncode(currentStockCopy))
            dataManager:SetValue(player, currentSeed, 'lastSeed')
            player:SetAttribute('lastSeed',currentSeed)
        end
    end
end



players.PlayerAdded:Connect(function(player: Player)
    local profile = dataManager.Profiles[player]
    while player.Parent == players and not profile  do
        task.wait()
        profile = dataManager.Profiles[player]
    end
    if player.Parent ~= players then
        return
    end
    local lastStock = profile.Data.lastStock
    local lastSeed = profile.Data.lastSeed

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
        sessionData[player.UserId] = nil
    end
end)

stockBuyEvent.OnServerEvent:Connect(function(player: Player, item: string)
    local playerStock = sessionData[player.UserId]
   -- warn(playerStock)
   -- warn(playerStock[item])
    if playerStock and playerStock[item] and playerStock[item] > 0 then
        playerStock[item] -= 1
        dataManager:SetValue(player, playerStock, 'lastStock')
       -- dataManager:SetValue(player, Value, key)
        player:SetAttribute('lastStock', http:JSONEncode(playerStock))
        buySoundEvent:FireClient(player)
        dataManager:AddValue(player, 1, item)
        player:SetAttribute(item, player:GetAttribute(item) :: number + 1 )
        
      --  stockBuyEvent:FireClient(player, item)
        --print()
       -- player:SetAttribute(table.concat(play))
    end
end)

task.spawn(function()
    while true do
     
        local now = os.time()
        local stockRemain = timeUpdate - (now % timeUpdate)
    
        task.wait(stockRemain)
    
        local currentStock, currentSeed = stockModule:getStock(true)
        updateStock(currentStock, currentSeed)
        warn("Сток обновлен в цикле: ", currentStock, "Время обновления (os.time):", os.time()-now)
    end
end)



