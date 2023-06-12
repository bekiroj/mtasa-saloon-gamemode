local conn = exports.vn_mysql:getConn()
local cords = {
    {1, 1, 2503.681640625, -1656.5947265625, 13.524615287781},
    {1, 2, 2509.8125, -1674.248046875, 13.412475585938},
    {1, 3, 2509.6630859375, -1665.6298828125, 13.575166702271},
    {1, 4, 2505.5986328125, -1680.4052734375, 13.546875},
    {1, 5, 2499.2412109375, -1683.439453125, 13.388501167297},
    {2, 1, 2136.9423828125, -1448.61328125, 23.971969604492},
    {2, 2, 2137.17578125, -1443.462890625, 23.971677780151},
    {2, 3, 2136.806640625, -1437.337890625, 23.975673675537},
    {2, 4, 2136.845703125, -1431.8515625, 23.981246948242},
    {2, 5, 2136.845703125, -1426.201171875, 23.985610961914},
    {3, 1, 1892.533203125, -2021.376953125, 13.546875},
    {3, 2, 1891.046875, -2014.974609375, 13.539081573486},
    {3, 3, 1887.2958984375, -2009.88671875, 13.546875},
    {3, 4, 1879.2890625, -2011.2001953125, 13.546875},
    {3, 5, 1873.75, -2015.7783203125, 13.539081573486},
    {4, 1, 2457.7685546875, -1346.2265625, 23.992227554321},
    {4, 2, 2458.130859375, -1341.125, 23.992227554321},
    {4, 3, 2458.0986328125, -1333.7021484375, 24},
    {4, 4, 2457.8994140625, -1325.521484375, 24},
    {4, 5, 2457.708984375, -1317.873046875, 24},
}

local loadItems = function(source)
    local dbid = source:getData("dbid") or 0
    dbQuery(
        function(qh, player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                for _, row in ipairs(res) do
                    local item = tonumber(row.item)
                    local ammo = tonumber(row.ammo)
                    if item == 31 then
                        takeWeapon(player, 30)
                    end
                    if item == 34 then
                        takeWeapon(player, 33)
                    end
                    giveWeapon(player, item, ammo)
                end
            end
        end,
    {source}, conn, "SELECT * FROM items WHERE own = ?", tonumber(dbid))
end

addEvent("gangwar.enter", true)
addEventHandler("gangwar.enter", root, function(gang, r, g, b)
    source:setData("lobby", nil)
    source:setData("deathmatch", nil)
    source:setData("gangwars", tonumber(gang))
    takeAllWeapons(source)
    source:setNametagColor(r, g, b)
    exports.vn_pets:remove(source)
    source.health = 100
    if source:getData("vip") then
        source.armor = 100
    else
        source.armor = 50
    end
    giveWeapon(source, 24, 225)
    giveWeapon(source, 30, 450)
    source:setInterior(0)
    source:setDimension(0)
    loadItems(source)
    local chance = math.random(1,5)
    for index, value in ipairs(cords) do
        if gang == value[1] then
            if chance == value[2] then
                source:setPosition(value[3],value[4],value[5])
            end
        end
    end
end)

addEventHandler("onPlayerWasted", root, function(_, attacker)
    local gang = source:getData("gangwars") or 0
    if gang > 0 then
        local chance = math.random(1,5)
        for index, value in ipairs(cords) do
            if gang == value[1] then
                if chance == value[2] then
                    Timer(function(player)
                        player:spawn(value[3], value[4], value[5], 0, player.model, player.interior, player.dimension)
                        takeAllWeapons(player)
                    end,550,1,source)
                    Timer(function(player)
                        player.health = 100
                        if player:getData("vip") then
                            player.armor = 100
                        else
                            player.armor = 50
                        end
                        giveWeapon(player, 24, 225)
                        giveWeapon(player, 30, 450)
                        loadItems(player)
                    end,750,1,source)
                end
            end
        end
        if attacker then
            local death = source:getData("death") or 0
            local kill = attacker:getData("kill") or 0
            source:setData("death", tonumber(death + 1))
            attacker:setData("kill", tonumber(kill + 1))
            exports.vn_utils:giveKillMoney(attacker)
            attacker:setHealth(100)
        end
    end
end)