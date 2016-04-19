

ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EntityManager, 'OnGameStateChange'), EntityManager)

function EntityManager:OnGameStateChange(data)
	--[[
		Built-in variables
			index (integer)
			userid (integer) --Different from playerID
			splitscreenplayer (integer) [-1 equals off]
	]]--

	if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_HERO_SELECTION then
		return
	else
		for i=0, 9 do
			if PlayerResource:IsValidPlayer(i) then
				self['players'][i] = self:PlayerConfigure(PlayerResource:GetPlayer(i))
			end
		end

		return
	end
end