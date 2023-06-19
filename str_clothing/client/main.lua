local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

hasInit = false
isInMenu = false
FreeRoaming = false
LastSkin = {}
PlayerIdentifier = 0

local Time = 0
local startRotation = 0
local cam = false
local lastCam = nil

local glasses, shirts, hats, mask, pants, shoes = {}, {}, {}, {}, {}, {}

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()

    local playerPed = PlayerPedId()
    while GetEntityModel(playerPed) == GetHashKey('a_m_y_hipster_01') do
        Wait(0)
    end

    Citizen.Wait(5000)

    TriggerServerEvent("esx_clothing:Init")

    while not hasInit do
        Wait(0);
    end

    SendNUIMessage({
        init = true,
        PlayerJob = ESX.PlayerData.job.name,
        Identifier = PlayerIdentifier,
        NameResource = {GetCurrentResourceName(), GetCurrentServerEndpoint()},
    })
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    Citizen.Wait(500)

    SendNUIMessage({
        refreshPlayerJob = true,
        PlayerJob = ESX.PlayerData.job.name,
    })
end)

Citizen.CreateThread(function()
    while not hasInit do
        Wait(0);
    end
    
    while true do
        Citizen.Wait(2)
        local letSleep = true

        if not isInMenu then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for k,v in pairs(Config.Stores) do
                for storeKey, store in pairs(v.StoresCoords) do
                    local distance = #(playerCoords - store.pos)

                    if distance <= 5.0 and distance >= 2.0 then
                        letSleep = false

                        local x, y, z = table.unpack(store.pos)
                        DrawMarker(Config.Type, x, y, z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                    elseif distance <= 2.0 then
                        letSleep = false

                        local x, y, z = table.unpack(store.pos)
                        DrawText3Ds(x, y, z + 1.0, "~r~[E]~s~ for at " .. v.interactLabel)
                        if IsControlJustReleased(0, Keys['E']) and (GetGameTimer() - Time) > 1000 then
                            Time = GetGameTimer()

                            if k == "tatto" then
                                OpenTattoMenu()
                            end

                            if k ~= "tatto" then
                                OpenClothingMenu(k, v.hasWardrobe)
                            end
                        end
                    end
                end
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Stores) do
        for storeKey, store in pairs(v.StoresCoords) do
            if store.hasBlip then
                local x, y, z = table.unpack(store.pos)
                local blip = AddBlipForCoord(x,y,z)

                SetBlipSprite(blip, v.spriteType)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, v.spriteScale)
                SetBlipColour(blip, v.spriteColour)
                SetBlipAsShortRange(blip, true)
                
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)

OpenClothingMenu = function(store, hasWardrobe)
    ESX.TriggerServerCallback('starboyz:getPlayerDressing', function(dressings)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if isTableEmpty(LastSkin) then
                LastSkin = skin
            end

            local clothingComponents = {}

            local maxVals = GetMaxVals()
            for k,v in pairs(Config.Components) do
                local normalMax = maxVals[v.name]
                local value = skin[v.name]

                v.max = normalMax
                v.value = value

                if v.texturename then
                    local texturesMax = maxVals[v.texturename]
                    local texturevalue = skin[v.texturename]

                    v.texturemax = texturesMax
                    v.texturevalue = texturevalue
                end

                if not v.blacklisted then
                    table.insert(clothingComponents, v)
                end
            end

            isInMenu = true
            SetNuiFocus(true, true)

            if store == nil then
                SendNUIMessage({
                    open = true,
                    Components = clothingComponents,
                    Wardrobe = dressings, 
                })
            end

            if store ~= nil then
                SendNUIMessage({
                    openStore = true,
                    Components = clothingComponents,
                    Wardrobe = dressings, 
                    store = store, 
                    hasWardrobe = hasWardrobe,
                })
            end

            CustomCamera('torso', false)

            local playerPed = PlayerPedId()
            startRotation = GetEntityHeading(playerPed)
        end)
    end)
end

RegisterNetEvent('esx_clothing:resyncWardrobe')
AddEventHandler('esx_clothing:resyncWardrobe', function(dressings)
    SendNUIMessage({
        refreshWardrobe = true,
        Wardrobe = dressings, 
    })
end)

RegisterNetEvent('esx_clothing:activateTempSex')
AddEventHandler('esx_clothing:activateTempSex', function()
    for k,v in pairs(Config.Components) do
        if v.name == "sex" then
            v.blacklisted = false
        end
    end
end)

ResyncComponents = function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local clothingComponents = {}
        for k,v in pairs(Config.Components) do
            local value = skin[v.name]
            v.value = value

            if v.texturename then
                local texturevalue = skin[v.texturename]
                v.texturevalue = texturevalue
            end

            if not v.blacklisted then
                table.insert(clothingComponents, v)
            end
        end

        SendNUIMessage({
            refreshComponents = true,
            Components = clothingComponents,
        })
    end)
end

ToggleProps = function(prop)
    local offProp = -1

    TriggerEvent('skinchanger:getSkin', function(skin)
        local playerPed = PlayerPedId()
        
        if prop == 'glasses' then
            if skin.glasses_1 == offProp then
                local clothesSkin = {
                    ['glasses_1'] = glasses[1], 
                    ['glasses_2'] = glasses[2]
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                glasses = {}
            end

            if skin.glasses_1 ~= offProp then
                glasses[1] = skin.glasses_1
                glasses[2] = skin.glasses_2

                local clothesSkin = {
                    ['glasses_1'] = offProp, 
                    ['glasses_2'] = 0
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end
        
        if prop == 'hat' then
            if skin.helmet_1 == offProp then
                local clothesSkin = {
                    ['helmet_1'] = hats[1], 
                    ['helmet_2'] = hats[2]
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                hats = {}
            end

            if skin.helmet_1 ~= offProp then
                hats[1] = skin.helmet_1
                hats[2] = skin.helmet_2

                local clothesSkin = {
                    ['helmet_1'] = offProp, 
                    ['helmet_2'] = 0
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end

        if prop == 'mask' then
            offProp = 0

            if skin.mask_1 == offProp then
                local clothesSkin = {
                    ['mask_1'] = mask[1], 
                    ['mask_2'] = mask[2]
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                mask = {}
            end

            if skin.mask_1 ~= offProp then
                mask[1] = skin.mask_1
                mask[2] = skin.mask_2

                local clothesSkin = {
                    ['mask_1'] = offProp, 
                    ['mask_2'] = 0
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end

        if prop == 'pants' then
            offProp = 21

            if skin.pants_1 == offProp then
                local clothesSkin = {
                    ['pants_1'] = pants[1], 
                    ['pants_2'] = pants[2]
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                pants = {}
            end

            if skin.pants_1 ~= offProp then
                pants[1] = skin.pants_1
                pants[2] = skin.pants_2

                local clothesSkin = {
                    ['pants_1'] = offProp, 
                    ['pants_2'] = 0
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end

        if prop == 'shoes' then
            offProp = 34

            if GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
                shoesOff = 35
            end

            if skin.shoes_1 == offProp then
                local clothesSkin = {
                    ['shoes_1'] = shoes[1], 
                    ['shoes_2'] = shoes[2]
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                shoes = {}
            end

            if skin.shoes_1 ~= offProp then
                shoes[1] = skin.shoes_1
                shoes[2] = skin.shoes_2

                local clothesSkin = {
                    ['shoes_1'] = offProp, 
                    ['shoes_2'] = 0
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end

        if prop == 'shirt' then
            offProp = 15

            if skin.torso_1 == offProp then
                local clothesSkin = {
                    ['tshirt_1'] = shirts[1], 
                    ['tshirt_2'] = shirts[2],
                    ['torso_1'] = shirts[3], 
                    ['torso_2'] = shirts[4],
                    ['arms'] = shirts[5],
                    ['arms_2'] = shirts[6],
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                shirts = {}
            end

            if skin.torso_1 ~= offProp then
                shirts[1] = skin.tshirt_1
                shirts[2] = skin.tshirt_2
                shirts[3] = skin.torso_1
                shirts[4] = skin.torso_2
                shirts[5] = skin.arms
                shirts[6] = skin.arms_2

                local clothesSkin = {
                    ['tshirt_1'] = offProp, 
                    ['tshirt_2'] = 0,
                    ['torso_1'] = offProp, 
                    ['torso_2'] = 0,
                    ['arms'] = offProp,
                    ['arms_2'] = 0,
                }

                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
        end
    end)
end

RegisterNUICallback('saveClose', function(data, cb)
    SetNuiFocus(false)
    CustomCamera('cancel', false)

    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)

        LastSkin = {}
        isInMenu = false
    end)

    cb('ok')
end)

RegisterNUICallback('nosaveClose', function(data, cb)
    SetNuiFocus(false)
    CustomCamera('cancel', false)
    
    if not isTableEmpty(LastSkin) then
        TriggerEvent('skinchanger:loadSkin', LastSkin)

        LastSkin = {}
    end

    isInMenu = false

    cb('ok')
end)

RegisterNUICallback('SetClothing', function(data, cb)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:change', data.name, tonumber(data.value))

        if string.find(data.name, "_1") then
            local name = data.name:gsub("%_1", "_2")
            local components = GetMaxVals()
            local maxTextureValue = components[name]
            
            SendNUIMessage({
                updateTexture = true,
                name = data.name,
                value = maxTextureValue,
            })
        end

        if data.name == "arms" then
            local name = data.name .. '_2'
            local components = GetMaxVals()
            local maxTextureValue = components[name]
            
            SendNUIMessage({
                updateTexture = true,
                name = data.name,
                value = maxTextureValue,
            })
        end

        cb('ok')
    end)
end)

RegisterNUICallback('SetCamera', function(data, cb)
    local cameraType = data["type"]
    local isTatto = data["isTattoShop"]

    CustomCamera(cameraType, isTatto)

    cb('ok')
end)

RegisterNUICallback('RotateCamera', function(data, cb)
    local rotateType = data.direction
    if rotateType == 'left' then
        rotatePlayer(20)
    end

    if rotateType == 'reset' then
        setPlayerRotation(startRotation)
    end

    if rotateType == 'right' then
        rotatePlayer(-20)
    end

    cb('ok')
end)

RegisterNUICallback('ToggleClothing', function(data, cb)
    ToggleProps(data.type)

    if data.type == "pants" then
        ToggleProps("shoes")
    end

    cb('ok')
end)

RegisterNUICallback('SaveOutfit', function(data, cb)
    local name = data["outfit_name"]

    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_clothing:saveOutfit', name, skin)
    end)

    cb('ok')
end)

RegisterNUICallback('ResetOutfit', function(data, cb)
    if not isTableEmpty(LastSkin) then
        TriggerEvent('skinchanger:loadSkin', LastSkin)
    end

    cb('ok')
end)

RegisterNUICallback('ChooseOutfit', function(data, cb)
    local index = data["index"]

    TriggerEvent('skinchanger:getSkin', function(skin)
        ESX.TriggerServerCallback('starboyz:getPlayerOutfit', function(clothes)
            TriggerEvent('skinchanger:loadClothes', skin, clothes)
            TriggerEvent('esx_skin:setLastSkin', skin)

            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)

                ResyncComponents()
            end)
        end, index)
    end)

    cb('ok')
end)

RegisterNUICallback('OverrideOutfit', function(data, cb)
    local index = data["index"]

    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_clothing:overrideOutfit', index, skin)
    end)

    cb('ok')
end)

RegisterNUICallback('DeleteOutfit', function(data, cb)
    local index = data["index"]
    TriggerServerEvent("esx_clothing:removeOutfit", index)
    cb('ok')
end)

RegisterNUICallback('ToggleFreeRoam', function(data, cb)
    FreeRoaming = data["isFreeroaming"]
    
    local playerPed = PlayerPedId()
    if not FreeRoaming then
        SetNuiFocus(true, true)
        FreezeEntityPosition(playerPed, false)
    end

    if FreeRoaming then
        SetNuiFocus(false)
        CustomCamera('cancel', false)
        FreezeEntityPosition(playerPed, true)
    end

    cb('ok')
end)

local hasHandsup = false
RegisterNUICallback('Handsup', function(data, cb)
    if hasHandsup then
        TriggerEvent('esx_animation:EmoteCancel')
    end

    if not hasHandsup then
        TriggerEvent('esx_animation:OnEmotePlay', 'Emotes', 'handsup_x')
    end

    hasHandsup = not hasHandsup

    cb('ok')
end)

RegisterCommand('+freeRoaming', function()
    if FreeRoaming then
        SendNUIMessage({
            ToggleFreeRoam = true
        })
    end
end, false)

RegisterKeyMapping('+freeRoaming', 'Toggle Clothing Freeroam', 'keyboard', 'N')

RegisterCommand("clothing", function()
    OpenClothingMenu()
end)

CustomCamera = function(position, isTatto)
    local playerPed = PlayerPedId()

    if position == "cancel" then
        FreezePedCameraRotation(playerPed, false)
        SetCamActive(cam, false)
        RenderScriptCams(false, false, 0, true, true)

        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
    end

    if position ~= "cancel" then
        if lastCam == position then return end
        lastCam = position

        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        SetEntityRotation(playerPed, 0.0, 0.0, 0.0, 1, true)
        FreezePedCameraRotation(playerPed, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, playerPed)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)

        SwitchCam(position, isTatto)
    end
end

SwitchCam = function(name, isTatto)
    local playerPed = PlayerPedId()

    local bonepos = false
    if name == "face" then
        bonepos = GetPedBoneCoords(playerPed, 31086)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
    end

    if name == "torso" or name == "normal" then
        bonepos = GetPedBoneCoords(playerPed, 11816)

        if not isTatto then
            bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
        end

        if isTatto then
            bonepos = vector3(bonepos.x, bonepos.y + 1.2, bonepos.z + 0.2)
        end
    end

    if name == "feet" then
        bonepos = GetPedBoneCoords(playerPed, 46078)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    SetCamRot(cam, 0.0, 0.0, 180.0)
end

rotatePlayer = function(dir)
    local playerPed = PlayerPedId()
    local pedRot = GetEntityHeading(playerPed) + dir
    SetEntityHeading(playerPed, pedRot % 360)
end

setPlayerRotation = function(dir)
    local playerPed = PlayerPedId()
    SetEntityHeading(playerPed, dir)
end

GetMaxVals = function()
	local playerPed = PlayerPedId()
    local data = {}

    TriggerEvent('skinchanger:getSkin', function(skin)
        data = {
            sex				= 1,
            face			= 45,
            skin			= 45,
            age_1			= GetNumHeadOverlayValues(3)-1,
            age_2			= 10,
            beard_1			= GetNumHeadOverlayValues(1)-1,
            beard_2			= 10,
            beard_3			= GetNumHairColors() -1,
            beard_4			= GetNumHairColors() -1,
            hair_1			= GetNumberOfPedDrawableVariations(playerPed, 2) - 1,
            hair_2			= GetNumberOfPedTextureVariations(playerPed, 2, skin['hair_1']) - 1,
            hair_color_1	= GetNumHairColors()-1,
            hair_color_2	= GetNumHairColors()-1,
            eye_color		= 31,
            eyebrows_1		= GetNumHeadOverlayValues(2)-1,
            eyebrows_2		= 10,
            eyebrows_3		= GetNumHairColors()-1,
            eyebrows_4		= GetNumHairColors()-1,
            makeup_1		= GetNumHeadOverlayValues(4)-1,
            makeup_2		= 10,
            makeup_3		= GetNumHairColors()-1,
            makeup_4		= GetNumHairColors()-1,
            lipstick_1		= GetNumHeadOverlayValues(8)-1,
            lipstick_2		= 10,
            lipstick_3		= GetNumHairColors()-1,
            lipstick_4		= GetNumHairColors()-1,
            blemishes_1		= GetNumHeadOverlayValues(0)-1,
            blemishes_2		= 10,
            blush_1			= GetNumHeadOverlayValues(5)-1,
            blush_2			= 10,
            blush_3			= GetNumHairColors()-1,
            complexion_1	= GetNumHeadOverlayValues(6)-1,
            complexion_2	= 10,
            sun_1			= GetNumHeadOverlayValues(7)-1,
            sun_2			= 10,
            moles_1			= GetNumHeadOverlayValues(9)-1,
            moles_2			= 10,
            chest_1			= GetNumHeadOverlayValues(10)-1,
            chest_2			= 10,
            chest_3			= GetNumHairColors()-1,
            bodyb_1			= GetNumHeadOverlayValues(11)-1,
            bodyb_2			= 10,
            ears_1			= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
            ears_2			= GetNumberOfPedPropTextureVariations	(playerPed, 1, skin['ears_1'] - 1),
            tshirt_1		= GetNumberOfPedDrawableVariations		(playerPed, 8) - 1,
            tshirt_2		= GetNumberOfPedTextureVariations		(playerPed, 8, skin['tshirt_1']) - 1,
            torso_1			= GetNumberOfPedDrawableVariations		(playerPed, 11) - 1,
            torso_2			= GetNumberOfPedTextureVariations		(playerPed, 11, skin['torso_1']) - 1,
            decals_1		= GetNumberOfPedDrawableVariations		(playerPed, 10) - 1,
            decals_2		= GetNumberOfPedTextureVariations		(playerPed, 10, skin['decals_1']) - 1,
            arms			= GetNumberOfPedDrawableVariations		(playerPed, 3) - 1,
            arms_2			= GetNumberOfPedTextureVariations		(playerPed, 3, skin['arms']) - 1,
            pants_1			= GetNumberOfPedDrawableVariations		(playerPed, 4) - 1,
            pants_2			= GetNumberOfPedTextureVariations		(playerPed, 4, skin['pants_1']) - 1,
            shoes_1			= GetNumberOfPedDrawableVariations		(playerPed, 6) - 1,
            shoes_2			= GetNumberOfPedTextureVariations		(playerPed, 6, skin['shoes_1']) - 1,
            mask_1			= GetNumberOfPedDrawableVariations		(playerPed, 1) - 1,
            mask_2			= GetNumberOfPedTextureVariations		(playerPed, 1, skin['mask_1']) - 1,
            bproof_1		= GetNumberOfPedDrawableVariations		(playerPed, 9) - 1,
            bproof_2		= GetNumberOfPedTextureVariations		(playerPed, 9, skin['bproof_1']) - 1,
            chain_1			= GetNumberOfPedDrawableVariations		(playerPed, 7) - 1,
            chain_2			= GetNumberOfPedTextureVariations		(playerPed, 7, skin['chain_1']) - 1,
            bags_1			= GetNumberOfPedDrawableVariations		(playerPed, 5) - 1,
            bags_2			= GetNumberOfPedTextureVariations		(playerPed, 5, skin['bags_1']) - 1,
            helmet_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 0) - 1,
            helmet_2		= GetNumberOfPedPropTextureVariations	(playerPed, 0, skin['helmet_1']) - 1,
            glasses_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
            glasses_2		= GetNumberOfPedPropTextureVariations	(playerPed, 1, skin['glasses_1'] - 1),
            watches_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 6) - 1,
            watches_2		= GetNumberOfPedPropTextureVariations	(playerPed, 6, skin['watches_1']) - 1,
            bracelets_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 7) - 1,
            bracelets_2		= GetNumberOfPedPropTextureVariations	(playerPed, 7, skin['bracelets_1'] - 1)
        }
    end)

	return data
end

isTableEmpty = function(table)
    return next(table) == nil
end

DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)

    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

print_r = function(t)
    local print_r_cache = {}
    local function sub_print_r(t, indent)
        if (print_r_cache[tostring(t)]) then
            print(indent .. "*" .. tostring(t))
        else
            print_r_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
                        sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
                        print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
                    else
                        print(indent .. "[" .. pos .. "] => " .. tostring(val))
                    end
                end
            else
                print(indent .. tostring(t))
            end
        end
    end
    sub_print_r(t, "  ")
end

exports("OpenClothingMenu", OpenClothingMenu);
