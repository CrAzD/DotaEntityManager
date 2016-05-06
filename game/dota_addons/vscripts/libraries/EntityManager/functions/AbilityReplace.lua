

function EntityManager:AbilityReplace(entity, abilityOld, abilityNewName)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING.')

		return false
	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')

		return false
	elseif not abilityOld then
		print('[ENTITY MANAGER]  "abilityOld" argument is MISSING.')

		return false
	elseif type(abilityOld) ~= 'table' then
		print('[ENTITY MANAGER]  "abilityOld" argument must be a TABLE.')

		return false
	elseif not abilityNewName then
		print('[ENTITY MANAGER]  "abilityNewName" argument is MISSING.')

		return false
	elseif type(abilityNewName) ~= 'string' then
		print('[ENTITY MANAGER]  "abilityNewName" argument must be a STRING.')

		return false
	elseif not entity['abilities'][abilityOld] or type(entity['abilities'][abilityOld]) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before replacing an ability.')

		return false
	else
		self:AbilityRemoveFast(entity, abilityOld)
		self:AbilityAddFast(entity, abilityNewName)

		return true
	end
end