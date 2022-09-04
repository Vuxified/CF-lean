local QBCore = exports['qb-core']:GetCoreObject()
---Useable Items
QBCore.Functions.CreateUseableItem("lean", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:clientLeanDrink", source, item.name)
    end
end)
if  Config.ConsuambleSprite == true then 
QBCore.Functions.CreateUseableItem("sprite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:clientSprite", source, item.name)
    end
end)
else 
	return

end

--   Player.Functions.GiveItem('sandwich', 1)
--Gathering Promethazine
RegisterNetEvent('CF-lean:server:GatheringPromethazine', function()
	local Player = QBCore.Functions.GetPlayer(source)
	local DrugXP = Player.PlayerData.metadata.drugxp
	local src = source

	if Config.EnableDrugXP == true  then
	if DrugXP >= Config.DrugLevels[1] then



		--If math.random < then do this else lose xp
		if Config.GainingXp < math.random(1,100) then
		Player.Functions.SetMetaData('drugxp', (DrugXP + Config.DrugXPReward))
		TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")

		Player.Functions.AddItem('promethazine', Config.Promethazine)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['promethazine'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'You made promethazine', "success")
		else
			Player.Functions.SetMetaData('drugxp', (DrugXP - Config.DrugXPRemoved))
		TriggerClientEvent('QBCore:Notify', src, 'You have lost '.. Config.DrugXPRemoved ..' Drug XP.', "error")
		TriggerClientEvent('QBCore:Notify', src, 'You mixed the wrong ingredients', "error")
		end

	else

	Player.Functions.AddItem('promethazine', 1)
	Player.Functions.SetMetaData('drugxp', (DrugXP + 1))
	TriggerClientEvent('QBCore:Notify', src, 'You have gained 1 Drug XP.', "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['promethazine'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'You made promethazine', "success")


	end
else

	Player.Functions.AddItem('promethazine', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['promethazine'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'You made promethazine', "success")
	end


end)
--Gathering Codeine
RegisterNetEvent('CF-lean:server:GatheringCodeine', function()
	local Player = QBCore.Functions.GetPlayer(source)
	local DrugXP = Player.PlayerData.metadata.drugxp
	local src = source
	if Config.EnableDrugXP == true  then

		if DrugXP >= Config.DrugLevels[2] then


			--If math.random < then do this else lose xp
			if Config.GainingXp < math.random(1,100) then
			Player.Functions.SetMetaData('drugxp', (DrugXP + Config.DrugXPReward))
			TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")

			Player.Functions.AddItem('codeine',  Config.Codeine)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['codeine'], "add")
			TriggerClientEvent('QBCore:Notify', src, 'You made codeine', "success")
			else
			Player.Functions.SetMetaData('drugxp', (DrugXP - Config.DrugXPRemoved))
			TriggerClientEvent('QBCore:Notify', src, 'You have lost '.. Config.DrugXPRemoved ..' Drug XP.', "error")
			TriggerClientEvent('QBCore:Notify', src, 'You mixed the wrong ingredients', "error")
			end

		else

		Player.Functions.AddItem('codeine', 1)
		--Player.Functions.SetMetaData('drugxp', (DrugXP + 1)) I didn't want people to abuse this
		--TriggerClientEvent('QBCore:Notify', src, 'You have gained 1 Drug XP.', "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['codeine'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'You made codeine', "success")


		end
	else

		Player.Functions.AddItem('codeine', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['codeine'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'You made codeine', "success")
	end
end)

RegisterNetEvent('CF-lean:server:GatheringSprite',function()
	local src = source
	local Player =  QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem('sprite', 1)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['sprite'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'You gathered some sprite' , "success")
end)

-- Removing  Codeine, Promethazine, making coughsyrup
RegisterNetEvent('CF-lean:server:MakingCoughSyrup', function()
	local Player = QBCore.Functions.GetPlayer(source)
	local DrugXP = Player.PlayerData.metadata.drugxp
	local src = source
	if Config.EnableDrugXP == true  then

		if DrugXP >= Config.DrugLevels[3] then


			--If math.random < then do this else lose xp
			if Config.GainingXp < math.random(1,100) then
				Player.Functions.SetMetaData('drugxp', (DrugXP + Config.DrugXPReward))
				TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")
				Player.Functions.RemoveItem('codeine',1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['codeine'],"remove")
	 			Player.Functions.RemoveItem('promethazine',1)
	 			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['promethazine'],"remove")
	 			Player.Functions.AddItem('coughsyrup',Config.CoughSyrup)
	 			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coughsyrup'], "add")
			else
			Player.Functions.SetMetaData('drugxp', (DrugXP - Config.DrugXPRemoved))
			TriggerClientEvent('QBCore:Notify', src, 'You have lost '.. Config.DrugXPRemoved ..' Drug XP.', "error")
			TriggerClientEvent('QBCore:Notify', src, 'You measured wrong', "error")
			end

		else


			Player.Functions.SetMetaData('drugxp', (DrugXP + 1)) 
			TiggerClientEvent('QBCore:Notify', src, 'You have gained 1 Drug XP.', "success")
			Player.Functions.AddItem('coughsyrup',1)
	 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coughsyrup'], "add")
			TriggerClientEvent('QBCore:Notify', src, 'You made Cough Syrup', "success")


		end
	else
		 Player.Functions.RemoveItem('codeine',1)
		 TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['codeine'],"remove")
		 Player.Functions.RemoveItem('promethazine',1)
		 TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['promethazine'],"remove")
		 Player.Functions.AddItem('coughsyrup',Config.CoughSyrup)
		 TriggerClientEvent('inventory:client:ItemBox', src, QBCor.Shared.Items['coughsyrup'], "add")
		 TriggerClientEvent('QBCore:Notify', src, 'You made cough syrup', "success")
	end


	end)


	-- Removing Sprite, Codeine, Promethazine, making lean
RegisterNetEvent('CF-lean:server:MakingLean', function()
	local Player = QBCore.Functions.GetPlayer(source)
	local DrugXP = Player.PlayerData.metadata.drugxp
	local src = source
	if Config.EnableDrugXP == true  then

		if DrugXP >= Config.DrugLevels[4] then


			--If math.random < then do this else lose xp
			if Config.GainingXp < math.random(1,100) then
			Player.Functions.SetMetaData('drugxp', (DrugXP + Config.DrugXPReward))
				TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")
				Player.Functions.RemoveItem('styrofoamcups', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['styrofoamcups'], "remove")
				Player.Functions.RemoveItem('sprite', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sprite'], "remove")
				Player.Functions.RemoveItem('coughsyrup', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coughsyrup'], "remove")
				Player.Functions.AddItem('lean', Config.Lean)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lean'], "add")
			else
			Player.Functions.SetMetaData('drugxp', (DrugXP - Config.DrugXPRemoved))
			TriggerClientEvent('QBCore:Notify', src, 'You have lost '.. Config.DrugXPRemoved ..' Drug XP.', "error")
			TriggerClientEvent('QBCore:Notify', src, 'You mixed the wrong ingredients', "error")
			end

		else

			TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")
			Player.Functions.RemoveItem('styrofoamcups', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['styrofoamcups'], "remove")
			Player.Functions.RemoveItem('sprite', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sprite'], "remove")
			Player.Functions.RemoveItem('coughsyrup', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coughsyrup'], "remove")
			Player.Functions.AddItem('lean', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lean'], "add")
			Player.Functions.SetMetaData('drugxp', (DrugXP + 1))
			TriggerClientEvent('QBCore:Notify', src, 'You have gained 1 Drug XP.', "success")
			TriggerClientEvent('QBCore:Notify', src, 'You made lean', "success")

		end
	else

				TriggerClientEvent('QBCore:Notify', src, 'You have gained '.. Config.DrugXPReward ..' Drug XP.', "success")
				Player.Functions.RemoveItem('styrofoamcups', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['styrofoamcups'], "remove")
				Player.Functions.RemoveItem('sprite', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sprite'], "remove")
				Player.Functions.RemoveItem('coughsyrup', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coughsyrup'], "remove")
				Player.Functions.AddItem('lean', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lean'], "add")
				TriggerClientEvent('QBCore:Notify', src, 'You made lean', "success")
	end

	end)

