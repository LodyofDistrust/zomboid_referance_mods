SP_Shutoffs = {}
local SPS = SP_Shutoffs


SPS.OnGameStart = function()
	if SP.config.shutoffs == 0 then return end

	if GameTime:getInstance():getModData().WaterShutModifier == nil then
		local min = 14
		local max = 14

		if SP.config.shutoffs == 2 then 
			min = 12
			max = 16
		elseif SP.config.shutoffs == 3 then 
			min = 7
			max = 21
		elseif SP.config.shutoffs == 4 then 
			min = 14
			max = 27
		end

		SandboxVars.WaterShutModifier = ZombRand(min, max+1)
		SandboxVars.ElecShutModifier = ZombRand(min, max+1)
		SandboxOptions.instance:updateFromLua()
		GameTime:getInstance():getModData().WaterShutModifier = SandboxVars.WaterShutModifier
		GameTime:getInstance():getModData().ElecShutModifier = SandboxVars.ElecShutModifier
	end
end
Events.OnGameStart.Add(SPS.OnGameStart)
