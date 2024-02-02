local pwd = string.gsub(shell.getRunningProgram(), "recursive_search.lua", "")

--print(pwd)

local function get_file_hierarchy(dir, tree)
    local tree = tree or {}

    for _, value in ipairs(fs.list(dir)) do
        --print(fs.isDir(dir..value.."/"))
        if string.find(value, ".lua") then
            --print(value)
            table.insert(tree, value)
        end
        if fs.isDir(dir..value.."/") then
            get_file_hierarchy(dir..value.."/", tree)
        end
    end

    return tree
end

textutils.pagedTabulate(get_file_hierarchy("nadOS/"))
