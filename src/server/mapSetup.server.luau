local mapFolder = workspace.Map

local stage1 = mapFolder.Stage1

local stage1Part: Part = stage1.Stage1Part

local stage1Pos: Vector3 = stage1Part.Position

local stage1Size: Vector3 = stage1Part.Size

local stage1Pos: Vector3 = stage1Part.Position

local function stage1Load() : ()
    local newPart = stage1Part:Clone()
    local newPos = stage1Pos + stage1Size.X
end




