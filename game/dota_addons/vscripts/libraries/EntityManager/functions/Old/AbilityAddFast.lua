

function EntityManager:AbilityAddFast(entity, abilityName)
	entity:AddAbility(abilityName)
	
	local ability = entity:FindAbilityByName(abilityName) or nil
	if not ability then
		print('[Entity Manager]'  ..abilityName..' was not added to '..entity['name']..'. Verify abilityName is spelt correctly and that it exists.')
		return false

	else
		entity['abilities']['count'] = entity['abilities']['count'] + 1

		ability['name'] = abilityName
		local abilityLevel = self:AbilityGetStartingLevel(ability)
		ability:SetLevel(abilityLevel)
		ability['cost'] = ability:GetGoldCost(-1)
		ability['caster'] = entity
		ability['position'] = #entity['abilities']['list']

		entity['abilities'][ability['name']] = ability
		entity['abilities'][ability['position']] = ability
		entity['abilities']['list'][ability['position']] = ability

		self:AbilityUpdateList(entity)
		return true
	end
end