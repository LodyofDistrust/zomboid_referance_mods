local function specialzeds(zombie)
	local vMod = zombie:getModData();
	local SpecialZedRandom = ZombRand(99)
	
	if vMod.SpecialZedCheck ~= true then
		vMod.SpecialZedCheck = true
		
		if SpecialZedRandom > 9 then -----------------------------------------Normal Zombie
			vMod.SpecialZedType = "Normal"
		end
		
		if SpecialZedRandom > 4 and SpecialZedRandom < 10 then -----------------------------------------Crawler Zombie
			vMod.SpecialZedType = "Crawler"
			zombie:toggleCrawling();
		end
		
		if SpecialZedRandom >= 0 and SpecialZedRandom < 5 then -----------------------------------------Runner Zombie
			vMod.SpecialZedType = "Runner"
			zombie:changeSpeed(1);
		end
	end
end

Events.OnZombieUpdate.Add(specialzeds);