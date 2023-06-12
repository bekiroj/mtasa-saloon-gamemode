local conn = exports.vn_mysql:getConn()
local _print = outputDebugString
addEvent("donate.buy.vip", true)
addEvent("donate.buy.pet", true)
addEvent("donate.buy.reset", true)
addEvent("donate.buy.tag", true)

local takeBalance = function(player,amount)
    if tonumber(amount) then
        local balance = player:getData("balance") or 0
        if balance >= amount then
            local newBalance = tonumber(balance - amount)
            player:setData("balance", tonumber(newBalance))
            dbExec(conn, "UPDATE `accounts` SET `balance`='"..(newBalance).."' WHERE `id`='"..(player:getData('dbid')).."'")
            return true
        end
    else
        _print("!DONATE - takeBalance null amount")
    end
    return false, "You must pay $"..amount.." to buy this product."
end

Timer(
    function()
        dbQuery(
            function(qh)
                local res, rows, _ = dbPoll(qh, 0)
                if rows > 0 then
                    for _, row in ipairs(res) do
                        local current = tonumber(row.remain)
                        local newCurrent = tonumber(current - 1)
                        local own = tonumber(row.own)
                        local id = tonumber(row.id)
                        if id then
                            if newCurrent <= 0 then
                                dbExec(conn, "DELETE FROM `vips` WHERE `id`='"..(id).."'")
                                for _, player in ipairs(Element.getAllByType("player")) do
                                    if player:getData("online") then
                                        if player:getData("dbid") == own then
                                            player:setData("vip", false)
                                            exports.vn_utils:sendChat(player, "Your vip period has expired to renew /donate")
                                        end
                                    end
                                end
                            else
                                dbExec(conn,"UPDATE vips SET remain='"..(newCurrent).."' WHERE id='"..(id).."'")
                            end
                        end
                    end
                end
            end,
        conn, "SELECT * FROM vips")
    end,
3600000, 0)

--// AUTO 1 WEEK
function giveVip(source)
    local dbid = source:getData("dbid")
    dbQuery(
        function(qh, player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                for _, row in ipairs(res) do
                    player:setData("vip", true)
                    local new = tonumber(row.remain) + 168
                    dbExec(conn, "UPDATE `vips` SET `remain`='"..(new).."' WHERE `id`='"..(tonumber(row.id)).."'")
                end
            else
                player:setData("vip", true)
                dbExec(conn, "INSERT INTO vips SET own='"..(dbid).."', remain='168'")
            end
            exports.vn_utils:sendChat(player, "Vip feature has been added to your account.")
        end,
    {source}, conn, "SELECT * FROM vips WHERE own = ?", tonumber(dbid))
end

addEventHandler("donate.buy.vip", root, function(price)
    local price = tonumber(price) or 0
    local app, err = takeBalance(source, price)
    if app then
        giveVip(source)
    else
        exports.vn_utils:sendChat(source, err)
    end
end)

addEventHandler("donate.buy.pet", root, function(price)
    local price = tonumber(price) or 0
    local app, err = takeBalance(source, price)
    if app then
        exports.vn_pets:create(source)
    else
        exports.vn_utils:sendChat(source, err)
    end
end)

addEventHandler("donate.buy.reset", root, function(price)
    local price = tonumber(price) or 0
    local app, err = takeBalance(source, price)
    if app then
        source:setData("death", 0)
        source:setData("kill", 0)
        exports.vn_utils:sendChat(source, "Your Death/Kill scores have been reset.")
    else
        exports.vn_utils:sendChat(source, err)
    end
end)

addEventHandler("donate.buy.tag", root, function(price)
    local price = tonumber(price) or 0
    local app, err = takeBalance(source, price)
    if app then
        exports.vn_utils:sendChat(source, "The balance has been deducted from your account, take a photo of this message and contact via discord.")
    else
        exports.vn_utils:sendChat(source, err)
    end
end)