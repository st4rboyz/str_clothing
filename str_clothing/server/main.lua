ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('esx_clothing:Init')
AddEventHandler('esx_clothing:Init', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)
		local tattos = json.decode(result[1].tattoos)
		if tattos then
			TriggerClientEvent('esx_clothing:Init', _source, tattos)
		else
			MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
				['@tattoos'] = json.encode({}),
				['@identifier'] = xPlayer.identifier
			}, function(result)
				TriggerClientEvent('esx_clothing:Init', _source, {})
			end)
		end
	end)
end)

RegisterServerEvent('esx_clothing:RegisterTattoos')
AddEventHandler('esx_clothing:RegisterTattoos', function(updatedTattos)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(updatedTattos),
		['@identifier'] = xPlayer.identifier
	}, function(result)
		TriggerClientEvent("esx_clothing:resyncWardrobe", _source, updatedTattos)
	end)
end)

RegisterServerEvent('esx_clothing:removeOutfit')
AddEventHandler('esx_clothing:removeOutfit', function(label)
	label = label + 1

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)
		
		TriggerClientEvent("esx_clothing:resyncWardrobe", source, dressing)

	end)
end)

ESX.RegisterServerCallback('starboyz:getPlayerDressing', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
  
      local count    = store.count('dressing')
      local labels   = {}
  
      for i=1, count, 1 do
        local entry = store.get('dressing', i)
        table.insert(labels, entry)
      end
      cb(labels)
  
    end)
end)
  
RegisterNetEvent('skinchanger:loadClothes')
AddEventHandler('skinchanger:loadClothes', function(playerSkin, clothesSkin)
	if playerSkin['sex'] ~= LastSex then
		LoadClothes = {
			playerSkin	= playerSkin,
			clothesSkin	= clothesSkin
		}

		if playerSkin['sex'] == 0 then
			TriggerEvent('skinchanger:loadDefaultModel', true)
		else
			TriggerEvent('skinchanger:loadDefaultModel', false)
		end
	else
		ApplySkin(playerSkin, clothesSkin)
	end

	LastSex = playerSkin['sex']
end)

RegisterServerEvent('esx_clothing:overrideOutfit')
AddEventHandler('esx_clothing:overrideOutfit', function(label, skin)
	label = label + 1

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')
		if dressing == nil then
			return
		else
			for k, v in pairs(dressing) do
				if k == label then
					v.skin = skin
				end
			end
		end
		
		store.set('dressing', dressing)

		TriggerClientEvent("esx_clothing:resyncWardrobe", source, dressing)
	end)
end)

RegisterServerEvent('esx_clothing:saveOutfit')
AddEventHandler('esx_clothing:saveOutfit', function(label, skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})
		
		store.set('dressing', dressing)

		TriggerClientEvent("esx_clothing:resyncWardrobe", source, dressing)
	end)
end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET `skin` = @skin WHERE identifier = @identifier', {
		['@skin']       = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('starboyz:getPlayerOutfit', function(source, cb, num)
	num = num + 1
	local xPlayer = ESX.GetPlayerFromId(source)
  
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
	  	cb(outfit.skin)
	end)
end)

  function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end