beekeeping = {override = false}
require 'lib'

-- prevent resource patch generation
for _,resource in pairs(data.raw.resource) do
    resource.autoplace = nil
end

for _,control in pairs(data.raw["autoplace-control"]) do
    if control.name ~= 'enemy-base' then
        control = nil
    end
end

local waterTiles = {"deepwater", "deepwater-green", "water", "water-green", "water-mud", "water-shallow"}
for _,waterTile in pairs(waterTiles) do
    data.raw.tile[waterTile].autoplace = nil
end

if settings.startup["better-bees-no-biters-setting"].value == true then
    for _,turret in pairs(data.raw.turret) do
        turret.autoplace = nil
    end
    for _,spawner in pairs(data.raw["unit-spawner"]) do
        spawner.autoplace = nil
    end
end

require('prototypes.entity.apiary')
require('prototypes.entity.hive-1')
require('prototypes.entity.hive-2')
require('prototypes.entity.hive-3')
require('prototypes.entity.liquiformer')
require('prototypes.entity.sequencer')
require('prototypes.entity.genetic-transposer')
require('prototypes.entity.logistic-hive')
require('prototypes.entity.nursery')
require('prototypes.entity.logistic-bees')
require('prototypes.category')
require('prototypes.item')
require('prototypes.recipe')