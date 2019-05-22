require "ToolInclude"
require "arithmetic"
local graph={}
graph.getUp={"shower","brushTeeth"}
graph.shower ={}
graph.brushTeeth={"breakfast"}
graph.breakfast = {}

local listA ={"getUp","shower","breakfast","brushTeeth"}
local listB ={"getUp","brushTeeth","breakfast","shower"}
local listC ={"shower","getUp","brushTeeth","breakfast"}

function CheckListIsOk(list,graph)
    local head = list[1]
    for i=2,#list do
        local res =SearchGraph_Breadth_First(graph,head,function(name)
            if name == list[i] then
                return true
            end
            return false
        end)
        if not res then -- ok
            return false
        end
    end
    return true
end

function PrintRes(list)
    local res = CheckListIsOk(list,graph)
    local str = table.concat(list,"->") .. ":"..tostring(res)
    print(str)
end
PrintRes(listA)
PrintRes(listB)
PrintRes(listC)
