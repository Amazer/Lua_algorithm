require "arithmetic"

local str1= "fosh"
local str2= "fish"

---- 最长公共串 -----

local lcs = LongestCommonSubString(str1,str2)
lcs.Print()

---- 最长子序列 -----
local maxCommonSequenceGrid = LongestCommonSubsequence(str1,str2)
maxCommonSequenceGrid.Print()

---练习题 9.3 ---

str1 = "blue"
str2 = "clues"
local longSubstr = LongestCommonSubString(str1,str2)
longSubstr.Print()
local longSubsec = LongestCommonSubsequence(str1,str2)
longSubsec.Print()

