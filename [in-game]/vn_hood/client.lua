local region = ColShape.Sphere(2146.7890625, -1671.0224609375, 15.0859375, 30)
local blip = Blip(2146.7890625, -1671.0224609375, 15.0859375, 0)

addEventHandler("onClientRender", root, function()
    countGrove = 0
    countBallas = 0
    countAztecas = 0
    countVagos = 0
    playerCount = 0
    for _, player in ipairs(Element.getAllByType("player")) do
        playerCount = playerCount + 1
        if player:isWithinColShape(region) then
            local gang = player:getData("gangwars") or 0
            if gang == 1 then
                countGrove = countGrove + 1
            elseif gang == 2 then
                countBallas = countBallas + 1
            elseif gang == 3 then
                countAztecas = countAztecas + 1
            elseif gang == 4 then
                countVagos = countVagos + 1
            end
        end
    end
    if playerCount <= 3 then
        return
    end
    blip:setIcon(0)
    --//GROVE
    if countGrove > countBallas then
        blip:setIcon(62)
    end
    if countGrove > countAztecas then
        blip:setIcon(62)
    end
    if countGrove > countVagos then
        blip:setIcon(62)
    end
    --//BALLAS
    if countBallas > countGrove then
        blip:setIcon(59)
    end
    if countBallas > countAztecas then
        blip:setIcon(59)
    end
    if countBallas > countVagos then
        blip:setIcon(59)
    end
    --//AZTECAZ
    if countAztecas > countGrove then
        blip:setIcon(58)
    end
    if countAztecas > countBallas then
        blip:setIcon(58)
    end
    if countAztecas > countVagos then
        blip:setIcon(58)
    end
    --//VAGOS
    if countVagos > countGrove then
        blip:setIcon(60)
    end
    if countVagos > countBallas then
        blip:setIcon(60)
    end
    if countVagos > countAztecas then
        blip:setIcon(60)
    end
end)

Timer(function()
    if blip.icon == 0 then return end
    local gang = localPlayer:getData("gangwars") or 0
    if blip.icon == 62 then
        if gang == 1 then
            triggerServerEvent("hood.win", localPlayer)
        end
    elseif blip.icon == 59 then
        if gang == 2 then
            triggerServerEvent("hood.win", localPlayer)
        end
    elseif blip.icon == 58 then
        if gang == 3 then
            triggerServerEvent("hood.win", localPlayer)
        end
    elseif blip.icon == 60 then
        if gang == 4 then
            triggerServerEvent("hood.win", localPlayer)
        end
    end
end, 120000, 0)