
local Event = require("__stdlib__/stdlib/event/event")
local startInventory = {}
local startingItems = {}

function startInventory.on_init()
    if remote.interfaces['freeplay'] then
        local createdItems = remote.call("freeplay", "get_created_items")
        for _,item in pairs(game.item_prototypes) do
            if string.match(item.name, '%-queen%-12') ~= nil then
                createdItems[item.name] = 1
            end
        end
        remote.call("freeplay", "set_created_items", createdItems)
    end
end

Event.register(Event.core_events.init, startInventory.on_init)