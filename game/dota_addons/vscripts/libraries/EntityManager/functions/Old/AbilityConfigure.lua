function EntityManager:AbilityConfigure(ability, entity)
	ability['name'] = ability:GetAbilityName()
	ability['cost'] = ability:GetGoldCost(-1)
	ability['caster'] = entity
	ability:SetLevel(self:AbilityGetStartingLevel(ability))

	if self['KV_FILES']['ABILITIES'][ability['name']] then
		for key, variable in pairs(self['KV_FILES']['ABILITIES'][ability['name']]) do
			ability[key] = variable
		end
	end
end