
Bicycles as items for QBCore.  
Spawn, ride, and pack up bikes as inventory items.

![Bicycle](images/bike.png) <!-- Update path if needed -->

---

## ✨ Features
- Adds **7 different bicycle types** as usable inventory items, more if you like or have customs!
- Compatible with **qb-core**, **qb-target**, and **ps-inventory**
- Optional: 5-day **decay & auto-delete**
- Optional: integrates with **fuel systems**
  
(players can only pick up bikes they place down. global bikes are not targetable just your own!)

- <img width="646" height="684" alt="bmx1" src="https://github.com/user-attachments/assets/96e613f8-6f6a-4938-9d24-7eb1c6ed892f" />
<img width="1064" height="1199" alt="bm2" src="https://github.com/user-attachments/assets/7af69aa0-62df-4d1f-98b5-404f429867f6" />


---

## 📥 Installation
1. Drop the resource folder into your `resources` directory.
2. Add `ensure vk-bicycles` to your `server.cfg`.
3. Add the provided `bike.png` to your inventory’s **images folder** (`qb-inventory/html/images` or `ps-inventory/html/images`).
   - If you want unique images for each bike, you’ll need to add them separately.

---

## ⚙️ Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)  
- [qb-target](https://github.com/qbcore-framework/qb-target)

---

## 🔧 Configuration

### Items  
Add the following to your `qb-core/shared/items.lua`:

```lua
bmx = {
    name = 'bmx', label = 'BMX', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A compact, agile bike perfect for tricks and urban riding.'
},

cruiser = {
    name = 'cruiser', label = 'Cruiser', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A comfortable, laid-back bike ideal for casual rides and beach cruising.'
},

fixter = {
    name = 'fixter', label = 'Fixter', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A sturdy, reliable bike suitable for everyday commuting and errands.'
},

scorcher = {
    name = 'scorcher', label = 'Scorcher', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A versatile mountain bike built for off-road adventures and rough terrain.'
},

tribike = {
    name = 'tribike', label = 'Whippet Race Bike', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A lightweight, aerodynamic road bike designed for speed and performance.'
},

tribike2 = {
    name = 'tribike2', label = 'Endurex Race Bike', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A high-performance road bike built for endurance and long-distance rides.'
},

tribike3 = {
    name = 'tribike3', label = 'Tri-Cycles Race Bike', weight = 3500, type = 'item',
    image = 'bike.png', unique = true, useable = true, shouldClose = false,
    combinable = nil, decay = 5.0, delete = true,
    description = 'A specialized triathlon bike optimized for speed and efficiency in multi-sport events.'
},
