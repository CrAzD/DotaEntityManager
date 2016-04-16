

function EntityManager:AbilityReplace(entity, abilityNameOld, abilityNameNew)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING.')

		return false
	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')

		return false
	elseif not abilityNameOld then
		print('[ENTITY MANAGER]  "abilityNameOld" argument is MISSING.')

		return false
	elseif type(abilityNameOld) ~= 'string' then
		print('[ENTITY MANAGER]  "abilityNameOld" argument must be a STRING.')

		return false
	elseif not abilityNameNew then
		print('[ENTITY MANAGER]  "abilityNameNew" argument is MISSING.')

		return false
	elseif type(abilityNameNew) ~= 'string' then
		print('[ENTITY MANAGER]  "abilityNameNew" argument must be a STRING.')

		return false
	elseif not entity['ability'] or type(entity['ability']) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before replacing an ability.')

		return false
	else
		entity:AddAbility(abilityNameNew)
		local abilityOld = entity['abilities'][abilityNameOld]
		local abilityNew = entity:FindAbilityByName(abilityNameNew)
		if type(abilityNameNew) ~= 'table' then
			print('[ENTITY MANAGER]  '..abilityNameNew..' was not found within '..entity['name']..'. Verify correct spelling and existance of ability.')

			return false
		elseif type(abilityNameOld) ~= 'table' then
			print('[ENTITY MANAGER]  '..abilityNameOld..' was not found within '..entity['name']..'. Verify correct spelling.')

			return false
		else
			abilityNew:SetLevel(1)
			abilityNew['cost'] = abi:GetGoldCost(-1)
			abilityNew['name'] = abilityNameNew
			abilityNew['caster'] = entity
			abilityNew['position'] = abilityOld['position']

			entity['abilities'][abilityNew['position']] = abilityNew
			entity['abilities'][abilityNameNew] = abilityNew
			entity['abilities']['list'][abilityNew['position']] = abi

			entity:RemoveAbility(abilityOld)
			entity['abiliites'][abilityNameOld] = nil

			return true
		end
	end
end