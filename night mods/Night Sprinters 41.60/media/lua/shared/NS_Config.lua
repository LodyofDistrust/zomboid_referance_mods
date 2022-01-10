require "ChangeZombieLore"
local SETTINGS = {
  options = { 
    rainSprinters = false,
    ironmanSettings = false,
  
    startSummer=24,
    endSummer=7,
    startAutumn=23,
    endAutumn=7,
    startWinter=21,
    endWinter=7,
    startSpring=23,
    endSpring=7,
    
    normalSpeed=2,
    modifiedSpeed=1,
		
    normalStrength=2,
    modifiedStrength=2,
    normalToughness=2,
    modifiedToughness=2,
    normalCognition=2,
    modifiedCognition=1,
    normalMemory=2,
    modifiedMemory=2,
    normalSight=2,
    modifiedSight=1,
    normalHearing=2,
    modifiedHearing=2,
    normalSmell=2,
    modifiedSmell=2,
		
  },
  names = {
    rainSprinters = "Rain Sprinters",
    ironmanSettings = "Permanent Settings",
  
    startSummer= "Start Summer",
    endSummer="End Summer",
    startAutumn="Start Autumn",
    endAutumn="End Autumn",
    startWinter="Start Winter",
    endWinter="End Winter",
    startSpring="Start Spring",
    endSpring="End Spring",

    normalSpeed="Normal Zombie Speed",
    modifiedSpeed="Modified Zombie Speed",
		
    normalStrength="Normal Zombie Strength",
    modifiedStrength="Modified Zombie Strength",
    normalToughness="Normal Zombie Toughness",
    modifiedToughness="Modified Zombie Toughness",
    normalCognition="Normal Zombie Cognition",
    modifiedCognition="Modified Zombie Cognition",
    normalMemory="Normal Zombie Memory",
    modifiedMemory="Modified Zombie Memory",
    normalSight="Normal Zombie Sight",
    modifiedSight="Modified Zombie Sight",
    normalHearing="Normal Zombie Hearing",
    modifiedHearing="Modified Zombie Hearing",
    normalSmell="Normal Zombie Smell",
    modifiedSmell="Modified Zombie Smell",
  },
  mod_id = "NightSprinters",
  mod_shortname = "Night Sprinters",
}
-- Connecting the options to the menu
if ModOptions and ModOptions.getInstance then
  local settings = ModOptions:getInstance(SETTINGS)

  local seasonVariables = {"startSummer","endSummer","startAutumn","endAutumn","startWinter","endWinter","startSpring","endSpring"}
  for key, value in pairs(seasonVariables) do
	local drop = settings:getData(value)
	drop[1] = getText("IGUI_NS_Chioce0") 
  	drop[2] = getText("IGUI_NS_Chioce1")
  	drop[3] = getText("IGUI_NS_Chioce2") 
	drop[4] = getText("IGUI_NS_Chioce3") 
  	drop[5] = getText("IGUI_NS_Chioce4")
  	drop[6] = getText("IGUI_NS_Chioce5")
	drop[7] = getText("IGUI_NS_Chioce6") 
  	drop[8] = getText("IGUI_NS_Chioce7")
  	drop[9] = getText("IGUI_NS_Chioce8")
	drop[10] = getText("IGUI_NS_Chioce9") 
	drop[11] = getText("IGUI_NS_Chioce10") 
  	drop[12] = getText("IGUI_NS_Chioce11")
  	drop[13] = getText("IGUI_NS_Chioce12") 
	drop[14] = getText("IGUI_NS_Chioce13") 
  	drop[15] = getText("IGUI_NS_Chioce14")
  	drop[16] = getText("IGUI_NS_Chioce15")
	drop[17] = getText("IGUI_NS_Chioce16") 
  	drop[18] = getText("IGUI_NS_Chioce17")
  	drop[19] = getText("IGUI_NS_Chioce18")
	drop[20] = getText("IGUI_NS_Chioce19") 
  	drop[21] = getText("IGUI_NS_Chioce20")
  	drop[22] = getText("IGUI_NS_Chioce21") 
	drop[23] = getText("IGUI_NS_Chioce22")
	drop[24] = getText("IGUI_NS_Chioce23")

	drop.tooltip = "IGUI_NS_Seasons_Tooltip"
  end
	
  local speedtypes = settings:getData("normalSpeed")
  speedtypes[1] = getText("IGUI_NS_Sprinters")
  speedtypes[2] = getText("IGUI_NS_FastShamblers")
  speedtypes[3] = getText("IGUI_NS_Shamblers")
  speedtypes[4] = getText("IGUI_NS_Random")

  local mspeedtypes = settings:getData("modifiedSpeed")
  mspeedtypes[1] = getText("IGUI_NS_Sprinters")
  mspeedtypes[2] = getText("IGUI_NS_FastShamblers")
  mspeedtypes[3] = getText("IGUI_NS_Shamblers")
  mspeedtypes[4] = getText("IGUI_NS_Random")
	
  local strengthtypes = settings:getData("normalStrength")
  strengthtypes[1] = getText("IGUI_NS_strsuperhuman")
  strengthtypes[2] = getText("IGUI_NS_strnormal")
  strengthtypes[3] = getText("IGUI_NS_strweak")
  strengthtypes[4] = getText("IGUI_NS_Random")
	
  local mstrengthtypes = settings:getData("modifiedStrength")
  mstrengthtypes[1] = getText("IGUI_NS_strsuperhuman")
  mstrengthtypes[2] = getText("IGUI_NS_strnormal")
  mstrengthtypes[3] = getText("IGUI_NS_strweak")
  mstrengthtypes[4] = getText("IGUI_NS_Random")
  
  local toughnesstypes = settings:getData("normalToughness")
  toughnesstypes[1] = getText("IGUI_NS_toughtough")
  toughnesstypes[2] = getText("IGUI_NS_toughnormal")
  toughnesstypes[3] = getText("IGUI_NS_toughfragile")
  toughnesstypes[4] = getText("IGUI_NS_Random")
	
  local mtoughnesstypes = settings:getData("modifiedToughness")
  mtoughnesstypes[1] = getText("IGUI_NS_toughtough")
  mtoughnesstypes[2] = getText("IGUI_NS_toughnormal")
  mtoughnesstypes[3] = getText("IGUI_NS_toughfragile")
  mtoughnesstypes[4] = getText("IGUI_NS_Random")	

  local cognitiontypes = settings:getData("normalCognition")
  cognitiontypes[1] = getText("IGUI_NS_cognavndoor")
  cognitiontypes[2] = getText("IGUI_NS_cognav")
  cognitiontypes[3] = getText("IGUI_NS_cogbasicnav")
  cognitiontypes[4] = getText("IGUI_NS_Random")
	
  local mcognitiontypes = settings:getData("modifiedCognition")
  mcognitiontypes[1] = getText("IGUI_NS_cognavndoor")
  mcognitiontypes[2] = getText("IGUI_NS_cognav")
  mcognitiontypes[3] = getText("IGUI_NS_cogbasicnav")
  mcognitiontypes[4] = getText("IGUI_NS_Random")
	
  local memorytypes = settings:getData("normalMemory")
  memorytypes[1] = getText("IGUI_NS_memlong")
  memorytypes[2] = getText("IGUI_NS_memnormal")
  memorytypes[3] = getText("IGUI_NS_memshort")
  memorytypes[4] = getText("IGUI_NS_memnone")
	
  local mmemorytypes = settings:getData("modifiedMemory")
  mmemorytypes[1] = getText("IGUI_NS_memlong")
  mmemorytypes[2] = getText("IGUI_NS_memnormal")
  mmemorytypes[3] = getText("IGUI_NS_memshort")
  mmemorytypes[4] = getText("IGUI_NS_memnone")	
  
  local sighttypes = settings:getData("normalSight")
  sighttypes[1] = getText("IGUI_NS_sighteagle")
  sighttypes[2] = getText("IGUI_NS_sightnormal")
  sighttypes[3] = getText("IGUI_NS_sightpoor")
	
  local msighttypes = settings:getData("modifiedSight")
  msighttypes[1] = getText("IGUI_NS_sighteagle")
  msighttypes[2] = getText("IGUI_NS_sightnormal")
  msighttypes[3] = getText("IGUI_NS_sightpoor")
  
  local hearingtypes = settings:getData("normalHearing")
  hearingtypes[1] = getText("IGUI_NS_hearpinpoint")
  hearingtypes[2] = getText("IGUI_NS_hearnormal")
  hearingtypes[3] = getText("IGUI_NS_hearpoor")
	
  local mhearingtypes = settings:getData("modifiedHearing")
  mhearingtypes[1] = getText("IGUI_NS_hearpinpoint")
  mhearingtypes[2] = getText("IGUI_NS_hearnormal")
  mhearingtypes[3] = getText("IGUI_NS_hearpoor")
  
  local smelltypes = settings:getData("normalSmell")
  smelltypes[1] = getText("IGUI_NS_smellpinpoint")
  smelltypes[2] = getText("IGUI_NS_smellnormal")
  smelltypes[3] = getText("IGUI_NS_smellpoor")
	
  local msmelltypes = settings:getData("modifiedSmell")
  msmelltypes[1] = getText("IGUI_NS_smellpinpoint")
  msmelltypes[2] = getText("IGUI_NS_smellnormal")
  msmelltypes[3] = getText("IGUI_NS_smellpoor")

  local pSettings = settings:getData("ironmanSettings")
  pSettings.tooltip = "IGUI_NS_pSettings_ToolTip"


end

NS = {}
NS.SETTINGS = SETTINGS
