--region:AStarFindRoute.lua
--Date  :2016/03/05
--Author:david
--Purpose:a star find path

local AStarFindRoute = class("AStarFindRoute")

--F = G + H
--地图是x * y 的矩形， 左下角坐标为 (1,1)
local X_MAX
local Y_MAX
local DIRECTIONS = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}} --暂时仅支持上下左右移动

local START_POS
local END_POS
local CURRENT_POS

local MAP_LIST      -- 地图数据
local BARRIER_LIST  -- 障碍物
local OPEN_LIST     -- 开放节点
local OPEN_MAP      -- key为x_y 节省开销
local CLOSEED_LIST  -- 关闭节点
local CLOSED_MAP    -- key为x_y 节省开销
local PATH_LIST     -- 路径

--utils
local GET_KEY = function(p) return string.format("%d_%d", p.x, p.y) end
local P = function(x, y) local point = {}
                point.x = x
                point.y = y 
                point.last = nil
                point.g = 0
                point.h = 0
                point.f = 0
                point.key = GET_KEY(point)
		return point
            end
local MANHTATAN_DIS = function(currPos, targetPos) return ( math.abs(targetPos.x - currPos.x) + math.abs(targetPos.y - currPos.y)) end
local IS_SAME_P = function(p1, p2) return p1.x == p2.x and p1.y == p2.y end
local IS_BARRIER = function(p, barrageList) 
                        for k, point in pairs(barrageList or {}) do
                            if IS_SAME_P(p, point) then
                                return true
                            end
                        end
                    return false end

local GET_VALUE_G = function(p) return (p.g + 1) end
local GET_VALUE_H = function(p1, p2) return MANHTATAN_DIS(p1, p2) end
local GET_VALUE_F = function(p) return (p.g + p.h )end

local CHECK_P_RANGE = function(p, xMax, yMax)
                            assert( p.x <= xMax and p.y <= yMax, string.format("point error, (%d, %d) limit(%d, %d)", p.x, p.y, xMax, yMax))
                        end
local CHECK_P_LIST_RANGE = function(pList, xMax, yMax)
                                for k, p in pairs(pList or {}) do
                                    CHECK_P_RANGE(p, xMax, yMax)
                                end
                            end
local COMPARE_FUNC = function(p1, p2) return p1.f < p2.f end

function AStarFindRoute:ctor()
end

function AStarFindRoute:init(prop)
    X_MAX = prop.x
    Y_MAX = prop.y

    self:initMapList(X_MAX, Y_MAX)
    BARRIER_LIST = prop.barrageList
    START_POS = P(prop.startPos.x, prop.startPos.y)
    END_POS = P(prop.endPos.x, prop.endPos.y)

    --检测范围
    CHECK_P_LIST_RANGE(BARRIER_LIST, X_MAX, Y_MAX)
    CHECK_P_RANGE(START_POS, X_MAX, Y_MAX)
    CHECK_P_RANGE(END_POS, X_MAX, Y_MAX)

    OPEN_MAP = {}
    OPEN_LIST = {}
    CLOSEED_LIST = {}
    CLOSED_MAP = {}

    OPEN_MAP[START_POS.key] = START_POS
    table.insert(OPEN_LIST, START_POS)
	
    PATH_LIST = self:findPath() or {}
    return PATH_LIST
end

function AStarFindRoute:initMapList(m, n)
    MAP_LIST = {}
    for i = 1, m do
        MAP_LIST[i] = {}
        for j = 1, n do
            MAP_LIST[i][j] = j
        end
    end
end

function AStarFindRoute:getNextPoints(point)
    local nextPoints = {}
    for i = 1, #DIRECTIONS do
        local offset = DIRECTIONS[i]
        local nextPoint = P(point.x + offset[1], point.y + offset[2])
        nextPoint.last = point
        if nextPoint.x >= 1 and nextPoint.x <= X_MAX and nextPoint.y >= 1 and nextPoint.y <= Y_MAX then
            nextPoint.g = GET_VALUE_G(point)
            nextPoint.h = GET_VALUE_H(point, END_POS)
            nextPoint.f = GET_VALUE_F(nextPoint)
            table.insert(nextPoints, nextPoint)
        end
    end
    return nextPoints
end

function AStarFindRoute:findPath()
    while (table.nums(OPEN_LIST) > 0) do
		CURRENT_POS = OPEN_LIST[1]
        table.remove(OPEN_LIST, 1)
        OPEN_MAP[CURRENT_POS.key] = nil
        if IS_SAME_P(CURRENT_POS, END_POS) then
            return self:makePath(CURRENT_POS)
        else
            CLOSED_MAP[CURRENT_POS.key] = CURRENT_POS
            local nextPoints = self:getNextPoints(CURRENT_POS)
            for i = 1, #nextPoints do
                local nextPoint = nextPoints[i]
                if (OPEN_MAP[nextPoint.key] == nil )and (CLOSED_MAP[nextPoint.key] == nil) and (IS_BARRIER(nextPoint, BARRIER_LIST) == false) then
                    OPEN_MAP[nextPoint.key] = nextPoint
                    table.insert(OPEN_LIST, nextPoint)
                end
            end
            table.sort(OPEN_LIST, COMPARE_FUNC)
        end
    end
    return nil
end

function AStarFindRoute:makePath(endPos)
    local path = {}
    local point = endPos
    while point.last ~= nil do
        table.insert(path, P(point.x, point.y))
        point = point.last
    end
    local startPoint = point
    table.insert(path, startPoint)
    return path
end

return AStarFindRoute
--endregion
