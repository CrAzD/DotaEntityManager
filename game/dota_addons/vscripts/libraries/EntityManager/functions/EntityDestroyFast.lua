

--[[
	EntityDestroyFast
		Remove entity, update player tables, and specfically FAST skips all checks.
]]--

function EntityManager:EntityDestroyFast(entity)
	if entity['positionInPlayerEntityList'] then
		entity['owningPlayer']['entities'][entity['positionInPlayerEntityList']] = nil
	end

	UTIL_Remove(entity)

	return
end