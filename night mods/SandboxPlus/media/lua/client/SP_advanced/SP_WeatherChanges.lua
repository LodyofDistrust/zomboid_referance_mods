SP_WeatherChanges = {}
local SPW = SP_WeatherChanges


SPW.minimumSpeed = nil


SPW.visibility = 0.5
SPW.clothing = {
	Shirt_CamoDesert =      0.2,
	Shirt_CamoGreen =       0.2,
	Shirt_CamoUrban =       0.2,
	Shirt_OfficerWhite =    0.8,
	Shirt_FormalWhite = 	0.8,
	Shirt_Jockey01 =        1,
	Shirt_Jockey02 =        1,
	Shirt_Jockey03 =        1,
	Shirt_Jockey04 =        1,
	Shirt_Jockey05 =        1,
	Shirt_Jockey06 =        1,

	Tshirt_ArmyGreen =      0.2,
	Tshirt_CamoDesert =     0.2,
	Tshirt_CamoGreen =      0.2,
	Tshirt_CamoUrban =      0.2,
	Tshirt_Sport =          1,

	Ghillie_Top = 			0,
	Jacket_ArmyCamoDesert = 0.2,
	Jacket_ArmyCamoGreen =  0.2,
	Jacket_CoatArmy =  		0.3,
	Jacket_Fireman = 		0.7,
	Jacket_Varsity = 		0.7,
	PonchoYellow = 			1,
	PonchoYellowDOWN = 		1,
	-- Jacket_WhiteTINT,
	-- HoodieDOWN_WhiteTINT,
	-- HoodieUP_WhiteTINT,

	Vest_BulletArmy =       0.2,
	Vest_Hunting_Camo =     0.2,
	Vest_Hunting_CamoGreen =0.2,
	Vest_BulletCivilian =   0.8,
	Vest_Hunting_Orange =   1,
	Vest_HighViz = 			1,

	Ghillie_Trousers = 		0,
	Trousers_CamoDesert = 	0,2,
	Trousers_CamoGreen = 	0,2,
	Trousers_CamoUrban = 	0,2,
	Shorts_CamoGreenLong = 	0.3,
 	Shorts_LongDenim = 		0.4,
	Trousers_Fireman = 		0.7,
	-- Trousers_WhiteTINT,
	
	HazmatSuit =            1,

	Hat_BalaclavaFull = 	0,
	Hat_GasMask =           0.2,
	Hat_NBCmask = 			0.2,
	Hat_Army = 				0.2,
	Hat_BonnieHat_CamoGreen = 0.2,
	Hat_BandanaMask = 		0.3,
	Hat_CrashHelmetFULL = 	0.3,
	Hat_CrashHelmet_Police = 0.3,
	Hat_RidingHelmet = 		0.2,
	Hat_RiotHelmet = 		0.3,
	Hat_BicycleHelmet = 	0.8,
	Hat_Fireman = 			1,
	Hat_HardHat = 			1,
	Hat_HardHat_Miner = 	1,
	Hat_JockeyHelmet01 =	1,
	Hat_JockeyHelmet02 =	1,
	Hat_JockeyHelmet03 =	1,
	Hat_JockeyHelmet04 =	1,
	Hat_JockeyHelmet05 =	1,
	Hat_JockeyHelmet06 = 	1,
	-- Hat_BandanaMaskTINT,

	MakeUp_GreenCamo = 		0,
	MakeUp_CamoFullFace1 = 	0,
	MakeUp_CamoFullFace2 = 	0,
}


SPW.OnClothingUpdated = function()
	local p = getPlayer()
	local torso = 0
	local head = 0
	local legs = 0
	local back = 0
	--Dress
	--Skirt
	if p:getWornItem("FullSuitHead") then
		torso = SPW.getVisibility( p:getWornItem("FullSuitHead") ) * 1.5
		head = torso * 0.5
		legs = torso
	elseif p:getWornItem("FullSuit") then
		torso = SPW.getVisibility( p:getWornItem("FullSuit") ) * 2.5
		head = SPW.getVisibilityHead() * 0.5
	else		
		if p:getWornItem("FullTop") then
			torso = SPW.getVisibility( p:getWornItem("FullTop") ) * 1.5
			head = torso * 0.5
		elseif p:getWornItem("JacketHat") then
			torso = SPW.getVisibility( p:getWornItem("JacketHat") ) * 1.5
			head = torso * 0.25 + SPW.getVisibilityHead(true) * 0.5
		else
			if p:getWornItem("Jacket") then
				torso = SPW.getVisibility( p:getWornItem("Jacket") ) * 1.5
				head = SPW.getVisibilityHead() * 0.5
			elseif p:getWornItem("SweaterHat") then
				torso = SPW.getVisibility( p:getWornItem("SweaterHat") ) * 1.5
				head = torso * 0.25 + SPW.getVisibilityHead(true) * 0.5
			elseif p:getWornItem("Sweater") then
				torso = SPW.getVisibility( p:getWornItem("Sweater") ) * 1.5
				head = SPW.getVisibilityHead() * 0.5
			elseif p:getWornItem("Shirt") then 
				torso = SPW.getVisibility( p:getWornItem("Shirt") ) * 1.5
				head = SPW.getVisibilityHead() * 0.5
			else --"Tshirt"
				torso = (0.5*0.25 + SPW.getVisibility( p:getWornItem("Tshirt") )*0.75)  * 1.5
				head = SPW.getVisibilityHead() * 0.5
			end
			if p:getWornItem("TorsoExtra") then --Vest
				torso = torso *0.5 + SPW.getVisibility( p:getWornItem("Vest") )*1.5 *0.5
			end
		end
		legs = SPW.getVisibility( p:getWornItem("Pants") )
	end
	if p:getWornItem("Back") then
		back = SPW.getVisibility( p:getWornItem("Back") )
	end
	print(head)
	print(torso)
	print(legs)
	print(back)
	local visibility = torso
	if head > visibility then visibility = head end
	if legs > visibility then visibility = legs end
	if back > visibility then visibility = back end
	SPW.visibility = visibility*0.5 + (torso + head + legs + back)/4 * 0.5
	print("TOTAL VISIBILITY "..visibility)
	SPW.AdjustSight()
end
SPW.getVisibilityHead = function(ignoreHat)
	local p = getPlayer()
	if p:getWornItem("FullHat") then
		return SPW.getVisibility( p:getWornItem("FullHat") )
	else
		local visibility = 0
		if not ignoreHat then visibility = SPW.getVisibility( p:getWornItem("Hat") ) *0.5 end

		if p:getWornItem("MaskEyes") then
			return visibility + SPW.getVisibility( p:getWornItem("MaskEyes") ) *0.5
		elseif p:getWornItem("MakeUp_FullFace") then
			return visibility + SPW.getVisibility( p:getWornItem("MakeUp_FullFace") ) *0.5
		else
			return visibility + SPW.getVisibility( p:getWornItem("Eyes") ) *0.25 + SPW.getVisibility( p:getWornItem("Mask") ) *0.25
		end
	end
end
SPW.getVisibility = function(inventoryItem)
	if not inventoryItem then
		return 0.5
	end
	if inventoryItem:getVisual() then
		if inventoryItem:getClothingItem():getAllowRandomTint() then
			local tint = inventoryItem:getVisual():getTint( inventoryItem:getClothingItem() )
			local visibility = (tint:getRedFloat() + tint:getGreenFloat() + tint:getBlueFloat()) / 3
			print("TINT: "..visibility)
			return visibility
		elseif inventoryItem:getClothingItem():getAllowRandomHue() then
			local hue = inventoryItem:getVisual():getHue( inventoryItem:getClothingItem() )
			print("HUE: "..hue)
		end
	end
	return SPW.clothing[inventoryItem:getScriptItem():getName()] or 0.5
end


SPW.OnClimateTick = function()
	if getPlayer():getSquare() == nil then return end --happens during respawn

	--TODO: optimize sandbox updates
	SPW.AdjustSight()
	SPW.AdjustHearing()
	SPW.AdjustAttention()
	SPW.AdjustSpeed()	
end

SPW.AdjustSight = function()
	local CM = ClimateManager.getInstance()
	local reduction = 0
	reduction = 1 - CM:getDayLightStrength()
	-- if SandboxVars.NightDarkness <= 1 then
	-- 	reduction = reduction * 1.33
	-- elseif SandboxVars.NightDarkness >= 3 then
	-- 	reduction = reduction * 0.75
	-- end
	if getPlayer():getSquare():isOutside() then
		reduction = reduction+CM:getRainIntensity()*0.3
		reduction = reduction+CM:getSnowStrength()*0.3
		reduction = reduction+CM:getFogIntensity()
		if reduction > 1 then reduction = 1 end
	end
	--TODO:
	--indoor light, streetlights, flashlight, etc
	-- print( getPlayer():getSquare():getLightInfluenceB() ) --always nil?
	-- print( getPlayer():getSquare():getLampostTotalB() ) -- always 0?
	-- reduction = reduction * (1-SPW.visibility/2)

	if reduction > 0.7 and SandboxVars.Sight ~= 3 then
		SandboxVars.Sight = 3
		SandboxOptions.instance:updateFromLua()
	elseif reduction > 0.2 and SandboxVars.Sight ~= 2 then
		SandboxVars.Sight = 2
		SandboxOptions.instance:updateFromLua()
	elseif SandboxVars.Sight ~= 1 then
		SandboxVars.Sight = 1
		SandboxOptions.instance:updateFromLua()
	end
	CM:setViewDistance(30 - 25*reduction)
	-- print("Sight/viewDistance reduction:"..reduction)
end

SPW.AdjustHearing = function()
	local CM = ClimateManager.getInstance()
	local reduction = 0
	if CM:getWeatherPeriod():isTropicalStorm() then
		reduction = 1
	else
		reduction = CM:getRainIntensity()*0.8 + CM:getWindIntensity()*0.2
	end

	if not getPlayer():getSquare():isOutside() then
		reduction = reduction/2
	end

	if reduction > 0.7 and SandboxVars.Hearing ~= 3 then
		SandboxVars.Hearing = 3
		SandboxOptions.instance:updateFromLua()
	elseif reduction > 0.2 and SandboxVars.Hearing ~= 2 then
		SandboxVars.Hearing = 2
		SandboxOptions.instance:updateFromLua()
	elseif SandboxVars.Hearing ~= 1 then
		SandboxVars.Hearing = 1
		SandboxOptions.instance:updateFromLua()
	end
	-- print("Hearing reduction:"..reduction)
end


SPW.AdjustAttention = function()
	local CM = ClimateManager.getInstance()
	local reduction = 0
	if CM:getWeatherPeriod():isTropicalStorm() or CM:getWeatherPeriod():isBlizzard() then
		reduction = 1
	elseif getWorld():getGlobalTemperature() < 0 then
		reduction = 1
	else
		reduction = CM:getRainIntensity()*0.8 + CM:getWindIntensity()*0.2
	end	

	if not getPlayer():getSquare():isOutside() then
		reduction = reduction/2
	end

	if reduction > 0.5 and SandboxVars.Memory ~= 3 then
		SandboxVars.Memory = 3
		SandboxOptions.instance:updateFromLua()
	elseif reduction < 0.5 and SandboxVars.Memory ~= 2 then
		SandboxVars.Memory = 2
		SandboxOptions.instance:updateFromLua()
	end
	-- print("Memory reduction:"..reduction)
end

SPW.AdjustSpeed = function()
	local CM = ClimateManager.getInstance()
	local reduction = 0
	if getWorld():getGlobalTemperature() < 0 then
		reduction = 1
	end
	if reduction > 0.5 and SandboxVars.Speed ~= 3 then
		SPW.minimumSpeed = 3
		SandboxVars.Speed = 3
		SPW.AdjustGroup(true)
		SandboxOptions.instance:updateFromLua()
	elseif reduction < 0.5 and SandboxVars.Speed ~= 2 then
		SPW.minimumSpeed = nil
		SandboxVars.Speed = 2
		SPW.AdjustGroup(false)
		SandboxOptions.instance:updateFromLua()
	end
	-- print("Speed reduction:"..reduction)
end


SPW.groupAdjusted = false
local groupSize_original = 0
local groupDistance_original = 0
local groupSeperation_original = 0
local groupRadius_original = 0

SPW.AdjustGroup = function(bool)
	if SPW.groupAdjusted == bool then return end
	SPW.groupAdjusted = bool
	
	local SV = SandboxVars.ZombieConfig
	if bool then
		groupSize_original = SV.RallyGroupSize
		groupDistance_original = SV.RallyTravelDistance
		groupSeperation_original = SV.RallyGroupSeparation
		
		-- make zombies lazy
		local groupSize = math.floor( SV.RallyGroupSize *2 )
		if groupSize > 1000 then groupSize = 1000 end
		SV.RallyGroupSize = groupSize
		SV.RallyGroupDistance = 5
		SV.RayyGroupSeperation = 5
	else
		SV.RallyGroupSize = groupSize_original
		SV.RallyTravelDistance = groupDistance_original
		SV.RallyGroupSeparation = groupSeperation_original
	end
end


SPW.OnThunderEvent = function(x,y,strike,lightning,rumble)
	if strike then
		addSound(getPlayer(), x,y,7, 1000,1000)
	elseif rumble then
		addSound(getPlayer(), x,y,7, 1000,1000)
	end
end


SPW.OnGameStart = function()
	if SP.config.weatherEnabled == false then return end

	SPW.OnClimateTick()

	-- Events.OnClothingUpdated.Add(SPW.OnClothingUpdated)
	Events.OnClimateTick.Add(SPW.OnClimateTick)
	Events.OnThunderEvent.Add(SPW.OnThunderEvent)
end
Events.OnGameStart.Add(SPW.OnGameStart)
