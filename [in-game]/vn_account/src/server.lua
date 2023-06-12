local conn = exports.vn_mysql:getConn()
local _print = outputDebugString
setGameType('Lobby')

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

local validation = function(username, password)
    if username == "username" then
        return false, "You have not set a valid account name."
    end
    if string.len(username) <= 5 then
        return false, "Your account name must contain at least 5 characters."
    end
    if password == "password" then
        return false, "You have not set a valid account password."
    end
    if string.len(password) <= 5 then
        return false, "Your account password must contain at least 5 characters."
    end
    return true, ""
end

local login = function(source, username)
    dbQuery(
        function(qh, player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                for _, row in ipairs(res) do
                    player:setName(row.username)
                    local random = math.random(1,15)
                    player:spawn(cords[random][1], cords[random][2], cords[random][3])
                    player:setDimension(1)
                    player:setCameraTarget(player)
                    player:setModel(tonumber(row.model))
                    player:setWalkingStyle(tonumber(row.walking))
                    player:setData("online", true)
                    player:setData("dbid", tonumber(row.id))
                    player:setData("balance", tonumber(row.balance))
                    player:setData("money", tonumber(row.money))
                    player:setData("admin", tonumber(row.admin))
                    player:setData("death", tonumber(row.death))
                    player:setData("kill", tonumber(row.kill))
                    player:setData("tag", tonumber(row.tag))
                    player:setData("lobby", true)
                    player:setData("deathmatch", nil)
                    player:setData("gangwars", nil)
                    player.armor = 100
                    setPedStat(player, 70, 999)
                    setPedStat(player, 71, 999)
                    setPedStat(player, 72, 999)
                    setPedStat(player, 74, 999)
                    setPedStat(player, 76, 999)
                    setPedStat(player, 77, 999)
                    setPedStat(player, 78, 999)
                    setPedStat(player, 77, 999)
                    setPedStat(player, 78, 999)
                    setPedStat(player, 79, 999)
                    player:setNametagColor(200, 200, 200)
                    exports.vn_utils:sendChat(player, "welcome back "..player.name..", good to see you.")
                    exports.vn_utils:sendChat(player, "discord.gg/ebRqVbMDzb")
                    takeAllWeapons(player)
                    giveWeapon(player, 24, 75)
                    giveWeapon(player, 3)
                    Timer(function(thePlayer)
                        thePlayer:setWeaponSlot(1)
                    end, 250, 1, player)
                    dbQuery(
                        function(qh,vipPlayer)
                            local _, rows, _ = dbPoll(qh, 0)
                            if rows > 0 then
                                vipPlayer:setData("vip", true)
                                _print("!ACCOUNT - added vip to "..vipPlayer.name)
                            end
                        end,
                    {player}, conn, "SELECT * FROM vips WHERE own = ?", player:getData("dbid"))
                end
            end
        end,
    {source}, conn, "SELECT * FROM accounts WHERE username = ?", username)
end

addEvent("account.remember", true)
addEventHandler("account.remember", root, function()
    local serial = source.serial or ""
    dbQuery(
        function(qh,player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                for _, row in ipairs(res) do
                    triggerClientEvent(player, "account.remembered", player, row.username, row.password)
                end
            end
        end,
    {source}, conn, "SELECT username, password FROM accounts WHERE serial = ?", serial)
end)

addEvent("account.login", true)
addEventHandler("account.login", root, function(username, password)
    for _, value in ipairs(Element.getAllByType("player")) do
        if value:getData("online") then
            local name = value.name or ""
            if name == username then
                triggerClientEvent(player, "account.error", player, "This account is already in the game now.")
                return false
            end
        end
    end
    dbQuery(
        function(qh, player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                for _, row in ipairs(res) do
                    if row.password == password then
                        local pSerial = player.serial or ""
                        if row.serial == pSerial then
                            triggerClientEvent(player, "account.success", player)
                            login(player, username)
                        else
                            triggerClientEvent(player, "account.error", player, "You must enter this account with the computer that was last logged in.")
                        end
                    else
                        triggerClientEvent(player, "account.error", player, "You entered the password of the account named "..username.." incorrectly.")
                    end
                end
            else
                triggerClientEvent(player, "account.error", player, "No registered account with this name was found, please check your information.")
            end
        end,
    {source}, conn, "SELECT username, password, serial FROM accounts WHERE username = ?", username)
end)

addEvent("account.register", true)
addEventHandler("account.register", root, function(username, password)
    local app, err = validation(username, password)
    if app then
        dbQuery(
            function(qh, player)
            local _, rows, _ = dbPoll(qh, 0)
                if rows > 0 then
                    triggerClientEvent(player, "account.error", player, "Sorry, but this account name is in use, please choose another one.")
                else
                    local serial = player.serial or ""
                    dbExec(conn, "INSERT INTO accounts SET username='"..(username).."', password='"..(password).."', serial='"..(serial).."'")
                    triggerClientEvent(player, "account.success", player)
                    login(player, username)
                end
            end,
        {source}, conn, "SELECT username FROM accounts WHERE username = ?", username)
    else
        triggerClientEvent(source, "account.error", source, err)
    end
end)

addEventHandler("onPlayerQuit", root, function()
    if source:getData("online") then
        local dbid = source:getData("dbid")
        if tonumber(dbid) then
            local balance = source:getData("balance") or 0
            local admin = source:getData("admin") or 0
            local death = source:getData("death") or 0
            local kill = source:getData("kill") or 0
            local tag = source:getData("tag") or 0
            local model = source.model
            local walking = source.walkingStyle or 125
            dbExec(conn, "UPDATE `accounts` SET `balance`='"..(balance).."', `admin`='"..(admin).."', `tag`='"..(tag).."', `death`='"..(death).."', `kill`='"..(kill).."', `model`='"..(model).."', `walking`='"..(walking).."' WHERE `id`='"..(dbid).."'")
        end
    end
end)