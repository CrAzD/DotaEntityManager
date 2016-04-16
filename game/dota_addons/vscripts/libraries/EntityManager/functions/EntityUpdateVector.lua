

function EntityManager:EntityUpdateVector(entity)
	entity['vector'] = entity:GetAbsOrigin()
	entity['x'] = entity['vector']['x']
	entity['y'] = entity['vector']['y']
	entity['z'] = entity['vector']['z']

	return entity['vector']
end