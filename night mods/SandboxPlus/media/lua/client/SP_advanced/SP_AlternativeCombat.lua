SP_AlternativeCombat = {}
local SPAC = SP_AlternativeCombat


SPAC.currentWeapon = nil
SPAC.maxHitCountModified = -2

SPAC.weaponChanges = {
	MetalBar = 2,
	MetalPipe = 2,
	LeadPipe = 2,
	PipeWrench = 2,
	Crowbar = 2,
	DumbBell = 2,
	Nightstick = 2,
	SnowShovel = 3,
	Shovel = 3,
	Shovel2 = 3,
	Golfclub = 3,
	BaseballBat = 3,
	BaseballBatNails = 3,
	Axe = 3,
	BarBell = 3,
	WoodAxe = 4,
	Katana = 4,
	Sledgehammer = 5,
	Sledgehammer2 = 5,
}

local player = nil
local modData = nil
local wasAiming = false


SPAC.OnEquipPrimary = function(_player, _item) --also triggers when de-equipping!
	if SPAC.currentWeapon then
		SPAC.resetOriginalStats()
		SPAC.currentWeapon = nil
	end
	if instanceof(_item, "HandWeapon") then --new weapon equipped
		SPAC.currentWeapon = _item
	end
end


SPAC.OnWeaponSwing = function(_player, _weapon)

	--movement while shoving

	if modData.AttackBlockMovementsOriginal == true then
		if SandboxVars.AttackBlockMovements == true and _player:isShoving() then
			SandboxVars.AttackBlockMovements = false
			SandboxOptions.instance:updateFromLua()
			_player:AttemptAttack(0) -- need to call AttemptAttack(0) here to make the game process the changes
		elseif SandboxVars.AttackBlockMovements == false and not _player:isShoving() then
			SandboxVars.AttackBlockMovements = true
			SandboxOptions.instance:updateFromLua()
			_player:AttemptAttack(0)
		end
	end
	
	--multihit

	if _player:isShoving() then return end -- number of targets for shoving is hardcoded..
	if _weapon == nil or not instanceof(_weapon, "HandWeapon") then return end
	-- if _weapon:getSubCategory() ~= "Swinging" then return end -- test this!

	--get weapon after loading game
	if SPAC.currentWeapon == nil then
		SPAC.OnEquipPrimary(_player, _weapon)
	end

	if SPAC.currentWeapon:getSubCategory() == "Spear" then
		-- spears are now single target only
		SPAC.maxHitCountModified = 1
	elseif SPAC.currentWeapon:isTwoHandWeapon() == false and SPAC.weaponChanges[SPAC.currentWeapon:getType()] == nil then
		-- 1-handed weapons are now single target only, unless they're in our special list
		SPAC.maxHitCountModified = 1
	else
		local maxHitCountOriginal = ScriptManager.instance:getItem( SPAC.currentWeapon:getFullType() ):getMaxHitCount()
		local weaponPerkLvl = SPAC.getPerkLevel(_player, SPAC.currentWeapon)
		if weaponPerkLvl and weaponPerkLvl ~= -1 then
			SPAC.maxHitCountModified = maxHitCountOriginal/10 * (_player:getPerkLevel(Perks.Strength) + weaponPerkLvl + _player:getStats():getEndurance()*10) /3
		else
			SPAC.maxHitCountModified = maxHitCountOriginal
		end
	end

	local hitCount = SPAC.maxHitCountModified
	local chanceToHit = (hitCount - math.floor(hitCount)) * 100
	local r = ZombRand(100)
	if r > chanceToHit then
		hitCount = math.floor(hitCount)
	else
		hitCount = math.ceil(hitCount)
	end
	if hitCount == 0 then hitCount = 1 end
	SPAC.currentWeapon:setMaxHitCount(hitCount)
end


SPAC.resetOriginalStats = function()
	SPAC.currentWeapon:setMaxHitCount( ScriptManager.instance:getItem(SPAC.currentWeapon:getFullType()):getMaxHitCount() )
end


SPAC.getPerkLevel = function(_player, _weapon)
	local categories = _weapon:getCategories()
	for i = 0,categories:size()-1 do
		local s = categories:get(i)
		if 	   s =="Axe" 		then return _player:getPerkLevel(Perks.Axe)
		elseif s =="SmallBlunt" then return _player:getPerkLevel(Perks.SmallBlunt)
		elseif s =="Blunt" 		then return _player:getPerkLevel(Perks.Blunt)
		elseif s =="SmallBlade" then return _player:getPerkLevel(Perks.SmallBlade)
		elseif s =="LongBlade" 	then return _player:getPerkLevel(Perks.LongBlade)
		elseif s =="Spear" 		then return _player:getPerkLevel(Perks.Spear)
		elseif s =="Improvised" then return -1
		elseif s =="Unarmed" 	then return -1
		end
	end
	if s ~= nil then
		print("S+ MOD ERROR: Weapon type not found:", s)
	end
	return -1
end



SPAC.OnTick = function()
	if player:isAiming() then
		if wasAiming == false then
			modData.turnDeltaOriginal = player:getTurnDelta()
			player:setTurnDelta(2.5)
			wasAiming = true
		end
	else
		if wasAiming == true then
			player:setTurnDelta( modData.turnDeltaOriginal )
			wasAiming = false
		end
	end
end



SPAC.OnGameStart = function()
	if SP.config.combatEnabled == false then return end

	for name,value in pairs(SPAC.weaponChanges) do
		ScriptManager.instance:getItem(name):setMaxHitCount(value)
	end

	player = getPlayer()
	modData = getPlayer():getModData()
	if modData.AttackBlockMovementsOriginal == nil then
		modData.AttackBlockMovementsOriginal = SandboxVars.AttackBlockMovements
		modData.MultiHitZombiesOriginal = SandboxVars.MultiHitZombies
	end
	SandboxVars.MultiHitZombies = true
	SandboxOptions.instance:updateFromLua()

	Events.OnTick.Add(SPAC.OnTick)
	Events.OnEquipPrimary.Add(SPAC.OnEquipPrimary)
	Events.OnWeaponSwing.Add(SPAC.OnWeaponSwing)
end
Events.OnGameStart.Add(SPAC.OnGameStart)
