local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("bmx", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
         TriggerClientEvent('c_Bicycle:client:BMXMenu', source)
    end
end)
QBCore.Functions.CreateUseableItem("cruiser", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:CruiserMenu', source)
    end
end)
QBCore.Functions.CreateUseableItem("fixture", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:FixtureMenu', source)
    end
end)
QBCore.Functions.CreateUseableItem("scorcher", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:ScorcherMenu', source)
    end
end)
QBCore.Functions.CreateUseableItem("tribike", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:TribikeMenu', source)
    end
end)
QBCore.Functions.CreateUseableItem("tribike2", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:Tribike2Menu', source)
    end
end)
QBCore.Functions.CreateUseableItem("tribike3", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('c_Bicycle:client:Tribike3Menu', source)
    end
end)
