

function EntityManager:AbilityAdd(entity, abilityName)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING.')

		return false
	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')

		return false
	elseif not abilityName then
		print('[ENTITY MANAGER]  "abilityName" argument is MISSING.')

		return false
	elseif type(abilityName) ~= 'string' then
		print('[ENTITY MANAGER]  "abilityName" argument must be a STRING.')

		return false
	elseif not entity['ability'] or type(entity['ability']) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before adding an ability.')

		return false
	else
		entity:AbilityAdd(abilityName)
		local ability = entity:FindAbilityByName(abilityName)
		if not ability or type(abilityName) ~= 'table' then
			print('[ENTITY MANAGER]  '..abilityName..' was not found within '..entity['name']..'. Verify correct spelling and existance of ability.')

			return false
		else
			entity['abilities']['count'] = entity['abilities']['count'] + 1

			ability:SetLevel(1)
			ability['cost'] = ability:GetGoldCost(-1)
			ability['name'] = ability:GetAbilityName()
			ability['caster'] = entity
			ability['position'] = entity['abilities']['count']

			entity['abilities'][entity['abilities']['count']] = ability
			entity['abilities'][ability['name']] = ability
			entity['abilities']['list'][entity['abilities']['count']] = ability

			return true
		end
	end
end