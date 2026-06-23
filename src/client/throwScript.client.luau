local replicated = game:GetService('ReplicatedStorage')
local inputService = game:GetService('UserInputService')
local players = game:GetService('Players')

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')

local camera = workspace.CurrentCamera

local mouse = player:GetMouse()

local throwModule = require(replicated.Shared.throwModule)

local throwTable = throwModule.new() -- ! СКОРОСТЬ/ВРЕМЯ/ВЫСОТА

inputService.InputBegan:Connect(function(input, processed)
    
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        throwTable:throw()
        throwTable:test()
    end

end)

