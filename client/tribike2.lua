local QBCore = exports['qb-core']:GetCoreObject()
local IsRenting = false
local notifytype = qb  -- qb  or  rtx

RegisterNetEvent('c_Bicycle:client:Tribike2Menu')
AddEventHandler('c_Bicycle:client:Tribike2Menu', function()
    if IsRenting == true then
        exports['qb-menu']:openMenu({
            {
                id = 1,
                header = 'Bicycle Menu',
                isMenuHeader = true,
            },
            {
                id = 2,
                header = "Pack Endurex Race Bike",
                params = {
                    event = "c_Bicycle:client:PackTribike2"
                }
            },
            {
                id = 3,
                header = "< Close",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        })
    end
    if IsRenting == false then
        exports['qb-menu']:openMenu({
            {
                id = 1,
                header = 'Bicycle Menu',
                isMenuHeader = true,
            },
            {
                id = 2,
                header = "Place Endurex Race Bike",
                params = {
                    event = "c_Bicycle:client:Tribike2",
                    args = {
                        vehicle = 'tribike2',

                    }
                }
            },
            {
                id = 5,
                header = "< Close",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        })
    end
end)

RegisterNetEvent('c_Bicycle:client:Tribike2')
AddEventHandler('c_Bicycle:client:Tribike2', function(rental)
    local vehicle = rental.vehicle
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local bikeCoords = vector3(pedCoords.x + 2, pedCoords.y, pedCoords.z)
    DoScreenFadeOut(1000)
    Wait(1500)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "BIKE"..tostring(math.random(1000, 9999)))
        --exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        if notifytype == rtx then
            TriggerEvent("rtx_notify:Notify", "Bike Placed", "Bicycle Placed, Use the bike again to pack it up!.", 5000, "success")
        else
            TriggerEvent("QBCore:Notify", "Bicycle Placed, Use the bike again to pack it up!", "success")
        end
        SetVehicleEngineOn(veh, true, true)
    end, bikeCoords, true) 
    Citizen.Wait(300)
    DoScreenFadeIn(2500)
    IsRenting = true
end)

RegisterNetEvent('c_Bicycle:client:PackTribike2')
AddEventHandler('c_Bicycle:client:PackTribike2', function()
    if notifytype == rtx then
        TriggerEvent("rtx_notify:Notify", "Bike Stoed", "Bike Packed.", 5000, "success")
    else
        TriggerEvent("QBCore:Notify", "Bike Packed!", "success")
    end
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car)
    IsRenting = false
end)
