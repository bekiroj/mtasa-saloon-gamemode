addEvent('enter.vehicle', true)
addEventHandler('enter.vehicle',root,function(veh)
 if veh then
  setPedEnterVehicle(localPlayer, veh, true)
 end
end)

addEventHandler("onClientVehicleDamage", root, function ()
    local rx,ry = getElementRotation ( source )
    if rx > 90 and rx < 270 or ry > 90 and ry < 270 then
        setElementHealth(source, 450)
        setVehicleEngineState(source, false)
        cancelEvent()
    end
    if getElementHealth(source) < 450 then
        setElementHealth(source, 450)
        setVehicleEngineState(source, false)
        cancelEvent()
    end
end)