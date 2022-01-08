SP_FasterSeasons = {}
local SPFS = SP_FasterSeasons


SPFS.EveryHours_CheckTime = function()
	local hour = getGameTime():getHour()
	local isItTime = hour / SPFS.hoursPerDay
	if isItTime ~= 0 and isItTime ~= 24/SPFS.hoursPerDay and isItTime == math.floor(isItTime) then
		getGameTime():setDay( getGameTime():getDay()+1 )
	end
end


function SPFS.OnGameStart()
	if SP.config.fasterSeasons > 0 then
		SPFS.hoursPerDay = 24 / (SP.config.fasterSeasons+1)
		Events.EveryHours.Add(SPFS.EveryHours_CheckTime)
	end
end
Events.OnGameStart.Add(SPFS.OnGameStart)