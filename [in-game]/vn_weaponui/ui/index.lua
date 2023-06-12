local ui = class("ui")

function ui:init()
    self._functions = {
        render = function(...) self:render(...) end
    }
    self.screen = Vector2(guiGetScreenSize())
    self.roboto = exports.vn_fonts:getFont('RobotoB', 8)
    self.black = tocolor(0,0,0,174)
    addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
end

function ui:render()
    if localPlayer:getData("online") then
        local weapon = localPlayer:getWeapon()
        local clip = localPlayer:getAmmoInClip()
        local ammo = localPlayer:getTotalAmmo()
        local rem = 350
        dxDrawImage(self.screen.x-rem-15, self.screen.y-90, 65, 65, "assets/"..weapon..".png", 0, 0, 0, tocolor(255, 255, 255, 225))
        if (weapon >= 15 and weapon ~= 40 and weapon <= 44 or weapon >= 46) then
            dxDrawText(""..ammo-clip.."/"..clip.."", self.screen.x+1-rem, self.screen.y-90+45, nil, nil, self.black, 1, self.roboto)
            dxDrawText(""..ammo-clip.."/"..clip.."", self.screen.x-rem, self.screen.y-90+45+1, nil, nil, self.black, 1, self.roboto)
            dxDrawText(""..ammo-clip.."/"..clip.."", self.screen.x-rem, self.screen.y-90+45-1, nil, nil, self.black, 1, self.roboto)
            dxDrawText(""..ammo-clip.."/"..clip.."", self.screen.x-1-rem, self.screen.y-90+45, nil, nil, self.black, 1, self.roboto)
            dxDrawText(""..ammo-clip.."/"..clip.."", self.screen.x-rem, self.screen.y-90+45, nil, nil, tocolor(200, 200, 200, 200), 1, self.roboto)
        end
    end
end

function ui:roundedRectangle(x, y, width, height, radius, color)
    local diameter = radius * 2
    dxDrawCircle(x + radius, y + radius, radius, 180, 270, color)
    dxDrawCircle(x + width - radius, y + radius, radius, 270, 360, color)
    dxDrawCircle(x + radius, y + height - radius, radius, 90, 180, color)
    dxDrawCircle(x + width - radius, y + height - radius, radius, 0, 90, color)
    dxDrawRectangle(x + radius, y, width - diameter, height, color)
    dxDrawRectangle(x, y + radius, radius, height - diameter, color)
    dxDrawRectangle(x + width - radius, y + radius, radius, height - diameter, color)
    dxDrawRectangle(x + radius, y + radius, width - diameter, height - diameter, tocolor(0, 0, 0, 0))
end

ui:new()