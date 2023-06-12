local skinshop = class("skinshop")

function skinshop:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end,
        listUp = function(...) self:listUp(...) end,
        listDown = function(...) self:listDown(...) end,
    }

    self.icons = {
        male = exports.vn_fonts:getIcon("person"),
        female = exports.vn_fonts:getIcon("person-dress"),
        vip = "",
    }

    self.models = {
        {1, 66, "green 23", 415, 125},
        {1, 21, "black saints member", 175, 125},
        {1, 22, "scarface", 155, 125},
        {1, 23, "athletic black man", 95, 125},
        {1, 24, "bearded vest man", 140, 125},
        {1, 25, "bearded hoodie man", 160, 125},
        {1, 26, "duffy duck", 130, 125},
        {1, 27, "man in north face jacket", 210, 125},
        {1, 28, "hoodie man in puffy coat", 120, 125},
        {1, 29, "blond-haired man in a vest", 100, 125},
        {1, 30, "meadows 17", 105, 125},
        {1, 35, "striped t-shirt with white bandanna", 130, 125},
        {1, 36, "gas mask man", 155, 125},
        {1, 37, "gas mask man2", 270, 125},
        {1, 38, "black bandana man", 140, 125},
        {1, 39, "white hoodie man", 160, 125},
        {1, 40, "red hat man", 260, 125},
        {1, 41, "homeless", 90, 125},
        {1, 44, "man in sweater with blue hat", 210, 125},
        {1, 47, "man in camouflage pants", 100, 125},
        {1, 50, "tattooed skinny man", 130, 125},
        {1, 51, "black 13 number", 220, 125},
        {1, 56, "man with big military hat", 190, 125},
        {1, 57, "asian man wearing black", 160, 125},
        {1, 58, "asian man wearing red", 180, 125},
        {1, 60, "straight man", 90, 125},
        {1, 64, "man in camouflage pants", 180, 125},

        {2, 10, "sweet little girl", 160, 131},
        {2, 62, "girl in hat with blond hair", 300, 131},
        {2, 63, "blonde haired girl in black sweater", 230, 131},
        {2, 12, "crop top girl", 130, 131},
        {2, 13, "green-haired girl in a scottish skirt", 180, 131},
        {2, 14, "brunette sweet girl", 95, 131},
        {2, 15, "cute little girl with blue hair", 110, 131},
        {2, 16, "pretty girl with braided hair", 110, 131},
        {2, 17, "orange haired girl", 90, 131},
        {2, 18, "blonde haired girl in square sweatpants", 100, 131},
        {2, 31, "redhead black girl", 80, 131},
        {2, 32, "dady issues", 115, 131},
        {2, 43, "terrorist", 290, 131},
        {2, 45, "white bandana girl", 215, 131},
        {2, 49, "lara croft", 190, 131},
        {2, 55, "skinny black girl", 145, 131},

        {3, 2, "hoodie men", 0, 125},
        {3, 61, "girl in hat with blond hair", 0, 131},
        {3, 59, "north face hoodie men", 0, 125},
        {3, 48, "man with sunglasses", 0, 125},
        {3, 46, "camouflage gang member", 0, 125},
        {3, 1, "white shirt blonde hair", 0, 131},
        {3, 20, "daniel", 0, 125},
        {3, 7, "bad girl", 0, 131},
        {3, 19, "girl in jeans with orange hair", 0, 131},
        {3, 52, "Johnson 13", 0, 125},
        {3, 53, "skinny girl in white sweater", 0, 131},
        {3, 54, "terrorist 2", 0, 125},
    }

    --// NPC
    self.npc = createPed(62, 2142.0126953125, -1729.25390625, 13.541470527649, 99.946899414062)
    self.npc:setData("name", "skinshop")
    self.npc:setData("icon", "")
    self.npc:setDimension(1)
    self.npc.frozen = true
    setPedAnimation(self.npc, "BAR", "BARman_idle", -1, true, false, false)

    self.screen = Vector2(guiGetScreenSize())
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 10)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)

    addEventHandler("onClientPlayerWeaponFire", localPlayer, self._functions.display)
end

function skinshop:render()
    local y = self.screen.y/2-450/2
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(255, 255, 255, 45))
    self:roundedRectangle(50, y, 500, 450, 9, tocolor(25, 25, 25, 235))
    dxDrawText("", 60, y+10, nil, nil, tocolor(226, 161, 161), 1, self.awesome)
    dxDrawText("All outfits are listed below.", 120, y+20, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)
    local width = dxGetTextWidth(self.icons.male, 1, self.awesome)
    local height = dxGetFontHeight(1, self.awesome)
    if self.current == 1 then
        dxDrawText(self.icons.male, 70, y+75, nil, nil, tocolor(161, 165, 226, 245), 1, self.awesome)
    else
        if self:isInBox(70, y+75, width, height) then
            dxDrawText(self.icons.male, 70, y+75, nil, nil, tocolor(161, 165, 226, 155), 1, self.awesome)
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                self.current = 1
                self:refresh()
            end
        else
            dxDrawText(self.icons.male, 70, y+75, nil, nil, tocolor(161, 165, 226, 125), 1, self.awesome)
        end
    end
    local width = dxGetTextWidth(self.icons.female, 1, self.awesome)
    local height = dxGetFontHeight(1, self.awesome)
    if self.current == 2 then
        dxDrawText(self.icons.female, 100, y+75, nil, nil, tocolor(226, 161, 211, 245), 1, self.awesome)
    else
        if self:isInBox(100, y+75, width, height) then
            dxDrawText(self.icons.female, 100, y+75, nil, nil, tocolor(226, 161, 211, 155), 1, self.awesome)
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                self.current = 2
                self:refresh()
            end
        else
            dxDrawText(self.icons.female, 100, y+75, nil, nil, tocolor(226, 161, 211, 125), 1, self.awesome)
        end
    end
    local width = dxGetTextWidth(self.icons.vip, 1, self.awesome)
    local height = dxGetFontHeight(1, self.awesome)
    if self.current == 3 then
        dxDrawText(self.icons.vip, 470, y+75, nil, nil, tocolor(226, 211, 161, 245), 1, self.awesome)
    else
        if self:isInBox(470, y+75, width, height) then
            dxDrawText(self.icons.vip, 470, y+75, nil, nil, tocolor(226, 211, 161, 155), 1, self.awesome)
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                self.current = 3
                self:refresh()
            end
        else
            dxDrawText(self.icons.vip, 470, y+75, nil, nil, tocolor(226, 211, 161, 125), 1, self.awesome)
        end
    end
    local text
    if self.current == 1 then
        text = "Male Clothes"
    elseif self.current == 2 then
        text = "Female Clothes"
    elseif self.current == 3 then
        text = "Vip Clothes"
    end
    dxDrawText(text, 75, y+125, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
    dxDrawText("Price", 445, y+125, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
    local addY = 0
    local current = 0
    for index, value in ipairs(self.currentModels) do
        if index > self.currentRow and current < self.maxRow then
            if self:isInBox(70, y+150+addY, 460, 30) then
                self:roundedRectangle(70, y+150+addY, 460, 30, 9, tocolor(45, 45, 45, 225))
                self.preview.model = value[2]
                self.preview.walkingStyle = value[4]
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    triggerServerEvent("skinshop.buy", localPlayer, value[3], value[2], value[4],self.current)
                    self:stop()
                end
            else
                self:roundedRectangle(70, y+150+addY, 460, 30, 9, tocolor(45, 45, 45, 125))
            end
            dxDrawText(value[1], 100, y+150+addY+7, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText("$"..value[3], 470, y+150+addY+7, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            current = current + 1
            addY = addY + 32
        end
    end
    if self:isInBox(100, y+450-20, 400, 5) then
        dxDrawRectangle(100, y+450-20, 400, 5, tocolor(200, 200, 200, 225))
        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
            self.tick = getTickCount()
            self:stop()
        end
    else
        dxDrawRectangle(100, y+450-20, 400, 5, tocolor(200, 200, 200, 125))
    end
end

function skinshop:display(weapon,_,_,_,_,_,target)
    if localPlayer:getData('online') then
        if weapon == 24 then
            if target then
                if target == self.npc then
                    self.preview = createPed(localPlayer.model, 2144.25, -1725.98828125, 13.539078712463, 139)
                    self.preview:setDimension(1)
                    self.tick, self.current = 0,1
                    self.currentRow, self.maxRow = 0, 8
                    self:refresh()
                    setCursorPosition(self.screen.x/2, self.screen.y/2)
                    Camera.setMatrix(2143.1535644531, -1727.4730224609, 14.050200462341, 2143.7468261719, -1724.6694335938, 14.098284721375)
                    bindKey("mouse_wheel_up", "down", self._functions.listUp)
                    bindKey("mouse_wheel_down", "down", self._functions.listDown)
                    showChat(false)
                    showCursor(true)
                    addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
                end
            end
        end
    end
end

function skinshop:stop()
    self.preview:destroy()
    unbindKey("mouse_wheel_up", "down", self._functions.listUp)
    unbindKey("mouse_wheel_down", "down", self._functions.listDown)
    showChat(true)
    showCursor(false)
    removeEventHandler("onClientRender", root, self._functions.render)
    setCameraTarget(localPlayer, localPlayer)
end

function skinshop:refresh()
    self.currentModels = {}
    self.preview.model = localPlayer.model
    self.currentRow = 0
    for _, value in ipairs(self.models) do
        if value[1] == self.current then
            table.insert(self.currentModels, {value[3], value[2], value[4], value[5]})
        end
    end
end

function skinshop:listUp()
    if self.currentRow > 0 then
        self.currentRow = self.currentRow - 1
    end
end

function skinshop:listDown()
    local table = self.currentModels or {}
    if self.currentRow < #table - self.maxRow then
        self.currentRow = self.currentRow + 1
    end
end

function skinshop:roundedRectangle(x, y, width, height, radius, color)
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

function skinshop:isInBox(xS,yS,wS,hS)
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

skinshop:new()