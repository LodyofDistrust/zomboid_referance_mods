--local variable for mod settings
local nsOptions;

--gets the starting time for when zombies will follow the modified speed value
--Called on: Everything
local function getStartTime()
	local gametime = GameTime:getInstance();
	local month = gametime:getMonth();
	if month>=2 and month<=4 then
		return nsOptions.startSpring-1;
	elseif month>=5 and month<=7 then
		return nsOptions.startSummer-1;
	elseif month>=8 and month<=10 then
		return nsOptions.startAutumn-1;
	end
	return nsOptions.startWinter-1;
end

--gets the ending time for when zombies will stop following the modified speed value
--Called on: Everything
local function getEndTime()
	local gametime = GameTime:getInstance();
	local month = gametime:getMonth();
	if month>=2 and month<=4 then
		return nsOptions.endSpring-1;
	elseif month>=5 and month<=7 then
		return nsOptions.endSummer-1;
	elseif month>=8 and month<=10 then
		return nsOptions.endAutumn-1;
	end
	return nsOptions.endWinter-1;
end

--This method changes the zombie speed of zombies loaded by the server, but not on the client
--Called on: Server
local function changeServerSideZoms(zombie)
	zombie:makeInactive(true);
	zombie:makeInactive(false);
end

local function updateAllServerZoms()
	local zombieList = getCell():getZombieList();
	local zomSize = zombieList:size() - 1;
	for i=0,zomSize do
		changeServerSideZoms(zombieList:get(i));
	end
end

--This method is crucial as it is in charge of changing the lore speed given the time and settings
--Called on: Everything
local function changeLore()
	--bit janky, but it works I guess
	if not nsOptions and isClient() then
		sendClientCommand("NightSprinter","SettingsRequest",{});
		return;
	end
	local gTime = getGameTime();
	local hour = gTime:getTimeOfDay();
	local startTime = getStartTime();
	local endTime = getEndTime();
	local rain = RainManager:getRainIntensity();
	local rv = 0.02;
	local oldSpeed = getSandboxOptions():getOptionByName("ZombieLore.Speed"):getValue();
	--local oldCognition = getSandboxOptions():getOptionByName("ZombieLore.Cognition"):getValue();  --- if speed stays same day and night swap to cognition
	
	local newSpeed;
	local newStrength;
	local newToughness;
	local newCognition;
	local newMemory;
	local newSight;
	local newHearing;
	local newSmell;

	---- if it's day and raining -------
	if (hour >= startTime and hour < endTime) or (rain>rv and nsOptions.rainSprinters) then
		newSpeed = nsOptions.modifiedSpeed
		newStrength = nsOptions.modifiedStrength
		newToughness = nsOptions.modifiedToughness
		newCognition = nsOptions.modifiedCognition
		newMemory = nsOptions.modifiedMemory
		newSight = nsOptions.modifiedSight
		newHearing = nsOptions.modifiedHearing
		newSmell = nsOptions.modifiedSmell
		--getSandboxOptions():set("ZombieLore.Speed",newSpeed);
	---- if it's night -------
	elseif (hour>=startTime or hour<endTime) and startTime>endTime then
		newSpeed = nsOptions.modifiedSpeed
		newStrength = nsOptions.modifiedStrength
		newToughness = nsOptions.modifiedToughness
		newCognition = nsOptions.modifiedCognition
		newMemory = nsOptions.modifiedMemory
		newSight = nsOptions.modifiedSight
		newHearing = nsOptions.modifiedHearing
		newSmell = nsOptions.modifiedSmell
		--getSandboxOptions():set("ZombieLore.Speed",newSpeed);
	else
	---- it must be day and clear then -------
		newSpeed = nsOptions.normalSpeed
		newStrength = nsOptions.normalStrength
		newToughness = nsOptions.normalToughness
		newCognition = nsOptions.normalCognition
		newMemory = nsOptions.normalMemory
		newSight = nsOptions.normalSight
		newHearing = nsOptions.normalHearing
		newSmell = nsOptions.normalSmell
		--getSandboxOptions():set("ZombieLore.Speed",newSpeed);
	end
	if newSpeed ~= oldSpeed then  --- if speed stays same day and night swap to cognition
	-- if newCognition ~= oldCognition then --- if cognition stays same day and night swap to speed
		getSandboxOptions():set("ZombieLore.Speed",newSpeed);
		getSandboxOptions():set("ZombieLore.Strength",newStrength);
		getSandboxOptions():set("ZombieLore.Toughness",newToughness);
		getSandboxOptions():set("ZombieLore.Cognition",newCognition);
		getSandboxOptions():set("ZombieLore.Memory",newMemory);
		getSandboxOptions():set("ZombieLore.Sight",newSight);
		getSandboxOptions():set("ZombieLore.Hearing",newHearing);
		getSandboxOptions():set("ZombieLore.Smell",newSmell);
		if isServer() then
			updateAllServerZoms();
		end
	end
end

--finalizes the settings
--Called on: Servers and singleplayer
local function finilizeSettings()
	local globalData = getGameTime():getModData();
	
	if(globalData.NSSETTINGS and globalData.NSSETTINGS.ironmanSettings) then
		nsOptions = globalData.NSSETTINGS;
	else
		nsOptions = copyTable(NS.SETTINGS.options);
		globalData.NSSETTINGS = nsOptions;
	end
end

--Sends the client the server options
--Called on: Servers and clients, but funcitionally speaking only on servers
local nsOnClientCommand = function(module, command, args)
	if not isServer() and module ~= "NightSprinter" or command ~= "SettingsRequest" then
		return;
	end
	if command == "SettingsRequest" then
		sendServerCommand("NightSprinter","InitSettings",nsOptions);
		updateAllServerZoms();
	end
end

--This should work to make sure all clients have the same settings
--Called on: Servers and clients, but funcitionally speaking only on clients
local nsOnServerCommand = function(module, command, args)
	if not isClient() and module ~= "NightSprinter" or command ~= "InitSettings" then
		return
	end;
	nsOptions = copyTable(args);
	changeLore();
end

--handles event types for each type of game instance: server, singleplayer, and client in that order
--Called on: Everything
local function handleEvents()
	if isServer() then
		finilizeSettings();
		Events.EveryTenMinutes.Add(changeLore);
		Events.OnClientCommand.Add(nsOnClientCommand);
		Events.OnConnected.Add(onClientConnected);
		changeLore();
	elseif not isClient() then
		finilizeSettings();
		Events.EveryTenMinutes.Add(changeLore);
		changeLore();
	else
		Events.OnServerCommand.Add(nsOnServerCommand);
		Events.EveryTenMinutes.Add(changeLore);
		changeLore();
	end
end


Events.OnGameStart.Add(handleEvents);
Events.OnServerStarted.Add(handleEvents);
