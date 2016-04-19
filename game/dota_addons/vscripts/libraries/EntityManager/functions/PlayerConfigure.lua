

--[[
	PlayerConfigure
		Initial player configuration.
		Stores everything related to a player in the player's entity, rather than constantly calling functions and wasting resources.
]]--

function EntityManager:PlayerConfigure(player)
	-- General variables used for players
	player['id'] = player['id'] or player:GetPlayerID()
	player['hero'] = player['hero'] or {}
	player['team'] = player['team'] or PlayerResource:GetTeam(player['id'])
	player['handle'] = player['handle'] or PlayerResource:GetPlayer(player['id'])
	player['name'] = player['name'] or PlayerResource:GetPlayerName(player['id'])
	player['entities'] = player['entities'] or {}

	-- Custom generic variables
	player['units'] = player['units'] or {}
	player['structures'] = player['structures'] or {}
	player['gold'] = player['gold'] or 0
	player['population'] = player['population'] or {['current'] = 0, ['maximum'] = 0}
	player['positionInPlayerEntityList'] = -1

	-- Island Defense specific configuration
	if IslandDefense then
		player['lumber'] = player['lumber'] or 0
		player['upgrades'] = player['upgrades'] or {}
		if player['team'] == 2 then
			player['faction'] = 'Builder'
		else
			player['faction'] = 'Titan'
		end
	end

	-- Player configuration complete
	player['configured'] = true

	return(player)
end