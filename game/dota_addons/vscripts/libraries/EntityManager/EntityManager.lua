

if EntityManager == nil then
	_G.EntityManager = class({})
end

EntityManager['INFO'] = {
	['VERSION'] = '0.31',
	['URL'] = 'https://github.com/CrAzD/DotaEntityManager',
	['DESCRIPTION'] = 'A library that optimizes entities by storing the most commonly used data inside them. Rather than constantly firing functions for name/team/owner/etc, that data is stored directly in the entity.'
}

EntityManager['entity'] = GameRules:GetGameModeEntity()
EntityManager['users'] = {} --Table that ties the userID to a specific player
EntityManager['players'] = {} --Table that holds everything for each player
EntityManager['KV_FILES'] = {
	['ABILITIES'] = LoadKeyValues('scripts/npc/npc_abilities_custom.txt'), --Table that holds all ability data from the main ability KV
	['HEROES'] = LoadKeyValues('scripts/npc/npc_heroes_custom.txt'), --Table that holds all unit data from the main unit KV
	['UNITS'] = LoadKeyValues('scripts/npc/npc_units_custom.txt') --Table that holds all hero data from the main hero KV
}
EntityManager['defaultEntityType'] = 'unit'
--[[
	A table of all required files for EntityManager, and a simple loop to require them all.
--]]
local REQUIRE = {
 	['events'] = {
 		'entity_killed',
		'game_rules_state_change'
	},
	['functions'] = {
		'EntityConfigure',
		'EntityCreate',
		'EntityCreateDummy',
		'EntityCreateUnit',
		'EntityDestroy',
		'EntityDestroyFast',
		'EntityReplaceHeroWith',
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

require('libraries/EntityManager/Settings')