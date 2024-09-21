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
            TriggerClientEvent('c_Bicycle:client:' .. bicycle.name .. 'Menu', source)
        end
    end)
end

for _, bicycle in ipairs(bicycles) do
    CreateBicycleItem(bicycle)
end
