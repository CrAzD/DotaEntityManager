

function EntityManager:ParticleCleanup(particle)
	ParticleManager:DestroyParticle(particle, true)
	ParticleManager:ReleaseParticleIndex(particle)

	return
end