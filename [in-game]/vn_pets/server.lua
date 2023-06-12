local conn = exports.vn_mysql:getConn()
local utils = exports.vn_utils
local _print = outputDebugString
local pets = {}

function remove(source)
    for index, value in ipairs(pets) do
        if value[1]:getData('owner') == source:getData('dbid') then
            value[1]:destroy()
            pets[index] = nil
            collectgarbage("collect")
        end
    end
end

function create(player)
    local dbid = player:getData("dbid")
    dbExec(conn, "INSERT INTO pets SET own='"..(dbid).."', model='312', name='Unspecified'")
    utils:sendChat(player, "You bought a new pet, /pet")
    _print("!PETS - created pet to "..player.name)
end

addEvent("pets.call", true)
addEventHandler("pets.call", root, function(id)
    local id = tonumber(id) or 0
    remove(source)
    dbQuery(
        function(qh, player)
            local res, rows, _ = dbPoll(qh, 0)
            if rows > 0 then
                local x, y, z = player.position.x, player.position.y, player.position.z
                local dim = player.dimension
                local pID = player:getData("dbid")
                for _, row in ipairs(res) do
                    local i = #pets + 1
                    if not pets[i] then
                        pets[i] = {}
                    end
                    pets[i][1] = createPed(row.model,x,y+1,z+0.5)
                    if row.model == 309 then
                        pets[i][1].walkingStyle = 135
                    end
                    pets[i][1]:setDimension(dim)
                    pets[i][1]:setData("pet", true)
                    pets[i][1]:setData("owner", tonumber(pID))
                    pets[i][1]:setData("owner.element", player)
                    pets[i][1]:setData("name", row.name)
                end
            else
                _print("!PETS - error (41)")
            end
        end,
    {source}, conn, "SELECT * FROM pets WHERE id = ?", id)
end)

addCommandHandler("pet", function(source)
    if source:getData("online") then
        if source:getData("lobby") then
            local dbid = source:getData("dbid") or 0
            dbQuery(
                function(qh, player)
                    local res, rows, _ = dbPoll(qh, 0)
                    local pets = {}
                    if rows > 0 then
                        for _, row in ipairs(res) do
                            table.insert(pets, {row.id, row.model, row.name})
                        end
                        triggerClientEvent(player, "pets.display", player, pets)
                    else
                        utils:sendChat(player, "You don't have any pets, buy one first, /donate")
                    end
                end,
            {source}, conn, "SELECT * FROM pets WHERE own = ?", dbid)
        end
    end
end)

addEvent("pets.edit", true)
addEventHandler("pets.edit", root, function(id, name, model)
    local id = tonumber(id) or 0
    if name == "" then
        name = "Unspecified"
    end
    dbExec(conn, "UPDATE `pets` SET `name`='"..(name).."', `model`='"..(model).."' WHERE `id`='"..(id).."'")
    utils:sendChat(source, "Changes to your pet have been saved.")
end)

addEventHandler("onPlayerQuit", root, function()
    remove(source)
end)