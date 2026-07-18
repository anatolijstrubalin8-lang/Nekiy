local timeUpdate = 15

local stockRemain = timeUpdate - os.time() % timeUpdate
local players = game:GetService('Players')

local dataManager = require(game.ServerScriptService.Server.data.dataManager)
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local sessionData = {}

local replicated = game:GetService('ReplicatedStorage')

local stockBuyEvent = replicated:WaitForChild('stockBuyEvent')



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
end)

players.PlayerRemoving:Connect(function(player)
    sessionData[player.UserId] = nil
   -- replicated:SetAttribute('')
    warn(sessionData)
end)

stockBuyEvent.OnServerEvent:Connect(function(player: Player, item: string)
    local playerStock = sessionData[player.UserId]
    if playerStock[item] > 0 then
        playerStock[item] -= 1

task.spawn(function()

    task.wait(stockRemain)
    
    currentStock = stockModule:getStock()


    while true do
        task.wait(timeUpdate)
        currentStock = stockModule:getStock()
        warn("Сток обновлен в цикле: ", currentStock)
    end
end)




