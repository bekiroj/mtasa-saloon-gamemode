local isPedAiming = function(thePedToCheck)
    if isElement(thePedToCheck) then
        if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
            if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(thePedToCheck) then
                return true
            end
        end
    end
    return false
end

Timer(function()
    setGameSpeed(1.10)
    if isPedAiming(localPlayer) then
        setFPSLimit(60)
    else
        setFPSLimit(0)
    end
end, 0, 0)