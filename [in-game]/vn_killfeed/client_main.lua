local screen_maxX,      screen_maxY =           guiGetScreenSize()
local icon1_centerX,    icon1_topY =            0.93,                   0.3
local icon_width,       icon_height =           24,                     24
local icon_sideMargin,  icon_bottomMargin =     10,                     5
local label_width,      label_height =          200,                    20
local label_font,       label_topMargin =       exports.vn_fonts:getFont("RobotoB"),         3
local label_shadowColor = tocolor(12,12,12)
local rows = 5

local rows_margin =     icon_height + icon_bottomMargin

local label1_leftX =    screen_maxX * icon1_centerX - icon_width/2 - icon_sideMargin - label_width
local label1_rightX =   label1_leftX + label_width
local label2_leftX =    label1_rightX + icon_sideMargin*2 + icon_width
local label2_rightX =   label2_leftX + label_width

local icon_leftX =      label1_rightX + icon_sideMargin
local icon_topY =       screen_maxY * icon1_topY

local root =            getRootElement()
local resourceRoot =    getResourceRootElement()
local killRow = {}

local imagePath = {
    [0] =  "icons/weapons/fist.png",
    [1] =  "icons/weapons/brassKnuckles.png",
    [2] =  "icons/weapons/golfClub.png",
    [3] =  "icons/weapons/nightstick.png",
    [4] =  "icons/weapons/knife.png",
    [5] =  "icons/weapons/baseballBat.png",
    [6] =  "icons/weapons/shovel.png",
    [7] =  "icons/weapons/poolCue.png",
    [8] =  "icons/weapons/katana.png",
    [9] =  "icons/weapons/chainsaw.png",
    [10] = "icons/weapons/dildo.png",
    [11] = "icons/weapons/dildo.png",
    [12] = "icons/weapons/dildo.png",
    [13] = "icons/deathReasons/death.png",
    [14] = "icons/weapons/flowers.png",
    [15] = "icons/weapons/cane.png",
    [16] = "icons/weapons/grenade.png",
    [17] = "icons/weapons/tearGas.png",
    [18] = "icons/weapons/molotovCocktail.png",
    [19] = "icons/weapons/rocketLauncher.png",
    [20] = "icons/weapons/hsRocketLauncher.png",
    [21] = "icons/deathReasons/explosion.png",
    [22] = "icons/weapons/9mm.png",
    [23] = "icons/weapons/silenced9mm.png",
    [24] = "icons/weapons/desertEagle.png",
    [25] = "icons/weapons/shotgun.png",
    [26] = "icons/weapons/sawnoffShotgun.png",
    [27] = "icons/weapons/combatShotgun.png",
    [28] = "icons/weapons/microSmg.png",
    [29] = "icons/weapons/mp5.png",
    [30] = "icons/weapons/ak47.png",
    [31] = "icons/weapons/m4.png",
    [32] = "icons/weapons/tec9.png",
    [33] = "icons/weapons/countryRifle.png",
    [34] = "icons/weapons/sniperRifle.png",
    [35] = "icons/weapons/rocketLauncher.png",
    [36] = "icons/weapons/hsRocketLauncher.png",
    [37] = "icons/weapons/flamethrower.png",
    [38] = "icons/weapons/minigun.png",
    [39] = "icons/weapons/satchelCharge.png",
    [40] = "icons/weapons/detonator.png",
    [41] = "icons/weapons/spraycan.png",
    [42] = "icons/weapons/fireExtinguisher.png",
    [43] = "icons/deathReasons/explosion.png",
    [44] = "icons/weapons/goggles.png",
    [45] = "icons/weapons/goggles.png",
    [46] = "icons/weapons/parachute.png",

    [49] =  "icons/deathReasons/rammed.png",
    [50] =  "icons/deathReasons/helicopterBlades.png",
    [51] =  "icons/deathReasons/explosion.png",
    [52] =  "icons/deathReasons/fire.png",
    [53] =  "icons/deathReasons/death.png",
    [54] =  "icons/deathReasons/fall.png",
    [255] = "icons/deathReasons/death.png",

    connected =    "icons/connectStates/connected.png",
    disconnected = "icons/connectStates/disconnected.png"
}




function onClientResourceStart(resource)
	setBlurLevel(0)
end
addEventHandler( "onClientResourceStart", resourceRoot, onClientResourceStart)


function renderClientKillPanel ()
    if getElementData(localPlayer, "online") then
        for r = 1, rows do
            if killRow[r] then

                dxDrawText( killRow[r]["killerName"],
                    killRow[r]["killerNamePos"]["leftX"] + 1,  killRow[r]["killerNamePos"]["topY"] + 1,
                    killRow[r]["killerNamePos"]["rightX"] + 1, killRow[r]["killerNamePos"]["bottomY"] + 1,
                    label_shadowColor,
                    1,
                    label_font,
                    "right" )

                dxDrawText( killRow[r]["killerName"],
                    killRow[r]["killerNamePos"]["leftX"],  killRow[r]["killerNamePos"]["topY"],
                    killRow[r]["killerNamePos"]["rightX"], killRow[r]["killerNamePos"]["bottomY"],
                    killRow[r]["killerNameColor"],
                    1,
                    label_font,
                    "right" )

                dxDrawImage( killRow[r]["reasonIconPos"]["leftX"], killRow[r]["reasonIconPos"]["topY"],
                    icon_width, icon_height,
                    imagePath[ killRow[r]["deathReason"] ] )

                dxDrawText( killRow[r]["victimName"],
                    killRow[r]["victimNamePos"]["leftX"] + 1,  killRow[r]["victimNamePos"]["topY"] + 1,
                    killRow[r]["victimNamePos"]["rightX"] + 1, killRow[r]["victimNamePos"]["bottomY"] + 1,
                    label_shadowColor,
                    1,
                    label_font )

                dxDrawText( killRow[r]["victimName"],
                    killRow[r]["victimNamePos"]["leftX"],  killRow[r]["victimNamePos"]["topY"],
                    killRow[r]["victimNamePos"]["rightX"], killRow[r]["victimNamePos"]["bottomY"],
                    killRow[r]["victimNameColor"],
                    1,
                    label_font )

            end
        end
    end
end
addEventHandler ( "onClientRender", root, renderClientKillPanel )


function unfuck(text)
	return string.gsub(text, "(#%x%x%x%x%x%x)", function(colorString) return "" end)
end


function showClientDeathMessage ( killerName, killerNameColor, deathReason, victimName, victimNameColor )

    local firstRow = killRow[1]

    for r = 1, rows - 1 do
        killRow[r] = killRow[r + 1]
    end

    if type(killerNameColor) ~= "table" then killerNameColor = {255,255,255} end
    if type(victimNameColor) ~= "table" then victimNameColor = {255,255,255} end

    if firstRow then

        killRow[rows] = firstRow

        killRow[rows]["killerName"] =       unfuck(tostring(killerName))
        killRow[rows]["killerNameColor"] =  tocolor( unpack(killerNameColor) )
        killRow[rows]["deathReason"] =      deathReason
        killRow[rows]["victimName"] =       unfuck(tostring(victimName))
        killRow[rows]["victimNameColor"] =  tocolor( unpack(victimNameColor) )

    else
        killRow[rows] = {
            ["killerNamePos"] =     { leftX = label1_leftX, rightX = label1_rightX, topY = 0, bottomY = 0 },
            ["reasonIconPos"] =     { leftX = icon_leftX, topY = 0 },
            ["victimNamePos"] =     { leftX = label2_leftX, rightX = label2_rightX, topY = 0, bottomY = 0 },

            ["killerName"] =        unfuck(tostring(killerName)),
            ["killerNameColor"] =   tocolor( unpack(killerNameColor) ),
            ["deathReason"] =       deathReason,
            ["victimName"] =        unfuck(tostring(victimName)),
            ["victimNameColor"] =   tocolor( unpack(victimNameColor) )
        }
    end

    if imagePath[ killRow[rows]["deathReason"] ] == nil then
        killRow[rows]["deathReason"] = 255
    end

    if killRow[rows]["killerName"] == killRow[rows]["victimName"] then
        killRow[rows]["killerName"] = ""
    end

    local y = icon_topY

    for r = 1, rows do
        if killRow[r] then
            killRow[r]["killerNamePos"]["topY"] =       y + label_topMargin
            killRow[r]["killerNamePos"]["bottomY"] =    y + label_height

            killRow[r]["reasonIconPos"]["topY"] =       y

            killRow[r]["victimNamePos"]["topY"] =       killRow[r]["killerNamePos"]["topY"]
            killRow[r]["victimNamePos"]["bottomY"] =    killRow[r]["killerNamePos"]["bottomY"]
        end

        y = y + rows_margin
    end

end

addEvent("showDeathMessage", true )
addEventHandler("showDeathMessage", resourceRoot, showClientDeathMessage )

function killPanelTest()

    showClientDeathMessage( "oldPlayerName", { math.random(0,255), math.random(0,255), math.random(0,255) },
        "disconnected",
        "", {0,0,0} )

    for r = 2, rows - 1 do
        local c, nameLen, name1, name2 = 1, math.random(4,20), "", ""

        while c <= nameLen do
            name1 = name1 .. string.char( math.random(33,125) )
            c = c + 1
        end

        c, nameLen = 1, math.random(4,20)
        while c <= nameLen do
            name2 = name2 .. string.char( math.random(33,125) )
            c = c + 1
        end

        showClientDeathMessage( name1, { math.random(0,255), math.random(0,255), math.random(0,255) },
            math.random(0,54),
            name2, { math.random(0,255), math.random(0,255), math.random(0,255) } )
    end

    showClientDeathMessage( "newPlayerHere", { math.random(0,255), math.random(0,255), math.random(0,255) },
        "connected",
        "", {0,0,0} )
end

