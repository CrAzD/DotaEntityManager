

function EntityManager:Entity(entity, player)
	-- Functions
	function entity.AbilityConfigure(ability)
		ability['name'] = ability['name'] or ability:GetAbilityName() or nil

		local kvTable = self['KV_FILES']['ABILITIES'][ability['name']] or nil
		if kvTable then
			for key, variable in pairs(kvTable) do
				ability[key] = variable or nil
			end
		end

		ability['caster'] = ability['caster'] or entity
		ability['position'] = entity['abilities']['count']

		ability['startingLevel'] = ability['startingLevel'] or 0
		ability:SetLevel(ability['startingLevel'])
		ability['cost'] = ability:GetGoldCost(-1) or ability['cost'] or  0
		return(ability)
	end

	function entity.AbilityAdd(abilityName)
		if not type(abilityName) == 'string' then
			self:Error('\'abilityName\' parameter must be a string.')
			return nil

		local kvAbility = self['KV_FILES']['ABILITIES'][abilityName] or nil
		if not kvAbility then
			self:Error('\'abilityName\' does not exist in the KV_FILE table, check spelling.')
			return nil

		entity:AddAbility(abilityName)

		local ability = entity:FindAbilityByName(abilityName) or nil
		if not ability then
			self:Error(abilityName..' was not added to '..entity['name']..'.')
			return nil
		else
			ability['name'] = abilityName

			entity.AbilityConfigure(ability)
			entity.AbilityListRefresh()
			return true
		end
	end

	function entity.AbilityRemove(ability)
		if not type(ability) == 'table' then
			self:Error('the ability parameter must be a table/object, not a '..type(ability)..'.')
			return false

		local abilityOld = {
			['name'] = ability['name'],
			['position'] = ability['position']
		}

		entity:RemoveAbility(abilityOld['name'])
		entity['abilities'][abilityOld['position']] = nil
		entity['abilities'][abilityOld['name']] = nil
		entity['abilities']['list'][abilityOld['position']] = nil
		entity['abilities']['count'] = entity['abilities']['count'] - 1

		entity.AbilityListRefresh()
		return true
	end

	function entity.AbilityReplace(abilityOld, abilityNew)
		if not type(abilityOld) == 'table' then
			self:Error('abilityOld parameter must be a table/object. It\'s currently a '..tostring(abilityOld))
			return false

		if not type(abilityNew) == 'string' then
			self:Error('abilityNew parameter must be a string. It\'s currently a '..tostring(abilityNew))
			return false

		entity.AbilityRemove(abilityOld)
		entity.AbilityAdd(abilityNew)
		return true
	end

	function entity.AbilityListRefresh()
		local listOld = entity['abilities']['list']
		entity['abilities']['list'] = {}
		entity[abilities]['count'] = -1

		for i=0, #listOld do
			local ability = listOld[i]
			ability['position'] = i

			entity['abilities']['count'] = entity['abilities']['count'] + 1

			entity['abilities'][i] = ability
			entity['abilities'][ability['name']] = ability
			entity['abilities']['list'][i] = ability
		end
		return
	end

	function entity.LocationUpdate()
		entity['location'] = entity:GetAbsOrigin() or {0, 0, 0}
		entity['loc'] = entity['location'] or {0, 0, 0}
		entity['x'] = entity['origin']['x'] or 0
		entity['y'] = entity['origin']['y'] or 0
		entity['z'] = entity['origin']['z'] or 0
		return true
	end

	-- Read and insert varaibles found in the table of the KV file(s)
	local kvTypes = {[0] = 'UNITS', [1] = 'HEROES'}
	for i = 0, 1 do
		local kvTable = self['KV_FILES'][kvTypes[i]][entity['name']] or nil
		if kvTable then
			for key, value in pairs(kvTable) do
				entity[key] = value or nil
			end
		end
	end

	-- General Variables
	local owner = entity:GetOwner()
	local playerID = owner:GetPlayerID()

	entity['id'] = entity['id'] or playerID or nil
	entity['team'] = entity['team'] or entity:GetTeam() or nil
	entity['handle'] = entity['handle'] or entity:GetEntityHandle() or nil
	entity['hullRadius'] = entity['hullRadius'] or entity:GetHullRadius() or nil
	entity['index'] = entity['index'] or entity:GetEntityIndex() or nil

	entity['owningEntity'] = entity['owningEntity'] or entity:GetOwnerEntity() or nil
	entity['owningPlayer'] = entity['owningPlayer'] or owner or nil

	entity['type'] = entity['type'] or self['defaultEntityType'] or 'unit'

	entity['isUnit'] = entity['isUnit'] or false
	entity['isHero'] = entity['isHero'] or entity:IsHero() or false

	entity['abilityPoints'] = entity['abilityPoints'] or 0

	entity['orgin'] = entity['origin'] or entity:GetAbsOrigin() or {0, 0, 0}
	entity['location'] = entity['origin'] or {0, 0, 0}
	entity['loc'] = entity['location'] or {0, 0, 0}
	entity['x'] = entity['origin']['x'] or 0
	entity['y'] = entity['origin']['y'] or 0
	entity['z'] = entity['origin']['z'] or 0

	entity['effects'] = {['count'] = -1}

	-- Initial ability setup & configuration
	entity['abilities'] = {
		['list'] = {},
		['count'] = -1
	}
	for i = 0, 15 do
		local abilityTemp = entity:GetAbilityByIndex(i) or nil
		if abilityTemp then
			local ability = entity.AbilityConfigure(abilityTemp)

			entity['abilities']['count'] = entity['abilities']['count'] + 1

			ability['position'] = entity['abilities']['count']

			entity['abilities'][ability['name']] = ability
			entity['abilities'][ability['position']] = ability
			entity['abilities']['list'][ability['position']] = ability
		end
	end

	-- Initial hero setup & configuration
	if entity['isHero'] then
		entity:SetAbilityPoints(entity['abilityPoints'])
		entity['type'] = 'hero'
	end

	-- FindClearSpace and HullSize reset
	entity:SetHullRadius(20)
	FindClearSpaceForUnit(entity, entity['location'], true)
	entity:SetHullRadius(entity['hullRadius'])
	entity:SetControllableByPlayer(entity['id'], true)

	-- Insert entity into owning player
	if player['entities'] then
		entity['positionInPlayerEntityList'] = player['positionInPlayerEntityList'] + 1
		player['entities'][entity['positionInPlayerEntityList']] = entity
	else
		print('[Entity Manager] ERROR:  Cannot add entity to the owning player\'s table. Setup players before creating entities and/or using the EntityManager.')
	end

	-- Entity is configured, finishing touch(s)
	entity['isConfigured'] = true
	return(entity)
end