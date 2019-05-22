CLog = {}
CLog.Info = function(...)

end

CLog._get_table_str = function(content)
    local tabStr = ""
    if content then
        tabStr = table._print("table",content)
    else
        tabStr = "table".." = nil "
    end
    return tabStr
end
