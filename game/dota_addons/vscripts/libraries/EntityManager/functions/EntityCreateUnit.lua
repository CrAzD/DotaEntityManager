

function EntityManager:EntityCreateUnit(entity, player)
	return(EntityManager:EntityConfigure(CreateUnitByName(entity['name'], entity['origin'], true, entity['owningEntity'], entity['owningPlayer'], entity['team']), player))
end