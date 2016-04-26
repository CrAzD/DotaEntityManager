
function EntityManager:AbilityRemove(entity, ability)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING.')

		return false
	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')

		return false
	elseif not ability then
		print('[ENTITY MANAGER]  "ability" argument is MISSING.')

		return false
	elseif type(ability) ~= 'table' then
		print('[ENTITY MANAGER]  "ability" argument must be a TABLE.')

		return false
	elseif not entity['abilities'][ability] or type(entity['abilities'][ability]) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before removing an ability.')

		return false
	else
		local oldAbility = {
			['name'] = ability['name'],
			['position'] = ability['position']
		}

		entity:RemoveAbility(oldAbility['name'])
		entity['abilities'][oldAbility['position']] = nil
		entity['abilities'][oldAbility['name']] = nil
		entity['abilities']['list'][oldAbility['position']] = nil
		entity['abilities']['count'] = #entity['abilities']['list']

		self:AbilityUpdateList(entity)

		return true
	end
end