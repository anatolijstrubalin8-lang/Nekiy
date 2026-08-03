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
    if processed then return end
    local finalPosition
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        finalPosition = mouse.Hit.Position
    elseif input.UserInputType == Enum.UserInputType.Touch then
        local hitPosition = input.Position
        local ray = camera:ScreenPointToRay(hitPosition.X, hitPosition.Y)
        local params = RaycastParams.new()

        params.FilterType = Enum.RaycastFilterType.Exclude

        params.FilterDescendantsInstances = {character}

        local rayCast = workspace:Raycast(ray.Origin, ray.Direction * 1000)
        if rayCast then
            finalPosition = rayCast.Position
        else
            finalPosition = ray.Origin + (ray.Direction * 1000)
        end
    end
    if finalPosition then
        throwTable:throw(finalPosition)
        throwTable:clientSimulate(finalPosition)
        throwTable:test()
    end

end)

