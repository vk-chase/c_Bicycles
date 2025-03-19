local QBCore = exports['qb-core']:GetCoreObject()

local BikeOut = false
local notifytype = "qb"  -- "qb" or "rtx"
local currentBike = nil
local currentBikeModel = nil

local function OpenBicycleMenu(vehicleName)
    local menuItems = {
        { id = 1, header = 'Bicycle Menu', isMenuHeader = true },
        { 
            id = 2,
            header = BikeOut and ("Pack " .. vehicleName) or ("Place " .. vehicleName),
            params = {
                event = BikeOut and "c_Bicycle:client:PackBike" or "c_Bicycle:client:PlaceBike",
                args = not BikeOut and { vehicle = string.lower(vehicleName) } or nil
            }
        },
        { id = 3, header = "< Close", params = { event = "qb-menu:closeMenu" } }
    }
    exports['qb-menu']:openMenu(menuItems)
end

local function Notify(message, title, notifyType)
    if notifyType == "rtx" then
        TriggerEvent("rtx_notify:Notify", title, message, 5000, "success")
    else
        QBCore.Functions.Notify(message, "success")
    end
end

local function PlaceBicycle(data)
    if BikeOut then return end
    local vehicle = data.vehicle
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local bikeCoords = vector3(pedCoords.x + 2, pedCoords.y, pedCoords.z)

    DoScreenFadeOut(1000)
    Wait(1500)

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        if not DoesEntityExist(veh) then return end

        SetVehicleNumberPlateText(veh, "BIKE"..tostring(math.random(1000, 9999)))
        TaskWarpPedIntoVehicle(ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))

        Notify("Bicycle Placed, Use the bike again to pack it up!", "Bike Placed", notifytype)

        SetVehicleEngineOn(veh, true, true)

        exports['qb-target']:AddTargetEntity(veh, {
            options = {
                {
                    type = "client",
                    event = "c_Bicycle:client:PackBike",
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
        BikeOut = true
    end, bikeCoords, true) 

    Wait(300)
    DoScreenFadeIn(2500)
end

local function PackBicycle()
    if not currentBike or not DoesEntityExist(currentBike) then return end

    Notify("Bike Packed!", "Bike Stored", notifytype)

    if currentBikeModel then
        TriggerServerEvent('c_Bicycle:server:GiveBikeItem', currentBikeModel)
    end

    DeleteVehicle(currentBike)
    currentBike = nil
    currentBikeModel = nil
    BikeOut = false
end

RegisterNetEvent('c_Bicycle:client:PlaceBike', PlaceBicycle)
RegisterNetEvent('c_Bicycle:client:PackBike', PackBicycle)

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
        OpenBicycleMenu(bike.name)
    end)
end
