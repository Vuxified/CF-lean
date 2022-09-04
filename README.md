# CF-lean
MLO Used based on this script:
https://www.gta5-mods.com/maps/mlo-drugfarm-add-on-fivem

Requirements:
QB-Target



Drug Script 
['lean'] 		 		 = {['name'] = 'lean', 			 			['label'] = 'Lean', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'images/lean.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Time to get fucked up'},

['styrofoamcups'] 		 = {['name'] = 'styrofoamcups', 			['label'] = 'Styrofoam Cups', 		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'images/styrofoamcups.png', ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Used for drinks'},

['promethazine'] 		 = {['name'] = 'promethazine', 			    ['label'] = 'Promethazine', 		['weight'] = 800, 		['type'] = 'item', 		['image'] = 'images/promethazine.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Suppose to be used when people are sick'},

['codeine'] 		 	 = {['name'] = 'codeine', 			  		['label'] = 'Codeine', 				['weight'] = 800, 		['type'] = 'item', 		['image'] = 'images/codeine.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Relieve some pain'},

['coughsyrup'] 			 = {['name'] = 'coughsyrup', 			    ['label'] = 'Cough Syrup', 			['weight'] = 400, 		['type'] = 'item', 		['image'] = 'images/coughsyrup.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Main Ingredient'},

['sprite'] 				 = {['name'] = 'sprite', 			    	['label'] = 'Sprite', 				['weight'] = 300, 		['type'] = 'item', 		['image'] = 'images/sprite.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Tasty Drink'},


Add this into your qb-shops
1. Go to Config.lua
2. Config.Products
3. Copy this code
 [13] = {
            name = "styrofoamcups",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
        },
4. Place it into Config.Products = {
["normal"] = {
    
}
}

Add this in qbcore/server/player.lua

PlayerData.metadata['drugxp'] = PlayerData.metadata['drugxp'] or 0 -- Added for lean or drug you wish to make.

Go to qb-drugs/config.lua

and go to Config.CornerSellingDrugsList{
    "lean"
}
 then go to 
 Config.DrugsPrice{

     ["lean"] = {
        min = 400,
        max = 500,
    },
 }

 Go to Dpemotes/client/animationlist.lua
 then to DP.Emotes{

 }
 and this inside DP.Emotes
    ["drinklean"] = {"mp_player_intdrink", "loop_bottle", "Drink", AnimationOptions =
   {
        Prop = "v_ret_gc_cup",
        PropBone = 18905,
        PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true,
        EmoteLoop = true,
   }},
