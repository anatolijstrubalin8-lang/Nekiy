--!strict
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local soundService = game:GetService("SoundService")

local runService = game:GetService("RunService")


local keycaps: {[Model]: BasePart} = {}

local currentKeycaps = {}


for _, keycap in ipairs(workspace:GetDescendants()) do
    if keycap.Name == 'keycap' and keycap:IsA('Model') then
        local cube = keycap:FindFirstChild("Cube")
        if cube and cube:IsA("MeshPart") then
            keycaps[keycap] = cube
        end
    end
end

local sound = soundService:FindFirstChild("keycap")

local tInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

for keycap,cube in pairs(keycaps) do
    cube.Touched:Connect(function()
        currentKeycaps[cube] = true

    end)
end


runService.Heartbeat:Connect(function(dt)
    for cube,state in pairs(currentKeycaps) do
        local parts = workspace:GetPartsInPart(cube)
        for _,part in ipairs(parts) do
            if part.Name == "HumanoidRootPart" then
                local player = players:GetPlayerFromCharacter(part.Parent)
                if player then
                    tweenService:Create(cube, tInfo, {Position = cube.Position - Vector3.new(0,0.8,0)}):Play()
                    if sound then
                        sound:Play()
                    end
                end
            else
                currentKeycaps[cube] = nil
                tweenService:Create(cube, tInfo, {Position = cube.Position + Vector3.new(0,0.8,0)}):Play()
            end
        end
    end
end)