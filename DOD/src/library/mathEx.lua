--region : mathEx.lua
--Date   : 2017-5-16 
--Author : david

-- @module math

-- start --

--------------------------------
-- 根据系统时间初始化随机数种子，让后续的 math.random() 返回更随机的值
-- @function [parent=#math] newrandomseed

-- end --

function math.newrandomseed()
    local ok, socket = pcall(function()
        return require("socket")
    end)

    if ok then
        -- 如果集成了 socket 模块，则使用 socket.gettime() 获取随机数种子
        math.randomseed(socket.gettime())
    else
        math.randomseed(os.time())
    end
    math.random()
    math.random()
    math.random()
    math.random()
end

-- start --

--------------------------------
-- 对数值进行四舍五入，如果不是数值则返回 0
-- @function [parent=#math] round
-- @param number value 输入值
-- @return number#number 

-- end --

function math.round(value)
    value = checknumber(value)
    return math.floor(value + 0.5)
end

-- start --

--------------------------------
-- 角度转弧度
-- @function [parent=#math] angle2radian

-- end --

function math.angle2radian(angle)
	return angle*math.pi/180
end

-- start --

--------------------------------
-- 弧度转角度
-- @function [parent=#math] radian2angle

-- end --

function math.radian2angle(radian)
	return radian/math.pi*180
end


--endregion
