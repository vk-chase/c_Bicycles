local QBCore = exports['qb-core']:GetCoreObject()

local BikeOut = false
local notifytype = "qb"  -- "qb" or "rtx"
local currentBike = nil
local currentBikeModel = nil

local function OpenBicycleMenu(BikeOut, placeEvent, packEvent, vehicleName)
    local menuItems = {
        {
            id = 1,
            header = 'Bicycle Menu',
            isMenuHeader = true,
        },
        {
            id = 2,
            header = BikeOut and ("Pack " .. vehicleName) or ("Place " .. vehicleName),
            params = {
                event = BikeOut and packEvent or placeEvent,
                args = not BikeOut and { vehicle = string.lower(vehicleName) } or nil
            }
        },
        {
            id = 3,
            header = "< Close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(menuItems)
end

local function PlaceBicycle(data)
    local vehicle = data.vehicle
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local bikeCoords = vector3(pedCoords.x + 2, pedCoords.y, pedCoords.z)

    DoScreenFadeOut(1000)
    Wait(1500)

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "BIKE"..tostring(math.random(1000, 9999)))
        TaskWarpPedIntoVehicle(ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        
        local message = "Bicycle Placed, Use the bike again to pack it up!"
        if notifytype == "rtx" then
            TriggerEvent("rtx_notify:Notify", "Bike Placed", message, 5000, "success")
        else
            QBCore.Functions.Notify(message, "success")
        end
        
        SetVehicleEngineOn(veh, true, true)
        
        exports['qb-target']:AddTargetEntity(veh, {
            options = {
                {
                    type = "client",
                    event = "c_Bicycle:client:PickupBike",
                    icon = "fas fa-bicycle",
                    label = "Pick up Bike",
                    canInteract = function(entity)
                        return GetPlayerServerId(NetworkGetEntityOwner(entity)) == GetPlayerServerId(PlayerId())
                    end,
                },
            },
            distance = 2.5,
        })

        currentBike = veh
        currentBikeModel = vehicle
        TriggerServerEvent('c_Bicycle:server:RemoveBikeItem', vehicle)
    end, bikeCoords, true) 

    Wait(300)
    DoScreenFadeIn(2500)
    BikeOut = true
end

local function PackBicycle()
    if not currentBike then return end

    local message = "Bike Packed!"
    if notifytype == "rtx" then
        TriggerEvent("rtx_notify:Notify", "Bike Stored", message, 5000, "success")
    else
        QBCore.Functions.Notify(message, "success")
    end

    if currentBikeModel then
        TriggerServerEvent('c_Bicycle:server:GiveBikeItem', currentBikeModel)
    end

    DeleteVehicle(currentBike)
    currentBike = nil
    currentBikeModel = nil
    BikeOut = false
end

RegisterNetEvent('c_Bicycle:client:PickupBike')
AddEventHandler('c_Bicycle:client:PickupBike', function()
    PackBicycle()
end)


local bicycles = {
    {name = "BMX", model = "bmx"},
    {name = "Cruiser", model = "cruiser"},
    {name = "Fixter", model = "fixter"},
    {name = "Scorcher", model = "scorcher"},
    {name = "Whippet Race Bike", model = "tribike"},
    {name = "Endurex Race Bike", model = "tribike2"},
    {name = "Tri-Cycles Race Bike", model = "tribike3"}
}

for _, bike in ipairs(bicycles) do
    RegisterNetEvent('c_Bicycle:client:' .. bike.name .. 'Menu')
    AddEventHandler('c_Bicycle:client:' .. bike.name .. 'Menu', function()
        OpenBicycleMenu(BikeOut, 'c_Bicycle:client:' .. bike.name, 'c_Bicycle:client:Pack' .. bike.name, bike.name)
    end)

    RegisterNetEvent('c_Bicycle:client:' .. bike.name)
    AddEventHandler('c_Bicycle:client:' .. bike.name, PlaceBicycle)

    RegisterNetEvent('c_Bicycle:client:Pack' .. bike.name)
    AddEventHandler('c_Bicycle:client:Pack' .. bike.name, PackBicycle)
end

RegisterNetEvent('c_Bicycle:client:PickupBike')
AddEventHandler('c_Bicycle:client:PickupBike', function()
    PackBicycle()
end)
