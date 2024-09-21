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
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            if Player.Functions.RemoveItem(bicycle.model, 1) then
                TriggerClientEvent('c_Bicycle:client:' .. bicycle.name .. 'Menu', source)
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
    Player.Functions.AddItem(bikeModel, 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[bikeModel], 'add')
end)

RegisterNetEvent('c_Bicycle:server:RemoveBikeItem', function(bikeModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(bikeModel, 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[bikeModel], 'remove')
end)
