

if EntityManager == nil then
	_G.EntityManager = class({})
end

EntityManager['INFO'] = {
	['VERSION'] = '0.25',
	['URL'] = 'https://github.com/CrAzD/DotaEntityManager',
	['DESCRIPTION'] = 'A library that automates and optimizes entities.'
}

EntityManager['entity'] = GameRules:GetGameModeEntity()
EntityManager['users'] = {} --Table that ties the userID to a specific player
EntityManager['players'] = {} --Table that holds everything for each player
EntityManager['developers'] = {} --Table that holds the steamids of developers
EntityManager['KV_FILES']['ABILITIES'] = LoadKeyValues('scripts/npc/npc_abilities_custom.txt') --Table that holds all ability data from the main ability KV

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
		'AbilityRemove',
		'AbilityReplace',
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