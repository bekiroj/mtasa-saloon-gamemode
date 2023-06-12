local utils = exports.vn_utils
local cords = {
    [1] = {2142.7216796875, -1732.189453125, 13.543622016907},
    [2] = {2138.119140625, -1735.146484375, 13.55250453949},
    [3] = {2133.314453125, -1730.2197265625, 13.547632217407},
    [4] = {2128.04296875, -1730.2646484375, 13.550273895264},
    [5] = {2125.0576171875, -1727.2841796875, 13.546756744385},
    [6] = {2123.9677734375, -1733.19921875, 13.559170722961},
    [7] = {2120.7255859375, -1737.794921875, 13.563659667969},
    [8] = {2116.2158203125, -1738.154296875, 13.564010620117},
    [9] = {2114.6279296875, -1735.3125, 13.561234474182},
    [10] = {2115.1962890625, -1731.640625, 13.557648658752},
    [11] = {2118.8603515625, -1727.5087890625, 13.553612709045},
    [12] = {2116.2861328125, -1725.2978515625, 13.54963684082},
    [13] = {2124.166015625, -1725.853515625, 13.545399665833},
    [14] = {2128.8974609375, -1725.6181640625, 13.543048858643},
    [15] = {2131.2294921875, -1724.6875, 13.538125991821},
}

addEvent("turn.saloon.admin", true)
addEventHandler("turn.saloon.admin", root, function()
    --if source:getData("lobby") then
        --utils:sendChat(source, "you are already in the lobby now")
    --else
        source.vehicle = nil
        local random = math.random(1,15)
        source:setPosition(cords[random][1], cords[random][2], cords[random][3])
        source.health = 100
        source.armor = 100
        source:setNametagColor(200, 200, 200)
        source:setInterior(0)
        source:setDimension(1)
        source:setData("lobby", true)
        source:setData("deathmatch", nil)
        source:setData("gangwars", nil)
        takeAllWeapons(source)
        giveWeapon(source, 24, 75)
        giveWeapon(source, 3)
        Timer(function(player)
            player:setWeaponSlot(1)
        end, 250, 1, source)
    --end
end)

addEvent("turn.saloon", true)
addEventHandler("turn.saloon", root, function()
    if source:getData("lobby") then
        utils:sendChat(source, "you are already in the lobby now")
    else
        source.vehicle = nil
        local random = math.random(1,15)
        source:setPosition(cords[random][1], cords[random][2], cords[random][3])
        source.health = 100
        source.armor = 100
        source:setNametagColor(200, 200, 200)
        source:setInterior(0)
        source:setDimension(1)
        source:setData("lobby", true)
        source:setData("deathmatch", nil)
        source:setData("gangwars", nil)
        takeAllWeapons(source)
        giveWeapon(source, 24, 75)
        giveWeapon(source, 3)
        Timer(function(player)
            player:setWeaponSlot(1)
        end, 250, 1, source)
    end
end)