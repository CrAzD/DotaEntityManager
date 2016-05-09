

--[[
	EntityCreateUnit
		Creates and returns a configured entity.
]]--
function EntityManager:EntityCreateUnit(entity, player)
	local tEntity = CreateUnitByName(entity['name'], entity['origin'], true, entity['owningEntity'], entity['owningPlayer'], entity['team'])

	for key, value in pairs(entity) do
		tEntity[key] = value
	end
	tEntity['name'] = entity['name'] or entity:GetUnitName() or nil

	return(self:EntityConfigure(tEntity, player))
end