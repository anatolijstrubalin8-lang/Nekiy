-- local mapFolder = workspace.Map

-- local stage1 = mapFolder.Stage1

-- local stage1Part: Part = stage1.Stage1Part

-- local stage1Pos: Vector3 = stage1Part.Position

-- local stage1Size: Vector3 = stage1Part.Size

-- local stage1Pos: Vector3 = stage1Part.Position

-- local function stage1Load() : ()
--     for i = 1,50 do
--         local newPart = stage1Part:Clone()
--         local newPos = stage1Pos - Vector3.new(0,0, stage1Size.X) + Vector3.new(0, stage1Size.Y*0.1 * i*12 ,0)
--         --local newSize = stage1Size + Vector3.new(0, i*10, 0)
--         newPart.Position = newPos
--       --  newPart.Size = newSize
--       --  stage1Size = newSize
--         newPart.Parent = stage1
--         stage1Pos = newPos
--     end 
-- end




stage1Load()