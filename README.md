# c_Bicycles
bike / bicycle as item for qbcore


add the provided png to your immage foleder of your inventory. if you want a immage per bike you will have to do this.

this is set up for a 5 day decay and auto delete with ps-inventory, if you dont want decay or dont use it feel free to delete the:

decay = 5.0, delete = yes,

of each item, if your inventory doesnt support decay, simply ignore it.


-- ITEMS.LUA

bmx = {name = 'bmx', label = 'BMX', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A compact, agile bike perfect for tricks and urban riding.'},
cruiser = {name = 'cruiser', label = 'Cruiser', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A comfortable, laid-back bike ideal for casual rides and beach cruising.'},
fixture = {name = 'fixture', label = 'Fixture', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A sturdy, reliable bike suitable for everyday commuting and errands.'},
scorcher = {name = 'scorcher', label = 'Scorcher', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A versatile mountain bike built for off-road adventures and rough terrain.'},
tribike = {name = 'tribike', label = 'Whippet Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A lightweight, aerodynamic road bike designed for speed and performance.'},
tribike2 = {name = 'tribike2', label = 'Endurex Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A high-performance road bike built for endurance and long-distance rides.'},
tribike3 = {name = 'tribike3', label = 'Tri-Cycles Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A specialized triathlon bike optimized for speed and efficiency in multi-sport events.'},


-- add these items to any shop you want
-- great "fly in" items for new players!

***
if you for some reason want to use fuel on bicycles, ignore the bottom and go to each client bike lua and uncomment the 

--exportsLegacyFuel:SetFuel(veh, 100.0)

and set the LegacyFuel to whatever you use i.e.:
LegacyFuel or cdn-fuel or ps-fuel etc etc
__ this will have to be done to each clinet lua..
***

-- set no fuel usage in your LegacyFuel / cdn / ps-fuel etc.. per bike.

i.e. cdn-fuel will look like this -->

Config.NoFuelUsage = { -- This is for you to put vehicles that you don't want to use fuel.
    ["bmx"] = {
        blacklisted = true
    },
    ["cruiser"] = {
        blacklisted = true
    },
    ["fixter"] = {
        blacklisted = true
    },
    ["scorcher"] = {
        blacklisted = true
    },
    ["tribike"] = {
        blacklisted = true
    },
    ["tribike2"] = {
        blacklisted = true
    },
    ["tribike3"] = {
        blacklisted = true
    },
    ["skateboard"] = {
        blacklisted = true
    },

    -- add more here
}

bout it.. enjoy
