

if EntityManager == nil then
	_G.EntityManager = class({})
end

EntityManager['INFO'] = {
	['VERSION'] = '0.26',
	['URL'] = 'https://github.com/CrAzD/DotaEntityManager',
	['DESCRIPTION'] = 'A library that automates and optimizes entities.'
}

EntityManager['entity'] = GameRules:GetGameModeEntity()
EntityManager['users'] = {} --Table that ties the userID to a specific player
EntityManager['players'] = {} --Table that holds everything for each player
EntityManager['developers'] = {} --Table that holds the steamids of developers
EntityManager['KV_FILES']['ABILITIES'] = LoadKeyValues('scripts/npc/npc_abilities_custom.txt') --Table that holds all ability data from the main ability KV
EntityManager['KV_FILES']['HEROES'] = LoadKeyValues('scripts/npc/npc_heroes_custom.txt') --Table that holds all unit data from the main unit KV
EntityManager['KV_FILES']['UNITS'] = LoadKeyValues('scripts/npc/npc_units_custom.txt') --Table that holds all hero data from the main hero KV

--[[
	A table of all required files for EntityManager, and a simple loop to require them all.
--]]
local REQUIRE = {
 	['events'] = {
 		'entity_killed',
		'game_rules_state_change'
	},
	['functions'] = {
		'AbilityAdd',
		'AbilityAddFast',
		'AbilityGetStartingLevel',
		'AbilityRemove',
		'AbilityRemoveFast',
		'AbilityReplace',
		'AbilityReplaceFast',
		'AbilityUpdateList',
		'EntityConfigure',
		'EntityCreate',
		'EntityCreateDummy',
		'EntityCreateUnit',
		'EntityDestroy',
		'EntityDestroyFast',
		'EntityReplaceHeroWith',
		'EntityUpdateVector',
		'PlayerConfigure'
	},
	['utilities'] = {
		'ParticleCleanup'
	}
}

for tFolder, tTable in pairs(REQUIRE) do
	for _, tFile in pairs(tTable) do
		require('libraries/EntityManager/'..tFolder..'/'..tFile)
	end
end