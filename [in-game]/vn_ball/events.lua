local exports = exports
local addEvent = addEvent
local addEventHandler = addEventHandler
local toggleControl = toggleControl
local collectgarbage = collectgarbage
local root = root
local math = math
local attachment = exports.vn_pAttach
local balls = {}

local goal = function(player)
    if player then
        attachment:detach(balls[player])
        balls[player]:setPosition(player.position.x,player.position.y,player.position.z)
        balls[player]:move(500, 2109.416015625, -1740.474609375, 13.566277503967+2.1)
        Timer(function(object)
            object:move(500, object.position.x,object.position.y,object.position.z-3)
        end, 500, 1, balls[player])
        Timer(function(element)
            exports.vn_utils:sendChat(element, "I'll fire 25 bucks for this shot, man.")
            exports.vn_utils:giveMoney(element, 25)
            element:setAnimation()
            element.frozen = false
        end, 500, 1, player)
    end
end

local didnt = function(player)
    if player then
        attachment:detach(balls[player])
        balls[player]:setPosition(player.position.x,player.position.y,player.position.z)
        balls[player]:move(500, 2109.416015625, -1740.474609375+math.random(1,2), 13.566277503967+2.1)
        Timer(function(object)
            object:move(500, object.position.x,object.position.y,object.position.z-3)
        end, 500, 1, balls[player])
        Timer(function(element)
            exports.vn_utils:sendChat(element, "you're screwing up.")
            element:setAnimation()
            element.frozen = false
        end, 500, 1, player)
    end
end

addEvent('attach.ball', true)
addEventHandler('attach.ball', root, function()
    if source then
        if not balls[source] then
            balls[source] = Object(3065, 0, 0, 0)
        end
        attachment:attach(balls[source], source, 25, -0.05, 0.02, 0.19, 0, -190, -110)
        source.frozen = true
        source:setAnimation('bsktball','BBALL_pickup',true,false)
        Timer(function(player)
            if player then
                player:setAnimation()
                player.frozen = false
            end
        end, 1000, 1, source)
    end
end)

addEvent('detach.ball', true)
addEventHandler('detach.ball', root, function()
    if source then
        if balls[source] then
            attachment:detach(balls[source])
            balls[source]:destroy()
            balls[source] = nil
            collectgarbage('collect')
        end
    end
end)

addEvent('shoot.ball', true)
addEventHandler('shoot.ball', root, function(shoot)
    if source then
        source.frozen = true
        source:setAnimation('bsktball','BBALL_Jump_Shot',true,false)
        if shoot then
            Timer(function(player)
                goal(player)
            end, 800, 1, source)
        else
            Timer(function(player)
                didnt(player)
            end, 800, 1, source)
        end
        local controls = {{'fire'},{'aim_weapon'},{'enter_exit'},}
        for index, value in ipairs(controls) do
            toggleControl(source, value[1], true)
        end
    end
end)