local nadOS = {}

for key, value in pairs(fs.list("/nadOS")) do
    if string.find(value, ".lua") and value ~= "init.lua" then
        local sub_dir = string.gsub(value, ".lua", "")
        nadOS[sub_dir] = require("nadOS."..sub_dir)
    end
end

return nadOS