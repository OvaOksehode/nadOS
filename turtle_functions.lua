local turtle_functions = {}
turtle_functions.movement = {}

local util = require("/nadOS/util")

local strip_modtag = util.string.strip_modtag

turtle_functions.movement.forward = function (distance)
    if distance<0 then
        for i = 1, distance*-1 do
            turtle.back()
        end
    else
        for i = 1, distance do
            turtle.forward()
        end
    end
end

turtle_functions.movement.shift_left = function (distance)
    local distance = distance or 1
    turtle.turnLeft()
    for i = 1, distance do
        turtle.forward()
    end
    turtle.turnRight()
end

turtle_functions.movement.shift_right = function (distance)
    local distance = distance or 1
    turtle.turnRight()
    for i = 1, distance do
        turtle.forward()
    end
    turtle.turnLeft()
end

turtle_functions.movement.flip = function (times)
    for i = 1, 2 do
        turtle.turnLeft()
    end
end

turtle_functions.dump_internal_storage = function ()

    if not(turtle) then
        error("dump_internal_storage must be performed by a turtle.")
    end

    for i = 1, 4^2 do
        turtle.select(i)
        turtle.drop()
    end

    for i = 1, 4^2 do
        turtle.select(i)
        local item = turtle.getItemDetail()
        if item then
            return false
        end
    end

    return true

end

turtle_functions.chop_tree = function()
    if not(turtle) then
        error("chop_tree must be performed by a turtle.")
    end

    local _,item = turtle.inspect()
    local h = 0

    --print("hello window")
    --print(item=="No block to inspect")

    local function is_log(item)
        --print(item)
        if item=="No block to inspect" then
            --print("test")
            return false
        elseif string.find(item.name, "log") then
            return true
        else
            return false
        end
    end

    local function chop_and_elevate(height)
        turtle.dig()
        turtle.digUp()
        h = h + 1
        turtle.up()
    end

    local function go_down(h)
        for i = 1, h do
            turtle.down()
        end
    end

    --print(item=="No block to inspect")

    if not(is_log(item)) then
        print("no log found")
        return false
    end

    while is_log(item) do
        chop_and_elevate(h)
        _,item = turtle.inspect()
    end

    go_down(h)

    return true
end

turtle_functions.sort_inventory = function()
    if not(turtle) then
        error("Sort must be performed by a turtle.")
    end
    
    local chest = peripheral.wrap("front")
    
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

    local function switch_item_slots(slot1, slot2, listLength)
        if slot1==slot2 then return end
    
        chest.pushItems("front", slot1, 64, listLength+1)
        chest.pushItems("front", slot2, 64, slot1)
        chest.pushItems("front", listLength+1, 64, slot2)
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

return turtle_functions