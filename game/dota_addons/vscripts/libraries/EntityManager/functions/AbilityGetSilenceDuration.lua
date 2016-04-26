

function EntityManager:AbilityGetSilenceDuration(ability)
	if self['KV_FILES']['ABILITIES'][ability['name']] then
		return(self['KV_FILES']['ABILITIES'][ability['name']]['silenceImmune'] or false)
	else
		return false
	end
end