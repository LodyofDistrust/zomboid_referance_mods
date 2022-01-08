SP_XP = {}
local SPXP = SP_XP

SPXP.xpMultiplier = 2

SPXP.AddXP = function (character, type, amount)
	if type ~= Perks.Fitness and type ~= Perks.Strength then return	end	
	character:getXp():AddXP(type, amount*2, false)
end


SPXP.OnGameStart = function()
	if SP.config.xpEnabled == false or SP.config.xpEnabled == 0 then return end

	-- if SP.config.xpEnabled == 2 then
	-- 	SPXP.xpMultiplier = 3
	-- elseif SP.config.xpEnabled == 3 then
	-- 	SPXP.xpMultiplier = 5
	-- elseif SP.config.xpEnabled == 4 then
	-- 	SPXP.xpMultiplier = 10
	-- end
	Events.AddXP.Add(SPXP.AddXP)
end
Events.OnGameStart.Add(SPXP.OnGameStart)
