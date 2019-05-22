require "ToolInclude"

-- 图 广度搜索 --> 寻找芒果商

local graph ={}
graph.you = {"alice","bob","claire"}
graph.alice = {"peggy"}
graph.bob = {"anuj","peggy"}
graph.claire={"thom","jonny"}

graph.peggy ={}
graph.anuj={}

graph.thom={}
graph.jonny={}

seller = "peggy"
-- seller = "ammy"
function isSeller(name)
    if name == seller then
        return true
    end
    return false
end

-- 查找芒果商是否存在
function SearchSeller(graph,name)
    local searchQueue=Queue()
    local tmp_t ={}

    if table.count(graph[name]) > 0 then
        for i=1,#graph[name] do
            searchQueue.Enqueue(graph[name][i])
        end
    end
    while searchQueue.Count() > 0 do
        local friend=searchQueue.Dequeue()
        if table.containsEle(tmp_t,friend) then
            -- 已经查找过了
        else
            table.insert(tmp_t,friend)
            if isSeller(friend) then
                return true,friend
            else
                for i=1,#graph[friend] do
                    searchQueue.Enqueue(graph[friend][i])
                end
            end
        end
    end
    return false
end

print(SearchSeller(graph,"you"))


