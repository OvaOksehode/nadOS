
--[[
for i = 1, fs.list() do
    
end
--]]

local pwd = string.gsub(shell.getRunningProgram().."/", ".lua", "")


local return_table = {}

local function recursive_check(dir)
    local pwd = dir
    local results = {}

    for key, value in pairs(fs.list(pwd)) do
        --print(fs.isDir(value))
        if fs.isDir(value) then
            print("value "..value.." is a directory")
            pwd = dir..value.."/"
        elseif string.find(value, ".lua") then
            print("value "..value.."is a script")
            table.insert(results, value)
            return
        end
    end

    return results
end

--textutils.pagedTabulate(recursive_check(pwd))