local players = game:GetService('Players')


local player = players.LocalPlayer


local replicated = game:GetService('ReplicatedStorage')

replicated:GetAttributeChangedSignal('currentStock'):Connect(function()
    warn('серый')
end)
