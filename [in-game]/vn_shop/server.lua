local conn = exports.vn_mysql:getConn()
local utils = exports.vn_utils

addEvent("shop.buy", true)
addEventHandler("shop.buy", root, function(price,item,ammo)
    if utils:takeMoney(source, price) then
        if item == 1 then
            source:setData("kill", tonumber(0))
            source:setData("death", tonumber(0))
            utils:sendChat(source, "All your scores have been reset.")
            return
        end
        local dbid = source:getData("dbid") or 0
        local buyItem = tonumber(item)
        local buyAmmo = tonumber(ammo)
        dbQuery(
            function(qh, player)
                local res, rows, _ = dbPoll(qh, 0)
                if rows > 0 then
                    for _, row in ipairs(res) do
                        if row.item == buyItem then
                            local new = tonumber(row.ammo) + buyAmmo
                            dbExec(conn, "UPDATE `items` SET `ammo`='"..(new).."' WHERE `id`='"..(tonumber(row.id)).."'")
                            utils:sendChat(player, "You purchased the item by paying $"..(price)..".")
                            utils:sendChat(player, "Available Ammo: "..(new).."")
                            return
                        end
                    end
                    dbExec(conn, "INSERT INTO items SET own='"..(dbid).."', item='"..(buyItem).."', ammo='"..(buyAmmo).."'")
                    utils:sendChat(player, "You purchased the item by paying $"..(price)..".")
                    utils:sendChat(player, "Available Ammo: "..(buyAmmo).."")
                else
                    dbExec(conn, "INSERT INTO items SET own='"..(dbid).."', item='"..(buyItem).."', ammo='"..(buyAmmo).."'")
                    utils:sendChat(player, "You purchased the item by paying $"..(price)..".")
                    utils:sendChat(player, "Available Ammo: "..(buyAmmo).."")
                end
            end,
        {source}, conn, "SELECT * FROM items WHERE own = ?", tonumber(dbid))
    else
        utils:sendChat(source, "You need to pay $"..(price).." to purchase this item.")
    end
end)