--region : Test.lua
--Date   : 2017-5-16
--Author : david

local Test = class("Test")

function Test:ctor()

end

-- region case
function Test:AStar()
    
    local prop = {}
    prop.x = 7
    prop.y = 6
    prop.barrageList = {}
    prop.startPos = { x = 2, y = 3 }
    prop.endPos = { x = 6, y = 2 }
    prop.barrageList = {}
    prop.barrageList[1] = { x = 4, y = 2 }
    prop.barrageList[2] = { x = 4, y = 3 }
    prop.barrageList[3] = { x = 4, y = 4 }
    prop.barrageList[4] = { x = 4, y = 5 }
    prop.barrageList[5] = { x = 2, y = 2 }

    local AStarFindRoute = require("app.arithmetic.AStarFindRoute")
    local aStar = AStarFindRoute.new()
    local path = aStar:init(prop)
    local src = ""
    for i, point in ipairs(path) do
        src = src..point.key.."->"
    end
    print("david say path is "..src)
end

function Test:numConvert()
    require("app.arithmetic.NumConvert")
    local num = 10086

    print("---- dec convert to x ----\n")
    local text1 = ConvertDec2X(num, 10)
	local text2 = ConvertDec2X(num, 2)
	local text3 = ConvertDec2X(num, 8)
	local text4 = ConvertDec2X(num, 16)
	local text5 = ConvertDec2X(num, 14)
    print(string.format("dec %d to dec %s", num, text1))
    print(string.format("dec %d to bin %s", num, text2))
    print(string.format("dec %d to Oct %s", num, text3))
    print(string.format("dec %d to Hex %s", num, text4))
    print(string.format("dec %d to 14  %s", num, text5))
    
    
    print("\n---- string to num ----\n")
    local num1 = ConvertStr2Dec(text1, 10)
    local num2 = ConvertStr2Dec(text2, 2)
    local num3 = ConvertStr2Dec(text3, 8)
    local num4 = ConvertStr2Dec(text4, 16)
    local num5 = ConvertStr2Dec(text5, 14)
    print(string.format("dec:%s to dec %d", text1, num1))
    print(string.format("bin:%s to dec %d", text2, num2))
    print(string.format("Oct:%s to dec %d", text3, num3))
    print(string.format("Hex:%s to dec %d", text4, num4))
    print(string.format("14:%s to dec %d", text5, num5))    
end

--endregion

function Test:run()
--    self.AStar()
    self.numConvert()
end


return Test
--endregion
