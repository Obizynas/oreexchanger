local component = require("component")
-- руда
intr = component.proxy("6a57afe3-9af9-479c-8564-d62a575a3f27")
contr = component.proxy("3d0856ad-c523-41ce-b277-2aef0a10078e")
-- слитки
ints = component.proxy("7e3d3f40-b5c0-46dd-854e-9672664c105c")
conts = component.proxy("1f38102a-919b-46cb-8217-6be610f0e06c")

local ore_dict = {
    {
        "Железная руда",
        "Железный слиток",
        take = {name = "minecraft:iron_ore", damage = 0},
        give = {name = "minecraft:iron_ingot", damage = 0},
        rate = {take = 3, give = 7}
    },
    {
        "Кварцевая руда",
        "Кварц",
        take = {name = "minecraft:quartz_ore", damage = 0},
        give = {name = "minecraft:quartz", damage = 0},
        rate = {take = 1, give = 4}
    },
    {
        "Золотая руда",
        "Золотой слиток",
        take = {name = "minecraft:gold_ore", damage = 0},
        give = {name = "minecraft:gold_ingot", damage = 0},
        rate = {take = 3, give = 7}
    },
    {
        "Лазуритовая руда",
        "Лазурит",
        take = {name = "minecraft:lapis_ore", damage = 0},
        give = {name = "minecraft:dye", damage = 4},
        rate = {take = 1, give = 9}
    },
    {
        "Красная руда",
        "Красная пыль",
        take = {name = "minecraft:redstone_ore", damage = 0},
        give = {name = "minecraft:redstone", damage = 0},
        rate = {take = 1, give = 5}
    },
    {
        "Медная руда",
        "Медный слиток",
        take = {name = "IC2:blockOreCopper", damage = 0},
        give = {name = "IC2:itemIngot", damage = 0},
        rate = {take = 3, give = 7}
    },
    {
        "Оловянная руда",
        "Оловянный слиток",
        take = {name = "IC2:blockOreTin", damage = 0},
        give = {name = "IC2:itemIngot", damage = 1},
        rate = {take = 3, give = 7}
    },
    {
        "Оловянная руда",
        "Оловянный слиток",
        take = {name = "NetherOres:tile.netherores.ore.0", damage = 7},
        give = {name = "IC2:itemIngot", damage = 1},
        rate = {take = 3, give = 7}
    },
    {
        "Дракониевая руда",
        "Дракониевый слиток",
        take = {name = "DraconicEvolution:draconiumOre", damage = 0},
        give = {name = "DraconicEvolution:draconiumIngot", damage = 0},
        rate = {take = 1, give = 3}
    }
}
orer = 0
ores = 0

local irons = 0
local ironr = 0
local golds = 0
local goldr = 0
local meds = 0
local medr = 0
local olovos = 0
local olovor = 0

local function giveItemFromMeIgnot(item, dmg, amount, direction)
    local fingerprint = {id = item, dmg = dmg}
    local err, res = pcall(ints.exportItem, fingerprint, direction, amount)
    if err == true then
        return res.size
    end
end
local function giveItemFromMeOre(item, dmg, amount, direction)
    local fingerprint = {id = item, dmg = dmg}
    local err, res = pcall(intr.exportItem, fingerprint, direction, amount)
    if err == true then
        return res.size
    end
end

local function giveOre()
    for i, ore in ipairs(ore_dict) do
        local name_ru = ore[1]  -- Название руды (позиционно)
        local product_ru = ore[2]  -- Название предмета после обработки (позиционно)
    
        local take_name = ore.take.name
        local take_damage = ore.take.damage
    
        local give_name = ore.give.name
        local give_damage = ore.give.damage
    
        local rate_take = ore.rate.take
        local rate_give = ore.rate.give
    
        print("[" .. i .. "] " .. name_ru .. " -> " .. product_ru)
        print("  Берём: " .. take_name .. " (" .. take_damage .. "), " .. rate_take .. " шт.")
        orer = ints.getItemDetail({id=take_name, dmg=take_damage})
        giveItemFromMeOre(take_name, take_damage, rate_take, "UP")
        if orer == nil then
            orer = 0
        else
            orer = orer.basic().qty
        end
        print("  Отдаём: " .. give_name .. " (" .. give_damage .. "), " .. rate_give .. " шт.")
        giveItemFromMeIgnot(give_name, give_damage, rate_give, "DOWN")
        ores = ints.getItemDetail({id=take_name, dmg=take_damage})
        if ores == nil then
            ores = 0
        else
            ores = ores.basic().qty
        end
        if ores < rate_take then
            print("Недостаточно руды: " .. ores .. " из " .. rate_take)
        else 

        end
    end

end

while true do
giveOre()
end

