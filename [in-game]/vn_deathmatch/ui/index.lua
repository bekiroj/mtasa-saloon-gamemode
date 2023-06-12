local deathmatch = class("deathmatch")

function deathmatch:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end,
    }

    self.icons = {
        load = exports.vn_fonts:getIcon("load"),
        logo = "",
    }

    self.lobbys = {
        {'LV police HQ', 3},
        {'Pleasure domes', 3},
        {'Jefferson motel', 15},
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
    self.npc = createPed(31, 2138.298828125, -1741.375, 13.561543464661, 40)
    self.npc:setData("name", "deathmatch")
    self.npc:setData("icon", "")
    self.npc:setDimension(1)
    self.npc.frozen = true
    setPedAnimation(self.npc, "BAR", "BARman_idle", -1, true, false, false)
    addEventHandler("onClientPlayerWeaponFire", localPlayer, self._functions.display)
end

function deathmatch:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+20, self.y+27, nil, nil, tocolor(95, 95, 95), 1, self.awesome)
    dxDrawText("All lobbys are listed below.", self.x+85, self.y+32, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)
    if self.load <= 600 then
        dxDrawText(self.icons.load, self.screen.x/2, self.screen.y/2-25, nil, nil, tocolor(225,225,225), 1, self.awesome, "center", "center", false, false, false, false, false, self.load)
        self.load = self.load + 5
    else
        dxDrawText("Lobby", self.x+35, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
        dxDrawText("Players", self.x+430, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)

        local addY = 0
        for index, value in ipairs(self.lobbys) do
            gets = {}
            for _, player in ipairs(Element.getAllByType('player')) do
                if player:getData("online") then
                    if player:getData("deathmatch") == index then
                        table.insert(gets, player)
                    end
                end
            end
            if self:isInBox(self.x+25, self.y+110+addY, 500, 30) then
                self:roundedRectangle(self.x+25, self.y+110+addY, 500, 30, 9, tocolor(35, 35, 35, 225))
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    if #gets >= 10 then else
                        triggerServerEvent("deathmatch.enter", localPlayer, index, value[2])
                        self:stop()
                    end
                end
            else
                self:roundedRectangle(self.x+25, self.y+110+addY, 500, 30, 9, tocolor(35, 35, 35, 125))
            end
            dxDrawText(value[1], self.x+45, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText(""..#gets.."/10", self.x+430, self.y+117+addY, nil, nil, tocolor(95, 95, 95), 1, self.robotoBSmall)
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

function deathmatch:display(weapon,_,_,_,_,_,target)
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

function deathmatch:stop()
    showChat(true)
    showCursor(false)
    removeEventHandler("onClientRender", root, self._functions.render)
end

function deathmatch:roundedRectangle(x, y, width, height, radius, color)
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

function deathmatch:isInBox(xS,yS,wS,hS)
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

deathmatch:new()