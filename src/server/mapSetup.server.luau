local mapFolder = workspace.Map

local stage1 = mapFolder.Stage1

local stage1Part: Part = stage1.Stage1Part

local stage1Pos: Vector3 = stage1Part.Position

local stage1Size: Vector3 = stage1Part.Size

local stage1Pos: Vector3 = stage1Part.Position

local function stage1Load() : ()
    for i = 1,50 do
        local newPart = stage1Part:Clone()
        local newPos = stage1Pos - Vector3.new(0,0, stage1Size.X) + Vector3.new(0,stage1Pos.Y * i * 0.7,0)
        newPart.Position = newPos
        newPart.Parent = stage1
        stage1Pos = newPos
    end 
end




stage1Load()