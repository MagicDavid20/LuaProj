--region : main.lua
--Date   : 2017-5-15
--Author : david

function __G__TRACKBACK__(errorMessage)
    local msg = tostring(errorMessage);
    local tb = debug.traceback("", 2);

    print("----------------------------------------");
    print("LUA ERROR: " .. msg .. "\n");
    print(tb);
    print("----------------------------------------");
end

-- Init path
local obj = io.popen("cd")
local path = obj:read("*all"):sub(1,-2)
obj:close()

local lua_path = path.."\\src\\"
local m_package_path = package.path
package.path = string.format("%s;%s?.lua;%s?/init.lua", m_package_path, lua_path, lua_path)

require("app.interface").new():run();

--endregion
