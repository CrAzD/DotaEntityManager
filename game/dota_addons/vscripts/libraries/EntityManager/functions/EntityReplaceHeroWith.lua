

function EntityManager:EntityReplaceHeroWith(heroNameToReplaceWith, player)
	local oldHero = player['hero']

	PlayerResource:ReplaceHeroWith(player['id'], heroNameToReplaceWith, 0, 0)
	UTIL_Remove(oldHero)

	local hero = PlayerResource:GetSelectedHeroEntity(player['id'])	
	hero['isHero'] = true
	hero['type'] = 'hero'

	player['hero'] = hero
	
	return(EntityManager:EntityConfigure(hero, player))
end