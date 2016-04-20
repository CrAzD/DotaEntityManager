

function EntityManager:EntityConfigure(entity, player)
	-- General Variables
	entity['id'] = entity['id'] or entity:GetOwner():GetPlayerID()
	entity['name'] = entity['name'] or entity:GetUnitName()
	entity['team'] = entity['team'] or entity:GetTeam()
	entity['handle'] = entity['handle'] or entity:GetEntityHandle() or nil
	entity['hullRadius'] = entity['hullRadius'] or entity:GetHullRadius()
	entity['index'] = entity['index'] or entity:GetEntityIndex()

	entity['owningEntity'] = entity['owningEntity'] or entity:GetOwnerEntity() or nil
	entity['owningPlayer'] = entity['owningPlayer'] or entity:GetOwner() or nil
	entity['originalEntity'] = entity['owningEntity']
	entity['originalPlayer'] = entity['owningPlayer']

	entity['isUnit'] = entity['isUnit'] or false
	entity['isHero'] = entity['isHero'] or entity:IsHero() or false
	entity['isBuilding'] = entity['isBuilding'] or entity:IsBuilding() or false
	entity['type'] = entity['type'] or 'unit'
	entity['abilityPoints'] = entity['abilityPoints'] or 0

	entity['location'] = entity['location'] or entity:GetAbsOrigin()
	entity['x'] = entity['location']['x']
	entity['y'] = entity['location']['y']
	entity['z'] = entity['location']['z']
	entity['origin'] = entity['location']
	entity['effects'] = {}
	entity['effectsCount'] = -1

	-- Initial Ability Configuration
	entity['abilities'] = {
		['list'] = {}, 
		['count'] = -1
	}
	for i = 0, 15 do
		local ability = entity:GetAbilityByIndex(i) or nil
		if ability then
			entity['abilities']['count'] = entity['abilities']['count'] + 1

			ability:SetLevel(1)
			ability['cost'] = ability:GetGoldCost(-1)
			ability['name'] = ability:GetAbilityName()
			ability['caster'] = entity
			ability['position'] = entity['abilities']['count']
			ability['level'] = 1

			entity['abilities'][entity['abilities']['count']] = ability
			entity['abilities'][ability['name']] = ability
			entity['abilities']['list'][entity['abilities']['count']] = ability
		end
	end

	-- Hero entity configuration
	if string.find(entity['type'], 'hero') then
		entity:SetAbilityPoints(entity['abilityPoints'])
		entity['isHero'] = true
		entity['type'] = 'hero'
	end

	-- Building entity configuration
	if string.find(entity['type'], 'building') then
		entity['isBuilding'] = true
	end

	-- FindClearSpace and HullSize reset
	FindClearSpaceForUnit(entity, entity['location'], true)
	entity:SetHullRadius(entity['hullRadius'])
	entity:SetControllableByPlayer(entity['id'], true)

	-- Add entity to owning player entity table
	if type(player['entities']) == 'table' then
		entity['positionInPlayerEntityList'] = player['positionInPlayerEntityList'] + 1
		player['entities'][entity['positionInPlayerEntityList']] = entity
	else
		print('[Entity Manager] ERROR:  Cannot add entity to the owning player\'s table. Make sure players are setup before creating entities if possible.')
	end

	-- Entity Configuration Complete
	entity['isConfigured'] = true

	return(entity)
end