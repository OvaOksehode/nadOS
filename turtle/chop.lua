local function chop()
    local _,t = turtle.inspect()

    local h = 0

    if not(string.find(t.name, "log")) then print("not log") return end

    while string.find(t.name, "log") do
        turtle.dig()
        turtle.digUp()
        h = h + 1
        turtle.up()
        _,t = turtle.inspect()
    end
    
    for i = 1, h do
        turtle.down()
    end
end

return {chop=chop}