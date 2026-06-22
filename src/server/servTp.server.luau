local replicated = game:GetService('ReplicatedStorage')
local serverTp = replicated.serverTpEvent

serverTp.OnServerEvent:Connect(function(player,pos)
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild('HumanoidRootPart')
    rootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end)