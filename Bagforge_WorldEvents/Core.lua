--[[
	Bagforge_WorldEvents - Core
	-------------------------------------------------------------------------
	Registers the world events categories with Bagforge.API.
--]]

local _, addon = ...

local string = string
local pairs, ipairs = pairs, ipairs

-- Wait for Bagforge to be loaded and have API ready.
local API = Bagforge and Bagforge.API
if not API then
	return
end

local L = addon.L
local Database = addon.Database

local color_Noblegarden = "|cffffb3d9"
local color_DarkmoonFaire = "|cff9b59b6"
local color_LunarFestival = "|cffff2222"
local color_Midsummer = "|cffff5500"
local color_Brewfest = "|cffd35400"
local color_Remix = "|cff1DDB7F"
local color_RadiantEchoes = "|cff81ecec"
local color_Anniversary = "|cff1dc7db"
local color_HallowsEnd = "|cffff8000"
local color_WinterVeil = "|cff2ecc71"
local color_LoveIsInTheAir = "|cffff75a0"
local color_Fortune = "|cffe5c158"
local color_Duos = "|cff74b9ff"
local color_Emissary = "|cffd63031"
local resetColor = "|r"

-- Category Mapping: maps database key to localized display name, color prefix, and clean plugin option source name
local categoryMappings = {
	{ key = "noblegarden", list = Database.Noblegarden, name = L:Get("Noblegarden"), color = color_Noblegarden },
	{ key = "darkmoonfaire", list = Database.Darkmoonfaire, name = L:Get("Darkmoon Faire"), color = color_DarkmoonFaire },
	{ key = "lunarfestival", list = Database.LunarFestival, name = L:Get("Lunar Festival"), color = color_LunarFestival },
	{ key = "midsummerfirefestival", list = Database.MidsummerFireFestival, name = L:Get("Midsummer Fire Festival"), color = color_Midsummer },
	{ key = "brewfest", list = Database.Brewfest, name = L:Get("Brewfest"), color = color_Brewfest },
	{ key = "wowremix", list = Database.WoWRemix, name = L:Get("Remix"), color = color_Remix },
	{ key = "wowremixcache", list = Database.WoWRemixCache, name = L:Get("Remix: Cache"), color = color_Remix },
	{ key = "wowremixartifact", list = Database.WoWRemixArtifact, name = L:Get("Remix: Artifact"), color = color_Remix },
	{ key = "wowremixreputation", list = Database.WoWRemixReputation, name = L:Get("Remix: Reputation"), color = color_Remix },
	{ key = "wowremixbuff", list = Database.WoWRemixBuff, name = L:Get("Remix: Buff"), color = color_Remix },
	{ key = "radiantechoes", list = Database.RadiantEchoes, name = L:Get("Radiant Echoes"), color = color_RadiantEchoes },
	{ key = "wow20thanniversary", list = Database.WoW20thAnniversary, name = L:Get("20th Anniversary"), color = color_Anniversary },
	{ key = "hallowsend", list = Database.HallowsEnd, name = L:Get("Hallow's End"), color = color_HallowsEnd },
	{ key = "feastofwinterveil", list = Database.FeastOfWinterVeil, name = L:Get("Feast of Winter Veil"), color = color_WinterVeil },
	{ key = "loveisintheair", list = Database.LoveIsInTheAir, name = L:Get("Love is in the Air"), color = color_LoveIsInTheAir },
	{ key = "windsofmysteriousfortune", list = Database.WindsOfMysteriousFortune, name = L:Get("Winds of Mysterious Fortune"), color = color_Fortune },
	{ key = "dastardlyduos", list = Database.DastardlyDuos, name = L:Get("Dastardly Duos"), color = color_Duos },
	{ key = "agreedyemissary", list = Database.AGreedyEmissary, name = L:Get("A Greedy Emissary"), color = color_Emissary },
}

-- Register each category
for _, mapping in ipairs(categoryMappings) do
	local lookup = {}
	for _, itemID in ipairs(mapping.list) do
		lookup[itemID] = true
	end

	-- Key pattern is e.g. "bagforge_worldevents.noblegarden"
	-- Source name is e.g. "World Events: Noblegarden" (without color codes so the Settings UI lists it cleanly)
	-- Category name shown in bag is colored, e.g. "|cffa5a5ffNoblegarden|r"
	API:RegisterCategory({
		key = "bagforge_worldevents." .. mapping.key,
		source = "World Events: " .. mapping.name,
		name = mapping.color .. mapping.name .. resetColor,
		order = 16.0,
		filter = function(entry)
			local itemID = entry.itemID
			if itemID and lookup[itemID] then
				return true
			end
			return false
		end,
	})
end
