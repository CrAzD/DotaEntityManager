

function EntityManager:EntityCreate(entity, player)
	if not entity then
		print('[ENTITY MANAGER]  "entity" argument is MISSING.')
		return nil

	elseif type(entity) ~= 'table' then
		print('[ENTITY MANAGER]  "entity" argument must be a TABLE.')
		return nil

	elseif not player then
		print('[ENTITY MANAGER]  "player" argument is MISSING.')
		return nil

	elseif type(player) ~= 'table' then
		print('[ENTITY MANAGER]  "player" argument must be a TABLE.')
		return nil

	elseif not entity['type'] then
		print('[ENTITY MANAGER]  "entity[\'type\']" argument is MISSING.')
		return nil

	elseif type(entity['type']) ~= 'string' then
		print('[ENTITY MANAGER]  "entity[\'type\']" argument must be a STRING.')
		return nil
	end

	if string.find(entity['type'], 'unit') or string.find(entity['type'], 'hero') or string.find(entity['type'], 'building') then
		return(self:EntityCreateUnit(entity, player))

	elseif string.find(entity['type'], 'dummy') then
		if not entity['name'] then
			print('[ENTITY MANAGER]  "entity[\'name\']" argument is MISSING.')
			return nil

		elseif type(entity['name']) ~= 'string' then
			print('[ENTITY MANAGER]  "entity[\'name\']" argument must be a STRING.')
			return nil

		elseif not entity['origin'] then
			print('[ENTITY MANAGER]  "entity[\'origin\'" argument is MISSING.')
			return nil

		elseif type(entity['origin']) ~= 'table' then
			print('[ENTITY MANAGER]  "entity[\'origin\'" argument must be a TABLE.')
			return nil

		elseif not entity['team'] then
			print('[ENTITY MANAGER]  "entity[\'team\'" argument is MISSING.')
			return nil

		elseif type(entity['team']) ~= 'number' then
			print('[ENTITY MANAGER]  "entity[\'team\'" argument must be a NUMBER.')
			return nil
			
		else
			return(self:EntityCreateDummy(entity, player))
		end
	else
		print('[ENTITY MANAGER]  unknown "entity[\'type\'] argument. Make sure the spelling is correct, and there is a check for it.')

		return nil
	end
end