local players = game:GetService('Players')


local levelBar = game.PlayerGui.ScreenGui.Frame.Level

local player = players.LocalPlayer


player:GetAttributeChangedSignal('currentStrength'):Connect(function()
    local currentStrength = player:GetAttribute('currentStrength')
    local level = player:GetAttribute('Level')
    local needStrength = player:GetAttribute('needStrength')
    local barSize = math.clamp(currentStrength/needStrength,0,1)
    levelBar.Size = UDim2.new(barSize,0,1,0)
end)

player:GetAttributeChangedSignal('Level'):Connect(function()
    levelBar.Size = UDim2.new(0,0,1,0)
end)