local choto = {
    speed = 0
}

choto.__index = choto

local players = game:GetService('Players')

local player = players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()

local humanoid = character:WaitForChild('Humanoid')


function choto.new(speed)
    local self = setmetatable({}, choto)
    self.speed = speed
    return self
end 

function choto:beg()
    local sp = self.speed
    humanoid.WalkSpeed = sp
    for i = sp,0,-1 do
        humanoid.WalkSpeed = i
        task.wait(0.1)
    end
end
return choto
