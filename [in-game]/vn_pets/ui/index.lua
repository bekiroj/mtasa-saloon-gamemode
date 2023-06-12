local pets = class("pets")

function pets:init()
    self._functions = {
        display = function(...) self:display(...) end,
        render = function(...) self:render(...) end,
        write = function(...) self:write(...) end,
        textRectangle = function(...) self:textRectangle(...) end,
        listUp = function(...) self:listUp(...) end,
        listDown = function(...) self:listDown(...) end,
    }

    self.icons = {
        logo = exports.vn_fonts:getIcon("pet"),
        edit = exports.vn_fonts:getIcon("pen"),
        load = exports.vn_fonts:getIcon("load"),
        save = exports.vn_fonts:getIcon("share"),
    }

    self.textures = {
        {"moo", 304},
        {"hmori", 305},
        {"pika", 306},
        {"lashka", 307},
        {"pengu", 308},
        {"anime", 309},
        {"short", 310},
        {"dog1", 311},
        {"dog2", 312},
    }

    for _, value in ipairs(self.textures) do
        local txd = EngineTXD('assets/'..value[1]..'.txd')
        local dff = EngineDFF('assets/'..value[1]..'.dff')
        txd:import(value[2])
        dff:replace(value[2])
    end

    self.models = {
        {304},
        {305},
        {306},
        {307},
        {308},
        {309},
        {310},
        {311},
        {312},
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-550/2, self.screen.y/2-400/2, 550, 400
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 12)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.roboto = exports.vn_fonts:getFont("Roboto", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)
    self.awesomeSmall = exports.vn_fonts:getFont("AwesomeSolid", 11)
    self.awesomeSmall2 = exports.vn_fonts:getFont("AwesomeSolid", 15)

    addEvent("pets.display", true)
    addEventHandler("pets.display", root, self._functions.display)
end

function pets:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+25, self.y+22, nil, nil, tocolor(125, 125, 125), 1, self.awesome)
    dxDrawText("All pets are listed below.", self.x+85, self.y+29, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)

    if self.load <= 600 then
        dxDrawText(self.icons.load, self.screen.x/2, self.screen.y/2-25, nil, nil, tocolor(225,225,225), 1, self.awesome, "center", "center", false, false, false, false, false, self.load)
        self.load = self.load + 5
    else
        if self.selected > 0 then
            dxDrawText("Set a new name for your pet", self.x+175, self.y+100, nil, nil, tocolor(185, 185, 185), 1, self.robotoB)

            local width = dxGetTextWidth(self.name, 1, self.robotoBSmall)
            dxDrawText(self.name, self.screen.x/2-(width/2), self.y+135, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText("l", self.screen.x/2-(width/2)+width, self.y+135, nil, nil, tocolor(175, 175, 175, self.alpha), 1, self.robotoBSmall)

            if getKeyState('backspace') and self.tick+120 <= getTickCount() then
                self.tick = getTickCount()
                self.fistPart = self.name:sub(0, string.len(self.name)-1)
                self.lastPart = self.name:sub(string.len(self.name)+1, #self.name)
                self.name = self.fistPart..self.lastPart
            end

            dxDrawText("Set a new model for your pet", self.x+175, self.y+190, nil, nil, tocolor(185, 185, 185), 1, self.robotoB)
            local addX = 0
            local width = dxGetTextWidth(self.icons.logo, 1, self.awesomeSmall2)
            local height = dxGetFontHeight(1, self.awesomeSmall2)
            for _, value in ipairs(self.models) do
                if self.model == value[1] then
                    dxDrawText(self.icons.logo, self.screen.x/2+150-(addX/2), self.y+225, nil, nil, tocolor(222, 173, 124, 245), 1, self.awesomeSmall2)
                else
                    if self:isInBox(self.screen.x/2+150-(addX/2), self.y+225, width, height) then
                        dxDrawText(self.icons.logo, self.screen.x/2+150-(addX/2), self.y+225, nil, nil, tocolor(222, 173, 124, 185), 1, self.awesomeSmall2)
                        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                            self.tick = getTickCount()
                            self.model = value[1]
                        end
                    else
                        dxDrawText(self.icons.logo, self.screen.x/2+150-(addX/2), self.y+225, nil, nil, tocolor(125, 125, 125, 125), 1, self.awesomeSmall2)
                    end
                end
                addX = addX + 75
            end
            local width = dxGetTextWidth(self.icons.save, 1, self.awesome)
            local height = dxGetFontHeight(1, self.awesome)
            if self:isInBox(self.screen.x/2-width/2, self.y+280, width, height) then
                dxDrawText(self.icons.save, self.screen.x/2-width/2, self.y+280, nil, nil, tocolor(125, 125, 125, 225), 1, self.awesome)
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    triggerServerEvent("pets.edit", localPlayer, self.selected, self.name, self.model)
                    self:display()
                end
            else
                dxDrawText(self.icons.save, self.screen.x/2-width/2, self.y+280, nil, nil, tocolor(125, 125, 125, 125), 1, self.awesome)
            end
        else
            dxDrawText("ID", self.x+35, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText("Model", self.x+125, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            dxDrawText("Name", self.x+300, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
            local current = 0
            local addY = 0
            for index, value in ipairs(self.pets) do
                if index > self.currentRow and current < self.maxRow then
                    if self:isInBox(self.x+25, self.y+110+addY, 450, 30) then
                        self:roundedRectangle(self.x+25, self.y+110+addY, 450, 30, 9, tocolor(35, 35, 35, 225))
                        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                            self.tick = getTickCount()
                            triggerServerEvent("pets.call", localPlayer, value[1])
                            self:display()
                        end
                    else
                        self:roundedRectangle(self.x+25, self.y+110+addY, 450, 30, 9, tocolor(35, 35, 35, 125))
                    end
                    dxDrawText(value[1], self.x+45, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
                    dxDrawText(value[2], self.x+125, self.y+117+addY, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
                    dxDrawText(value[3], self.x+300, self.y+117+addY, nil, nil, tocolor(222, 173, 124), 1, self.robotoBSmall)

                    if self:isInBox(self.x+25+455, self.y+110+addY, 50, 30) then
                        self:roundedRectangle(self.x+25+455, self.y+110+addY, 50, 30, 9, tocolor(35, 35, 35, 225))
                        if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                            self.tick = getTickCount()
                            self.name, self.model = value[3], value[2]
                            self.selected = value[1]
                        end
                    else
                        self:roundedRectangle(self.x+25+455, self.y+110+addY, 50, 30, 9, tocolor(35, 35, 35, 125))
                    end
                    dxDrawText(self.icons.edit, self.x+25+455+15, self.y+115+addY, nil, nil, tocolor(200, 200, 200), 1, self.awesomeSmall)
                    current = current + 1
                    addY = addY + 32
                end
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
    end
end

function pets:display(results)
    local results = results or {}
    self.pets = results
    if self.active then
        self.active = false
        killTimer(self.timer)
        showCursor(false)
        showChat(true)
        unbindKey("mouse_wheel_up", "down", self._functions.listUp)
        unbindKey("mouse_wheel_down", "down", self._functions.listDown)
        removeEventHandler("onClientCharacter", root, self._functions.write)
        removeEventHandler("onClientRender", root, self._functions.render)
    else
        self.active, self.load, self.tick, self.selected = true, 0, 0, 0
        self.currentRow, self.maxRow = 0, 8
        self.name, self.model = "", ""
        self.timer = Timer(self._functions.textRectangle, 275, 0)
        showCursor(true)
        showChat(false)
        bindKey("mouse_wheel_up", "down", self._functions.listUp)
        bindKey("mouse_wheel_down", "down", self._functions.listDown)
        addEventHandler("onClientCharacter", root, self._functions.write)
        addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
    end
end

function pets:listUp()
    if self.currentRow > 0 then
        self.currentRow = self.currentRow - 1
    end
end

function pets:listDown()
    local table = self.pets or {}
    if self.currentRow < #table - self.maxRow then
        self.currentRow = self.currentRow + 1
    end
end

function pets:write(character)
    if self.selected > 0 then
        if string.len(self.name) <= 10 then
            self.name = ""..self.name..""..character
        end
        local effect = Sound("assets/key.mp3")
        effect:setVolume(0.5)
    end
end

function pets:textRectangle()
    if self.selected > 0 then
        if self.alpha == 225 then
            self.alpha = 0
        else
            self.alpha = 225
        end
    end
end

function pets:roundedRectangle(x, y, width, height, radius, color)
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

function pets:isInBox(xS,yS,wS,hS)
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

pets:new()