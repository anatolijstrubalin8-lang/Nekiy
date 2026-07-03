local timeUpdate = 15

local stockRemain = timeUpdate - os.time() % timeUpdate
local players = game:GetService('Players')
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local sessionData = {}

local currentStock = stockModule:getStock()

players.PlayerAdded:Connect(function(player)
    sessionData[player.UserId] = currentStock
    warn(sessionData)
end)

players.PlayerRemoving:Connect(function(player)
    sessionData[player.UserId] = nil
    warn(sessionData)
end)

do 
    task.wait(stockRemain)
    currentStock = stockModule:getStock()
    warn(currentStock)
end

while task.wait(timeUpdate) do
    currentStock = stockModule:getStock()
    warn(currentStock)
end





