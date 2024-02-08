local util = {}
util.inventory = {}
util.string = {}


util.inventory.search_internal_inventory = function()
    error("not yet implemented")
end

util.string.strip_modtag = function(input_string)
    local _,_,output_string = string.find(input_string, ":(.+)")
    return output_string
end

return util