local QBCore = exports['qb-core']:GetCoreObject()
local IsRenting = false
local notifytype = "qb"  -- "qb" or "rtx"

local function OpenBicycleMenu(isRenting, placeEvent, packEvent, vehicleName)
    local menuItems = {
        {
            id = 1,
            header = 'Bicycle Menu',
            isMenuHeader = true,
        },
        {
            id = 2,
            header = isRenting and ("Pack " .. vehicleName) or ("Place " .. vehicleName),
            params = {
                event = isRenting and packEvent or placeEvent,
                args = not isRenting and { vehicle = string.lower(vehicleName) } or nil
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
            TriggerEvent("QBCore:Notify", message, "success")
        end
        
        SetVehicleEngineOn(veh, true, true)
    end, bikeCoords, true) 

    Wait(300)
    DoScreenFadeIn(2500)
    IsRenting = true
end

local function PackBicycle()
    local message = "Bike Packed!"
    if notifytype == "rtx" then
        TriggerEvent("rtx_notify:Notify", "Bike Stored", message, 5000, "success")
    else
        TriggerEvent("QBCore:Notify", message, "success")
    end

    local car = GetVehiclePedIsIn(PlayerPedId(), true)
    DeleteVehicle(car)
    DeleteEntity(car)
    IsRenting = false
end

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
        OpenBicycleMenu(IsRenting, 'c_Bicycle:client:' .. bike.name, 'c_Bicycle:client:Pack' .. bike.name, bike.name)
    end)

    RegisterNetEvent('c_Bicycle:client:' .. bike.name)
    AddEventHandler('c_Bicycle:client:' .. bike.name, PlaceBicycle)

    RegisterNetEvent('c_Bicycle:client:Pack' .. bike.name)
    AddEventHandler('c_Bicycle:client:Pack' .. bike.name, PackBicycle)
end
