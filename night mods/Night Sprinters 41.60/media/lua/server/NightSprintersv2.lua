--Cool little thing I saw Xeph's mod use to ensure zombies have the correct speed value for each client
--Essentially, makes the zombie update every 5 seconds no matter what
local updateInterval = 100;

--Changes the zombie's speed based off it's current speed and the speed lore value in the sandbox
--Called on: Client and SinglePlayer
local function ZombieChange(zombie)
	local vMod = zombie:getModData();
	vMod.Ticks = vMod.Ticks or 0;
	vMod.Speed = vMod.Speed or -1;
	
	local speedLore = getSandboxOptions():getOptionByName("ZombieLore.Speed"):getValue();
	local strengthLore = getSandboxOptions():getOptionByName("ZombieLore.Strength"):getValue();
	local toughnessLore = getSandboxOptions():getOptionByName("ZombieLore.Toughness"):getValue();
	local cognitionLore = getSandboxOptions():getOptionByName("ZombieLore.Cognition"):getValue();
	local memoryLore = getSandboxOptions():getOptionByName("ZombieLore.Memory"):getValue();
	local sightLore = getSandboxOptions():getOptionByName("ZombieLore.Sight"):getValue();
	local hearingLore = getSandboxOptions():getOptionByName("ZombieLore.Hearing"):getValue();
	local smellLore = getSandboxOptions():getOptionByName("ZombieLore.Smell"):getValue();
	
	--------- change "vMod.Speed ~= speedLore" to "vMod.Cognition ~= cognitionLore" if not changing speed
	-- is update needed?             if so is it single player?             -- or maybe it's a client with zombie ownership within range
	if vMod.Speed ~= speedLore and ((not isClient() and not isServer()) or (isClient() and not zombie:isRemoteZombie())) then
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		vMod.Speed = speedLore;
		vMod.Strength = strengthLore;
		vMod.Toughness = toughnessLore;
		vMod.Cognition = cognitionLore;
		vMod.Memory = memoryLore;
		vMod.Sight = sightLore;
		vMod.Hearing = hearingLore;
		vMod.Smell = smellLore;
		vMod.Ticks = 0;
	--   Has 5 seconds past since last update?            (I know I can just use an or statement with the top if statement, but it's getting hard to read up there)
	elseif vMod.Ticks >= updateInterval then
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		vMod.Speed = speedLore;
		vMod.Strength = strengthLore;
		vMod.Toughness = toughnessLore;
		vMod.Cognition = cognitionLore;
		vMod.Memory = memoryLore;
		vMod.Sight = sightLore;
		vMod.Hearing = hearingLore;
		vMod.Smell = smellLore;
		vMod.Ticks = 0;
		--print("reupdated");
	else
		vMod.Ticks = vMod.Ticks + 1;
	end
end

--For right now this is pointless, but there are some things that I might need to do that will use this, so I'm keeping it here since it doesn't affect much
--Called on: Client and SinglePlayer
local function gameStart()
	Events.OnZombieUpdate.Add(ZombieChange);
end

Events.OnGameStart.Add(gameStart);
