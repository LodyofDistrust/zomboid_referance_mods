SP_FallDamage = {}
local SPF = SP_FallDamage


local zList = nil
local size = 0
local zomb = nil
local modData = nil
local storeys = 0
local damage = 0


local ingameSec = 0
local OnTick = function()
	if ingameSec < 10 then ingameSec = ingameSec + GameTime:getInstance():getGameWorldSecondsSinceLastUpdate() return end
	
	ingameSec = ingameSec -10

    zList = getCell():getZombieList()
    size = zList:size()-1
	for i =0,size do 
		zomb = zList:get(i)
        modData = zomb:getModData()

		-- falltime is 50 / storey
		-- standard damage 0.075 / storey 
		if zomb:getFallTime() > 0 then
			zomb:getModData().fallTime = zomb:getFallTime()
		elseif zomb:getModData().fallTime ~= nil then
			modData = zomb:getModData()
			storeys = math.floor( modData.fallTime/50 )
			modData.fallTime = nil
			if storeys == 0 then return end
			damage = 0.3
			if ZombRand(0,100) < storeys * 30 then
				damage = 0.45
				--crawler
				modData.type = 4
				zomb:toggleCrawling()
			else
				--shambler
				modData.type = 3
				zomb:changeSpeed(3)
                zomb:DoZombieStats()
			end
			zomb:setHealth( zomb:getHealth()-damage*storeys )
		end
	end
end


SPF.OnGameStart = function()
	if SP.config.fallDamageEnabled == false then return end

	Events.OnTick.Add(OnTick)
end
Events.OnGameStart.Add(SPF.OnGameStart)