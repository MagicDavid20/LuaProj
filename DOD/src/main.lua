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

package.path = package.path .. ";src/"

if true then
    print(package.path)
    print(package.path)
end

require("MyApp")();

--endregion
