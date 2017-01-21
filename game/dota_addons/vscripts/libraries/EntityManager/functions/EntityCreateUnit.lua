

--[[
	EntityCreateUnit
		Creates and returns a configured entity.

		local entity = EntityManager:EntityCreateUnit(entityData, player)

		entityData: Table
			name: string		[entity_name (NOT display name)]
			origin: float 		[coordinates (x,y,z)]
			owningEntity: table [the entity that is the owner/parent]
			owningPlayer: table [the player/entity that is the owner/parent]
			team: integer 		[team the entity belongs to]


]]--
function EntityManager:EntityCreateUnit(entityData, player)
	local entityTemp = CreateUnitByName(entityData['name'], entityData['origin'], true, entityData['owningEntity'], entityData['owningPlayer'], entityData['team'])

	for key, value in pairs(entityData) do
		entityTemp[key] = value or nil
	end

	local entityConfigured = self:Entity(entityTemp, player)

	return(entityConfigured)
end


--[[ OLD, Outdated, Leaving here until 1.0 for reasons
function EntityManager:EntityCreateUnit(entity, player)
	local tEntity = CreateUnitByName(entity['name'], entity['origin'], true, entity['owningEntity'], entity['owningPlayer'], entity['team'])

	for key, value in pairs(entity) do
		tEntity[key] = value
	end
	tEntity['name'] = entity['name'] or entity:GetUnitName() or nil

	return(self:EntityConfigure(tEntity, player))
end
]]--