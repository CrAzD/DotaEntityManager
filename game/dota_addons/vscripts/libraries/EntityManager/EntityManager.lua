

if EntityManager == nil then
	_G.EntityManager = class({})
end

EntityManager['INFO'] = {
	['VERSION'] = '0.02',
	['URL'] = 'https://github.com/CrAzD/DotaEntityManager',
	['DESCRIPTION'] = ''
}

EntityManager['users'] = {} --Table that ties the userID to a specific player
EntityManager['players'] = {} --Table that holds everything for each player
EntityManager['developers'] = {} --Table that holds the steamids of developers.

--[[
	Put all lua files that need to be required here.
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
		'EntityCreateTavern',
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