function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end


local allowedResources = {"iron-ore", "copper-ore", "coal", "stone", "crude-oil", "uranium-ore"}
-- default base game resource config

if mods["omnimatter"] then
    allowedResources = {"omnite"} -- omnite can be used to make all other resources
end

if (not mods["omnimatter"]) then
    -- config for pymods
    if not (mods["angelsrefining"]) and (not mods["bobores"]) then
        if mods["pyrawores"] then
            table.remove( allowedResources, 3) -- coal
            table.remove( allowedResources, 4) -- crude oil
            local rawores = {"nexelit-rock", "ore-aluminium", "ore-chromium", "ore-lead", "ore-nickel", "ore-quartz",
            "ore-tin", "ore-titanium", "ore-zinc", "raw-coal", "salt-rock"}
            allowedResources = merge(allowedResources, rawores)
            rawores = nil
        end
        if mods["pyfusionenergy"] then
            local fusionOres = {"molybdenum-ore", "regolites", "volcanic-pipe"}
            allowedResources = merge(allowedResources, fusionOres)
            fusionOres = nil
        end
        if mods["pyhightech"] then
            local hightechOres = {"phosphate-rock", "rare-earth-bolide"}
            allowedResources = merge(allowedResources, hightechOres)
            hightechOres = nil
        end
        if mods["pycoalprocessing"] then
            local coalOres = {"borax", "niobium"}
            allowedResources = merge(allowedResources, coalOres)
            coalOres = nil
        end
        if mods["pypetroleumhandling"] then
            local petrolOres = {"oil-sand", "sulfur-patch", }
            allowedResources = merge(allowedResources, petrolOres)
            petrolOres = nil
        end
    end

    if not (mods["pyrawores"] or mods["pycoalprocessing"] or mods["pypetroleumhandling"]) then
        -- config for Angels (and angels + bobs)
        if mods["angelsrefining"] then
            -- FIX MULTI PHASE OIL NOT PRODUCED
            allowedResources = {"coal", "crude-oil", "angels-ore1", "angels-ore2", "angels-ore3", "angels-ore4", "angels-fissure"}
            log('loaded config for angels refining')
        end
        -- config for Bobs
        if mods["bobores"] and (not mods["angelsrefining"]) then
            allowedResources = {"coal", "copper-ore", "iron-ore", "stone", "uranium-ore", "bauxite-ore", "cobalt-ore",
            "gold-ore", "lead-ore", "lithia-water", "nickel-ore", "quartz", "rutile-ore", "silver-ore", "sulfur",
            "thorium-ore", "tin-ore", "tungsten-ore", "zinc-ore", "gem-ore"}
            data.raw.resource["gem-ore"].minable = true
            log('loaded config for bob ores')
        end
    end

    -- config for pymods + angels
    if mods["pyrawores"] and mods["angelsrefining"] then
        allowedResources = {"angels-ore1", "angels-ore2", "angels-ore3", "angels-ore4", "angels-ore5", "angels-ore6",
        "angels-fissure"}
        local raworesRes = {"nexelit-rock", "ore-aluminium", "ore-chromium", "ore-lead", "ore-nickel", "ore-quartz",
        "ore-tin", "ore-titanium", "ore-zinc", "raw-coal", "salt-rock"}
        local fusionRes; local hightechRes; local petrolRes; local coalRes
        if mods["pyfusionenergy"] then
            fusionRes = {"molybdenum-ore", "regolites", "volcanic-pipe"}
        end
        if mods["pyhightech"] then
            hightechRes = {"phosphate-rock", "rare-earth-bolide"}
        end
        if mods["pypetroleumhandling"] then
            petrolRes = {"oil-sand", "sulfur-patch"} 
        end
        if mods["pycoalprocessing"] then
            coalRes = {"borax", "niobium"}
        end
        allowedResources = merge(allowedResources, raworesRes)
        allowedResources = merge(allowedResources, fusionRes)
        allowedResources = merge(allowedResources, hightechRes)
        allowedResources = merge(allowedResources, petrolRes)
        allowedResources = merge(allowedResources, coalRes)
        log('loaded config for angels + pymods')
    end
end
-- create a bee for each 'allowed' resource
for _,resName in pairs(allowedResources) do
    local resource = data.raw.resource[resName]
    --log('current resource: ' .. resource.name)
    if resource ~= nil then
        beekeeping.from_resource({resource})
        log('created bee for: ' .. resource.name)
    end
end

-- materials from oil wells / bitumen seep
if data.raw.fluid["crude-oil"] then
    beekeeping.from_fluid({data.raw.fluid["crude-oil"]})
end
if data.raw.fluid["natural-gas"] then
    beekeeping.from_fluid({data.raw.fluid["natural-gas"]})
end
if data.raw.fluid["tar"] then
    beekeeping.from_fluid({data.raw.fluid["tar"]})
end


require 'prototypes.dynamic.item'
require 'prototypes.dynamic.recipe'
require 'prototypes.dynamic.technology'

if beekeeping.override == false then
	beekeeping.extend()
end