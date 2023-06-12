local conn = exports.vn_mysql:getConn()
local _print = outputDebugString

function takeMoney(player, amount)
    if tonumber(amount) then
        if player:getData("online") then
            local money = player:getData("money") or 0
            if money >= amount then
                local newMoney = tonumber(money - amount)
                player:setData("money", tonumber(newMoney))
                dbExec(conn, "UPDATE `accounts` SET `money`='"..(newMoney).."' WHERE `id`='"..(player:getData('dbid')).."'")
                return true
            end
        end
    else
        _print("!UTILS - takeMoney null amount value.")
    end
    return false
end

function giveMoney(player, amount)
    if tonumber(amount) then
        if player:getData("online") then
            local money = player:getData("money") or 0
            local newMoney = tonumber(money + amount)
            player:setData("money", tonumber(newMoney))
            dbExec(conn, "UPDATE `accounts` SET `money`='"..(newMoney).."' WHERE `id`='"..(player:getData('dbid')).."'")
        end
    else
        _print("!UTILS - giveMoney null amount value.")
    end
end

function giveKillMoney(player)
    if player:getData("online") then
        local money = player:getData("money")
        local newMoney
        if player:getData("vip") then
            newMoney = 200
        else
            newMoney = 50
        end
        giveMoney(player, newMoney)
    end
end

function sendChat(player, ...)
    if (...) then
        local message = table.concat({...}, " ")
        player:outputChat("↷#D0D0D0 "..message.."", 154, 139, 213, true)
    else
        _print("!UTILS - sendChat null message value.")
    end
end