local utils = exports.vn_utils
local timers = {}
local vehicles = {}

function remove(player)
    player.vehicle = nil
    if vehicles[player] then
        vehicles[player]:destroy()
        vehicles[player] = nil
        collectgarbage("collect")
    end
end

function endTime(player)
    if timers[player] then
        if isTimer(timers[player]) then
            killTimer(timers[player])
        end
        timers[player] = nil
        collectgarbage("collect")
    end
end

addEvent("vehicle.create", true)
addEventHandler("vehicle.create", root, function(model, vip)
    if timers[source] then
        utils:sendChat(source, "You can take out a vehicle in just 1 minute.")
    else
        local gang = source:getData("gangwars") or 0
        if gang > 0 then
            if vip then
                if source:getData("vip") then else
                    utils:sendChat(source, "Only VIP users can download this tool.")
                    return
                end
            end
            if vehicles[source] then
                remove(source)
            end
            local r, g, b = getPlayerNametagColor(source)
            local x, y, z = source.position.x, source.position.y, source.position.z
            vehicles[source] = Vehicle(model, x, y+3, z+0.5)
            vehicles[source]:setColor(r, g, b)
            vehicles[source]:setData("gang", tonumber(gang))
            timers[source] = Timer(endTime, 30000, 1, source)
        end
    end
end)

addEvent("vehicle.remove", true)
addEventHandler("vehicle.remove", root, function()
    remove(source)
    endTime(source)
end)

addEventHandler("onPlayerWasted", root, function()
    endTime(source)
end)

addEventHandler("onPlayerVehicleEnter", root, function(vehicle)
    if getElementHealth(vehicle) <= 450 then
        setElementHealth(vehicle, 450)
        setVehicleEngineState(vehicle, false)
    end
end)

local timer = nil
addEventHandler('onVehicleStartEnter', getRootElement(), function(player, seat, jacked)
 if jacked ~= false then
  cancelEvent()
  if isTimer(timer) then
   killTimer(timer)
  end
  setTimer(function(thePlayer,theVehicle)
   timer = nil
   triggerClientEvent(thePlayer, 'enter.vehicle', thePlayer, theVehicle)
  end, 50, 1, player, source)
 end
end)