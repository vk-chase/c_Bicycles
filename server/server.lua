local QBCore = exports['qb-core']:GetCoreObject()

local bicycles = {
    {name = "BMX", model = "bmx"},
    {name = "Cruiser", model = "cruiser"},
    {name = "Fixter", model = "fixter"},
    {name = "Scorcher", model = "scorcher"},
    {name = "Whippet Race Bike", model = "tribike"},
    {name = "Endurex Race Bike", model = "tribike2"},
    {name = "Tri-Cycles Race Bike", model = "tribike3"}
}

local function CreateBicycleItem(bicycle)
    QBCore.Functions.CreateUseableItem(bicycle.model, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local playerItem = Player.Functions.GetItemBySlot(item.slot)
            if playerItem and playerItem.name == bicycle.model then
                if Player.Functions.RemoveItem(bicycle.model, 1) then
                    print("[Bicycle System] Item Used: " .. bicycle.model .. " by Player ID: " .. source)
                    TriggerClientEvent('c_Bicycle:client:' .. bicycle.name .. 'Menu', source)
                else
                    print("[Bicycle System] Failed to remove item: " .. bicycle.model .. " for Player ID: " .. source)
                end
            else
                print("[Bicycle System] Item not found in inventory slot for Player ID: " .. source)
            end
        end
    end)
end

for _, bicycle in ipairs(bicycles) do
    CreateBicycleItem(bicycle)
end

RegisterNetEvent('c_Bicycle:server:GiveBikeItem', function(bikeModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and QBCore.Shared.Items[bikeModel] then
        Player.Functions.AddItem(bikeModel, 1)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[bikeModel], 'add')
        print("[Bicycle System] Given item: " .. bikeModel .. " to Player ID: " .. src)
    else
        print("[Bicycle System] Error: Unable to give item " .. tostring(bikeModel) .. " to Player ID: " .. src)
    end
end)

RegisterNetEvent('c_Bicycle:server:RemoveBikeItem', function(bikeModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and QBCore.Shared.Items[bikeModel] then
        if Player.Functions.RemoveItem(bikeModel, 1) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[bikeModel], 'remove')
            print("[Bicycle System] Removed item: " .. bikeModel .. " from Player ID: " .. src)
        else
            print("[Bicycle System] Error: Failed to remove item " .. bikeModel .. " from Player ID: " .. src)
        end
    else
        print("[Bicycle System] Error: Item " .. tostring(bikeModel) .. " not found in Shared Items for Player ID: " .. src)
    end
end)
