QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = false
local curentPolice = 0
local jobduty
-- Drug Animation when drinking it

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
		isLoggedIn = true

    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo

end)

--Functions
--This is for police to get a notification when making coughsyrup, and lean
local function PoliceCall()
	if Config.PoliceNotify == true then
    	if Config.PoliceCallChance >= math.random(1,100) then

		--PS DISPTACH
		exports['ps-dispatch']:SuspiciousActivity()
         -- TriggerServerEvent('police:server:policeAlert', 'Suspicious Activity happening')  This is the basic QBCore dispatch
    	end
	else
		return
	end
end

-- Lean effect thanks to qb-smallresource for most of this lol ;)
function DrinkingLeanEffect()
	local num = 30
	while num > 0 do
		Wait(100)
		num = num -1
	SetFlash(0, 0, 500, 7000, 500)
	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)
	StartScreenEffect("DrugsTrevorClownsFightIn", 2.0, 0)
    Wait(1000)
    StartScreenEffect("DrugsTrevorClownsFight", 2.0, 0)
    Wait(1000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 2.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")


	end

end
--RegisterNetEvent
--Making Sprite and Lean consumables

RegisterNetEvent('consumables:clientLeanDrink', function(itemName)

    TriggerEvent('animations:client:EmoteCommandStart', {"drinklean"})
    QBCore.Functions.Progressbar("Lean", "Drinking Lean", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 8)
		DrinkingLeanEffect()
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

    end)
end)
RegisterNetEvent('consumables:clientSprite', function(itemName)

    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("Sprite", "Drinkin Sprite", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

    end)
end)



--Collecting Promethazine
RegisterNetEvent('CF-lean:client:GatheringPromethazine',function()
	QBCore.Functions.PlayAnim("missexile3", "ex03_dingy_search_case_base_michael", 0, Config.Timing)
	TriggerEvent('canUseInventoryAndHotbar:toggle', false)
	QBCore.Functions.Progressbar('Promethazine', 'Making Promethazine', Config.Timing, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true
	    }, {}, {}, {}, function() -- working
			TriggerEvent('canUseInventoryAndHotbar:toggle', true)
			TriggerServerEvent('CF-lean:server:GatheringPromethazine')



    	end, function() -- Cancelled or not working
			StopAnimTask(PlayerPedId(),"missexile3", "ex03_dingy_search_case_base_michael", 0)
			TriggerEvent('canUseInventoryAndHotbar:toggle', true) -- Enable

	    end)


end)

--Gathering Codeine
RegisterNetEvent('CF-lean:client:GatheringCodeine',function()
	QBCore.Functions.PlayAnim("missexile3", "ex03_dingy_search_case_base_michael", 0, Config.Timing)
	TriggerEvent('canUseInventoryAndHotbar:toggle', false)
	QBCore.Functions.Progressbar('Codeine', 'Making Codeine', Config.Timing, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true
	    }, {}, {}, {}, function() --
			TriggerEvent('canUseInventoryAndHotbar:toggle', true)
			TriggerServerEvent('CF-lean:server:GatheringCodeine')


    	end, function() -- Cancelled or not working
			StopAnimTask(PlayerPedId(),"missexile3", "ex03_dingy_search_case_base_michael", 0)
			TriggerEvent('canUseInventoryAndHotbar:toggle', true)

	    end)


end)

-- Gathering Sprite
RegisterNetEvent('CF-lean:client:GatheringSprite',function()
	QBCore.Functions.PlayAnim("missexile3", "ex03_dingy_search_case_base_michael", 0, Config.Timing)
	TriggerEvent('canUseInventoryAndHotbar:toggle', false)
	QBCore.Functions.Progressbar('Sprite', 'Gathering Sprite', Config.Timing, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true
	    }, {}, {}, {}, function() -- working
			TriggerEvent('canUseInventoryAndHotbar:toggle', true)
			TriggerServerEvent('CF-lean:server:GatheringSprite')


    	end, function() -- Cancelled or not working
			StopAnimTask(PlayerPedId(),"missexile3", "ex03_dingy_search_case_base_michael", 0)
			TriggerEvent('canUseInventoryAndHotbar:toggle', true)
	    end)


end)

-- Mixing the Ingredients to make cough syrup
RegisterNetEvent('CF-lean:client:MakingCoughSyrup', function()

	local items = {'promethazine', 'codeine'}
	local hasItem = QBCore.Functions.HasItem(items)
			if hasItem then
				QBCore.Functions.PlayAnim("missexile3", "ex03_dingy_search_case_base_michael", 0, Config.Timing)
				TriggerEvent('canUseInventoryAndHotbar:toggle', false)
				QBCore.Functions.Progressbar('MakingCoughSyrup', 'Creating Cough Syrup', Config.Timing, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true
					}, {}, {}, {}, function() -- working
						TriggerServerEvent('CF-lean:server:MakingCoughSyrup')
						PoliceCall()

						TriggerEvent('canUseInventoryAndHotbar:toggle', true)




					end, function() -- Cancelled or not working
						StopAnimTask(PlayerPedId(),"missexile3", "ex03_dingy_search_case_base_michael", 0)
						TriggerEvent('canUseInventoryAndHotbar:toggle', true)
					end)
				Wait(Config.Timing)
				QBCore.Functions.Notify('You made  cough syrup', "success", 5000)
			else
				QBCore.Functions.Notify('You are missing something', 'error', 5000)
			end

end)

--Final Step Creating the purple drink :)
RegisterNetEvent('CF-lean:client:MakingLean', function()

	local items = {'coughsyrup', 'styrofoamcups', 'sprite'}
	local hasItem = QBCore.Functions.HasItem(items)
			if hasItem then
				QBCore.Functions.PlayAnim("missexile3", "ex03_dingy_search_case_base_michael", 0, Config.Timing)
				TriggerEvent('canUseInventoryAndHotbar:toggle', false)
				QBCore.Functions.Progressbar('CretingLean', 'Creating Lean', Config.Timing, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true
					}, {}, {}, {}, function() -- working
						TriggerServerEvent('CF-lean:server:MakingLean')
						PoliceCall()
						TriggerEvent('canUseInventoryAndHotbar:toggle', true)





					end, function() -- Cancelled or not working
						StopAnimTask(PlayerPedId(),"missexile3", "ex03_dingy_search_case_base_michael", 0)
						TriggerEvent('canUseInventoryAndHotbar:toggle', true)
					end)
				Wait(Config.Timing)
				QBCore.Functions.Notify('You made made Lean', "success", 5000)
			else
				QBCore.Functions.Notify('You are missing something', 'error', 5000)
			end

end)




--Exports for QBCore Target
--For Promethazine

exports['qb-target']:AddBoxZone("promethazine", Config.Loc[1], 2.45, 1, {
	name = "promethazine",
	heading = 340.0,
	debugPoly = false,
	minZ=51.74,
	maxZ=55.74,
}, {
	options = {
		{
            type = "client",
            event = "CF-lean:client:GatheringPromethazine",
			icon = "fas fa-bottle-droplet",
			label = "Make some Promethazine",
			--item = ""
		},
	},
	distance = 2.5
})


-- For Codeine
exports['qb-target']:AddBoxZone("Codeine", Config.Loc[2],2.2, 1, {
	name = "Codeine",
	heading = 70.0,
	debugPoly = false,
	minZ=51.74,
  	maxZ=55.74,
}, {
	options = {
		{
            type = "client",
            event = "CF-lean:client:GatheringCodeine",
			icon = "fas fa-bottle-droplet",
			label = "Make some Codeine",
			--item = ""
		},
	},
	distance = 2.5
})
--For Sprite
exports['qb-target']:AddBoxZone("Sprite", Config.Loc[3], 1.45, 1, {
	name = "Sprite",
	heading = 20.0,
	debugPoly = false,
	minZ=33.98,
	maxZ=37.98,
}, {
	options = {
		{
            type = "client",
            event = "CF-lean:client:GatheringSprite",
			icon = "fas fa-bottle-droplet",
			label = "Gather Sprite",
			--item = ""
		},
	},
	distance = 2.5
})




-- Making Cough Syrup
exports['qb-target']:AddBoxZone("MakingCoughSyrup", Config.Loc[4], 2.4, 1, {
	name = "MakingCoughSyrup",
	heading = 20,
	debugPoly = false,
	minZ=35.34,
	maxZ=39.34,

}, {
	options = {
		{
            type = "client",
            event = "CF-lean:client:MakingCoughSyrup",
			icon = "fas fa-bottle-droplet",
			label = "Make some cough syrup",
			--item =
		},
	},
	distance = 2.5
})

--Making Lean

exports['qb-target']:AddBoxZone("MakingLean", Config.Loc[5], 2.2, 1, {
	name = "MakingLean",
	heading = 55,
	debugPoly = false,
	minZ=15.46,
    maxZ=19.46,

}, {
	options = {
		{
            type = "client",
            event = "CF-lean:client:MakingLean",
			icon = "fas fa-bottle-droplet",
			label = "Make Lean",
			--item =  leanitems
		},
	},
	distance = 2.5
})

