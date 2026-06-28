local pearls = game.Workspace:WaitForChild('Pearls')

local players = game:GetService('Players')

local enderPearls = {
    Pearl1 = 100,
    Pearl2 = 500,
    Pearl3 = 600,
    Pearl4 = 1000,
}

for i, pearl in ipairs(pearls:GetChildren()) do
    pearl.Touched:Connect(function(hit)
        local character = hit:FindFirstAncestorOfClass('Model')
        if not character then return end
        local player = players:GetPlayerFromCharacter(character)
        if player then

            local pearlValue = enderPearls[pearlName]
        end
    end)
en