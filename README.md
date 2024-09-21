# vk-Bicycles 🚲

Bicycles as items for QBCore

![Bicycle](path/to/your/bike.png)

## Features

- Adds various bicycle types as usable items
- Compatible with ps-inventory
- 5-day decay and auto-delete functionality (optional)
- Easy integration with fuel systems (optional)

## Installation

1. Add the provided `bike.png` to your inventory's image folder.
2. If you want a unique image per bike, you'll need to add those separately.

## Configuration
you will need : 

qb-target 
qb-core

### Items

Add the following to your `items.lua`:

```lua:items.lua
bmx = {name = 'bmx', label = 'BMX', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A compact, agile bike perfect for tricks and urban riding.'},
cruiser = {name = 'cruiser', label = 'Cruiser', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A comfortable, laid-back bike ideal for casual rides and beach cruising.'},
fixture = {name = 'fixture', label = 'Fixture', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A sturdy, reliable bike suitable for everyday commuting and errands.'},
scorcher = {name = 'scorcher', label = 'Scorcher', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A versatile mountain bike built for off-road adventures and rough terrain.'},
tribike = {name = 'tribike', label = 'Whippet Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A lightweight, aerodynamic road bike designed for speed and performance.'},
tribike2 = {name = 'tribike2', label = 'Endurex Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A high-performance road bike built for endurance and long-distance rides.'},
tribike3 = {name = 'tribike3', label = 'Tri-Cycles Race Bike', weight = 3500, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, decay = 5.0, delete = yes, description = 'A specialized triathlon bike optimized for speed and efficiency in multi-sport events.'},
