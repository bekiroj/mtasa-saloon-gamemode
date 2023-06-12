local saloon = class("saloon")

function saloon:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end,
        damage = function(...) self:damage(...) end,
    }
    self.icons = {
        logo = ""
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-550/2, self.screen.y/2-200/2, 550, 200
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 12)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.roboto = exports.vn_fonts:getFont("Roboto", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)

    bindKey("f1", "down", self._functions.display)
    addEventHandler("onClientPlayerDamage", localPlayer, self._functions.damage)
end

function saloon:damage()
    if getElementData(localPlayer, "lobby") then
        cancelEvent()
    end
end

function saloon:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+20, self.y+27, nil, nil, tocolor(223, 88, 88), 1, self.awesome)
    dxDrawText("Are you leave the game and go to the saloon?", self.x+85, self.y+32, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)

    if self:isInBox(self.x+50, self.y+85, self.w-100, 30) then
        self:roundedRectangle(self.x+50, self.y+85, self.w-100, 30, 9, tocolor(35, 35, 35, 245))
        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
            self.tick = getTickCount()
            triggerServerEvent("turn.saloon", localPlayer)
            triggerServerEvent("vehicle.remove", localPlayer)
            self:display()
        end
    else
        self:roundedRectangle(self.x+50, self.y+85, self.w-100, 30, 9, tocolor(35, 35, 35, 125))
    end
    dxDrawText("Yes, I want to exit the game.", self.x+50+15, self.y+85+7, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)

    if self:isInBox(self.x+50, self.y+85+33, self.w-100, 30) then
        self:roundedRectangle(self.x+50, self.y+85+33, self.w-100, 30, 9, tocolor(35, 35, 35, 245))
        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
            self.tick = getTickCount()
            self:display()
        end
    else
        self:roundedRectangle(self.x+50, self.y+85+33, self.w-100, 30, 9, tocolor(35, 35, 35, 125))
    end
    dxDrawText("No, thanks.", self.x+50+15, self.y+85+33+7, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
end

function saloon:display()
    if self.active then
        self.active = false
        showCursor(false)
        showChat(true)
        removeEventHandler("onClientRender", root, self._functions.render)
    else
        self.active, self.tick = true, 0
        showCursor(true)
        showChat(false)
        addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
    end
end

function saloon:roundedRectangle(x, y, width, height, radius, color)
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

function saloon:isInBox(xS,yS,wS,hS)
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

saloon:new()