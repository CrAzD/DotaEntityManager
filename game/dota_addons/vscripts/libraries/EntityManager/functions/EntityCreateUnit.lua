

--[[
	EntityCreateUnit
		Creates and returns a configured entity.
]]--

function EntityManager:EntityCreateUnit(entity, player)
	return(self:EntityConfigure(CreateUnitByName(entity['name'], entity['origin'], true, entity['owningEntity'], entity['owningPlayer'], entity['team']), player))
end