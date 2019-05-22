Queue=function()
    local public ={}
    local private = {
        data={},
        count = 0
    }

    public.Enqueue=function(ele)
        table.insert(private.data,ele)
        private.count = private.count +1
    end
    public.Dequeue=function()
        if private.count > 0 then
            local val = private.data[private.count]
            table.remove(private.data,private.count)
            private.count = private.count-1
            return val
        else
            print("error,queue count is 0")
            return nil
        end

    end
    public.Peek = function()
        if private.count > 0 then
            local val = private.data[private.count]
            return val
        else
            return nil
        end

    end

    public.Contains = function(val)
        if private.count > 0 then
            for i=1,private.count do
                if private.data[i] == val then
                    return true
                end
            end
        end
        return false
    end

    public.Count = function()
        return private.count
    end
    return public
end


