

ListenToGameEvent('entity_killed', Dynamic_Wrap(EntityManager, 'OnEntityKilled'), EntityManager)

function EntityManager:OnEntityKilled(data)
	--[[
		Built-in variables
			entindex_killed (integer)
			entindex_attacker (integer)
			damagebits (integer)
			splitscreenplayer (integer) [-1 equals off]
	]]--

	local victim = EntIndexToHScript(data['entindex_killed'])

	for key, particle in pairs(victim['effects']) do
		if not key['SkipCleanupOnDeath'] or key['SkipCleanupOnDeath'] == false then
			self:ParticleCleanup(particle)
		end
	end
end