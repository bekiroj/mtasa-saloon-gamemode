local playerlist = class("playerlist")

function playerlist:init()
    self._functions = {
        render = function(...) self:render(...) end,
        active = function(...) self:active(...) end,
        inactive = function(...) self:inactive(...) end,
        listUp = function(...) self:listUp(...) end,
        listDown = function(...) self:listDown(...) end,
    }
    self.icons = {
        logo = ""
    }

    self.screen = Vector2(guiGetScreenSize())
    self.x, self.y, self.w, self.h = self.screen.x/2-550/2, self.screen.y/2-400/2, 550, 400
    self.robotoB = exports.vn_fonts:getFont("RobotoB", 12)
    self.robotoBSmall = exports.vn_fonts:getFont("RobotoB", 10)
    self.roboto = exports.vn_fonts:getFont("Roboto", 10)
    self.awesome = exports.vn_fonts:getFont("AwesomeSolid", 22)

    bindKey("tab", "down", self._functions.active)
    bindKey("tab", "up", self._functions.inactive)
end

function playerlist:render()
    dxDrawRectangle(0, 0, self.screen.x, self.screen.y, tocolor(200, 200, 200, 25))
    self:roundedRectangle(self.x, self.y, self.w, self.h, 14, tocolor(15, 15, 15, 245))
    dxDrawText(self.icons.logo, self.x+20, self.y+27, nil, nil, tocolor(125, 125, 125), 1, self.awesome)
    dxDrawText("All players are listed below.  ("..#self.players..")", self.x+85, self.y+32, nil, nil, tocolor(200, 200, 200), 1, self.robotoB)

    dxDrawText("(ID) Name", self.x+35, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
    dxDrawText("Kills", self.x+320, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)
    dxDrawText("Deaths", self.x+420, self.y+85, nil, nil, tocolor(200, 200, 200), 1, self.robotoBSmall)

    local addY = 0
    local current = 0
    for index, value in ipairs(self.players) do
        if value:getData("online") then
            if index > self.currentRow and current < self.maxRow then
                self:roundedRectangle(self.x+25, self.y+110+addY, 500, 30, 9, tocolor(35, 35, 35, 225))
                local name = "("..value:getData("dbid")..") "..value.name.."" or "Unknown"
                local kill = value:getData("kill") or 0
                local death = value:getData("death") or 0
                local r, g, b = getPlayerNametagColor(value)
                dxDrawText(name, self.x+45, self.y+117+addY, nil, nil, tocolor(r, g, b), 1, self.robotoBSmall)
                dxDrawText(kill, self.x+330, self.y+117+addY, nil, nil, tocolor(r, g, b), 1, self.robotoBSmall)
                dxDrawText(death, self.x+430, self.y+117+addY, nil, nil, tocolor(r, g, b), 1, self.robotoBSmall)
                addY = addY + 32
                current = current + 1
            end
        end
    end
end

function playerlist:active()
    if localPlayer:getData('online') then
        self.players = {}
        self.currentRow, self.maxRow = 0, 8
        for _, value in ipairs(Element.getAllByType("player")) do
            table.insert(self.players, value)
        end
        table.sort(self.players, function(a,b)
            self.idA = a:getData("dbid") or 0
            self.idB = b:getData("dbid") or 0
            if a == localPlayer then
                self.idA = -1
            elseif b == localPlayer then
                self.idB = -1
            end
            return tonumber(self.idA) < tonumber(self.idB)
        end)
        showChat(false)
        bindKey("mouse_wheel_up", "down", self._functions.listUp)
        bindKey("mouse_wheel_down", "down", self._functions.listDown)
        addEventHandler("onClientRender", root, self._functions.render, true, "low-9999")
    end
end

function playerlist:inactive()
    if localPlayer:getData('online') then
        self.players = {}
        showChat(true)
        unbindKey("mouse_wheel_up", "down", self._functions.listUp)
        unbindKey("mouse_wheel_down", "down", self._functions.listDown)
        removeEventHandler("onClientRender", root, self._functions.render)
    end
end

function playerlist:listUp()
    if self.currentRow > 0 then
        self.currentRow = self.currentRow - 1
    end
end

function playerlist:listDown()
    local table = self.players or {}
    if self.currentRow < #table - self.maxRow then
        self.currentRow = self.currentRow + 1
    end
end

function playerlist:roundedRectangle(x, y, width, height, radius, color)
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

playerlist:new()