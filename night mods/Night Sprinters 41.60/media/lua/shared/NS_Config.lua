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

  local pSettings = settings:getData("ironmanSettings")
  pSettings.tooltip = "IGUI_NS_pSettings_ToolTip"


end

NS = {}
NS.SETTINGS = SETTINGS