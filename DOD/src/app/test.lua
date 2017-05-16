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

--endregion

function Test:run()
    self.AStar()
end


return Test
--endregion
