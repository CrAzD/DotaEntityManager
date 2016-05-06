

function EntityManager:AbilityReplace(entity, abilityOld, abilityNewName)
	if not entity['abilities'][abilityOld] or type(entity['abilities'][abilityOld]) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before replacing an ability.')

		return false
	else
		self:AbilityRemoveFast(entity, abilityOld)
		self:AbilityAddFast(entity, abilityNewName)

		return true
	end
end