

function EntityManager:ParticleCleanup(particle)
	if particle then
		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)

		return
	else
		return
	end
end