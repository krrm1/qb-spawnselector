local QBCore = exports['qb-core']:GetCoreObject()

-- spwan checks
local CanSpawn = false
local LastSpawn = false
local legionsquare = false
local casino = false
local bank = false
local impound = false

-- functions 

-- cam pos and names

local function CreateCamPed()
    local ped = PlayerPedId()
    MapCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(MapCam, Config.CamCoords.Cam)
    SetCamRot(MapCam, Config.CamCoords.CamRot)
    RenderScriptCams(true, false, 0, 1, 0)
    SetCamActive(MapCam, true)
    SetEntityCoords(ped, Config.CamCoords.PedCod)
    FreezeEntityPosition(ped, true)
    CanSpawn = true
end

local function DestroyCamPed()
    DestroyCam(MapCam, true)
    RenderScriptCams(false, false)
end

-- ui and button

local function CreateUi(data)
    CreateCamPed()
    TriggerScreenblurFadeIn(1000)
    Citizen.Wait(600)
    SetNuiFocus(true, true)
    SendNUIMessage({
        event = "show",
    })
    DoScreenFadeIn(1000)
    TriggerScreenblurFadeOut(1000.0)
end

local function DestroyUi()
    SetNuiFocus(false, false)
    SendNUIMessage({
        event = "hide",
    })
end

local function Spawn(data)
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local insideMeta = PlayerData.metadata["inside"]
    local JaillSpawn = Config.Jaill

    if insideMeta.house ~= nil then
        local houseId = insideMeta.house

        TriggerScreenblurFadeIn(1000)
        DoScreenFadeOut(1000)
        DestroyUi()
        Wait(1000)
        TriggerEvent('qb-houses:client:LastLocationHouse', houseId)
        Wait(2000)
        DestroyCamPed()
        DoScreenFadeIn(1000)
        FreezeEntityPosition(ped, false)
        TriggerScreenblurFadeOut(1000.0)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
        local apartmentType = insideMeta.apartment.apartmentType
        local apartmentId = insideMeta.apartment.apartmentId

        TriggerScreenblurFadeIn(1000)
        DoScreenFadeOut(1000)
        DestroyUi()
        Wait(1000)
        TriggerEvent('qb-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        Wait(2000)
        DestroyCamPed()
        DoScreenFadeIn(1000)
        FreezeEntityPosition(ped, false)
        TriggerScreenblurFadeOut(1000.0)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    elseif PlayerData.metadata['injail'] == true then
        TriggerScreenblurFadeIn(1000)
        DoScreenFadeOut(1000)
        DestroyUi()
        Wait(1000)
        DoScreenFadeIn(1000)
        TriggerScreenblurFadeOut(1000.0)
        DestroyCamPed()
        QBCore.Functions.Notify('Send To Jaill', 500)
    elseif LastSpawn == false then
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        RenderScriptCams(false, true, 2000, true, true)
        SetEntityVisible(ped, true)
        SetEntityCollision(ped, true, true)
        SendNUIMessage({ event = "hide" })
        SetNuiFocus(false, false)
        DestroyCam(MapCam, true)
        Citizen.Wait(5000)
        DoScreenFadeIn(1000)
        TriggerScreenblurFadeIn(1000)
        SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.9, 0, 0, 0, false)
        SetCamParams(Cam, data.x, data.y, data.z + 300, -85.0, 0.00, 0.00, 100.0, 7200, 0, 0, 2)
        SetCamParams(Cam, data.x, data.y, data.z + 10, -40.0, 0.00, 0.00, 100.0, 5000, 0, 0, 2)
        FreezeEntityPosition(ped, false)
        Wait(700)
        TriggerScreenblurFadeOut(1000.0)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    elseif LastSpawn == true then
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        RenderScriptCams(false, true, 2000, true, true)
        SetEntityVisible(ped, true)
        SetEntityCollision(ped, true, true)
        SendNUIMessage({ event = "hide" })
        SetNuiFocus(false, false)
        DestroyCam(MapCam, true)
        Citizen.Wait(5000)
        DoScreenFadeIn(1000)
        TriggerScreenblurFadeIn(1000)
        SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z - 0.9, 0, 0, 0, false)
        SetCamParams(Cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 300, -85.0, 0.00, 0.00, 100.0, 7200, 0, 0, 2)
        SetCamParams(Cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 10, -40.0, 0.00, 0.00, 100.0, 5000, 0, 0, 2)
        FreezeEntityPosition(ped, false)
        Wait(700)
        TriggerScreenblurFadeOut(1000.0)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    end
    legionsquare = false bank = false casino = false impound = false CanSpawn = false LastSpawn = false
end

-- event

RegisterNetEvent('qb-spawnselector:StartSpawnSelector', function()
    CreateUi()
end)

-- nui button

RegisterNUICallback("lastloc", function()
    local src = source

    if CanSpawn == true then
        LastSpawn = true
        Spawn()
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)

RegisterNUICallback("spawn", function()
    local src = source
    local spawn = Config.SpawnCoords

    if CanSpawn == true then
        if legionsquare == true then
            Spawn(spawn.Legionsquare)
        elseif casino == true then
            Spawn(spawn.casino)
        elseif bank == true then
            Spawn(spawn.bank)
        elseif impound == true then
            Spawn(spawn.impound)
        end
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)

-- spawn nui

RegisterNUICallback("legionsquare", function()
    local src = source

    if CanSpawn == true then
        legionsquare = true casino = false bank = false impound = false LastSpawn = false
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)

RegisterNUICallback("casino", function()
    local src = source

    if CanSpawn == true then
        casino = true
        legionsquare = false
        bank = false
        impound = false
        LastSpawn = false
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)

RegisterNUICallback("bank", function()
    local src = source

    if CanSpawn == true then
        bank = true
        legionsquare = false
        casino = false
        impound = false
        LastSpawn = false
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)

RegisterNUICallback("impound", function()
    local src = source

    if CanSpawn == true then
        impound = true
        bank = false
        legionsquare = false
        casino = false
        LastSpawn = false
    else
        QBCore.Functions.Kick(src, 'Check Discord ❗', nil, nil)
    end
end)


CreateThread(function()
    while true do
        Wait(0)
        if CanSpawn == true then
            DisableAllControlActions(0)
        else
            Wait(1000)
        end
    end
end)
