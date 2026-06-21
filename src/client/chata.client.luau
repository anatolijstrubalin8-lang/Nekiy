local replicated = game:GetService('ReplicatedStorage')

local b = require(replicated.Shared.choto)

local a = b.new(100)

a:beg()
local players = game:GetService('Players')

local player = players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')
local camera = workspace.CurrentCamera

local inputService = game:GetService('UserInputService')

inputService.InputBegan:Connect(function(input, processed)
    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        a:click()
        a:test()
        local tpCords = character.HumanoidRootPart.CFrame.LookVector * 25
      --  print(tpCords)
        a:tp(tpCords)
    end
end)

