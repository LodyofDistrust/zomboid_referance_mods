function NightZeds()
	local gTime = getGameTime()
	local hour = gTime:getTimeOfDay()
	local night = gTime:getNight()
	local climate = getClimateManager()
	local sun = climate:getDayLightStrength()
	local light = climate:getGlobalLightIntensity()
	-- local cloud = climate:getCloudIntensity()
	-- local rain = climate:getRainIntensity()
	local fog = climate:getFogIntensity()

	-- print("Night - " .. tostring(night))
	-- print("Sun - " .. tostring(sun))
	-- print("Light - " .. tostring(light))
	-- print("Cloud - " .. tostring(cloud))
	-- print("Rain - " .. tostring(rain))
	-- print("Fog - " .. tostring(fog))
	
	if night == 1 or fog > 0.5 then
		getSandboxOptions():set("ZombieLore.Memory",1)
		getSandboxOptions():set("ZombieLore.Sight",1)
		getSandboxOptions():set("ZombieLore.Hearing",1)
	elseif night > 0 or fog > 0 or light < 0.5 then
		getSandboxOptions():set("ZombieLore.Memory",1)
		getSandboxOptions():set("ZombieLore.Sight",1)
		getSandboxOptions():set("ZombieLore.Hearing",2)	
	elseif (hour < 12 and hour > 15) or light < 0.6 or sun < 0.85 then 
		getSandboxOptions():set("ZombieLore.Memory",2)
		getSandboxOptions():set("ZombieLore.Sight",2)
		getSandboxOptions():set("ZombieLore.Hearing",2)
	else
		getSandboxOptions():set("ZombieLore.Memory",3)
		getSandboxOptions():set("ZombieLore.Sight",3)
		getSandboxOptions():set("ZombieLore.Hearing",3)			
	end
end