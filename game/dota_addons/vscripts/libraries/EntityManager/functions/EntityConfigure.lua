

function EntityManager:EntityConfigure(entity, player)
	-- Insert variables from the KV file table
	if self['KV_FILES']['UNITS'][entity['name']] then
		for key, variable in pairs(self['KV_FILES']['UNITS'][entity['name']]) do
			entity[key] = variable
		end
	end
	if self['KV_FILES']['HEROES'][entity['name']] then
		for key, variable in pairs(self['KV_FILES']['HEROES'][entity['name']]) do
			entity[key] = variable
		end
	end

	-- General Variables
	entity['id'] = entity['id'] or entity:GetOwner():GetPlayerID()
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

			ability['name'] = ability:GetAbilityName()
			ability:SetLevel(self:AbilityGetStartingLevel(ability))
			ability['cost'] = ability:GetGoldCost(-1)
			ability['caster'] = entity
			ability['position'] = entity['abilities']['count']

			entity['abilities'][ability['name']] = ability
			entity['abilities'][ability['position']] = ability
			entity['abilities']['list'][ability['position']] = ability
		end
	end

	-- Hero entity configuration
	if entity['isHero'] then
		entity:SetAbilityPoints(entity['abilityPoints'])
		entity['isHero'] = true
		entity['type'] = 'hero'
	end

	-- FindClearSpace and HullSize reset
	FindClearSpaceForUnit(entity, entity['location'], true)
	entity:SetHullRadius(entity['hullRadius'])
	entity:SetControllableByPlayer(entity['id'], true)

	-- Add entity to owning player entity table
	if player['entities'] then
		entity['positionInPlayerEntityList'] = player['positionInPlayerEntityList'] + 1
		player['entities'][entity['positionInPlayerEntityList']] = entity
	else
		print('[Entity Manager] ERROR:  Cannot add entity to the owning player\'s table. If possible setup players before creating entities.')
	end

	-- Entity Configuration Complete
	entity['isConfigured'] = true

	return(entity)
end