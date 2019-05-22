require "arithmetic"

local states_needed = Set().AddElements({"mt","wa","or","id","nv","ut","ca","az"})
local stations = {}
stations.kone=Set().AddElements({"id","nv","ut"})
stations.ktwo=Set().AddElements({"wa","id","mt"})
stations.kthree= Set().AddElements({"or","nv","ca"})
stations.kfour= Set().AddElements({"nv","ut"})
stations.kfive = Set().AddElements({"ca","az"})

local final_stations = Set()


while states_needed.Count()>0 do
    local best_station = nil
    local states_covered=Set()
    for k,v in pairs(stations) do
        if not final_stations.Contains(k) then
            local covered = set.intersection(states_needed,v) -- 交集
            if states_covered.Count()<covered.Count() then
                best_station = k
                states_covered = covered
            end
        end
    end
    if best_station then
        final_stations.AddEle(best_station)
        states_needed = set.difference(states_needed,states_covered)
    else
        break
    end
end


set.print(final_stations)
print("over")
CLog.Info("this is :{0}",1)

