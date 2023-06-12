local cache = {}
local utils = exports.vn_utils

local remove = function(source)
    if cache[source] then
        cache[source] = nil
        collectgarbage("collect")
    end
end

addEventHandler("onPlayerCommand", root, function()
    if cache[source] then
        cancelEvent()
    else
        cache[source] = Timer(remove, 1500, 1, source)
    end
end)

addEventHandler("onPlayerQuit", root, function()
    remove(source)
end)