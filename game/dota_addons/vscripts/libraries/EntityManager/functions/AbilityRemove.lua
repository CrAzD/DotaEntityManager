

function EntityManager:AbilityRemove(entity, abilityName)
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
		local ability = entity['abilities'][abilityName]
		if not ability or type(ability) ~= 'table' then
			print('[ENTITY MANAGER]  '..abilityNameNew..' was not found within '..entity['name']..'. Verify correct spelling and existance of ability.')

			return false
		else
			local position = ability['position']

			entity:RemoveAbility(abilityName)
			entity['abilities'][position] = nil
			entity['abilities'][abilityName] = nil
			entity['abilities']['list'][position] = nil
			entity['abilities']['count'] = entity['abilities']['count'] - 1

			return true
		end
	end
end