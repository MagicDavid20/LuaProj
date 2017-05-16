--region : stringEx.lua
--Date   : 2017-5-16
--Author : david

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

-- start --

--------------------------------
-- 将特殊字符转为 HTML 转义符
-- @function [parent=#string] htmlspecialchars
-- @param string input 输入字符串
-- @return string#string  转换结果

--[[--

将特殊字符转为 HTML 转义符

~~~ lua

print(string.htmlspecialchars("<ABC>"))
-- 输出 &lt;ABC&gt;

~~~

]]

-- end --

function string.htmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, k, v)
    end
    return input
end

-- start --

--------------------------------
-- 将 HTML 转义符还原为特殊字符，功能与 string.htmlspecialchars() 正好相反
-- @function [parent=#string] restorehtmlspecialchars
-- @param string input 输入字符串
-- @return string#string  转换结果

--[[--

将 HTML 转义符还原为特殊字符，功能与 string.htmlspecialchars() 正好相反

~~~ lua

print(string.restorehtmlspecialchars("&lt;ABC&gt;"))
-- 输出 <ABC>

~~~

]]

-- end --

function string.restorehtmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, v, k)
    end
    return input
end

-- start --

--------------------------------
-- 将字符串中的 \n 换行符转换为 HTML 标记
-- @function [parent=#string] nl2br
-- @param string input 输入字符串
-- @return string#string  转换结果

--[[--

将字符串中的 \n 换行符转换为 HTML 标记

~~~ lua

print(string.nl2br("Hello\nWorld"))
-- 输出
-- Hello<br />World

~~~

]]

-- end --

function string.nl2br(input)
    return string.gsub(input, "\n", "<br />")
end

-- start --

--------------------------------
-- 将字符串中的特殊字符和 \n 换行符转换为 HTML 转移符和标记
-- @function [parent=#string] text2html
-- @param string input 输入字符串
-- @return string#string  转换结果

--[[--

将字符串中的特殊字符和 \n 换行符转换为 HTML 转移符和标记

~~~ lua

print(string.text2html("<Hello>\nWorld"))
-- 输出
-- &lt;Hello&gt;<br />World

~~~

]]

-- end --

function string.text2html(input)
    input = string.gsub(input, "\t", "    ")
    input = string.htmlspecialchars(input)
    input = string.gsub(input, " ", "&nbsp;")
    input = string.nl2br(input)
    return input
end

-- start --

--------------------------------
-- 用指定字符或字符串分割输入字符串，返回包含分割结果的数组
-- @function [parent=#string] split
-- @param string input 输入字符串
-- @param string delimiter 分割标记字符或字符串
-- @return array#array  包含分割结果的数组

--[[--

用指定字符或字符串分割输入字符串，返回包含分割结果的数组

~~~ lua

local input = "Hello,World"
local res = string.split(input, ",")
-- res = {"Hello", "World"}

local input = "Hello-+-World-+-Quick"
local res = string.split(input, "-+-")
-- res = {"Hello", "World", "Quick"}

~~~

]]

-- end --

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

-- start --

--------------------------------
-- 去除输入字符串头部的空白字符，返回结果
-- @function [parent=#string] ltrim
-- @param string input 输入字符串
-- @return string#string  结果
-- @see string.rtrim, string.trim

--[[--

去除输入字符串头部的空白字符，返回结果

~~~ lua

local input = "  ABC"
print(string.ltrim(input))
-- 输出 ABC，输入字符串前面的两个空格被去掉了

~~~

空白字符包括：

-   空格
-   制表符 \t
-   换行符 \n
-   回到行首符 \r

]]

-- end --

function string.ltrim(input)
    return string.gsub(input, "^[ \t\n\r]+", "")
end

-- start --

--------------------------------
-- 去除输入字符串尾部的空白字符，返回结果
-- @function [parent=#string] rtrim
-- @param string input 输入字符串
-- @return string#string  结果
-- @see string.ltrim, string.trim

--[[--

去除输入字符串尾部的空白字符，返回结果

~~~ lua

local input = "ABC  "
print(string.rtrim(input))
-- 输出 ABC，输入字符串最后的两个空格被去掉了

~~~

]]

-- end --

function string.rtrim(input)
    return string.gsub(input, "[ \t\n\r]+$", "")
end

-- start --

--------------------------------
-- 去掉字符串首尾的空白字符，返回结果
-- @function [parent=#string] trim
-- @param string input 输入字符串
-- @return string#string  结果
-- @see string.ltrim, string.rtrim

--[[--

去掉字符串首尾的空白字符，返回结果

]]

-- end --

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

-- start --

--------------------------------
-- 将字符串的第一个字符转为大写，返回结果
-- @function [parent=#string] ucfirst
-- @param string input 输入字符串
-- @return string#string  结果

--[[--

将字符串的第一个字符转为大写，返回结果

~~~ lua

local input = "hello"
print(string.ucfirst(input))
-- 输出 Hello

~~~

]]

-- end --

function string.ucfirst(input)
    return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
    return "%" .. string.format("%02X", string.byte(char))
end

-- start --

--------------------------------
-- 将字符串转换为符合 URL 传递要求的格式，并返回转换结果
-- @function [parent=#string] urlencode
-- @param string input 输入字符串
-- @return string#string  转换后的结果
-- @see string.urldecode

--[[--

将字符串转换为符合 URL 传递要求的格式，并返回转换结果

~~~ lua

local input = "hello world"
print(string.urlencode(input))
-- 输出
-- hello%20world

~~~

]]

-- end --

function string.urlencode(input)
    -- convert line endings
    input = string.gsub(tostring(input), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    input = string.gsub(input, "([^%w%.%- ])", urlencodechar)
    -- convert spaces to "+" symbols
    return string.gsub(input, " ", "+")
end

-- start --

--------------------------------
-- 将 URL 中的特殊字符还原，并返回结果
-- @function [parent=#string] urldecode
-- @param string input 输入字符串
-- @return string#string  转换后的结果
-- @see string.urlencode

--[[--

将 URL 中的特殊字符还原，并返回结果

~~~ lua

local input = "hello%20world"
print(string.urldecode(input))
-- 输出
-- hello world

~~~

]]

-- end --

function string.urldecode(input)
    input = string.gsub (input, "+", " ")
    input = string.gsub (input, "%%(%x%x)", function(h) return string.char(checknumber(h,16)) end)
    input = string.gsub (input, "\r\n", "\n")
    return input
end

-- start --

--------------------------------
-- 计算 UTF8 字符串的长度，每一个中文算一个字符
-- @function [parent=#string] utf8len
-- @param string input 输入字符串
-- @return integer#integer  长度

--[[--

计算 UTF8 字符串的长度，每一个中文算一个字符

~~~ lua

local input = "你好World"
print(string.utf8len(input))
-- 输出 7

~~~

]]

-- end --

function string.utf8len(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

-- start --

--------------------------------
-- 将数值格式化为包含千分位分隔符的字符串
-- @function [parent=#string] formatnumberthousands
-- @param number num 数值
-- @return string#string  格式化结果

--[[--

将数值格式化为包含千分位分隔符的字符串

~~~ lua

print(string.formatnumberthousands(1924235))
-- 输出 1,924,235

~~~

]]

-- end --

function string.formatnumberthousands(num)
    local formatted = tostring(checknumber(num))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

--endregion