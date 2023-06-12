local utils = exports.vn_utils

local blocked = {
    ["shutdown"] = true,
    ["register"] = true,
    ["msg"] = true,
    ["login"] = true,
    ["restart"] = true,
    ["start"] = true,
    ["stop"] = true,
    ["refresh"] = true,
    ["aexec"] = true,
    ["refreshall"] = true,
    ["debugscript"] = true,
}

addEventHandler("onPlayerCommand", root, function(command)
    if blocked[command] then
        cancelEvent()
        utils:sendChat(source, "Sorry you cannot use this command.")
    end
end)

addEventHandler("onPlayerChangeNick", root, function(oldNick)
    cancelEvent()
    source.name = tostring(oldNick)
end)

function onDuty(player)
    if player:getData("admin") > 0 then
        if player:getData("duty") then
            player:removeData("duty")
            player:setNametagColor(200, 200, 200)
        else
            player:setData("duty", true)
            player:setNametagColor(200, 25, 25)
        end
    end
end
addCommandHandler("duty", onDuty)

local findTarget = function(id)
    local target = nil
    local id = tonumber(id) or 0
    for _, value in ipairs(Element.getAllByType("player")) do
        if value:getData("online") then
            if value:getData("dbid") == id then
                target = value
            end
        end
    end
    return target
end

function getPosition(player)
    local x, y, z = player.position.x, player.position.y, player.position.z
    local rx, ry, rz = player.rotation.x, player.rotation.y, player.rotation.z
    player:outputChat("Pos: "..x..", "..y..", "..z)
    player:outputChat("Rot: "..rx..", "..ry..", "..rz)
end
addCommandHandler("pos", getPosition)

function giveBalance(player,command,id,balance)
    if player:getData("admin") >= 2 then
        if tonumber(id) and tonumber(balance) then
            local target = findTarget(id)
            if target then
                local targetBalance = target:getData("balance") or 0
                local newBalance = tonumber(targetBalance + balance)
                target:setData("balance", tonumber(newBalance))
                utils:sendChat(player, "You have given a player named "..target.name.." a balance of $"..balance..".")
                utils:sendChat(target, ""..player.name.." added $"..balance.." balances to you.")
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID] [BALANCE]")
        end
    end
end
addCommandHandler("givebalance", giveBalance)

function takeBalance(player,command,id,balance)
    if player:getData("admin") >= 2 then
        if tonumber(id) and tonumber(balance) then
            local target = findTarget(id)
            if target then
                local targetBalance = target:getData("balance") or 0
                local newBalance = tonumber(targetBalance - balance)
                if newBalance <= 0 then
                    newBalance = 0
                end
                target:setData("balance", tonumber(newBalance))
                utils:sendChat(player, "You have taken a player named "..target.name.." a balance of $"..balance..".")
                utils:sendChat(target, ""..player.name.." removed $"..balance.." balances to you.")
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID] [BALANCE]")
        end
    end
end
addCommandHandler("takebalance", takeBalance)

function setPlayerModel(player,command,id,model)
    if player:getData("admin") >= 1 then
        if tonumber(id) and tonumber(model) then
            local target = findTarget(id)
            if target then
                local app = target:setModel(model)
                if app then
                    utils:sendChat(player, "success.")
                else
                    utils:sendChat(player, "nope.")
                end
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID] [MODEL]")
        end
    end
end
addCommandHandler("setmodel", setPlayerModel)

function giveWeap(player,command,wep,ammo)
    if player:getData("admin") >= 2 then
        if tonumber(wep) and tonumber(ammo) then
            local app = giveWeapon(player, wep, ammo)
            if app then
                utils:sendChat(player, "success.")
            else
                utils:sendChat(player, "nope.")
            end
        else
            utils:sendChat(player, "/"..command.." [WEAPON] [AMMO]")
        end
    end
end
addCommandHandler("weapon", giveWeap)

function giveTag(player,command,id,tag)
    if player:getData("admin") >= 1 then
        if tonumber(id) and tonumber(tag) then
            local target = findTarget(id)
            if target then
                local app = target:setData("tag", tonumber(tag))
                if app then
                    utils:sendChat(player, "success.")
                else
                    utils:sendChat(player, "nope.")
                end
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID] [TAG]")
        end
    end
end
addCommandHandler("tag", giveTag)

function goPlayer(player,command,id)
    if player:getData("admin") >= 1 then
        if tonumber(id) then
            local target = findTarget(id)
            if target then
                local x, y, z = target.position.x, target.position.y, target.position.z
                local int, dim = target.interior, target.dimension
                player:setPosition(x, y, z+2)
                player:setInterior(int)
                player:setDimension(dim)
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID]")
        end
    end
end
addCommandHandler("goto", goPlayer)

function getPlayer(player,command,id)
    if player:getData("admin") >= 1 then
        if tonumber(id) then
            local target = findTarget(id)
            if target then
                local x, y, z = player.position.x, player.position.y, player.position.z
                local int, dim = player.interior, player.dimension
                target:setPosition(x, y, z+2)
                target:setInterior(int)
                target:setDimension(dim)
            else
                utils:sendChat(player, "No such player was found, please try again later.")
            end
        else
            utils:sendChat(player, "/"..command.." [TARGET ID]")
        end
    end
end
addCommandHandler("gethere", getPlayer)

function serverEvent(player,command,amount)
    if player:getData("admin") >= 2 then
        if tonumber(amount) then
            for _, value in ipairs(Element.getAllByType("player")) do
                if value:getData("online") then
                    utils:giveMoney(value, tonumber(amount))
                    utils:sendChat(value, "$"..amount.." has been added to you for the event.")
                end
            end
        else
            utils:sendChat(player, "/"..command.." [Amount]")
        end
    end
end
addCommandHandler("event", serverEvent)

function turn(player,command)
    if player:getData("admin") >= 1 then
        triggerEvent("turn.saloon.admin", player)
    end
end
addCommandHandler("lobby", turn)