local veh = Vehicle(482, 2120, -1724, 13.6, 0, 0, 239.996)
veh:setColor(16,15,15,77,98,104,0,0,0,0,0,0)
veh:setDimension(1)
veh:setLocked(true)
veh:setFrozen(true)
veh:setPlateText("LIBLUA")

addEventHandler("onClientVehicleDamage", root, function()
    if source == veh then
        iprint("vehicle damage blocked.")
        source:fix()
        cancelEvent()
    end
end)