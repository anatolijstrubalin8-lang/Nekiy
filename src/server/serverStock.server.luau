local timeUpdate = 15

local stockRemain = os.time() % timeUpdate
local players = game:GetService('Players')
local stockModule = require(game.ReplicatedStorage.Shared.stock)
local sessionData = {}

task.spawn(function()
    task.wait(stockRemain)
    local stock = stockModule:getStock()
    warn(stock)
end)

task.spawn(function()
    while task.wait(timeUpdate) do
        local stock = stockModule:getStock()
        warn(stock)
    end
end)


players.PlayerAdded:Connect(function(player)
    sessionData[player.UserId] = {}
    warn(sessionData)
end)

players.PlayerRemoving:Connect(function(player)
    sessionData[player.UserId] = nil
    warn(sessionData)
end)



