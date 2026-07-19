local timeUpdate = 15

local stockRemain = timeUpdate - os.time() % timeUpdate
local players = game:GetService('Players')

local dataManager = require(game.ServerScriptService.Server.data.dataManager)
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local sessionData = {}

local replicated = game:GetService('ReplicatedStorage')
local http = game:GetService('HttpService')

local stockBuyEvent = replicated:WaitForChild('StockBuyEvent')



players.PlayerAdded:Connect(function(player: Player)
    local profile = dataManager.Profiles[player]
    while not profile do
        task.wait()
        profile = dataManager.Profiles[player]
    end
    local lastStock = profile.Data.lastStock
    if not lastStock then
        lastStock = stockModule:getStock()
    end

    sessionData[player.UserId] = lastStock
    dataManager:SetValue(player, lastStock, 'lastStock')
    player:SetAttribute('lastStock', http:JSONEncode(lastStock))
end)

players.PlayerRemoving:Connect(function(player)
    dataManager:SetValue(player, sessionData[player.UserId], 'lastStock')
    player:SetAttribute('lastStock', http:JSONEncode(sessionData[player.UserId]))
    sessionData[player.UserId] = nil
    --warn(sessionData)
end)

stockBuyEvent.OnServerEvent:Connect(function(player: Player, item: string)
    local playerStock = sessionData[player.UserId]
   -- warn(playerStock)
   -- warn(playerStock[item])
    if playerStock[item] > 0 then
        playerStock[item] -= 1
        dataManager:SetValue(player, playerStock, 'lastStock')
        player:SetAttribute('lastStock', http:JSONEncode(playerStock))
        stockBuyEvent:FireClient(player, item)
        print()
       -- player:SetAttribute(table.concat(play))
    end
end)

task.spawn(function()

    task.wait(stockRemain)
    
    local currentStock = stockModule:getStock()


    while true do
        task.wait(timeUpdate)
        currentStock = stockModule:getStock()
        warn("Сток обновлен в цикле: ", currentStock)
    end
end)




