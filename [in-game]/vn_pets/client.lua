local font = exports.vn_fonts:getFont("RobotoB", 9)
local black = tocolor(0,0,0)
local white = tocolor(225,225,225)

local setRotatin = function(element, value)
    return setPedRotation(element, 360-value)
end

addEventHandler("onClientRender", root, function()
    if localPlayer:getData("online") then
        for _, pet in ipairs(Element.getAllByType("ped")) do
            if pet:getData("pet") then
                local owner = pet:getData("owner.element") or nil
                if owner then
                    local x, y, z = owner.position.x, owner.position.y, owner.position.z
                    local lx, ly, lz = localPlayer.position.x, localPlayer.position.y, localPlayer.position.z
                    local rx, ry, rz = pet.position.x, pet.position.y, pet.position.z
                    local sx, sy = getScreenFromWorldPosition(rx,ry,rz+0.5, 100, false)
                    local distance = getDistanceBetweenPoints3D(x,y,z,rx,ry,rz)
                    local distance2 = getDistanceBetweenPoints3D(lx,ly,lz,rx,ry,rz)
                    if distance2 < 8 then
                        if sx and sy then
                            local ownerName = owner.name
                            local name = pet:getData("name")
                            dxDrawText("Owner: "..ownerName.."\n"..name.." (PET)", sx+1, sy, sx+1, sy, black, 1, font, "center", "center")
                            dxDrawText("Owner: "..ownerName.."\n"..name.." (PET)", sx, sy+1, sx, sy+1, black, 1, font, "center", "center")
                            dxDrawText("Owner: "..ownerName.."\n"..name.." (PET)", sx-1, sy, sx-1, sy, black, 1, font, "center", "center")
                            dxDrawText("Owner: "..ownerName.."\n"..name.." (PET)", sx, sy-1, sx, sy-1, black, 1, font, "center", "center")
                            dxDrawText("Owner: #8DE0E6"..ownerName.."#E1E1E1\n"..name.." #A544DE(PET)", sx, sy, sx, sy, white, 1, font, "center", "center", false, false, false, true, false)
                        end
                    end
                    local veh = owner.vehicle
                    local petVeh = pet.vehicle
                    pet.interior = owner.interior
                    pet.dimension = owner.dimension
                    if veh then
                        if veh == petVeh then else
                            setPedExitVehicle(pet)
                        end
                        setPedEnterVehicle(pet, veh, true)
                    else
                        if petVeh then
                            setPedExitVehicle(pet)
                        else
                            setPedControlState(pet, 'sprint', true)
                        end
                    end
                    if distance > 15 then
                        pet:setPosition(x,y+1,z+0.5)
                    end
                    if distance > 2.5 then
                        pet:setControlState('forwards', true)
                        local rX, rY = 0, 0
                        rX = math.abs(x-rx)
                        rY = math.abs(y-ry)
                        faceMe = math.deg(math.atan2(rY,rX))
                        if (x >= rx) and (y > ry) then
                            faceMe = 90 - faceMe
                        elseif (x <= rx) and (y > ry) then
                            faceMe = 270 + faceMe
                        elseif (x >= rx) and (y <= ry) then
                            faceMe = 90 + faceMe
                        elseif (x < rx) and (y <= ry) then
                            faceMe = 270 - faceMe
                        end
                        setRotatin(pet, faceMe)
                        setPedLookAt(pet, x, y, z + .5)
                    else
                        pet:setControlState('forwards', false)
                    end
                end
            end
        end
    end
end)