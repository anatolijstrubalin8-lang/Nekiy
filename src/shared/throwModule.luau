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
local rootPart = character:WaitForChild('HumanoidRootPart')

local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

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

    local throwSpeed = 25 -- ! ТУТА
    local timeScale = 2.4 -- ! ТУТА
    local arcHeight = 15 -- ! ТУТА
   
    local launchVelocity = (clickPosition - origin).Unit * throwSpeed
    launchVelocity = launchVelocity + Vector3.new(0, arcHeight, 0)
    local gravity = Vector3.new(0,-35,0)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude


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
        
        t = t + timeScale * dt 
        local nextPos = origin + (launchVelocity * t) + (0.5 * gravity * t ^ 2)
        local segmentDirection = nextPos - currentPos
        local raycastRes = workspace:Raycast(currentPos, segmentDirection, params)

        if raycastRes then
            connection:Disconnect()
            finalPos = raycastRes.Position + (raycastRes.Normal * 1)
            hitSomeone = true
            part.Position = finalPos
            rootPart.CFrame = CFrame.new(finalPos + Vector3.new(0, 3, 0))
            debris:AddItem(part, 0.5)
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
