SP_OpenDoors = {}
local SPOD = SP_OpenDoors


local ingameSec = 0
local list = nil
local thumped = nil
local door = nil


SPOD.openDoorChance = function()
	if ingameSec < 48 then ingameSec = ingameSec + GameTime:getInstance():getGameWorldSecondsSinceLastUpdate() return end
	ingameSec = ingameSec -48

	list = getCell():getZombieList()
	for i = 0,list:size()-1 do
		if list:get(i) then 
			if ZombRand(0,101) < SP.config.openDoorChance then
				thumped = list:get(i):getThumpTarget()
				if thumped and thumped:getSquare() and instanceof(thumped, "IsoDoor") then
					door = thumped:getSquare():getIsoDoor()
					if door and thumped == door then 
						door:ToggleDoor( list:get(i) )
						return
					end
				end
			end
		end
	end
end


SPOD.OnGameStart = function()
	if SP.config.openDoorChance == 0 then return end

	Events.OnTick.Add(SPOD.openDoorChance)
end
Events.OnGameStart.Add(SPOD.OnGameStart)
