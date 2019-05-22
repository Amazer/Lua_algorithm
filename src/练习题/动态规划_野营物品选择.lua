require "arithmetic"

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

local water = Goods("water",3,10)
local book = Goods("book",1,3)
local food = Goods("food",2,9)
local jacket = Goods("jacket",2,5)
local camera = Goods("camera",1,6)

local goodsList ={}
table.insert(goodsList,water)
table.insert(goodsList,book)
table.insert(goodsList,food)
table.insert(goodsList,jacket)
table.insert(goodsList,camera)

local bagMaxWeight = 6

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
print("over...")
lastGrid.Print()
