local cords = {
    --lobi, oran, x, y ,z
    {1, 1, 289.099609375, 171.6884765625, 1007.1794433594},
    {1, 2, 238.7255859375, 141.5087890625, 1003.0234375},
    {1, 3, 210.36328125, 142.1142578125, 1003.0234375},
    {1, 4, 190.208984375, 157.9501953125, 1003.0234375},
    {1, 5, 211.5673828125, 185.427734375, 1003.03125},
    {2, 1, -2640.762939,1406.682006,906.460937},
    {2, 2, -2667.3720703125, 1428.08203125, 906.4609375},
    {2, 3, -2687.4013671875, 1423.5537109375, 906.4609375},
    {2, 4, -2670.89453125, 1428.298828125, 912.40625},
    {2, 5, -2656.5146484375, 1391.4853515625, 912.41143798828},
    {3, 1, 2227.25, -1150.8369140625, 1029.796875},
    {3, 2, 2236.203125, -1170.5234375, 1029.796875},
    {3, 3, 2244.3291015625, -1189.5439453125, 1029.796875},
    {3, 4, 2240.5283203125, -1189.1455078125, 1033.796875},
    {3, 5, 2215.454833,-1147.475585,1025.796875},
}

addEvent("deathmatch.enter", true)
addEventHandler("deathmatch.enter", root, function(id, int)
    source:setData("lobby", nil)
    source:setData("deathmatch", tonumber(id))
    source:setData("gangwars", nil)
    source.health = 100
    source.armor = 50
    source:setInterior(tonumber(int))
    source:setDimension(0)
    takeAllWeapons(source)
    exports.vn_pets:remove(source)
    source:setNametagColor(200, 200, 200)
    Timer(function(player)
        if player then
            giveWeapon(player, 24, 500)
            giveWeapon(player, 25, 75)
        end
    end,500,1,source)
    local chance = math.random(1,5)
    for _, value in ipairs(cords) do
        if id == value[1] then
            if chance == value[2] then
                source:setPosition(value[3],value[4],value[5])
            end
        end
    end
end)

addEventHandler("onPlayerWasted", root, function(_, attacker)
    if source:getData("online") then
        local lobby = source:getData("deathmatch") or 0
        if lobby > 0 then
            local chance = math.random(1,5)
            for _, value in ipairs(cords) do
                if lobby == value[1] then
                    if chance == value[2] then
                        Timer(function(player)
                            if player then
                                player:spawn(value[3],value[4],value[5],0,player.model,player.interior,player.dimension)
                                takeAllWeapons(player)
                            end
                        end,250,1,source)
                        Timer(function(player)
                            if player then
                                player.armor = 50
                                giveWeapon(player, 24, 500)
                                giveWeapon(player, 25, 75)
                            end
                        end,550,1,source)
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
    end
end)