

function EntityManager:EntityCreateDummy(entity, player)
	local dummy =  CreateUnitByName(entity['name'], entity['origin'], false, player['handle'], player, entity['team'])
	dummy['effects'] = {}
	
	return(dummy)
end