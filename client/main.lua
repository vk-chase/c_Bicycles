local QBCore = exports['qb-core']:GetCoreObject()

local BikeOut, currentBike, currentBikeModel = false, nil, nil
local notifytype = "qb" -- or "rtx"

-- =========================
-- Helpers
-- =========================
local function Notify(title, msg, typ)
    if notifytype == "rtx" then
        TriggerEvent("rtx_notify:Notify", title, msg, 5000, typ)
    else
        QBCore.Functions.Notify(msg, typ)
    end
end

-- =========================
-- Bicycle Handling
-- =========================
local function PlaceBicycle(data)
    local model = data.vehicle
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped) + GetEntityForwardVector(ped) * 3.0
    local heading = GetEntityHeading(ped)

    DoScreenFadeOut(500)
    Wait(800)

    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetEntityCoords(veh, coords.x, coords.y, coords.z)
        SetEntityHeading(veh, heading)
        SetVehicleOnGroundProperly(veh)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        SetVehicleNumberPlateText(veh, "BIKE"..math.random(1000, 9999))
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)

        exports['qb-target']:AddTargetEntity(veh, {
            options = {
                {
                    type = "client",
                    event = "c_Bicycle:client:PickupBike",
                    icon = "fas fa-bicycle",
                    label = "Pick up Bike",
                    canInteract = function(entity)
                        return NetworkGetEntityOwner(entity) == PlayerId()
                    end,
                },
            },
            distance = 2.5,
        })

        currentBike = veh
        currentBikeModel = model
        BikeOut = true

        TriggerServerEvent('c_Bicycle:server:RemoveBikeItem', model)
        Notify("Bike Placed", "Bicycle placed successfully. Use again to pack it up!", "success")
    end, coords, true)

    Wait(500)
    DoScreenFadeIn(1500)
end

local function PackBicycle()
    if not currentBike then return end

    if currentBikeModel then
        TriggerServerEvent('c_Bicycle:server:GiveBikeItem', currentBikeModel)
    end

    DeleteVehicle(currentBike)
    currentBike, currentBikeModel, BikeOut = nil, nil, false
    Notify("Bike Packed", "Your bike has been packed up.", "success")
end

RegisterNetEvent('c_Bicycle:client:PickupBike', PackBicycle)

-- =========================
-- Menu & Events
-- =========================
local function OpenBicycleMenu(vehicleName, model)
    local menu = {
        { title = '🚲 Bicycle Menu', icon = 'bicycle', disabled = true },
        {
            title = BikeOut and ("📦 Pack " .. vehicleName) or ("📍 Place " .. vehicleName),
            icon = BikeOut and 'box' or 'map-pin',
            onSelect = function()
                if BikeOut then
                    PackBicycle()
                else
                    PlaceBicycle({ vehicle = model })
                end
            end
        },
        {
            title = '❌ Close',
            icon = 'circle-xmark',
            onSelect = function()
                lib.hideContext() -- force close menu
            end
        },
    }

    lib.registerContext({
        id = 'bicycle_menu',
        title = 'Bicycle Options',
        options = menu
    })

    lib.showContext('bicycle_menu')
end

local bicycles = {
    { name = "BMX", model = "bmx" },
    { name = "Cruiser", model = "cruiser" },
    { name = "Fixter", model = "fixter" },
    { name = "Scorcher", model = "scorcher" },
    { name = "Whippet Race Bike", model = "tribike" },
    { name = "Endurex Race Bike", model = "tribike2" },
    { name = "Tri-Cycles Race Bike", model = "tribike3" }
}

for _, bike in ipairs(bicycles) do
    RegisterNetEvent('c_Bicycle:client:' .. bike.model .. 'Menu', function()
        OpenBicycleMenu(bike.name, bike.model)
    end)
end
