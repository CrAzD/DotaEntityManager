



function EntityManager:EntitySilenceAbilities(entity, ability) --entity param is entitiy being silence, ability param is ability causing silence
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
	elseif not entity['abilities'][ability['name']] or type(entity['abilities'][ability['name']]) ~= 'table' then
		print('[ENTITY MANAGER]  entity must be configured before they can be silenced.')

		return false
	else
		for i=0, entity['abilities']['count'] do
			local ability = entity['abilities']['list'][i]
			if ability and ability['silence']['immune'] == false then
				ability['silence']['status'] = true
				local unsilenceLocal = function()
					
				end

				self['entity']:SetContextThink('EM:AbilityUnSilence-'..ability['name']..)
			end
		end

		return true
	end
end