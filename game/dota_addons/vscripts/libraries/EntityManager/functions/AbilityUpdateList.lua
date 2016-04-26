

function EntityManager:AbilityUpdateList(entity)
	local oldList = entity['abilities']['list']
	entity['abilities']['list'] = {}
	entity['abilities']['count'] = -1

	for i=0, #oldList do
		local tAbility = oldList[i]
		entity['abilities']['list'][i] = tAbility
		entity['abilities'][i] = tAbility
		tAbility['position'] = i

		entity['abilities']['count'] = entity['abilities']['count'] + 1
	end

	return true
end