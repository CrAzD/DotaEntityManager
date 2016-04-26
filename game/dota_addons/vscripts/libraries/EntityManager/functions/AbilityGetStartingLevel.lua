

function EntityManager:AbilityGetStartingLevel(ability)
	if self['KV_FILES']['ABILITIES'][ability['name']] then
		return(self['KV_FILES']['ABILITIES'][ability['name']]['startingLevel'] or 0)
	else
		return(0)
	end
end