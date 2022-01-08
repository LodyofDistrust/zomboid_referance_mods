SP_SpeedChanges = {}
local SPS = SP_SpeedChanges


local zList = nil
local size = 0
local ZombRand = ZombRand
local zomb = nil
local modData = nil
local random = 0
local type = 0

local percentages = {}
local maxPercent = 0
local minimumSpeed = nil


local ingameSec = 24
local OnTick = function()
    if ingameSec < 24 then ingameSec = ingameSec + GameTime:getInstance():getGameWorldSecondsSinceLastUpdate() return end
	
    ingameSec = ingameSec -24
    
    minimumSpeed = SP_WeatherChanges.minimumSpeed

    zList = getCell():getZombieList()
    size = zList:size()-1
	for i =0,size do 
		zomb = zList:get(i)
        modData = zomb:getModData()
        type = modData.type
        if type == nil then
            random = ZombRand(0, maxPercent+1)
            for percent,type in pairs(percentages) do
                if random <= percent then
                    modData.type = type
                    if type == 2 then
                        zomb:changeSpeed(minimumSpeed or type)
                        zomb:DoZombieStats()
                    elseif type == 3 then
                        zomb:changeSpeed(minimumSpeed or type)
                        zomb:DoZombieStats()
                    elseif type == 1 then
                        zomb:changeSpeed(minimumSpeed or type)
                        zomb:DoZombieStats()
                    end
                    
                    if type == 4 and zomb:GetAnimSetName() ~= "zombie-crawler" then 
                        zomb:toggleCrawling()
                    elseif type ~= 4 and zomb:GetAnimSetName() == "zombie-crawler" then 
                        zomb:toggleCrawling() 
                    end

                    if type == 5 and zomb:isFakeDead() == false and zomb:isForceFakeDead() == false then 
                        zomb:setFakeDead(true)
                        zomb:DoZombieStats()
                    elseif type ~= 5 and (zomb:isFakeDead() == true or zomb:isForceFakeDead() == true) then 
                        zomb:setFakeDead(false)
                        zomb:setForceFakeDead(false)
                        zomb:DoZombieStats()
                    end

                    break
                end
            end
        else
            -- the zombie will get reset & "recycled" when out of player area
    --        if VirtualZombieManager:isReused(zomb) then --nope, too late
      --      if zomb:getCurrentSquare() == nil then --nope
            if modData.horde then
                --horde mod support
                if type <= 3 then
                    zomb:changeSpeed(minimumSpeed or 2)
                    zomb:DoZombieStats()
                elseif type == 4 then
                    modData.type = 2
                    zomb:changeSpeed(minimumSpeed or 2)
                    zomb:toggleCrawling()
                elseif type == 5 then
                    modData.type = 2
                    zomb:changeSpeed(minimumSpeed or 2)
                    zomb:setFakeDead(false)
                    zomb:setForceFakeDead(false)
                end
            else
                if zomb:GetAnimSetName() == "zombie-crawler" then 
                    -- zomb:setTurnDelta(0.5)
                    return
                end

                if type <= 3 then
                    zomb:changeSpeed(minimumSpeed or type)
                    zomb:DoZombieStats()
                elseif type == 5 and zomb:getTarget() then
                    zomb:setFakeDead(false) -- fakeDead will not get up unless they're allowed to
                    zomb:setForceFakeDead(false)
                    modData.type = 3
                end
            end
        end
    end
end


SPS.OnGameStart = function()
    if SP.config.speedEnabled == false then return end

    local zList = getCell():getZombieList()
    local size = zList:size()-1
	for i= 0,size do 
        zList:get(i):getModData().type = nil
    end

    --sort percentages
    local percent = 0
    percentages = {}
    if SP.config.percentRunners > 0 then
        -- doing *10 here because of strange bug when doing table.sort with certain number combinations like 3,2
        percent = percent + SP.config.percentRunners*10 --speedMod 0.85 + Rand 0.15, setTurnDelta(1)
        percentages[percent] = 1
    end
    if SP.config.percentWalkers > 0 then
        percent = percent + SP.config.percentWalkers*10 --speedMod 0.85 + Rand 0.15
        percentages[percent] = 2 
    end
    if SP.config.percentShamblers > 0 then
        percent = percent + SP.config.percentShamblers*10 --speedMod 0.55 + Rand 0.15
        percentages[percent] = 3
    end
    if SP.config.percentCrawlers > 0 then 
        percent = percent + SP.config.percentCrawlers*10 --speedMod 0.3 + Rand 0.15
        percentages[percent] = 4 
    end
    if SP.config.percentFakeDead > 0 then 
        percent = percent + SP.config.percentFakeDead*10
        percentages[percent] = 5 
     end
    maxPercent = percent--maxPercent in case it's not 100%


    table.sort(percentages)
    --reverse for performace reasons
    local i,j = 1,#percentages
	while i < j do
		percentages[i],percentages[j] = percentages[j],percentages[i]
		i = i + 1
		j = j - 1
    end
    
	SandboxVars.Speed = 2
    SandboxOptions.instance:updateFromLua()

    Events.OnTick.Add(OnTick)
    Events.OnZombieUpdate.Add(OnZombieUpdate);
end
Events.OnGameStart.Add(SPS.OnGameStart)