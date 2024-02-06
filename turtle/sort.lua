--[[
Sorting script for minecraft computercraft mod.
Version 1.0
by Anders    
--]]

local is_sorted = false
local INTERNAL_SLOTS = 4*4

local chest = peripheral.wrap("front")

local string_functions = require("/nadOS.util.string")

local strip_modtag = string_functions.strip_modtag

local function get_chest_inventory()
    turtle.select(1)


    local items_raw = chest.list()
    local items_output = {}

    for key, value in pairs(items_raw) do
        table.insert(items_output, strip_modtag(value.name))
    end
    
    --textutils.tabulate(items)
    turtle.select(1)
    return items_output
end

local function lookup_slot(name, i)
    for i=i, chest.size() do
        if chest.getItemDetail(i) then
            if strip_modtag(chest.getItemDetail(i).name) == name then
                return i
            end
        end
    end
    print("item not found")
end

local function switch_item_slots(slot1, slot2, listLength)
    if slot1==slot2 then return end

    chest.pushItems("front", slot1, 64, listLength+1)
    chest.pushItems("front", slot2, 64, slot1)
    chest.pushItems("front", listLength+1, 64, slot2)
end

local function sort_inventory()
    if not turtle then
        error("Sort must be performed by a turtle.")
        return nil
    end

    local unsorted_inventory = get_chest_inventory()
    local sorted_inventory = table.move(unsorted_inventory, 1, #unsorted_inventory, 1, {})
    table.sort(sorted_inventory)

    local a_time = os.clock()
    local b_time

        
    print("sorting...")
    for i = 1, #sorted_inventory do
        switch_item_slots(i, lookup_slot(sorted_inventory[i], i), #sorted_inventory)
        term.clear()
        b_time = os.clock()
        print(i.."/"..#sorted_inventory.." items sorted ("..(math.floor((b_time-a_time)*100+0.5)/100).."s)")
    end

    term.clear()
    print("Done sorting. ("..(math.floor((b_time-a_time)*100+0.5)/100).."s)")
end

return {sort_inventory=sort_inventory}

--[[

local y = 1
while y <= #sorted_inventory do
    for i = 1, INTERNAL_SLOTS do
        turtle.select(i)
            
        if turtle.getItemDetail() ~= nil then 
            local item_name = strip_modtag(turtle.getItemDetail().name)
            if item_name == sorted_inventory[y] then
                turtle.drop()
                y = y + 1
                break
            end
        end
    end
end
--]]
