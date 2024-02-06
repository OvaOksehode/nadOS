local function strip_modtag(input_string)
    local _,_,output_string = string.find(input_string, ":(.+)")
    return output_string
end

return {strip_modtag=strip_modtag}