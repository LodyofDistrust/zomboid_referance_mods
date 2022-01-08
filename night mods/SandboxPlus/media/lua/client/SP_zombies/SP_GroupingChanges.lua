SP_GroupingChanges = {}
local SPG = SP_GroupingChanges


local groupSize_original = 0
local groupDistance_original = 0
local groupSeperation_original = 0
local groupRadius_original = 0


SPG.changeGroupBehaviour = function()
	local days = GameTime:getInstance():getDaysSurvived()
	local SV = SandboxVars.ZombieConfig
	SV.RallyGroupSize = 		math.floor( groupSize_original + (SP.config.groupSize-groupSize_original) * (days/SP.config.groupPeakDay) )
	SV.RallyTravelDistance =	math.floor( groupDistance_original + (SP.config.groupDistance-groupDistance_original) * (days/SP.config.groupPeakDay) )
	SV.RallyGroupSeparation = 	math.floor( groupSeperation_original + (SP.config.groupSeperation-groupSeperation_original) * (days/SP.config.groupPeakDay) )
	SV.RallyGroupRadius = 		math.floor( groupRadius_original + (SP.config.groupRadius-groupRadius_original) * (days/SP.config.groupPeakDay) )
	SandboxOptions.instance:updateFromLua()
end


SPG.OnGameStart = function()
	if SP.config.groupEnabled == false then return end

	local SV = SandboxVars.ZombieConfig
	groupSize_original = SV.RallyGroupSize
	groupDistance_original = SV.RallyTravelDistance
	groupSeperation_original = SV.RallyGroupSeparation
	groupRadius_original = SV.RallyGroupRadius

	Events.EveryDays.Add(SPG.changeGroupBehaviour)
end
Events.OnGameStart.Add(SPG.OnGameStart)