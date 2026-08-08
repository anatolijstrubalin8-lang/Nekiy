local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local soundService = game:GetService("SoundService")
local runService = game:GetService("RunService")

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(newChar)
    character = newChar
end)

local keycaps = {}
local currentKeycaps = {}

-- Новые таблицы для хранения стартовых позиций и неподвижных сенсоров
local originalPositions = {}
local keySensors = {} 

-- Инициализация: сканируем Workspace и настраиваем кнопки
for _, keycap in ipairs(workspace:GetDescendants()) do
    if keycap.Name == 'keycap' and keycap:IsA('Model') then
        local cube = keycap:FindFirstChild("Cube")
        if cube and cube:IsA("MeshPart") then
            keycaps[keycap] = cube
            
            cube.Anchored = true
            cube.CanCollide = false
            
            -- Запоминаем оригинальную позицию один раз при старте
            originalPositions[cube] = cube.Position
            
            -- СОЗДАЕМ НЕВИДИМЫЙ СЕНСОР (он выше куба и никогда не будет двигаться)
            local sensor = Instance.new("Part")
            sensor.Size = cube.Size + Vector3.new(0, 4, 0) -- делаем его на 4 studs выше
            sensor.CFrame = cube.CFrame + Vector3.new(0, 2, 0) -- приподнимаем зону детекции вверх
            sensor.Transparency = 1
            sensor.CanCollide = false
            sensor.Anchored = true
            sensor.Parent = cube
            
            keySensors[cube] = sensor
        end
    end
end

local sound = soundService:FindFirstChild("keycap")
local tInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Настраиваем фильтр только на нашего персонажа
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.FilterDescendantsInstances = {character}

player.CharacterAdded:Connect(function(newChar)
    overlapParams.FilterDescendantsInstances = {newChar}
end)

-- Касание клавиши
for keycap, cube in pairs(keycaps) do
    local origPos = originalPositions[cube]
    local newPos = origPos - Vector3.new(0, 0.8, 0)
    
    cube.Touched:Connect(function(hit)
        if hit:IsDescendantOf(character) then
            -- Если клавиша еще не нажата (ее нет в активном списке)
            if currentKeycaps[cube] == nil then
                currentKeycaps[cube] = origPos -- записываем оригинальную позицию
                
                if sound then
                    sound:Play() -- Проигрываем звук строго 1 раз!
                end
                
                tweenService:Create(cube, tInfo, {Position = newPos}):Play()
            end
        end
    end)
end

-- Обработка отпускания клавиш в цикле Heartbeat
runService.Heartbeat:Connect(function(dt)
    for cube, pos in pairs(currentKeycaps) do
        -- Находим неподвижный высокий сенсор для этой клавиши
        local sensor = keySensors[cube]
        
        -- Проверяем пересечение с НЕПОДВИЖНЫМ сенсором!
        local parts = workspace:GetPartsInPart(sensor, overlapParams)
        
        -- Если в зоне сенсора пусто, значит игрок полностью сошел с клавиши
        if #parts == 0 then
            currentKeycaps[cube] = nil -- убираем из активных в цикле
            tweenService:Create(cube, tInfo, {Position = pos}):Play()
        end
    end
end)