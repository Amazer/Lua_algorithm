require "arithmetic"

local graphA={}
graphA.start={}
graphA.start.a=5
graphA.start.b=2

graphA.a={}
graphA.a.c=4
graphA.a.d=2

graphA.b={}
graphA.b.a=8
graphA.b.d=7

graphA.c={}
graphA.c.d=6
graphA.c.fin=3

graphA.d={}
graphA.d.fin=1

graphA.fin={}

FindLowestCostsAndParents(graphA,"start","fin",true)

local graphB = {}

graphB.start={}
graphB.start.a=10

graphB.a={}
graphB.a.b=20

graphB.b={}
graphB.b.c=1
graphB.b.fin=30

graphB.c={}
graphB.c.a=1

graphB.fin={}


FindLowestCostsAndParents(graphB,"start","fin",true)

local graphC = {}

graphC.start = {}
graphC.start.a=2
graphC.start.b=2

graphC.a={}
graphC.a.c=2

graphC.b={}
graphC.b.a=2

graphC.c={}
graphC.c.b=-1
graphC.c.fin=2


graphC.fin={}
FindLowestCostsAndParents(graphC,"start","fin",true)
