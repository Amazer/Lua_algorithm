--- 返回字符串分隔的字符表
function string.str2charArray(str)
    local len = string.len(str)
    local t= {}
    for i=1,len do
        local char =string.sub(str,i,i)
        table.insert(t,char)
    end
    return t
end