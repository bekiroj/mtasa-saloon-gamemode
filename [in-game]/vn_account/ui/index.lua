local account = class("account")

function account:init()
    self._functions = {
        render = function(...) self:render(...) end,
        write = function(...) self:write(...) end,
        remembered = function(...) self:remembered(...) end,
        textRectangle = function(...) self:textRectangle(...) end,
        error = function(...) self:error(...) end,
        killError = function(...) self:killError(...) end,
        success = function(...) self:success(...) end
    }

    self.icons = {
        load = exports.vn_fonts:getIcon("load"),
        user = exports.vn_fonts:getIcon("user"),
        key = exports.vn_fonts:getIcon("key"),
        login = exports.vn_fonts:getIcon("login"),
        register = exports.vn_fonts:getIcon("person-circle-plus")
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-250/2, self.screen.y/2-30/2, 250, 30
    self.awesomeBig = exports.vn_fonts:getFont("AwesomeSolid", 20)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 12)
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 10)
    self.robotoBig = exports.vn_fonts:getFont("RobotoB", 11)


    if not localPlayer:getData("online") then
        self:display()
    end
    self:start()
    self:engine()
end

function account:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(25, 25, 25))
    dxDrawImage(0, 0, 500, 500, "assets/logo.png")
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(25, 25, 25,125))

    local max = 25
    if self.anim <= max then
        self.anim = self.anim + 5
    end
    local widthError = dxGetTextWidth(self.err, 1, self.robotoB)
    dxDrawText(self.err, self.screen.x/2-widthError/2, self.screen.y-self.anim, nil, nil, tocolor(175, 75, 75), 1, self.robotoB)

    if self.load <= 1500 then
        dxDrawText(self.icons.load, self.screen.x/2, self.screen.y/2, nil, nil, tocolor(225,225,225), 1, self.awesomeBig, "center", "center", false, false, false, false, false, self.load)
        self.load = self.load + 5
    else
        if getKeyState('backspace') and self.tick+120 <= getTickCount() then
            self.tick = getTickCount()
            if self.selected == 1 then
                self.fistPart = self.username:sub(0, string.len(self.username)-1)
                self.lastPart = self.username:sub(string.len(self.username)+1, #self.username)
                self.username = self.fistPart..self.lastPart
            elseif self.selected == 2 then
                self.fistPart = self.password:sub(0, string.len(self.password)-1)
                self.lastPart = self.password:sub(string.len(self.password)+1, #self.password)
                self.password = self.fistPart..self.lastPart
            end
        end
        if self.page == 1 then
            local text = "Welcome, I think you're new here, please create a new account."
            local width = dxGetTextWidth(text, 1, self.robotoBig)
            dxDrawText(text, self.screen.x/2-width/2, self.y-40, nil, nil, tocolor(225, 225, 225), 1, self.robotoBig)
        elseif self.page == 2 then
            local text = "Welcome back "..self.username..", good to see you here."
            local width = dxGetTextWidth(text, 1, self.robotoBig)
            dxDrawText(text, self.screen.x/2-width/2, self.y-40, nil, nil, tocolor(225, 225, 225), 1, self.robotoBig)
        end
        if self.selected == 1 then
            self:roundedRectangle(self.x, self.y, self.w, self.h, 7, tocolor(102,102,102, 175))
            local width = dxGetTextWidth(self.username, 1, self.robotoB)
            dxDrawText("l", self.x+40+width, self.y+6, nil, nil, tocolor(200, 200, 200, self.alpha), 1, self.robotoB)
        else
            if self:isInBox(self.x, self.y, self.w, self.h) then
                self:roundedRectangle(self.x, self.y, self.w, self.h, 7, tocolor(102,102,102, 175))
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    self.selected = 1
                    if self.username == "username" then
                        self.username = ""
                    end
                end
            else
                self:roundedRectangle(self.x, self.y, self.w, self.h, 7, tocolor(102,102,102, 125))
            end
        end
        dxDrawText(self.icons.user, self.x+5, self.y+5, nil, nil, tocolor(200, 200, 200), 1, self.awesome)
        dxDrawText(self.username, self.x+40, self.y+6, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)

        if self.selected == 2 then
            self:roundedRectangle(self.x, self.y+(self.h+5), self.w, self.h, 7, tocolor(102,102,102, 175))
            local width = dxGetTextWidth(string.gsub(self.password, ".", "*"), 1, self.robotoB)
            dxDrawText("l", self.x+40+width, self.y+(self.h+5)+6, nil, nil, tocolor(200, 200, 200, self.alpha), 1, self.robotoB)
        else
            if self:isInBox(self.x, self.y+(self.h+5), self.w, self.h) then
                self:roundedRectangle(self.x, self.y+(self.h+5), self.w, self.h, 7, tocolor(102,102,102, 175))
                if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                    self.tick = getTickCount()
                    self.selected = 2
                    if self.password == "password" then
                        self.password = ""
                    end
                end
            else
                self:roundedRectangle(self.x, self.y+(self.h+5), self.w, self.h, 7, tocolor(102,102,102, 125))
            end
        end
        dxDrawText(self.icons.key, self.x+5, self.y+(self.h+5)+5, nil, nil, tocolor(200, 200, 200), 1, self.awesome)
        dxDrawText(string.gsub(self.password, ".", "*"), self.x+40, self.y+(self.h+5)+6, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)

        local icon
        if self.page == 1 then
            icon = self.icons.register
        elseif self.page == 2 then
            icon = self.icons.login
        end
        local width = dxGetTextWidth(icon, 1, self.awesomeBig)
        local height = dxGetFontHeight(1, self.awesomeBig)
        if self:isInBox(self.x+self.w+10, self.y+(self.h+5)+5, width, height) then
            dxDrawText(icon, self.x+self.w+10, self.y+(self.h+5)+5, nil, nil, tocolor(200, 200, 200, 200), 1, self.awesome)
            if getKeyState('mouse1') and self.tick+400 <= getTickCount() then
                self.tick = getTickCount()
                if self.page == 1 then
                    triggerServerEvent("account.register", localPlayer, self.username, self.password)
                elseif self.page == 2 then
                    triggerServerEvent("account.login", localPlayer, self.username, self.password)
                end
            end
        else
            dxDrawText(icon, self.x+self.w+10, self.y+(self.h+5)+5, nil, nil, tocolor(200, 200, 200, 125), 1, self.awesome)
        end
    end
end

function account:display()
    if self.active then
        self.active = false
        killTimer(self.timer)
        showChat(true)
        showCursor(false)
        setPlayerHudComponentVisible("crosshair", true)
        removeEventHandler("onClientRender", root, self._functions.render)
        removeEventHandler("onClientCharacter", root, self._functions.write)
    else
        self.active, self.load, self.page, self.tick, self.selected, self.anim = true, 0, 1, 0, 0, 0
        self.username, self.password, self.err = "username", "password", ""
        setPlayerHudComponentVisible("all", false)
        triggerServerEvent("account.remember", localPlayer)
        Camera.fade(true)
        showChat(false)
        showCursor(true)
        for _ = 1, 25 do
            outputChatBox(" ")
        end
        self.timer = Timer(self._functions.textRectangle, 275, 0)
        addEventHandler("onClientRender", root, self._functions.render)
        addEventHandler("onClientCharacter", root, self._functions.write)
    end
end

function account:roundedRectangle(x, y, width, height, radius, color)
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

function account:isInBox(xS,yS,wS,hS)
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

function account:success()
    self:display()
end

function account:killError()
    self.err = ""
    self.anim = 0
end

function account:error(err)
    self.err = err or "nope :("
    self.anim = 0
    if isTimer(self.killer) then
        killTimer(self.killer)
    end
    local effect = Sound("assets/err.mp3")
    effect:setVolume(0.5)
    self.killer = Timer(self._functions.killError, 3500, 1)
end

function account:remembered(username, password)
    self.page = 2
    self.username = username
    self.password = password
end

function account:textRectangle()
    if self.alpha == 225 then
        self.alpha = 0
    else
        self.alpha = 225
    end
end

function account:write(character)
    if self.selected == 1 then
        if string.len(self.username) <= 20 then
            self.username = ""..self.username..""..character
        end
        local effect = Sound("assets/key.mp3")
        effect:setVolume(0.5)
    elseif self.selected == 2 then
        if string.len(self.password) <= 20 then
            self.password = ""..self.password..""..character
        end
        local effect = Sound("assets/key.mp3")
        effect:setVolume(0.5)
    end
end

function account:start()
    addEvent("account.remembered", true)
    addEventHandler("account.remembered", root, self._functions.remembered)
    addEvent("account.error", true)
    addEventHandler("account.error", root, self._functions.error)
    addEvent("account.success", true)
    addEventHandler("account.success", root, self._functions.success)
end

function account:engine()
    Engine.setAsynchronousLoading(true, true)
    setFarClipDistance(5000)
    setFogDistance(5000)
    for i = 1, 10000 do
        engineSetModelLODDistance(i, 1000)
    end
    isWorldSpecialPropertyEnabled('extraairresistance', false)
    setAmbientSoundEnabled('gunfire', false )
    setDevelopmentMode(false)
    setPedTargetingMarkerEnabled(false)
    toggleControl('radar', false)
    guiSetInputMode('no_binds_when_editing')
    setDevelopmentMode(true)
    showCol(true)
end

account:new()