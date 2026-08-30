local players = game:GetService('Players')
local debris = game:GetService('Debris')
local runService = game:GetService('RunService')
local replicated = game:GetService('ReplicatedStorage')

local camera = workspace.CurrentCamera

local throwServer = replicated.throwServerEvent

local self = {
    throwSpeed = 10,
    timeScale = 2.4,
    arcHeight = 15
}

local strengthMultiplierDivider = 2
local strengthHeightDivider = 4
local strengthTimeDivider = 6

throwServer.OnServerEvent:Connect(function(player,clickPosition)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild('Humanoid')
    local rootPart = character:WaitForChild('HumanoidRootPart')

    local origin = rootPart.Position
    local leaderstats = player:WaitForChild('leaderstats')

    local strength = leaderstats:WaitForChild('Strength').Value

    local strengthMltiplier = 1 + (math.log10(strength+1) / strengthMultiplierDivider)
    local strengthHeight = 1 + (math.log10(strength+1) / strengthHeightDivider)
    local strengthTime = 1 + (math.log10(strength+1) / strengthTimeDivider)  * 0.001

    local throwSpeed = self.throwSpeed * strengthMltiplier -- ! ТУТА
    local timeScale = self.timeScale * strengthTime -- ! ТУТА
    local arcHeight = self.arcHeight *strengthHeight -- ! ТУТА
   
    local launchVelocity = (clickPosition - origin).Unit * throwSpeed
    launchVelocity = launchVelocity + Vector3.new(0, arcHeight, 0)
    local gravity = Vector3.new(0,-35,0)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude

    params.FilterDescendantsInstances = {character}

    local t = 0
    local currentPos = origin
    local finalPos = origin

    local hitSomeone = false

    local connection
    connection = runService.Heartbeat:Connect(function(dt)
        
        t = t + timeScale * dt 
        local nextPos = origin + (launchVelocity * t) + (0.5 * gravity * t ^ 2)
        local segmentDirection = nextPos - currentPos
        local raycastRes = workspace:Raycast(currentPos, segmentDirection, params)

        if raycastRes then
            connection:Disconnect()
            finalPos = raycastRes.Position + (raycastRes.Normal * 1)
            hitSomeone = true
            rootPart.CFrame = CFrame.new(finalPos + Vector3.new(0, 3, 0))
            return
        end
        currentPos = nextPos

        if t > 10 then
            connection:Disconnect()

        end

    end)

end)
