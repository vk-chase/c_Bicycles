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
    local model = bicycle.model
    QBCore.Functions.CreateUseableItem(model, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.Functions.GetItemBySlot(item.slot) then
            TriggerClientEvent('c_Bicycle:client:' .. model .. 'Menu', source)
        end
    end)
end

-- Register all bicycle items
for _, bicycle in ipairs(bicycles) do
    CreateBicycleItem(bicycle)
end

RegisterNetEvent('c_Bicycle:server:GiveBikeItem', function(bikeModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem(bikeModel, 1)
        local itemData = QBCore.Shared.Items[bikeModel]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, itemData, 'add')
        else
            print(('^1[ERROR]^0 Unknown bike item model: %s'):format(bikeModel))
        end
    end
end)

RegisterNetEvent('c_Bicycle:server:RemoveBikeItem', function(bikeModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveItem(bikeModel, 1)
        local itemData = QBCore.Shared.Items[bikeModel]
        if itemData then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, itemData, 'remove')
        else
            print(('^1[ERROR]^0 Unknown bike item model: %s'):format(bikeModel))
        end
    end
end)
