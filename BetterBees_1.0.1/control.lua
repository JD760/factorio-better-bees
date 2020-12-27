
local Event = require("__stdlib__/stdlib/event/event")
local start_inventory = {}

function start_inventory.on_init()
    if remote.interfaces['freeplay'] then
        local createdItems = remote.call("freeplay", "get_created_items")
        createdItems["clean-queen-10"] = 1
        for _,item in pairs(game.item_prototypes) do
            if (item.name:find "-queen-12" ~= nil) then
                createdItems[item.name] = 1
            end
        end
        remote.call("freeplay", "set_created_items", createdItems)
    end
end

Event.register(Event.core_events.init, start_inventory.on_init)