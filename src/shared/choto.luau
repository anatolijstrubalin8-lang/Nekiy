local choto = {
    speed = 0
}

choto.__index = choto

local players = game:GetService('Players')

local player = players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')

local rootPart = character.HumanoidRootPart

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

local mouse = player:GetMouse()

function choto:click()
    local clickPosition = mouse.Hit.Position 
 --   local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)
   -- print(1, ray)
    local origin = rootPart.Position
    local direction = (clickPosition - origin.Unit) * 50
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character}

    local raycastRes = workspace:Raycast(origin, direction, params)
    if raycastRes then
        finalPos = raycastRes.Position
    else
        finalPos = origin + direction
    end


    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = finalPos
    part.Anchored = true
    part.Parent = game.Workspace

end

function choto:test()
    warn('выполнено')
end


function choto:tp(coords)
    player.Character.HumanoidRootPart.Position += coords
end


return choto
