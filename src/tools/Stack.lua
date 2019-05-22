Stack= function()
    local private ={
        data={},
        count=0
    }
    local public ={}

    public.Push = function(ele)
        table.insert(private.data,ele)
        private.count = private.count +1

    end
    public.Pop = function()
        if private.count>0 then
            local ele = private.data[1]
            table.remove(private.data,1)
            private.count = private.count -1
            return ele
        end
        return nil

    end
    public.Peek = function()
        if private.count > 0 then
            return private.data[1]
        end
        return nil
    end
    public.Count = function()
        return private.count
    end

    return public
end