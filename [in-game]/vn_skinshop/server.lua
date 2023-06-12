addEvent("skinshop.buy", true)
addEventHandler("skinshop.buy", root, function(price,model,walking,vip)
    if vip == 3 then
        if source:getData("vip") then else
            exports.vn_utils:sendChat(source, "You must be a VIP to get this outfit.")
            return
        end
    end
    if exports.vn_utils:takeMoney(source, price) then
        exports.vn_utils:sendChat(source, "you have successfully received the outfit you selected.")
        source.model = model
        source.walkingStyle = walking
    else
        exports.vn_utils:sendChat(source, "You have to pay $"..price.." to get this outfit.")
    end
end)