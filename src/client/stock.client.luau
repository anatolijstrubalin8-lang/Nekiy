local players = game:GetService('Players')


local player = players.LocalPlayer

local playerGui  = player.PlayerGui

local stockGui = playerGui.StockGui

local stockFrame = stockGui.StockFrame

local itemsFrame = stockFrame.ItemsFrame

local potionsFrame = stockFrame.PotionsFrame

local potItems = {}

for i,v in ipairs(potionsFrame:GetChildren()) do
    if v:isA('Frame') then
        table.insert(potItems,v)
    end
end

warn(potItems)
local replicated = game:GetService('ReplicatedStorage')

replicated:GetAttributeChangedSignal('currentStock'):Connect(function()
    warn('серый')
    local clientStock = string.split(replicated:GetAttribute('currentStock'),',')
    print(clientStock)
end)

warn('seriiiiiiiii')
-- ! ТУТ ФУНКЦИЮ ПОКУПКИ И НА СЕРВЕРЕ СПРАГШИВАЕМ