local triggerServerEvent = triggerServerEvent
local getKeyState = getKeyState
local getTickCount = getTickCount
local getDistanceBetweenPoints3D = getDistanceBetweenPoints3D
local dxDrawRectangle = dxDrawRectangle
local localPlayer = getLocalPlayer()
local guiGetScreenSize = guiGetScreenSize
local math = math
local tocolor = tocolor
local toggleControl = toggleControl
local ball = new('ball')

function ball.prototype.____constructor(self)
    self._function = {}
    self._function.play = function(...) self:play(self) end
    self._function.render = function(...) self:render(self) end
    self.screen = Vector2(guiGetScreenSize())
    self.controls = {{'fire'},{'aim_weapon'},{'enter_exit'},}
    self.active,self.min,self.max = false, 0+10, 300-10
    self.pot = Object(947, 2109.134765625, -1740.7802734375, 13.566576004028+1.2, 0, 0, 314)
    self.pot:setDimension(1)
    self.pickup = Pickup(2113.94921875, -1741.3994140625, 13.567180633545, 3, 3065)
    self.pickup:setDimension(1)
    self.pickup:setData("information", "/play")
    addCommandHandler('play', self._function.play)
end

function ball.prototype.play(self)
    if localPlayer.dimension == self.pot.dimension then
        if getDistanceBetweenPoints3D(localPlayer.position.x,localPlayer.position.y,localPlayer.position.z,self.pot.position.x,self.pot.position.y,self.pot.position.z) < 10 then
            if self.active then
                self:stop(self)
                triggerServerEvent('detach.ball', localPlayer)
                for index, value in ipairs(self.controls) do
                    toggleControl(value[1], true)
                end
            else
                triggerServerEvent('attach.ball', localPlayer)
                for index, value in ipairs(self.controls) do
                    toggleControl(value[1], false)
                end
                self.active,self.count,self.x,self.charge,self.tick,self.click,self.shoot = true, 0, 150, 0, 0, 0, false
                self.timer = Timer(self._function.render,0,0)
            end
        end
    end
end

function ball.prototype.render(self)
    if getDistanceBetweenPoints3D(localPlayer.position.x,localPlayer.position.y,localPlayer.position.z,self.pot.position.x,self.pot.position.y,self.pot.position.z) < 10 then
        self:check(self)
        dxDrawRectangle(self.screen.x/2-150+self.x-1, self.screen.y-218-1, 10+2, 50+2, tocolor(0,0,0))
        dxDrawRectangle(self.screen.x/2-150+self.x, self.screen.y-218, 10, 50, tocolor(25,100,25))
        dxDrawRectangle(self.screen.x/2-150-1, self.screen.y-200-1, 300+2, 15+2, tocolor(0,0,0))
        dxDrawRectangle(self.screen.x/2-150, self.screen.y-200, 300, 15, tocolor(15,15,15))
        dxDrawRectangle(self.screen.x/2-150, self.screen.y-200, self.charge, 15, tocolor(100,25,25))
        if self.tick+150 <= getTickCount() then
            self.tick = getTickCount()
            self.chance = math.random(1,3)
            if self.chance == 1 then
                self.x = self.x - math.random(1,5)
            elseif self.chance == 2 then
                self.x = self.x + math.random(1,5)
            end
        end
        if self.x >= self.max then
            self.x = self.max
        elseif self.x <= self.min then
            self.x = self.min
        end
        if getKeyState('mouse2') then
            if self.charge >= 300 then
                self.charge = 300
            else
                self.charge = self.charge + 2
            end
        else
            if self.charge <= 0 then
                self.charge = 0
            else
                self.charge = self.charge - 2
            end
        end
        if getKeyState('mouse1') and self.click+500 <= getTickCount() then
            self.click = getTickCount()
            triggerServerEvent('shoot.ball', localPlayer, self.shoot)
            self:stop()
        end
    else
        triggerServerEvent('detach.ball', localPlayer)
        for index, value in ipairs(self.controls) do
            toggleControl(value[1], true)
        end
        self:stop(self)
    end
end

function ball.prototype.check(self)
    self.shoot = false
    for i = 0, 10 do
        if self.charge == self.x+i then
            self.shoot = true
        end
    end
end

function ball.prototype.stop(self)
    self.active = false
    if self.timer.valid then
        self.timer:destroy()
    end
end

load(ball)