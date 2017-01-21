

--[[
	EntityReplaceHeroWith
		Enhances the builtin ReplaceHeroWith function with cleanup and EntityManager integration.
]]--

function EntityManager:EntityReplaceHeroWith(heroNameToReplaceWith, player)
	local oldHero = player['hero']

	PlayerResource:ReplaceHeroWith(player['id'], heroNameToReplaceWith, 0, 0)
	UTIL_Remove(oldHero)

	local entity = PlayerResource:GetSelectedHeroEntity(player['id'])
	entity['name'] = heroNameToReplaceWith or entity:GetUnitName() or nil
	entity['origin'] = entity:GetAbsOrigin() or nil
	entity['owningEntity'] = entity or nil
	entity['owningPlayer'] = player or nil
	entity['team'] = player['team'] or entity:GetTeam() or nil
	entity['isHero'] = true
	entity['type'] = 'hero'

	player['hero'] = entity

	return(self:Entity(entity, player))
end