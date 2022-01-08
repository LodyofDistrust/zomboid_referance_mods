require "SP_Config"


SP_ClothingChanges = {}
local SPC = SP_ClothingChanges

SPC.clothingChanges = {
    Shirt_CamoDesert =      {15,7},
    Shirt_CamoGreen =       {15,7},
    Shirt_CamoUrban =       {15,7},
    Shirt_Ranger =          {15,7},
    Shirt_Lumberjack =      {10,5},
    Shirt_Workman =         {10,5},
    Shirt_OfficerWhite =    {10,5},
    Shirt_PrisonGuard =     {10,5},
    Shirt_PoliceBlue =      {10,5},
    Shirt_PoliceGrey =      {10,5},
    Shirt_Jockey01 =        {10,5},
    Shirt_Jockey02 =        {10,5},
    Shirt_Jockey03 =        {10,5},
    Shirt_Jockey04 =        {10,5},
    Shirt_Jockey05 =        {10,5},
    Shirt_Jockey06 =        {10,5},
    Shirt_Baseball_KY =     {10,5},
    Shirt_Baseball_Rangers ={10,5},
    Shirt_Baseball_Z =      {10,5},

    Tshirt_ArmyGreen =      {10,5},
    Tshirt_CamoDesert =     {10,5},
    Tshirt_CamoGreen =      {10,5},
    Tshirt_CamoUrban =      {10,5},
    Tshirt_PoliceBlue =     {10,5},
    Tshirt_PoliceGrey =     {10,5},
    Tshirt_Ranger =         {10,5},
    Tshirt_Sport =          {10,5},
    Tshirt_Profession_FiremanBlue =     {10,5},
    Tshirt_Profession_FiremanRed =      {10,5},
    Tshirt_Profession_FiremanRed02 =    {10,5},
    Tshirt_Profession_FiremanWhite =    {10,5},
    Tshirt_Profession_PoliceBlue =      {10,5},
    Tshirt_Profession_PoliceWhite =     {10,5},
    Tshirt_Profession_RangerBrown =     {10,5}, 
    Tshirt_Profession_RangerGreen =     {10,5},

    Vest_BulletArmy =       {100,100},
    Vest_BulletCivilian =   {100,100},
    Vest_BulletPolice =     {100,100},
    Vest_Foreman =          {10,5},
    Vest_HighViz =          {10,5},
    Vest_Hunting_Grey =     {10,5},
    Vest_Hunting_Orange =   {10,5},
    Vest_Hunting_Camo =     {10,5},
    Vest_Hunting_CamoGreen ={10,5},

    HazmatSuit =            {30,20},
    Boilersuit_Flying =     {20,10},

    Trousers_Police =       {15,10},
    Trousers_PoliceGrey =   {15,10},
    Trousers_Ranger =       {20,10},

    Hat_Beany =                 {10,0},
    Hat_Cowboy =                {10,0},
    Hat_DustMask =              {10,0},
    Hat_Police =                {10,0},
    Hat_Police_Grey =           {10,0},
    Hat_Ranger =                {10,0},
    Hat_WoolyHat =              {10,0},
    Hat_BucketHat =             {10,0},
    Hat_BonnieHat =             {10,0},
    Hat_BonnieHat_CamoGreen =   {10,0},
    Hat_PeakedCapArmy =         {10,0},
    Hat_BandanaMaskTINT =       {10,0},
    Hat_BandanaMask =           {10,0},
    Hat_BalaclavaFace =         {10,0},
    Hat_BalaclavaFull =         {20,10},

    Hat_Spiffo =            {20,20},
    Hat_WinterHat =         {30,30},
    Hat_GasMask =           {50,50},
    WeldingMask =           {60,60},
    Hat_BicycleHelmet =     {50,50},
    Hat_SPHhelmet =         {100,100},

    Hat_HardHat =           {50,50}, --reduced
    Hat_HardHat_Miner =     {50,50}, --reduced
    Hat_JockeyHelmet01 =    {50,50}, --reduced
    Hat_JockeyHelmet02 =    {50,50}, --reduced
    Hat_JockeyHelmet03 =    {50,50}, --reduced
    Hat_JockeyHelmet04 =    {50,50}, --reduced
    Hat_JockeyHelmet05 =    {50,50}, --reduced    
    Hat_JockeyHelmet06 =    {50,50}, --reduced    
    Hat_Fireman =           {70,70}, --reduced

    Glasses_SkiGoggles =    {10,10},
    Glasses_SafetyGoggles = {20,20},

    Gloves_FingerlessGloves ={10,5},
    Gloves_LongWomenGloves = {10,5},
    Gloves_WhiteTINT =       {10,5},
}

-- SPC.bodyPartDefenses = {}

--this is used just like BloodBodyPartType.FromIndex(i) in Java
-- SPC.BloodBodyPartTypes = {
--     "Hand_L", "Hand_R", "ForeArm_L", "ForeArm_R", "UpperArm_L", "UpperArm_R", "Torso_Upper", "Torso_Lower", "Head", "Neck", "Groin", "UpperLeg_L", "UpperLeg_R", "LowerLeg_L", "LowerLeg_R", "Foot_L", "Foot_R", "Back"
-- }


-- SPC.OnClothingUpdated = function(p)
-- 	local p = getPlayer()
-- 	local pBody = p:getBodyDamage()
-- 	for i = 0,pBody:getBodyParts():size()-2 do
-- 		if p:getBodyPartClothingDefense(i, false) ~= SPC.bodyPartDefenses[i] then
-- 			SPC.bodyPartDefenses[i] = p:getBodyPartClothingDefense(i, false)
-- 			local bloodBodyPartType = SPC.BloodBodyPartTypes[i+1]
-- 			-- itemVisual.removeHole(BloodBodyPartType.ToIndex(paramBloodBodyPartType));
-- 			print("---------------HOLE")
-- 	        --p:addHole(BloodBodyPartType.FromIndex(i));
--         end
-- 	end
-- end



SPC.OnInitWorld = function()
	if SP.config.armorEnabled == false then return end

    for name,values in pairs(SPC.clothingChanges) do
        local item = ScriptManager.instance:getItem(name)
        if item then
            item:DoParam("scratchDefense="..values[1])
            item:DoParam("biteDefense="..values[2])
        else
            print("Sandbox+ WARNING: item "..name.." not found!")
        end
    end
    ScriptManager.instance:getItem("Jumper_PoloNeck"):DoParam("NeckProtectionModifier=1")
    -- Events.OnClothingUpdated.Add(SPC.OnClothingUpdated)
end
Events.OnInitWorld.Add(SPC.OnInitWorld)
