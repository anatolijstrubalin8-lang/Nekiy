--!strict

export type dataKeys = "Strength" | "Wins" | "Rebirths" | "Level" | "currentStrength" | 'needStrength' | 'currentPearl' | 'lastStock' | 'lastSeed' | 'StrengthPotion1' | 'WinsPotion1' | 'inventory'

local Template = {
    Wins = 0,
    Strength = 0,
    Rebirths = 0,
    Level = 1,
    currentStrength = 0,
    needStrength = 1000,
    currentPearl = 1,
    lastStock = false,
    inventory = {
        StrengthPotion1 = 0,
        WinsPotion1 = 0,

    },
    lastSeed = false,
} 

return Template