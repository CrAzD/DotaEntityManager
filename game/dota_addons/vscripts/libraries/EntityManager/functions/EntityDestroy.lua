

function EntityManager:EntityDestroy(entity)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING or NIL.')

		return false
	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')

		return false
	elseif entity:IsNull() then
		print('[ENTITY MANAGER]  "entity" does NOT exist.')

		return false
	else
		if entity['positionInPlayerEntityList'] then
			entity['owningPlayer']['entities'][entity['positionInPlayerEntityList']] = nil
		end

		UTIL_Remove(entity)

		return true
	end
end