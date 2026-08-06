local mapFolder = workspace.Map

local stage1 = mapFolder.Stage1

local stage1Part: Part = stage1.Stage1Part

local stage1Pos: Vector3 = stage1Part.Position


local function stage1Load()
    for i = 1,50 do
        local newPart = stage1Part:Clone()
        local newPartPos = stage1Pos + Vector3.new(stage1Pos.Z,0,0)
        newPart.Position = newPartPos
        newPart.Parent = stage1
    end

end



stage1Load()