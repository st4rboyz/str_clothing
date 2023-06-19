local my_tattoos = Config.Tattoos
local update_tattoos = {}

RegisterNetEvent('esx_clothing:Init')
AddEventHandler('esx_clothing:Init', function(playerTattos, Identifier)
    hasInit = true

    PlayerIdentifier = Identifier

    local playerPed = PlayerPedId()
    ClearPedDecorations(playerPed)

    local model = GetPlayerModel()
    
    local start = GetGameTimer()
    while Config.TattooList[model] == nil and GetGameTimer() - start < 30000 do 
        print("Model is nil.. Trying Again")
        model = GetPlayerModel()
        
        Wait(5000); 
    end

    if Config.TattooList[model] == nil then
        print(model .. " is nil (Model)", GetEntityModel(playerPed))
        return
    end
    
    for k,v in pairs(playerTattos) do
        local tattoModels = Config.TattooList[model][v.category]

        if tattoModels == nil then
            print(v.category .. " is nil (Category)")
        end

        for i=1, #tattoModels, 1 do
            local tattoModel = tattoModels[i]

            if tattoModel["nameHash"] == v.nameHash and tattoModel["dlc"] == v.dlc then
                AddPedDecorationFromHashes(playerPed, GetHashKey(tattoModel.dlc), GetHashKey(tattoModel.nameHash))

                for y,z in pairs(my_tattoos) do
                    if z.dlc == v.category then
                        table.insert(z.acquired, i)
                    end
                end
            end
        end
    end

end)

RegisterNetEvent('esx_clothing:activateTempTat')
AddEventHandler('esx_clothing:activateTempTat', function(tattoo, identifier)
    for k,v in pairs(my_tattoos) do
        if v.dlc == tattoo then
            if v.whitelistedPlayers == nil then
                v.whitelistedPlayers = {}
            end

            table.insert(v.whitelistedPlayers, identifier)
        end
    end

    if isInMenu then
        SendNUIMessage({
            refreshTattos = true,
            Tattos = my_tattoos,
        })
    end
end)

Citizen.CreateThread(function()
    while not hasInit do
        Wait(0);
    end

    while true do
        Citizen.Wait(5000)

        if not isInMenu then
            local playerPed = PlayerPedId()
            ClearPedDecorations(playerPed)

            local model = GetPlayerModel()
            for k,v in pairs(my_tattoos) do
                for i=1, #v.acquired, 1 do
                    local acquired = v.acquired[i]
                    local tattoModel = Config.TattooList[model][v.dlc][acquired]
                    AddPedDecorationFromHashes(playerPed, GetHashKey(tattoModel.dlc), GetHashKey(tattoModel.nameHash))
                end
            end
        end
    end
end)

OpenTattoMenu = function()
    local model = GetPlayerModel()

    for k,v in pairs(my_tattoos) do
        local modelList = Config.TattooList[model]
        v.qty = #modelList[v.dlc]
    end

    isInMenu = true
    SetNuiFocus(true, true)

    SendNUIMessage({
        openTatto = true,
        Tattos = my_tattoos,
    })

    CustomCamera('torso', true)
    startRotation = GetEntityHeading(playerPed)

    update_tattoos = my_tattoos
end

RegisterNUICallback('SetTatto', function(data, cb)
    local dlc = data["item"]["dlc"]
    local current = tonumber(data["item"]["current"])

    local playerPed = PlayerPedId()
    ClearPedDecorations(playerPed)

    local model = GetPlayerModel()

    local tatto = nil
    for k,v in pairs(my_tattoos) do
        if v.dlc == dlc then
            tatto = v
        end
    end

    tatto.current = current

    if current ~= 0 and not tableContains(tatto.acquired, current) then
        local tattoModel = Config.TattooList[model][dlc][current]
        AddPedDecorationFromHashes(playerPed, GetHashKey(tattoModel.dlc), GetHashKey(tattoModel.nameHash))
    end

    for k,v in pairs(update_tattoos) do
        for i=1, #v.acquired, 1 do
            local acquired = v.acquired[i]
            local tattoModel = Config.TattooList[model][v.dlc][acquired]
            AddPedDecorationFromHashes(playerPed, GetHashKey(tattoModel.dlc), GetHashKey(tattoModel.nameHash))
        end
    end

    cb('ok')
end)

RegisterNUICallback('RemoveTatto', function(data, cb)
    local current = data["item"]["current"]

    for k,v in pairs(update_tattoos) do
        for i=1, #v.acquired, 1 do
            local acquired = v.acquired[i]

            if acquired == current then
                table.remove(v.acquired, i)
            end
        end
    end

    SendNUIMessage({
        refreshTattos = true,
        Tattos = update_tattoos,
    })

    cb('ok')
end)

RegisterNUICallback('AddTatto', function(data, cb)
    local dlc = data["item"]["dlc"]
    local current = data["item"]["current"]

    for k,v in pairs(update_tattoos) do
        if v.dlc == dlc then
            table.insert(v.acquired, current)
        end
    end

    SendNUIMessage({
        refreshTattos = true,
        Tattos = update_tattoos,
    })

    cb('ok')
end)

RegisterNUICallback('ResetAllTattos', function(data, cb)
    local playerPed = PlayerPedId()
    ClearPedDecorations(playerPed)

    for k,v in pairs(my_tattoos) do
        v.acquired = {}
    end

    update_tattoos = {}

    SendNUIMessage({
        refreshTattos = true,
        Tattos = my_tattoos,
    })

    cb('ok')
end)

RegisterNUICallback('closeTattoShop', function(data, cb)
    local playerPed = PlayerPedId()
    ClearPedDecorations(playerPed)

    local model = GetPlayerModel()

    local updatedTattos = {}
    for k,v in pairs(update_tattoos) do
        for i=1, #v.acquired, 1 do
            local acquired = v.acquired[i]
            local tattoModel = Config.TattooList[model][v.dlc][acquired]
            AddPedDecorationFromHashes(playerPed, GetHashKey(tattoModel.dlc), GetHashKey(tattoModel.nameHash))

            table.insert(updatedTattos, {
                category = v.dlc,
                dlc = tattoModel.dlc,
                nameHash = tattoModel.nameHash,
            })
        end
    end

    my_tattoos = update_tattoos
    update_tattoos = {}

    TriggerServerEvent("esx_clothing:RegisterTattoos", updatedTattos)

    SetNuiFocus(false)
    CustomCamera('cancel', false)

    isInMenu = false

    cb('ok')
end)

GetPlayerModel = function()
    local model = "maleModel"

    local playerPed = PlayerPedId()
    if GetEntityModel(playerPed) == GetHashKey('mp_f_freemode_01') then
        model = "femaleModel"
    end

    return model
end

tableContains = function(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end
