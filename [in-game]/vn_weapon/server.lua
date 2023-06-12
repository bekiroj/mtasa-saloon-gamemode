local setWeaponProperty = setWeaponProperty
local _print = outputDebugString
local weapons = {
    --// COLT45
    {22, "weapon_range", 300},
    {22, "accuracy", 0.30},
    {22, "damage", 60},
    {22, "move_speed", 1.7},
    --// SILENCED
    {23, "weapon_range", 300},
    {23, "accuracy", 0.30},
    {23, "damage", 100},
    {23, "move_speed", 1.7},
    --// DEAGLE
    {24, "weapon_range", 300},
    {24, "accuracy", 0.30},
    {24, "damage", 100},
    {24, "move_speed", 1.7},
    --// SHOTGUN
    {25, "weapon_range", 45},
    {25, "accuracy", 1.2},
    {25, "damage", 9},
    {25, "move_speed", 1.7},
    --// C.SHOTGUN
    {27, "weapon_range", 60},
    {27, "accuracy", 0.6},
    {27, "damage", 12},
    {27, "move_speed", 1.7},
    --// UZI
    {28, "weapon_range", 80},
    {28, "accuracy", 1},
    {28, "damage", 40},
    {28, "move_speed", 1.7},
    --// TEC9
    {32, "weapon_range", 80},
    {32, "accuracy", 1},
    {32, "damage", 40},
    {32, "move_speed", 1.7},
    --// MP5
    {29, "weapon_range", 100},
    {29, "accuracy", 0.45},
    {29, "damage", 55},
    {29, "move_speed", 1.7},
    --// AK47
    {30, "weapon_range", 300},
    {30, "accuracy", 0.40},
    {30, "damage", 60},
    {30, "move_speed", 1.7},
    --// M4
    {31, "weapon_range", 250},
    {31, "accuracy", 0.60},
    {31, "damage", 80},
    {31, "move_speed", 1.7},
    --// RIFLE
    {33, "weapon_range", 150},
    {33, "accuracy", 0.9},
    {33, "damage", 140},
    {33, "move_speed", 1.7},
    --// SNIPER
    {34, "weapon_range", 500},
    {34, "accuracy", 1},
    {34, "damage", 200},
    {34, "move_speed", 1.7},
}

for _, value in ipairs(weapons) do
    setWeaponProperty(value[1], "poor", value[2], value[3])
    setWeaponProperty(value[1], "std", value[2], value[3])
    setWeaponProperty(value[1], "pro", value[2], value[3])
end
_print("!Weapon: weapon specs applied")