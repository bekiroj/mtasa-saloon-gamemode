local font = exports.vn_fonts:getFont("RobotoB", 11)
local black = tocolor(0,0,0)
local white = tocolor(225,225,225)

addEventHandler("onClientRender", root, function()
    if localPlayer.dimension == 1 then
        for _, pickup in ipairs(Element.getAllByType("pickup")) do
            if pickup:getData("information") then
                local x, y, z = pickup.position.x, pickup.position.y, pickup.position.z
                local px, py, pz = localPlayer.position.x, localPlayer.position.y, localPlayer.position.z
                if getDistanceBetweenPoints3D(px,py,pz,x,y,z) <= 10 then
                    local sx, sy = getScreenFromWorldPosition(x,y,z, 100, false)
                    if sx and sy then
                        local text = pickup:getData("information") or "null"
                        dxDrawText(text, sx+1, sy, sx+1, sy, black, 1, font, "center", "center")
                        dxDrawText(text, sx, sy+1, sx, sy+1, black, 1, font, "center", "center")
                        dxDrawText(text, sx-1, sy, sx-1, sy, black, 1, font, "center", "center")
                        dxDrawText(text, sx, sy-1, sx, sy-1, black, 1, font, "center", "center")
                        dxDrawText(text, sx, sy, sx, sy, white, 1, font, "center", "center")
                    end
                end
            end
        end
    end
end, true, "low-9999")