local throwModule = {
    throwSpeed = 0,
    timeScale = 0,
    arcHeight = 0
}

throwModule.__index = throwModule

local players = game:GetService('Players')
local debris = game:GetService('Debris')
local runService = game:GetService('RunService')

local player = players.LocalPlayer

local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

function throwModule.new(throwSpeed: number, timeScale: number, arcHeight: number)
    local self = setmetatable({}, throwModule)
    self.throwSpeed = throwSpeed
    self.timeScale = timeScale
    self.arcHeight = arcHeight
    return self
end 

function throwModule:throw()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild('Humanoid')
    local rootPart = character:WaitForChild('HumanoidRootPart')
    local clickPosition = mouse.Hit.Position 
    local origin = rootPart.Position

    local throwSpeed = self.throwSpeed -- ! ТУТА
    local timeScale = self.timeScale -- ! ТУТА
    local arcHeight = self.arcHeight -- ! ТУТА
   
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

function throwModule:test()
    warn('выполнено')
end

return throwModule
