function table.count(ptab)
    local result = 0
    if type(ptab) == "table" then
        for k,v in pairs(ptab) do
            result = result + 1
        end
    end
    return result
end

function table.add(t1,t2)
    for i=1,#t2 do
        table.insert(t1,t2[i])
    end
    return t1
end
function table.containsVal(t,val)
    for k,v in pairs(t) do
        if v == val then
            return true
        end
    end
    return false
end
function table.containsEle(t,val)
    for k,v in pairs(t) do
        if v == val then
            return true
        end
    end
    return false
end

function table.containsKey(t,key)
    for k,v in pairs(t) do
        if k == key then
            return true
        end
    end
    return false
end



local _print_blank_level = 0
local _print_new_line = function()
    local result = "\n"
    for i = 1,_print_blank_level do
        result = result .. "    "
    end
    return result
end

function table.print(ptab,tabname)
    local tabStr = ""
    tabname = tabname or "table"
    if ptab then
        tabStr = table._print(tabname,ptab)
    else
        tabStr = tabname .. " = nil"
    end
    print(tabStr)
end

function table._print(key,value,vistor)
    local tabStr = ""
    if not vistor then
        vistor = {}
    end
    if "table" == type(value) and not vistor[tostring(value)] then
        vistor[tostring(value)] = true
        tabStr = string.format(_print_new_line().."%s = { ",key)
        _print_blank_level = _print_blank_level + 1
        if table.count(value) > 0 then
            for k,v in pairs(value) do
                tabStr = tabStr .. table._print(k,v,vistor)
            end
        end

        local meta_table = getmetatable(value)
        if meta_table and meta_table.__index then
            tabStr = tabStr.._print_blank_level .. " }"
        end
        tabStr = tabStr .. _print_new_line() .. " }"
        _print_blank_level = _print_blank_level - 1
    else
        tabStr = string.format(_print_new_line().."%s = %s, ",key,tostring(value) or "nil")
    end

    return tabStr
end
