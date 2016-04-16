

function EntityManager:EntityCreateTavern(entity, player)
	local unit = CreateUnitByName(entity['name'], entity['origin'], true, player['handle'], player, entity['team'])
	unit['effects'] = {}
	unit:SetAbilityPoints(0)

	if entity['team'] == 2 then
		for i = 0, (IslandDefense['BUILDER_COUNT'] - 1) do
			EntityManagement:AbilityAdd(unit, IslandDefense['ABILITIES']['BUILDER_SELECTION'][i])
		end
	else
		for i = 0, (IslandDefense['BUILDER_COUNT'] - 1) do
			EntityManagement:AbilityAdd(unit, IslandDefense['ABILITIES']['BUILDER_SELECTION'][i])
		end
	end

	return(unit)
end