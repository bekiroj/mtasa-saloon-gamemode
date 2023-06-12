local donates = class("donate")

function donates:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end
    }
    self.icons = {
        logo = exports.vn_fonts:getIcon("money")
    }

    self.options = {
        {"VIP (1 WEEK)", 3, "donate.buy.vip"},
        {"Lobby Pet (Unlimited)", 6, "donate.buy.pet"},
        {"Score Reset", 1, "donate.buy.reset"},
        {"Name Tag (Unlimited)", 4, "donate.buy.tag"},
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-550/2, self.screen.y/2-400/2, 550, 400
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 12)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.roboto = exports.vn_fonts:getFont("Roboto", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)

    addCommandHandler("donate", self._functions.display)
end

function donates:render()
    local balance = localPlayer:getData("balance") or 0

    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+20, self.y+27, nil, nil, tocolor(145, 195, 160), 1, self.awesome)
    dxDrawText("Welcome to the private market interface.", self.x+85, self.y+27, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)
    dxDrawText("Your balance: $"..balance, self.x+85, self.y+50, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)

    dxDrawText("Options", self.x+35, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
    dxDrawText("Price", self.x+450, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)

    local addY = 0
    for _, value in ipairs(self.options) do
        if self:isInBox(self.x+25, self.y+110+addY, 500, 30) then
            self:roundedRectangle(self.x+25, self.y+110+addY, 500, 30, 9, tocolor(35, 35, 35, 225))
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                triggerServerEvent(tostring(value[3]), localPlayer, value[2])
                self:display()
            end
        else
            self:roundedRectangle(self.x+25, self.y+110+addY, 500, 30, 9, tocolor(35, 35, 35, 125))
        end
        dxDrawText(value[1], self.x+45, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
        dxDrawText("$"..value[2], self.x+460, self.y+117+addY, nil, nil, tocolor(145, 195, 160), 1, self.robotoBSmall)
        addY = addY + 32
    end

    if self:isInBox(self.x+100, self.y+self.h-15, self.w-200, 5) then
        dxDrawRectangle(self.x+100, self.y+self.h-15, self.w-200, 5, tocolor(255, 255, 255, 225))
        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
            self.tick = getTickCount()
            self:display()
        end
    else
        dxDrawRectangle(self.x+100, self.y+self.h-15, self.w-200, 5, tocolor(255, 255, 255, 125))
    end
end

function donates:display()
    if localPlayer:getData("lobby") then
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
end

function donates:roundedRectangle(x, y, width, height, radius, color)
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

function donates:isInBox(xS,yS,wS,hS)
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

donates:new()