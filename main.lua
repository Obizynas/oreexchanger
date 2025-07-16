local component = require("component")
-- руда
intr = component.proxy("6a57afe3-9af9-479c-8564-d62a575a3f27")
contr = component.proxy("3d0856ad-c523-41ce-b277-2aef0a10078e")
-- слитки
ints = component.proxy("7e3d3f40-b5c0-46dd-854e-9672664c105c")
conts = component.proxy("1f38102a-919b-46cb-8217-6be610f0e06c")

local irons = 0
local ironr = 0

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

local function ingnot()
irons = ints.getItemDetail({id='minecraft:iron_ingot' , dmg=0})
    if irons == nil then
        irons = 0
    else
        irons = irons.basic().qty
    end
end
local function ore()
    ironr = intr.getItemDetail({id='minecraft:iron_ore' , dmg=0})
    if ironr == nil then
        ironr = 0
    else
        ironr = ironr.basic().qty
    end

end
while true do
    ore()
    ingnot()
    if irons >= 7 then
        if ironr >= 3 then
            giveItemFromMeIgnot("minecraft:iron_ingot", 0, 7, "DOWN")
            giveItemFromMeOre("minecraft:iron_ore", 0, 3, "UP")
        else
            print("Недостаточно руды")
        end
    else
        print("Недостаточно слитков")
    end
    os.sleep(0.1)
end

