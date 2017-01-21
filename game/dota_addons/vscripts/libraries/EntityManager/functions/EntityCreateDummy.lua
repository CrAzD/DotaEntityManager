

function EntityManager:EntityCreateDummy(entityData, player)
	local dummy =  CreateUnitByName(entityData['name'], entityData['origin'], false, player['handle'], player, entityData['team'])

	for key, value in pairs(entityData) do
		dummy[key] = value or nil
	end

	dummy['effects'] = {}
	
	EntityManager:EntityConfigure(dummy, player)
	
	return(dummy)
end