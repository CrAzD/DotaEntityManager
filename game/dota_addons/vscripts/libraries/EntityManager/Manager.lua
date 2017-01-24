

--[[
]]--
function EntityManagerInitialization(manager)
	--[[
		Manager ENTITY
	]]--
	function manager.Entity(entity, player)
		-- Functions
		function entity.AbilityConfigure(ability)
			ability['name'] = ability['name'] or ability:GetAbilityName() or nil

			local kvTable = manager['kv']['abilities'][ability['name']] or nil
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
				manager.Error('\'abilityName\' parameter must be a string. It\'s currently a '..tostring(type(abilityName)))
				return nil
			end

			local kvAbility = manager['kv']['abilities'][abilityName] or nil
			if not kvAbility then
				manager.Error('\'abilityName\' does not exist in the KV_FILE table, check spelling.')
				return nil
			end

			entity:AddAbility(abilityName)

			local ability = entity:FindAbilityByName(abilityName) or nil
			if not ability then
				manager.Error(tostring(abilityName)..' was not added to '..entity['name']..'.')
				return nil
			else
				ability['name'] = abilityName

				entity.AbilityConfigure(ability)

				entity['abilities']['count'] = entity['abilities']['count'] + 1

				ability['position'] = entity['abilities']['count']

				entity['abilities'][ability['name']] = ability
				entity['abilities'][ability['position']] = ability
				entity['abilities']['list'][ability['position']] = ability

				entity.AbilityListRefresh()
				return ability
			end
		end

		function entity.AbilityRemove(ability)
			if not type(ability) == 'table' then
				manager.Error('the ability parameter must be a table/object, not a '..tostring(type(ability))..'.')
				return false
			end

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
				manager.Error('abilityOld parameter must be a table/object. It\'s currently a '..tostring(type(abilityOld)))
				return false
			end

			if not type(abilityNew) == 'string' then
				manager.Error('abilityNew parameter must be a string. It\'s currently a '..tostring(type(abilityNew)))
				return false
			end

			local abilityRemoved = {
				['name'] = abilityOld['name'],
				['position'] = abilityOld['position']
			}

			entity:RemoveAbility(abilityRemoved['name'])
			entity['abilities'][abilityRemoved['position']] = nil
			entity['abilities'][abilityRemoved['name']] = nil
			entity['abilities']['list'][abilityRemoved['position']] = nil
			entity['abilities']['count'] = entity['abilities']['count'] - 1

			entity.AbilityAdd(abilityNew)
			return true
		end

		function entity.AbilityListRefresh()
			local listOld = entity['abilities']['list']
			entity['abilities']['list'] = {}
			entity['abilities']['count'] = -1

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

		function entity.LocationRefresh()
			entity['location'] = entity:GetAbsOrigin() or {0, 0, 0}
			entity['loc'] = entity['location'] or {0, 0, 0}
			entity['x'] = entity['origin']['x'] or 0
			entity['y'] = entity['origin']['y'] or 0
			entity['z'] = entity['origin']['z'] or 0
			return(entity['location'])
		end

		-- KV Variables
		local kvTable = manager['kv']['entities'][entity['name']] or nil
		if kvTable then
			for key, value in pairs(kvTable) do
				entity[key] = value or nil
			end
		end

		-- General Variables
		entity['id'] = entity['id'] or entity:GetOwner():GetPlayerID() or nil
		entity['team'] = entity['team'] or entity:GetTeam() or nil
		entity['handle'] = entity['handle'] or entity:GetEntityHandle() or nil
		entity['hullRadius'] = entity['hullRadius'] or entity:GetHullRadius() or nil
		entity['index'] = entity['index'] or entity:GetEntityIndex() or nil

		entity['owningEntity'] = entity['owningEntity'] or entity:GetOwnerEntity() or nil
		entity['owningPlayer'] = entity['owningPlayer'] or entity:GetOwner() or nil

		entity['type'] = entity['type'] or 'unit'

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
		elseif not entity['id'] == -123 then
			manager.Error('Cannot add entity to owning player, verify player has been configured. \nIf this is a dummy unit use -123 as the id.')
		end

		-- Entity is configured, finishing touch(s)
		entity['entityConfigured'] = true
		return(entity)
	end


	--[[
		Manager PLAYER
	]]--
	function manager.Player(player)
		-- Functions

		-- General Variables
		player['id'] = player['id'] or player:GetPlayerID() or -123
		player['hero'] = player['hero'] or PlayerResource:GetSelectedHeroEntity(player['id']) or nil
		player['team'] = player['team'] or PlayerResource:GetTeam(player['id']) or 0
		player['handle'] = player['handle'] or PlayerResource:GetPlayer(player['id']) or nil
		player['name'] = player['name'] or PlayerResource:GetPlayerName(player['id']) or ''

		player['entities'] = player['entities'] or {}
		player['positionInPlayerEntityList'] = -1

		-- Player is configured, finishing touch(s)
		player['entityConfigured'] = true
		return(player)
	end


	--[[
		Manager CORE/FUNCTIONS
	]]--
	function manager.EntityCreate(entityData, player)
		if not type(entityData) == 'table' then
			manager.Error('entity parameter must be a table. It\'s currently a '..tostring(type(entity)..'.'))
			return false
		end

		if not type(player) == 'table' then
			manager.Error('player parameter must be a table. It\'s currently a '..tostring(type(player)..'.'))
			return false
		end

		local entityTemp
		local Match = string.match
		if Match(entityData['type'], 'dummy') then
			entityTemp = CreateUnitByName(
				entityData['name'], 
				entityData['origin'], 
				false, 
				player['handle'], 
				player, 
				entityData['team']
			)

		else
			entityTemp = CreateUnitByName(
				entityData['name'], 
				entityData['origin'], 
				true, 
				entityData['owningEntity'], 
				entityData['owningPlayer'],
				entityData['team']
			)
		end

		for key, value in pairs(entityData) do
			entityTemp[key] = value or nil
		end

		local entity = manager.Entity(entityTemp, player)
		entity:SetAbsOrigin(entity['orgin'])
		return(entity)
	end

	function manager.EntityDestroy(entity)
		if not type(entity) == 'table' then
			manager.Error('entity parameter must be a table. It\'s currently a '..tostring(type(entity)..'.'))
			return false
		end

		if entity['positionInPlayerEntityList'] then
			entity['owningPlayer']['entities'][entity['positionInPlayerEntityList']] = nil
		end

		UTIL_Remove(entity)
		return true
	end

	function manager.EntityReplaceHero(heroOld, nameOfNewHero, player)
		local heroData = {
			['name'] = 'nameOfNewHero',
			['origin'] = heroOld.LocationRefresh(),
			['owningEntity'] = heroOld['owningEntity'],
			['owningPlayer'] = heroOld['owningPlayer'],
			['team'] = heroOld['team'],
			['isHero'] = true,
			['type'] = 'hero'
		}

		PlayerResource:ReplaceHeroWith(player['id'], nameOfNewHero, 0, 0)
		UTIL_Remove(heroOld)

		local hero = PlayerResource:GetSelectedHeroEntity(player['id'])
		for key, value in pairs(heroData) do
			hero[key] = value or nil
		end

		player['hero'] = hero

		entity = manager.Entity(hero, player)
		return(entity)
	end

	function manager.EntityReplace(entityOld, nameOfNewEntity, player)
		local entityData = {
			['name'] = 'nameOfNewEntity',
			['origin'] = entityOld.LocationRefresh(),
			['owningEntity'] = entityOld['owningEntity'],
			['owningPlayer'] = entityOld['owningPlayer'],
			['team'] = entityOld['team'],
			['type'] = manager['kv']['entities'][nameOfNewEntity] or 'unknown'
		}
		if manager.EntityDestroy(entityOld) then
			local entity = manager.EntityCreate(entityData, player)
			return(entity)
		else
			manager.Error('failed to destroy entity, '..entity['name']..'.')
			return false
		end
	end

	function manager.ParticleCleanup(particle)
		if particle then
			ParticleManager:DestroyParticle(particle, true)
			ParticleManager:ReleaseParticleIndex(particle)
			return true
		else
			return false
		end
	end


	--[[
		Manager EVENTS
	]]--
	local function OnGameStateChange(data)
		if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_HERO_SELECTION then
			return

		else
			for i=0, 9 do
				if PlayerResource:IsValidPlayer(i) then
					local player = PlayerResource:GetPlayer(i)
					manager['players'][i] = manager.Player(player)
				end
			end
		end
	end

	local function OnEntityKilled(ddta)
		local entity = EntIndexToHScript(data['entindex_killed'])

		for i=0, entity['effectsCount'] do
			local effect = entity['effects'] or nil
			if effect then
				if not effect['SkipCleanupOnDeath'] then
					if manager.ParticleCleanup(effect['particle']) then
						entity['effects'][i] = nil
						return true
					else
						manager.Error('unable to cleanup particle effect.')
						return false
					end
				end
			end
		end
	end

	ListenToGameEvent('game_rules_state_change', OnGameStateChange, self)
	ListenToGameEvent('entity_killed', OnEntityKilled, self)


	--[[
		Final touch(s), then return the manager.
	]]--
	return(manager)
end