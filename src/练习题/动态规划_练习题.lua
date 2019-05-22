require "arithmetic"
local DynamicTest= {}
DynamicTest.Test_1= function()
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

    FindBestGoods(goodsList,bagMaxWeight)
end

--- 9.1 ---
DynamicTest.Test_2= function()

    local bagMaxWeight = 4

    local sound = Goods("音响",4,3000)
    local laptop = Goods("笔记本电脑",3,2000)
    local guitar = Goods("吉他",1,1500)

    local goodsList = {}
    table.insert(goodsList,sound)
    table.insert(goodsList,laptop)
    table.insert(goodsList,guitar)
    FindBestGoods(goodsList,bagMaxWeight)
end

--- 9.2---
DynamicTest.Test_3= function()

    local bagMaxWeight = 4

    local sound = Goods("音响",4,3000)
    local laptop = Goods("笔记本电脑",3,2000)
    local guitar = Goods("吉他",1,1500)
    local iphone = Goods("iPhone",1,2000)

    local goodsList = {}
    table.insert(goodsList,sound)
    table.insert(goodsList,laptop)
    table.insert(goodsList,guitar)
    table.insert(goodsList,iphone)
    FindBestGoods(goodsList,bagMaxWeight)
end

--- 9.2.4---
DynamicTest.Test_4= function()

    local bagMaxWeight = 4

    local sound = Goods("音响",4,3000)
    local laptop = Goods("笔记本电脑",3,2000)
    local guitar = Goods("吉他",1,1500)
    local iphone = Goods("iPhone",1,2000)
    local necklace= Goods("项链",0.5,1000)

    local goodsList = {}
    table.insert(goodsList,sound)
    table.insert(goodsList,laptop)
    table.insert(goodsList,guitar)
    table.insert(goodsList,iphone)
    table.insert(goodsList,necklace)
    FindBestGoods(goodsList,bagMaxWeight)
end

-- DynamicTest.Test_1()
-- DynamicTest.Test_2()
-- DynamicTest.Test_3()
DynamicTest.Test_4()

