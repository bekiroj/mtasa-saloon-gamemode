local launcher = {}
launcher.__index = launcher

function launcher:new(name, priority)
    local resource = {}
    setmetatable(resource, launcher)
    resource.name = name
    resource.priority = priority or 0
    return resource
end

function launcher:launch()
    print("Starting "..self.name)
    Resource.getFromName(self.name):start()
end

-- Resource listesi
local resources = {
    -- isim, sıra/öncelik
    launcher:new("vn_mysql", 1),
    launcher:new("vn_fonts", 2),
    launcher:new("vn_information", 3),
    launcher:new("vn_utils", 4),
    launcher:new("vn_anticheat", 5),
    launcher:new("vn_pAttach", 6),
    launcher:new("vn_access", 7),
    launcher:new("vn_debug", 10),
    launcher:new("vn_account", 11),
    launcher:new("vn_cursor", 12),
    launcher:new("vn_weapon", 13),
    launcher:new("vn_ball", 14),
    launcher:new("vn_dgs", 15),
    launcher:new("vn_timecyc", 16),
    launcher:new("vn_clearlights", 17),
    launcher:new("vn_lightfix", 18),
    launcher:new("vn_lowshade", 19),
    launcher:new("vn_weather", 20),
    launcher:new("vn_model_sugar", 21),
    launcher:new("vn_object_caravan", 22),
    launcher:new("vn_object_picture", 23),
    launcher:new("vn_object_pool", 24),
    launcher:new("vn_object_skate", 25),
    launcher:new("vn_object_table", 26),
    launcher:new("vn_map_caravan", 27),
    launcher:new("vn_map_lobby", 28),
    launcher:new("vn_donate", 29),
    launcher:new("vn_pets", 30),
    launcher:new("vn_peds", 31),
    launcher:new("vn_map_caravan", 32),
    launcher:new("vn_skinshop", 33),
    launcher:new("vn_blur", 34),
    launcher:new("vn_nametags", 36),
    launcher:new("vn_saloon", 37),
    launcher:new("vn_playerlist", 39),
    launcher:new("vn_shop", 40),
    launcher:new("vn_deathmatch", 41),
    launcher:new("vn_hitmarker", 42),
    launcher:new("vn_stats", 43),
    launcher:new("vn_map_city", 44),
    launcher:new("vn_gangwars", 45),
    launcher:new("vn_weaponui", 46),
    launcher:new("vn_radar", 47),
    launcher:new("vn_vehicle", 48),
    launcher:new("vn_driveby", 49),
    launcher:new("vn_killfeed", 50),
    launcher:new("vn_antispam", 51),
    launcher:new("vn_clanwars", 52),
    launcher:new("vn_hood", 53),
    launcher:new("vn_chat", 54),
    launcher:new("vn_reload", 55),
}

table.sort(resources, function(a,b) return a.priority < b.priority end)

for _, resource in ipairs(resources) do
    resource:launch()
end