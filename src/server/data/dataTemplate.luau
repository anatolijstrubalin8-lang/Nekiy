--!strict

export type dataKeys = "Strength" | "Wins" | "Rebirths" | "Level" | "currentStrength" | 'needStrength' | 'currentPearl' | 'lastStock' | 'lastSeed' | 'StrengthPotion1' | 'WinsPotion1' | 'inventory'

export type PlayerData = {
	Wins: number,
	Strength: number,
	Rebirths: number,
	Level: number,
	currentStrength: number,
	needStrength: number,
	currentPearl: number,
	lastStock: any,
	inventory: {
		StrengthPotion1: number,
		WinsPotion1: number,
	},
	StrengthPotion1: number,
	WinsPotion1: number,
	lastSeed: any,
}




local Template: PlayerData = {
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
    StrengthPotion1 = 0,
    WinsPotion1 = 0,
    lastSeed = false,
} 

return Template