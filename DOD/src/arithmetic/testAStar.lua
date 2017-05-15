--region:testAStar.lua
--Date  :2016/03/05
--Author:david
--Purpose:a star find path  
  
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

    local path = AStarFindRoute.init(prop)
    local src = ""
    for i, point in ipairs(path) do
        src = src..point.key.."->"
    end
    print("david say path is "..src)
    
--endregion
