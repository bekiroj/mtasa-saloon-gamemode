local shop = class("shop")

function shop:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end,
    }

    self.icons = {
        load = exports.vn_fonts:getIcon("load"),
        logo = "",
        shopping = "",
    }

    self.items = {
        {"M4", 2500, 31, 200},
        {"Rifle", 1250, 33, 40},
        {"Sniper", 4000, 34, 15},
        {"C.Shotgun", 2000, 27, 30},
        {"Tec-9", 750, 32, 125},
        {"Score Reset", 10000, 1, 0},
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-550/2, self.screen.y/2-400/2, 550, 400
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 12)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.roboto = exports.vn_fonts:getFont("Roboto", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)
    self.awesomeSmall = exports.vn_fonts:getFont("AwesomeSolid", 11)
    self.awesomeSmall2 = exports.vn_fonts:getFont("AwesomeSolid", 15)

    --// NPC
    self.npc = createPed(23, 2117.5576171875, -1724.2568359375, 13.548140525818, 140)
    self.npc:setData("name", "shop")
    self.npc:setData("icon", "")
    self.npc:setDimension(1)
    self.npc.frozen = true
    setPedAnimation(self.npc, "LOWRIDER", "M_smklean_loop", -1, true, false, false)
    addEventHandler("onClientPlayerWeaponFire", localPlayer, self._functions.display)
end

function shop:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+20, self.y+27, nil, nil, tocolor(125, 125, 125), 1, self.awesome)
    dxDrawText("All items are listed below.", self.x+85, self.y+32, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)
    if self.load <= 1000 then
        dxDrawText(self.icons.load, self.screen.x/2, self.screen.y/2-25, nil, nil, tocolor(225,225,225), 1, self.awesome, "center", "center", false, false, false, false, false, self.load)
        self.load = self.load + 5
    else
        dxDrawText("Item", self.x+35, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
        dxDrawText("Ammo", self.x+125, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
        dxDrawText("Price", self.x+300, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
        local addY = 0
        for _, value in ipairs(self.items) do
            self:roundedRectangle(self.x+25, self.y+110+addY, 450, 30, 9, tocolor(35, 35, 35, 225))
            dxDrawText(value[1], self.x+45, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText(value[4], self.x+125, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText("$"..exports.vn_utils:formatMoney(value[2]), self.x+300, self.y+117+addY, nil, nil, tocolor(222, 173, 124), 1, self.robotoBSmall)
            if self:isInBox(self.x+25+455, self.y+110+addY, 50, 30) then
                self:roundedRectangle(self.x+25+455, self.y+110+addY, 50, 30, 9, tocolor(35, 35, 35, 225))
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    triggerServerEvent("shop.buy", localPlayer, value[2], value[3], value[4])
                    self:stop()
                end
            else
                self:roundedRectangle(self.x+25+455, self.y+110+addY, 50, 30, 9, tocolor(35, 35, 35, 125))
            end
            dxDrawText(self.icons.shopping, self.x+25+455+15, self.y+115+addY, nil, nil, tocolor(200, 200, 200), 1, self.awesomeSmall)
            addY = addY + 32
        end
        if self:isInBox(self.x+100, self.y+self.h-15, self.w-200, 5) then
            dxDrawRectangle(self.x+100, self.y+self.h-15, self.w-200, 5, tocolor(255, 255, 255, 225))
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                self:stop()
            end
        else
            dxDrawRectangle(self.x+100, self.y+self.h-15, self.w-200, 5, tocolor(255, 255, 255, 125))
        end
    end
end

function shop:display(weapon,_,_,_,_,_,target)
    if localPlayer:getData('online') then
        if weapon == 24 then
            if target then
                if target == self.npc then
                    self.tick, self.load = 0, 0
                    setCursorPosition(self.screen.x/2, self.screen.y/2)
                    showChat(false)
                    showCursor(true)
                    addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
                end
            end
        end
    end
end

function shop:stop()
    showChat(true)
    showCursor(false)
    removeEventHandler("onClientRender", root, self._functions.render)
end

function shop:roundedRectangle(x, y, width, height, radius, color)
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

function shop:isInBox(xS,yS,wS,hS)
    if(isCursorShowing()) then
        local cursorX, cursorY = getCursorPosition()
        sX,sY = guiGetScreenSize()
        cursorX, cursorY = cursorX*sX, cursorY*sY
        if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
            return true
        else
            return false
        end
    end
end

shop:new()