local players = game:GetService("Players")
local player = players.LocalPlayer


player:GetAttributeChangedSignal('Strength'):Connect(function(...)
    local strength = player:GetAttribute('Strength')
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 16 + strength / 10
end)