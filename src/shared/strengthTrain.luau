local strengthTrain = {

}

local ServerScriptService = game:GetService("ServerScriptService")
local players = game:GetService('Players')
local player = players.LocalPlayer

local dataManager = require(ServerScriptService.Server.data.dataManager)

function strengthTrain:train(player: Player)

   -- local character = player.Character or player.CharacterAdded:Wait()
   -- local humanoid = character:WaitForChild('Humanoid')

    dataManager:AddValue(player,1, 'Strength')
        


end




return strengthTrain