

--[[
	EntityCreateUnit
		Creates and returns a configured entity.
]]--
function EntityManager:EntityCreateUnit(entity, player)
	local tEntity = CreateUnitByName(entity['name'], entity['origin'], true, entity['owningEntity'], entity['owningPlayer'], entity['team'])
	tEntity['name'] = entity['name'] or nil
	tEntity['origin'] = entity['origin'] or nil
	tEntity['owningEntity'] = entity['owningEntity'] or nil
	tEntity['owningPlayer'] = entity['owningPlayer'] or nil
	tEntity['team'] = entity['team'] or nil

	return(self:EntityConfigure(tEntity, player))
end