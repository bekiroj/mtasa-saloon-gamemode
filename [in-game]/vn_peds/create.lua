local peds = class("peds")

function peds:init()
    self._functions = {
        render = function(...) self:render(...) end
    }

    self.font = exports.vn_fonts:getFont("RobotoB", 8)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 15)
    self.black = tocolor(0,0,0)
    self.color = tocolor(192,176,123)
    self.white = tocolor(225,225,225)

    addEventHandler("onClientPedDamage", root, function()
        cancelEvent()
    end)

    addEventHandler("onClientRender", root, self._functions.render)
end

function peds:render()
    if localPlayer.dimension == 1 then
        for _, ped in ipairs(Element.getAllByType("ped")) do
            if ped:getData("pet") then else
                local x, y, z = localPlayer.position.x, localPlayer.position.y, localPlayer.position.z
                local x2, y2, z2 = ped.position.x, ped.position.y, ped.position.z
                local distance = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
                if distance < 15 then
                    local name = ped:getData("name") or nil
                    if name then
                        local sx, sy = getScreenFromWorldPosition(x2,y2,z2+1.20, 100, false)
                        if sx and sy then
                            local icon = ped:getData("icon") or ""
                            dxDrawText(icon, sx+1, sy-50, sx+1, sy, self.black, 1, self.awesome, "center", "center")
                            dxDrawText(icon, sx, sy-50+1, sx, sy+1, self.black, 1, self.awesome, "center", "center")
                            dxDrawText(icon, sx-1, sy-50, sx-1, sy, self.black, 1, self.awesome, "center", "center")
                            dxDrawText(icon, sx, sy-50-1, sx, sy-1, self.black, 1, self.awesome, "center", "center")
                            dxDrawText(icon, sx, sy-50, sx, sy, self.color, 1, self.awesome, "center", "center")

                            dxDrawText(""..name.." (NPC)", sx+1, sy, sx+1, sy, self.black, 1, self.font, "center", "center")
                            dxDrawText(""..name.." (NPC)", sx, sy+1, sx, sy+1, self.black, 1, self.font, "center", "center")
                            dxDrawText(""..name.." (NPC)", sx-1, sy, sx-1, sy, self.black, 1, self.font, "center", "center")
                            dxDrawText(""..name.." (NPC)", sx, sy-1, sx, sy-1, self.black, 1, self.font, "center", "center")
                            dxDrawText(""..name.." (NPC)", sx, sy, sx, sy, self.white, 1, self.font, "center", "center")
                        end
                    end
                end
            end
        end
    end
end

peds:new()