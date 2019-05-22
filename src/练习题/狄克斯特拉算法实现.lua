require "ToolInclude"

local graph = {}

graph.start={}
graph.start.a=6
graph.start.b=2

graph.a={}
graph.a.fin=1

graph.b={}
graph.b.a=3
graph.b.fin = 5

local infinity= math.huge

--local costs={}
--local parents={}
--local processed={}


--costs.a = 6
--costs.b=2
--costs.fin = infinity
--
--parents.a="start"
--parents.b="start"
--parents.fin="None"

function find_lowest_cost_node(costs,processed)
    local nodeName= "None"
    local nodeCost=infinity
    for k,v in pairs(costs) do
        if v<nodeCost and not table.containsEle(processed,k) then
            nodeName = k
            nodeCost = v
        end
    end
    return nodeName,nodeCost
end


function FindLowestTable(graph,startNode,endNode)
    local costs={}
    local parents={}
    local processed = {}
    local neighbor = graph[startNode]
    if neighbor then
        for k,v in pairs(neighbor) do
            parents[k] = startNode
            costs[k] = v
        end
    end
    parents[endNode] = startNode
    costs[endNode] = infinity

    local node = find_lowest_cost_node(costs,processed)
    while node ~= "None" do
        local cost = costs[node]
        local neighbors = graph[node]
        if neighbors then
            for k,v in pairs(neighbors) do
                local newCost = cost + v
                if costs[k] > newCost then
                    costs[k] = newCost
                    parents[k] = node
                end
            end
            table.insert(processed,node)
            node = find_lowest_cost_node(costs,processed)
        else
            break
        end
    end
    return parents,costs -- 返回最终列表和costs列表
end

local parents,costs = FindLowestTable(graph,"start","fin")
table.print(parents,"parents")
table.print(costs,"costs")



