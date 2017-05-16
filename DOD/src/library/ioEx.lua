--region : ioEx.lua
--Date   : 2017-5-16 
--Author : david

-- @module io

-- start --

--------------------------------
-- 检查指定的文件或目录是否存在，如果存在返回 true，否则返回 false
-- @function [parent=#io] exists
-- @param string path 要检查的文件或目录的完全路径
-- @return boolean#boolean 

--[[--

检查指定的文件或目录是否存在，如果存在返回 true，否则返回 false

可以使用 cc.FileUtils:fullPathForFilename() 函数查找特定文件的完整路径，例如：

~~~ lua

local path = cc.FileUtils:getInstance():fullPathForFilename("gamedata.txt")
if io.exists(path) then
    ....
end

~~~

]]

-- end --

function io.exists(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end

-- start --

--------------------------------
-- 读取文件内容，返回包含文件内容的字符串，如果失败返回 nil
-- @function [parent=#io] readfile
-- @param string path 文件完全路径
-- @return string#string 

--[[--

读取文件内容，返回包含文件内容的字符串，如果失败返回 nil

io.readfile() 会一次性读取整个文件的内容，并返回一个字符串，因此该函数不适宜读取太大的文件。

]]

-- end --

function io.readfile(path)
    local file = io.open(path, "r")
    if file then
        local content = file:read("*a")
        io.close(file)
        return content
    end
    return nil
end

-- start --

--------------------------------
-- 以字符串内容写入文件，成功返回 true，失败返回 false
-- @function [parent=#io] writefile
-- @param string path 文件完全路径
-- @param string content 要写入的内容
-- @param string mode 写入模式，默认值为 "w+b"
-- @return boolean#boolean 

--[[--

以字符串内容写入文件，成功返回 true，失败返回 false

"mode 写入模式" 参数决定 io.writefile() 如何写入内容，可用的值如下：

-   "w+" : 覆盖文件已有内容，如果文件不存在则创建新文件
-   "a+" : 追加内容到文件尾部，如果文件不存在则创建文件

此外，还可以在 "写入模式" 参数最后追加字符 "b" ，表示以二进制方式写入数据，这样可以避免内容写入不完整。

**Android 特别提示:** 在 Android 平台上，文件只能写入存储卡所在路径，assets 和 data 等目录都是无法写入的。

]]

-- end --

function io.writefile(path, content, mode)
    mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then return false end
        io.close(file)
        return true
    else
        return false
    end
end

-- start --

--------------------------------
-- 拆分一个路径字符串，返回组成路径的各个部分
-- @function [parent=#io] pathinfo
-- @param string path 要分拆的路径字符串
-- @return table#table 

--[[--

拆分一个路径字符串，返回组成路径的各个部分

~~~ lua

local pathinfo  = io.pathinfo("/var/app/test/abc.png")

-- 结果:
-- pathinfo.dirname  = "/var/app/test/"
-- pathinfo.filename = "abc.png"
-- pathinfo.basename = "abc"
-- pathinfo.extname  = ".png"

~~~

]]

-- end --

function io.pathinfo(path)
    local pos = string.len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = string.byte(path, pos)
        if b == 46 then -- 46 = char "."
            extpos = pos
        elseif b == 47 then -- 47 = char "/"
            break
        end
        pos = pos - 1
    end

    local dirname = string.sub(path, 1, pos)
    local filename = string.sub(path, pos + 1)
    extpos = extpos - pos
    local basename = string.sub(filename, 1, extpos - 1)
    local extname = string.sub(filename, extpos)
    return {
        dirname = dirname,
        filename = filename,
        basename = basename,
        extname = extname
    }
end

-- start --

--------------------------------
-- 返回指定文件的大小，如果失败返回 false
-- @function [parent=#io] filesize
-- @param string path 文件完全路径
-- @return integer#integer 

-- end --

function io.filesize(path)
    local size = false
    local file = io.open(path, "r")
    if file then
        local current = file:seek()
        size = file:seek("end")
        file:seek("set", current)
        io.close(file)
    end
    return size
end


--endregion
