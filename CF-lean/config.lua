 Config = {}


 -- Chance of  GainingXp
 Config.GainingXp = 75

 --Making Sprite Consumable
 Config.ConsuambleSprite =true
 --Drug items if Drug XP enabled
 Config.CoughSyrup = math.random(1,2)
 Config.Codeine = math.random(1,2)
 Config.Promethazine = math.random(1,2)
 Config.Lean = math.random(1,2)
 
  --If you want Drug XP
Config.EnableDrugXP = true
Config.DrugXPReward = math.random(3,5)
Config.DrugXPRemoved = math.random(3,5)
Config.DrugLevels = {
   100, --level 1
   300, --level 2
   600, --level 3
   900, --level 4
 
}


--Chances of cops getting a dispatch
 
Config.PoliceCallChance = 15
-- Keep this true if you want comes to get notifications
Config.PoliceNotify = true
-- If changing these locations you must go to client.lua and make your own polyzones and create your own length, width, minz,min max
 Config.Loc = {
    [1] = vector3(-31.37, 2881.45, 55.54), -- Location for Promethazine
    [2] = vector3(-27.21, 2886.4, 55.54), -- Location for Codeine
    [3] = vector3(1399.69, 3605.87, 34.98),-- Location for Sprite
    [4] = vector3(1391.15, 3605.52, 38.94), -- Location for making cough syrup
    [5] = vector3(136.02, -1968.97, 18.86) -- Location for making lean

 }
 --Progress bar Timings
 Config.Timing = math.random(3000,5000)