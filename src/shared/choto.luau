local choto = {
    speed = 0
}

choto.__index = choto

local players = game:GetService('Players')
local debris = game:GetService('Debris')

local runService = game:GetService('RunService')

local player = players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')

local rootPart = character.HumanoidRootPart

local camera = workspace.CurrentCamera



local mouse = player:GetMouse()

function choto.new(speed)
    local self = setmetatable({}, choto)
    self.speed = speed
    return self
end 

function choto:beg()
    local sp = self.speed
    humanoid.WalkSpeed = sp
    task.spawn(function()
        for i = sp,33,-1 do
            humanoid.WalkSpeed = i
            task.wait(0.1)
        end
    end)
end



function choto:click()
    local clickPosition = mouse.Hit.Position 
    local origin = rootPart.Position
    local throwSpeed = 25
    local launchVelocity = (clickPosition - origin).Unit * throwSpeed

    local arcArc = 15
    launchVelocity = launchVelocity + Vector3.new(0, arcArc, 0)
    local gravity = Vector3.new(0,-35,0)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character}


    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Anchored = true
    part.Parent = game.Workspace
    part.CanCollide = false
    params.FilterDescendantsInstances = {character, part}

    local t = 0
    local currentPos = origin
    local finalPos = origin

    local hitSomeone = false

    local connection
    connection = runService.RenderStepped:Connect(function(dt)
        t = t + 2 * dt 
        local nextPos = origin + (launchVelocity * t) + (0.5 * gravity * t ^ 2)
        local segmentDirection = nextPos - currentPos
        local raycastRes = workspace:Raycast(currentPos, segmentDirection, params)
        if raycastRes then
            connection:Disconnect()
            finalPos = raycastRes.Position + (raycastRes.Normal * 1)

            part.Position = finalPos
            rootPart.CFrame = CFrame.new(finalPos + Vector3.new(0, 3, 0))
            return
        end
        part.Position = nextPos
        currentPos = nextPos

        if t > 10 then
            connection:Disconnect()
            debris:AddItem(part, 0.5)
        end

    end)

end


function choto:test()
    warn('выполнено')
end


function choto:tp(coords)
    player.Character.HumanoidRootPart.Position += coords
end


return choto
