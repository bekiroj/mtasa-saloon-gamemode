local nametag = class("nametag")

function nametag:init()

    self._functions = {
        render = function(...) self:render(...) end
    }

    self.font = exports.vn_fonts:getFont("RobotoB", 14)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 14)
    self.black = tocolor(0,0,0)
    self.white = tocolor(225,225,225)

    addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
end

function nametag:refreshIcons(player)
    self.icons = {}
    if player:getData("admin") == 1 and player:getData("duty") then
        table.insert(self.icons, {"", tocolor(233, 101, 101)})
    end
    if player:getData("admin") == 2 and player:getData("duty") then
        table.insert(self.icons, {"", tocolor(233, 101, 101)})
    end
    if player:getData("vip") then
        table.insert(self.icons, {"", tocolor(233, 224, 101)})
    end
    if player:getData("tag") == 1 then
        table.insert(self.icons, {"", tocolor(195, 225, 146)})
    end
    if player:getData("tag") == 2 then
        table.insert(self.icons, {"", tocolor(149, 146, 225)})
    end
    if player:getData("tag") == 3 then
        table.insert(self.icons, {"", tocolor(239, 158, 66)})
    end
    if player:getData("tag") == 4 then
        table.insert(self.icons, {"", tocolor(200, 200, 200)})
    end
    if player:getData("tag") == 5 then
        table.insert(self.icons, {"", tocolor(85, 151, 226)})
    end
    if player:getData("tag") == 6 then
        table.insert(self.icons, {"", tocolor(207, 226, 85)})
    end
    if player:getData("tag") == 7 then
        table.insert(self.icons, {"", tocolor(200, 200, 200)})
    end
    if player:getData("tag") == 8 then
        table.insert(self.icons, {"", tocolor(200, 200, 200)})
    end
    if player:getData("tag") == 9 then
        table.insert(self.icons, {"", tocolor(100, 100, 100)})
    end
end

function nametag:render()
    if localPlayer:getData("online") then
        for _, player in ipairs(Element.getAllByType("player")) do
            player.nametagShowing = false
            if player:getData("online") then
                if player.onScreen then
                    local lx, ly, lz = localPlayer.position.x, localPlayer.position.y, localPlayer.position.z
                    local rx, ry, rz = player.position.x, player.position.y, player.position.z
                    local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
                    if localPlayer:getTarget() == player or distance < 12 then
                        if isLineOfSightClear(rx, ry, rz, lx, ly, lz, true, false, false, true, false, false, false, localPlayer) then
                            local sx, sy = getScreenFromWorldPosition(rx, ry, rz+1.10, 100, false)
                            if sx and sy then
                                if player.ducked then
                                    sy = sy + 50
                                end
                                local name = player.name or "null"
                                local id = player:getData("dbid") or 0
                                local r, g, b = getPlayerNametagColor(player)
                                dxDrawText(""..name.." ("..id..")", sx+1, sy, sx+1, sy, self.black, 0.66, self.font, "center", "center", false, false, false, false, false)
                                dxDrawText(""..name.." ("..id..")", sx, sy+1, sx, sy+1, self.black, 0.66, self.font, "center", "center", false, false, false, false, false)
                                dxDrawText(""..name.." ("..id..")", sx-1, sy, sx-1, sy, self.black,0.66, self.font, "center", "center", false, false, false, false, false)
                                dxDrawText(""..name.." ("..id..")", sx, sy-1, sx, sy-1, self.black, 0.66, self.font, "center", "center", false, false, false, false, false)
                                dxDrawText(""..name.." ("..id..")", sx, sy, sx, sy, tocolor(r, g, b), 0.66, self.font, "center", "center", false, false, false, false, false)
                                local hp = player.health
                                local arm = player.armor
                                if arm > 0 then
                                    sy = sy + 9
                                    dxDrawRectangle(sx-25-1,sy-1,50+2,6+2,tocolor(0,0,0))
                                    dxDrawRectangle(sx-25,sy,arm/2,6,tocolor(135, 135, 135))
                                end
                                sy = sy + 9
                                dxDrawRectangle(sx-25-1,sy-1,50+2,6+2,tocolor(0,0,0))
                                dxDrawRectangle(sx-25,sy,hp/2,6,tocolor(210,55,55))
                                self:refreshIcons(player)
                                sy = sy + 12
                                local addX = 0
                                sx = sx - #self.icons * 10
                                for _, value in ipairs(self.icons) do
                                    dxDrawText(value[1], sx+addX+1, sy, sx+1, sy, self.black, 0.66, self.awesome)
                                    dxDrawText(value[1], sx+addX, sy+1, sx, sy+1, self.black, 0.66, self.awesome)
                                    dxDrawText(value[1], sx+addX-1, sy, sx-1, sy, self.black, 0.66, self.awesome)
                                    dxDrawText(value[1], sx+addX, sy-1, sx, sy-1, self.black, 0.66, self.awesome)
                                    dxDrawText(value[1], sx+addX, sy, sx, sy, value[2], 0.66, self.awesome)
                                    addX = addX + 20
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

nametag:new()