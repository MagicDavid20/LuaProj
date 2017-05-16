--region : interface.lua
--Date   : 2017-5-16 
--Author : david

require("app.init")
local Test = require("app.Test")

local interface = class("interface")

function interface:ctor()

end

function interface:run()
    Test.new():run()
end

return interface

--endregion
