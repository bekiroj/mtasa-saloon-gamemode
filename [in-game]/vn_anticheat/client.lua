--// TAKEN FROM https://gist.github.com/fresholia/2bbf4751ee293b659d59101cbb1474c8
local lastWarningTick = getTickCount()
local lastDistanceTickCount = getTickCount()
local warningsCount = 0
local LIMIT_DISTANCE = 10
local WARN_SECONDS = 7
local WARN_LIMIT = 3
local bannedMode, bannedModeFromDistance = nil, nil
local lastChangeStateAction = nil
local function checkEntityGround(entity)
    local dimension, interior = entity:getDimension(entity), entity:getInterior(entity)
    if dimension > 0 and interior > 0 then
        local elements = getElementsWithinRange(entity.position, 1, "object", interior, dimension)
        if #elements > 0 then
            return true
        end
    end
    return isPedOnGround(entity)
end

addEventHandler("onClientPreRender", root, function()
    if not localPlayer.vehicle then
        if not lastPosition then
            lastPosition = localPlayer.position
            lastDistanceTickCount = getTickCount()
        end
        if lastDistanceTickCount + 500 <= getTickCount() then
            local distance = getDistanceBetweenPoints3D(localPlayer.position, lastPositionFromWarning or lastPosition)
            if distance > LIMIT_DISTANCE then
                warningsCount = warningsCount + 1
                if warningsCount == WARN_LIMIT then
                    bannedMode = true
                    bannedModeFromDistance = true
                else
                    lastPositionFromWarning = localPlayer.position
                end
            else
                bannedModeFromDistance = false
                lastPosition = localPlayer.position
            end
            lastDistanceTickCount = getTickCount()
        end
    end

    local groundOn = checkEntityGround(localPlayer)
    if not groundOn then
        if groundOn ~= lastChangeStateAction then
            lastWarningTick = getTickCount()
            lastChangeStateAction = groundOn
        end

        local seconds = math.floor((getTickCount() - lastWarningTick) / 1000)

        if seconds > WARN_SECONDS then
            warningsCount = warningsCount + 1
            lastWarningTick = getTickCount()
            if warningsCount == WARN_LIMIT then
                bannedMode = true
            end
        end
    else
        lastChangeStateAction = nil
        if bannedMode then
            WARN_SECONDS = 3
        end
        if not bannedModeFromDistance then
            bannedMode = false
            warningsCount = 0
            lastPositionFromWarning = nil
        end
    end
end)

addEventHandler("onClientPlayerDamage", root, function(attacker,weapon)
    if bannedMode then
        if attacker == localPlayer then
            triggerServerEvent("anticheat.kick", attacker)
            iprint("!CHEAT")
            cancelEvent()
        end
    end
    if attacker then
        if weapon == 38 or weapon == 35 then
            triggerServerEvent("anticheat.kick", attacker)
            iprint("!CHEAT")
            cancelEvent()
        end
    end
end)