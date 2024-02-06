local function chop()
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

return {chop=chop}
