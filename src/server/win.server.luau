local players = game:GetService('Players')

local winPartsFolder = game.Workspace:WaitForChild('WinPartsFolder')


local winParts = {
    WinPart1 = {
        part = winPartsFolder.WinPart1,
        wins = 1
}
    ,
}

local dataManager = require(game.ServerScriptService.Server.data.dataManager)



local processedPlayers = {}
for _, winpart in pairs(winParts) do
    local part = winpart.part
    part.Touched:Connect(function(hit)
        local character = hit:FindFirstAncestorOfClass('Model')
        if not character then return end
        local player = players:GetPlayerFromCharacter(character)
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        if player and humanoid and not processedPlayers[player.UserId] and humanoid.Health > 0 then
            processedPlayers[player.UserId] = true
            local wins = winpart.wins
            warn(player.Name .. ' победил')
            character:PivotTo(CFrame.new(0, 3, -10.675))
            dataManager:AddValue(player,wins, 'Wins')
            player:SetAttribute('Wins', player:GetAttribute('Wins') + wins)
            task.delay(0.77, function()
                processedPlayers[player.UserId] = nil
            end)
        end
    end)
end
        
