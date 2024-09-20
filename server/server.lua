local QBCore = exports['qb-core']:GetCoreObject()

local bicycles = {
    "bmx",
    "cruiser",
    "fixter",
    "scorcher",
    "tribike",
    "tribike2",
    "tribike3"
}

local function CreateBicycleItem(bicycleName)
    QBCore.Functions.CreateUseableItem(bicycleName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            TriggerClientEvent('c_Bicycle:client:' .. bicycleName:gsub("^%l", string.upper) .. 'Menu', source)
        end
    end)
end

for _, bicycle in ipairs(bicycles) do
    CreateBicycleItem(bicycle)
end
