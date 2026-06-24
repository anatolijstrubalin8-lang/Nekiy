local players = game:GetService('Players')

local winPart = workspace.WinPart1





winPart.Touched:Connect(function(hit)
    local character = hit:FindFirstAncestorOfClass('Model')
    local player = players:GetPlayerFromCharacter(character)
    if player then
