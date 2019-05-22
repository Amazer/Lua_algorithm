Set = function()
    local public = {}
    local private ={
        data ={},
        count = 0,
    }
    public.AddEle=function(ele)
        if not table.containsEle(private.data,ele) then
            table.insert(private.data,ele)
            private.count = private.count + 1
        end
        return public
    end
    public.AddElements = function(t)
        for i=1,#t do
            public.AddEle(t[i])
        end
        return public
    end

    public.RemEle= function(ele)
        if table.containsEle(private.data,ele) then
            for i=1,#private.data do
                if private.data[i] == ele then
                    table.remove(private.data,i)
                    private.count = private.count - 1
                    break
                end

            end
        end

        return public
    end

    public.Contains = function(ele)
        return table.containsEle(private.data,ele)
    end

    public.GetData = function()
        local t = {}
        for i=1,#private.data do
            table.insert(t,private.data[i])
        end
        return t
    end

    public.Count = function()
        return private.count
    end

    public.Clear = function()
        private.data = {}
        private.count = 0
        return public
    end


    return public
end

set = {}

--- 并集
set.union = function(set1,set2)
    local unionSet = Set()
    unionSet.AddElements(set1.GetData())
    unionSet.AddElements(set2.GetData())
    return unionSet
end

--- 交集
set.intersection = function(set1,set2)
    local interSet = Set()
    local set2Data = set2.GetData()
    for i=1,#set2Data do
        if set1.Contains(set2Data[i]) then
            interSet.AddEle(set2Data[i])
        end
    end
    return interSet
end

--- 差集
set.difference = function(set1,set2)
    local diffSet = Set().AddElements(set1.GetData())
    local set2Data = set2.GetData()

    for i=1,#set2Data do
        if diffSet.Contains(set2Data[i]) then
            diffSet.RemEle(set2Data[i])
        end
    end
    return diffSet
end


set.print = function(s)
    local data = s.GetData()
    local str = table.concat(data,",")
    str ="set:{ ".. str .. " }"
    print(str)
end
