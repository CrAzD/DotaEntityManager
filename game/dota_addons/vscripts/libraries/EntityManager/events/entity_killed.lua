

ListenToGameEvent('entity_killed', Dynamic_Wrap(EntityManager, 'OnEntityKilled'), EntityManager)

function EntityManager:OnEntityKilled(data)
	--[[
		Built-in variables
			entindex_killed (integer)
			entindex_attacker (integer)
			damagebits (integer)
			splitscreenplayer (integer) [-1 equals off]
	]]--

	local entity = EntIndexToHScript(data['entindex_killed'])

	for i=0, entity['effectsCount'] do
		local effect = entity['effects'][i] or nil
		if effect then
			if not effect['SkipCleanupOnDeath'] or effect['SkipCleanupOnDeath'] == false then
				self:ParticleCleanup(effect['particle'])
				entity['effects'][i] = nil
			end
		end
	end

	return
end