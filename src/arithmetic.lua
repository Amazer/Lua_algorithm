require "ToolInclude"
local t={2,4,6,8,10,12}


-- 计算总和
function Sum(t)
    if not t or #t ==0 then
        return 0
    end
    if #t == 1 then
        return t[1]
    end
    local head = t[1]
    table.remove(t,1)
--     tmp_t[1] = nil
    return (head + Sum(t))
end


-- print(Sum(t))

-- 找最大值
function Max(t)
    if #t == 1 then
        return t[1]
    end
    local head = t[1]
    table.remove(t,1)
    local otherMax = Max(t)
    if head > otherMax then
        return head
    else
        return otherMax
    end
end
-- print("max:"..Max(t))
--

--- 二分查找
function Binary_Search(t,num,low,high)
    if low > high then
        return -1
    end
    if low == high then
        if t[low] == num then
            return low
        else
            return -1
        end
    else
        local mid =math.floor((low+high)/2)
        if t[mid]==num then
            return mid
        elseif t[mid]>num then
            return Binary_Search(t,num,low,mid-1)
        else
            return Binary_Search(t,num,mid+1,high)
        end
    end
end

-- print(Binary_Search(t,12,1,#t))
--
--- 快速排序
function QuickSort(t)
    if #t < 2 then
        return t
    end
    local divot = t[1]
    local lessPartition={}
    local greaterPartition={}
    for i=2,#t do
        if t[i]<divot then
            table.insert(lessPartition,t[i])
        else
            table.insert(greaterPartition,t[i])
        end
    end
    lessPartition = QuickSort(lessPartition)
    greaterPartition =QuickSort(greaterPartition)
    local sortedTable = lessPartition
    table.insert(lessPartition,divot)
    for i=1,#greaterPartition do
        table.insert(sortedTable,greaterPartition[i])
    end
    return sortedTable
end

--local t2={6,2,4,8,10,12}
--local res = QuickSort(t2)
--table.print(res)

--- 搜索图,广度优先搜索
--- 返回是否能到达、到达节点
function SearchGraph_Breadth_First(graph,name,TrueFunc)
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
            if TrueFunc(friend) then
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

-----------------狄克斯特拉算法-------------------------
local infinity=math.huge
function _find_lowest_cost_node(costs,processed)
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


function FindLowestCostsAndParents(graph,startNode,endNode,printRes)
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

    local node = _find_lowest_cost_node(costs,processed)
    while node ~= "None" do
        local cost = costs[node]
        local neighbors = graph[node]
        if neighbors then
            for k,v in pairs(neighbors) do
                local newCost = cost + v
                if not costs[k] then
                    costs[k] = newCost
                    parents[k] = node
                elseif costs[k] > newCost then
                    costs[k] = newCost
                    parents[k] = node
                end
            end
            table.insert(processed,node)
            node = _find_lowest_cost_node(costs,processed)
        else
            break
        end
    end
    if printRes then
        local nodeName = endNode
        local res_table={}
        table.insert(res_table,nodeName)
        while parents[nodeName] do
            nodeName = parents[nodeName]
            table.insert(res_table,1,nodeName)
        end
        local res_str = res_table[1].."->"
        for i=2,#res_table-1 do
            res_str =res_str.. res_table[i].."->"
        end
        res_str = res_str .. res_table[#res_table]
        print("path:"..res_str)
        print("cost:"..costs[endNode])
    end
    return costs,parents -- 返回costs列表和最终列表
end

-----------------动态规划 背包问题-------------------------

Goods = function(name,weight,value)
    local public = {}
    public.name = name
    public.weight = weight
    public.value = value
    return public
end

Grid = function()
    local public = {
        weight = 0,
        value = 0,
        goodsList={},
    }

    public.AddGoodsList= function(glist)
        for k,v in pairs(glist) do
            public.weight = public.weight + v.weight
            public.value = public.value + v.value
            table.insert(public.goodsList,v)
        end
    end
    public.AddGoods= function(g)
        public.weight = public.weight + g.weight
        public.value = public.value + g.value
        table.insert(public.goodsList,g)
    end
    public.Print = function()
        print("total weight:"..tostring(public.weight)..", value:"..public.value)
        print("goodsList:")
        if #public.goodsList > 0 then
            local str = public.goodsList[1].name
            for i = 2,#public.goodsList do
                str = str..","..public.goodsList[i].name
            end
            print(str)
        end

    end

    return public
end
function FindBestGoods(goodsList,bagMaxWeight)
    local minWeight = math.huge

    for i=1,#goodsList do
        local g = goodsList[i]
        if g.weight<minWeight then
            minWeight = g.weight
        end
    end
    -- print(string.format("min:%d,max:%d",minWeight,maxWeight))

    local n = bagMaxWeight / minWeight     -- 格子分为n列.单位重量是minWeight

    local grid_table = {}

    -- 对于每一个goods,一行一行的处理
    for i=1,#goodsList do
        grid_table[i] = {}
        local g = goodsList[i]
        for k=1,n do   -- k表示第几个重量的格子
            grid_table[i][k]=Grid()   -- 新建格子
            if g.weight <= k*minWeight then -- 可以放得下
                if i > 1 then -- 当前不是第一行
                    --
                    local lastMaxValue = grid_table[i-1][k].value

                    local curMaxValue= g.value
                    local diff=k-g.weight/minWeight
                    if diff > 0 then -- 有剩余
                        curMaxValue = curMaxValue +  grid_table[i-1][diff].value
                    end

                    if lastMaxValue >= curMaxValue then --当前最大价值没有之前的最大价值大
                        grid_table[i][k].AddGoodsList(grid_table[i-1][k].goodsList)
                    else
                        grid_table[i][k].AddGoods(g)
                        if diff > 0 then
                            grid_table[i][k].AddGoodsList(grid_table[i-1][diff].goodsList)
                        end
                    end
                else -- 当前是第一行
                    grid_table[i][k].AddGoods(g)
                end
            else -- 放不下当前物品
                if i > 1 then -- 当前不是第一行
                    grid_table[i][k].AddGoodsList(grid_table[i-1][k].goodsList)
                else -- 当前是第一行,放不下，就都是零，不用管

                end
            end
            --         print(string.format("[%d,%d]:",i,k))
            --         grid_table[i][k].Print()
        end
    end

    local lastGrid = grid_table[#goodsList][n]
    print("动态规划结果：")
    lastGrid.Print()
    return lastGrid
end


----------------动态规划 最长公共串(子串完全匹配) -------------------------
---
--- 字符串格子
SubSecGrid = function()
    local public = {
        num = 0,
        charList = {},
    }
    public.AddChar =  function(char)
        if char then
            public.num = public.num + 1
            table.insert(public.charList,char)
        end
    end
    public.AddCharList =  function(charList)
        if charList then
            for i=1,#charList do
                public.num = public.num + 1
                table.insert(public.charList,charList[i])
            end
        end
    end
    public.Print = function()
        print("length:"..tostring(public.num))
        print("subString:"..table.concat(public.charList))
    end
    return public
end

function LongestCommonSubString(str1,str2)
    local t1= string.str2charArray(str1)
    local t2= string.str2charArray(str2)

    local n = #t1
    local m = #t2

    local gridList = {}
    local maxGrid = nil
    for i= 1,m do -- 一共m行
        gridList[i] = {}
        for k=1,n do -- 对于每一行，有n列
            gridList[i][k] = SubSecGrid()
            if t2[i] == t1[k] then -- 字母相等，则value=左上格子value+1
                local charList = nil
                if gridList[i-1] and gridList[i-1][k-1]then
                    charList = gridList[i-1][k-1].charList
                end
                gridList[i][k].AddCharList(charList)
                gridList[i][k].AddChar(t2[i])
                if not maxGrid  then
                    maxGrid =  gridList[i][k]
                else
                    if gridList[i][k].num > maxGrid.num then
                        maxGrid =  gridList[i][k]
                    end
                end
--             else -- 字母不等，则value = 0,不用管
            end
        end
    end
    return maxGrid
end

----------------动态规划 最长公共子序列(子集交集) -------------------------
function LongestCommonSubsequence(str1,str2)
    local t1= string.str2charArray(str1)
    local t2= string.str2charArray(str2)

    local n = #t1
    local m = #t2

    local gridList = {}
    local maxGrid = nil
    for i= 1,m do -- 一共m行
        gridList[i] = {}
        for k=1,n do -- 对于每一行，有n列
            gridList[i][k] = SubSecGrid()
            if t2[i] == t1[k] then -- 字母相等，则value=左上格子value+1
                local charList = nil
                if gridList[i-1] and gridList[i-1][k-1]then
                    charList = gridList[i-1][k-1].charList
                end
                gridList[i][k].AddCharList(charList)
                gridList[i][k].AddChar(t2[i])
            else -- 字母不等，则value = 做方和上方的最大值
                local upGrid,leftGrid = SubSecGrid(),SubSecGrid()
                if gridList[i-1] and  gridList[i-1][k] then
                    upGrid = gridList[i-1][k]
                end
                if gridList[i][k-1] then
                    leftGrid =  gridList[i][k-1]
                end
                local tmpMaxGrid = upGrid
                if leftGrid.num > upGrid.num then
                    tmpMaxGrid = leftGrid
                end
                gridList[i][k].AddCharList(tmpMaxGrid.charList)
            end
            if not maxGrid  then
                maxGrid =  gridList[i][k]
            else
                if gridList[i][k].num > maxGrid.num then
                    maxGrid =  gridList[i][k]
                end
            end
        end
    end
    return maxGrid
end
