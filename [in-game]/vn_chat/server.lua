function rgbToHex(red, green, blue, alpha)

	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end

function check(player,target)
    local sgang = player:getData("gangwars") or 0
    local tgang = target:getData("gangwars") or 0
    if player:getData("lobby") then
        if target:getData("lobby") then
            return true
        else
            return false
        end
    elseif sgang > 0 then
        if tgang > 0 then
            return true
        else
            return false
        end
    elseif player:getData("deathmatch") > 0 then
        if target:getData("deathmatch") == player:getData("deathmatch") then
            return true
        else
            return false
        end
    end
end

function sendMessage(source, message)
    local gang = source:getData("gangwars") or 0
    local r, g, b = getPlayerNametagColor(source)
    for _, player in ipairs(Element.getAllByType("player")) do
        if player:getData("online") then
            if check(source,player) then
                if gang > 0 then
                    player:outputChat(""..rgbToHex(r, g, b)..""..source.name..":#FFFFFF "..message, 255, 255, 255, true)
                elseif source:getData("duty") then
                    player:outputChat("#DA3636[Admin] "..source.name..":#FFFFFF "..message, 255, 255, 255, true)
                elseif source:getData("vip") then
                    player:outputChat("#D0D463[VIP] "..source.name..":#FFFFFF "..message, 255, 255, 255, true)
                else
                    player:outputChat(""..source.name..": "..message, 255, 255, 255, true)
                end
            end
        end
    end
end

addEventHandler("onPlayerChat", root, function(message)
    if source:getData("online") then
        sendMessage(source, message)
        cancelEvent()
    else
        cancelEvent()
    end
end)