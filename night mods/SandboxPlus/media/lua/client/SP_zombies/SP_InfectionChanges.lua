SP_InfectionChanges = {}
local SPI = SP_InfectionChanges


SPI.isInfected = false
SPI.isFakeInfected = false
SPI.numScratched = 0
SPI.numLaceration = 0
SPI.numBitten = 0
SPI.attackingZombie = nil


SPI.AdjustInfection = function(_player, _item)
	local p = getPlayer():getBodyDamage()
	--check for healing
	if SPI.isInfected and p:IsInfected()==false then
		SPI.isInfected = false
	end
	if SPI.isFakeInfected and p:IsFakeInfected()==false then
		SPI.isFakeInfected = false
	end
	if p:getNumPartsScratched() < SPI.numScratched then
		SPI.numScratched = p:getNumPartsScratched()
	end
	if p:getNumPartsBitten() < SPI.numBitten then
		SPI.numBitten = p:getNumPartsBitten()
	end
	local numPartsLaceration = SPI.getNumPartsLaceration(p)
	if numPartsLaceration < SPI.numLaceration then
		SPI.numLaceration = numPartsLaceration
	end
	
	if SPI.isInfected then return end

	--handle injuries
	local attackingZombie = getPlayer():getAttackingZombie()
	if SPI.attackingZombie ~= attackingZombie then
		SPI.attackingZombie = attackingZombie
		if SPI.attackingZombie==nil then return end

		if p:getNumPartsScratched() > SPI.numScratched then
			--got scratched!
			SPI.numScratched = p:getNumPartsScratched()
			if ZombRand(0, 101) >= SP.config.scratchInfectionChance then
				SPI.setInfected(p,false)
				if SPI.isFakeInfected == false then SPI.setFakeInfected(p,false) end
			elseif ZombRand(0, 101) >= SP.config.scratchInfectionChanceDeath then
				SPI.setInfected(p,false)
				SPI.setFakeInfected(p,true)
			else
				SPI.setInfected(p,true)
				SPI:setIsFakeInfected(p,false)
			end
		elseif p:getNumPartsBitten() > SPI.numBitten then
			--got bitten!
			getPlayer():getEmitter():playSound("zombiebite_new")
			SPI.numBitten = p:getNumPartsBitten()
			if ZombRand(0, 101) >= SP.config.biteInfectionChance then
				SPI.setInfected(p,false)
				if SPI.isFakeInfected == false then SPI.setFakeInfected(p,false) end
			elseif ZombRand(0, 101) >= SP.config.biteInfectionChanceDeath then
				SPI.setInfected(p,false)
				SPI.setFakeInfected(p,true)
			else
				SPI.setInfected(p,true)
				SPI.setFakeInfected(p,false)
			end
		elseif numPartsLaceration > SPI.numLaceration then
			--new laceration!
			getPlayer():getEmitter():playSound("laceration")
			SPI.numLaceration = numPartsLaceration
			if ZombRand(0, 101) >= SP.config.lacerationInfectionChance then
				SPI.setInfected(p,false)
				if SPI.isFakeInfected == false then SPI.setFakeInfected(p,false) end
			elseif ZombRand(0, 101) >= SP.config.lacerationInfectionChanceDeath then
				SPI.setInfected(p,false)
				SPI.setFakeInfected(p,true)
			else
				SPI.setInfected(p,true)
				SPI.setFakeInfected(p,false)
			end
		end
	end
end

SPI.setInfected = function(p, bool)
	if bool then
		p:setInfected(true)
	else
		p:setInfected(false)
		for i = 0,16 do		
			p:getBodyPart( BodyPartType.FromIndex(i) ):SetInfected(false)
		end	
	end
	SPI.isInfected = bool
end
SPI.setFakeInfected = function(p, bool)
	if p:IsInfected() then return end
	if bool then
		p:setIsFakeInfected(true)
	else
		p:setIsFakeInfected(false)
		for i = 0,16 do		
			p:getBodyPart( BodyPartType.FromIndex(i) ):SetFakeInfected(false)
		end	
	end
	SPI.isFakeInfected = bool
end

SPI.getNumPartsLaceration = function(p)
	local counter = 0
	for i = 0,16 do
		if p:getBodyPart( BodyPartType.FromIndex(i) ):isCut() then
			counter = counter +1
		end
	end
	return counter
end

  
SPI.OnGameStart = function()
	if SP.config.infectionEnabled == false then return end

	local p = getPlayer():getBodyDamage()
	p:setHealthReductionFromSevereBadMoodles(0.01) --down from 0.0165
	-- SPI.isInfected = p:IsInfected() --always return false at OnGameStart!
	-- SPI.isFakeInfected = p:IsFakeInfected() --always return false at OnGameStart!
	for i = 0,16 do		
		if p:getBodyPart( BodyPartType.FromIndex(i) ):IsInfected() then
			SPI.isInfected = true
			break
		end
	end	
	for i = 0,16 do		
		if p:getBodyPart( BodyPartType.FromIndex(i) ):IsFakeInfected() then
			SPI.isFakeInfected = true
			break
		end
	end	
	SPI.numScratched = p:getNumPartsScratched()
	SPI.numBitten = p:getNumPartsBitten()
	SPI.numLaceration = SPI.getNumPartsLaceration(p)

	--Events.OnBeingHitByZombie.Add(SPI.AdjustInfection) --currently not working (21.11)
	Events.OnTick.Add(SPI.AdjustInfection)
end
Events.OnGameStart.Add(SPI.OnGameStart)