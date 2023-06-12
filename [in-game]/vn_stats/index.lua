local kd = new('kd')

function kd.prototype.____constructor(self)
    self._function = {}
    self._function.render = function(...) self:render(self) end
    self._function.anim = function(...) self:anim(self) end
    self.screen = Vector2(guiGetScreenSize())
    self.w, self.h = 250, 65
    self.x, self.y = self.screen.x/2-self.w/2, self.screen.y/2-self.h/2
    self.font = exports.vn_fonts:getFont("RobotoB", 9)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 25)
    self.alpha = 245

    addEventHandler("onClientRender", root, self._function.render, true, "low-99999")
    Timer(self._function.anim, 750, 0)
end

function kd.prototype.render(self)
    if localPlayer:getData("online") then
        self:roundedRectangle(self.screen.x-self.w-15-10,self.screen.y-self.h-25,self.w+10,self.h,9,tocolor(5,5,5,100))
        self:roundedRectangle(self.screen.x-self.w-15,self.screen.y-self.h-25,self.w,self.h,9,tocolor(15,15,15,175))
        local kill = localPlayer:getData("kill") or 0
        local money = localPlayer:getData("money") or 0
        local death = localPlayer:getData("death") or 0
        dxDrawText("",self.screen.x-self.w-15+15,self.screen.y-self.h-25+10,nil,nil,tocolor(145,145,145,self.alpha),1,self.awesome)
        dxDrawText("Deaths: "..death.."\nKills: "..kill.."\nMoney: $"..exports.vn_utils:formatMoney(money).."",self.screen.x-self.w-15+75,self.screen.y-self.h-25+10,nil,nil,tocolor(145,145,145,245),1,self.font)
    end
end

function kd.prototype.anim(self)
    if self.alpha == 245 then
        self.alpha = 125
    else
        self.alpha = 245
    end
end

function kd.prototype:roundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end

load(kd)