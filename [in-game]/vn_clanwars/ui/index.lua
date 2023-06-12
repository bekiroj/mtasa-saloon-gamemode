local clanwar = class("clanwar")

function clanwar:init()
    --// NPC
    self.npc = createPed(20, 2133.55078125, -1725.5810546875, 13.538780212402, 236)
    self.npc:setData("name", "clanwars soon..")
    self.npc:setData("icon", "")
    self.npc:setDimension(1)
    self.npc.frozen = true
    setPedAnimation(self.npc, "Attractors", "Stepsit_loop", -1, true, false, false)
end

clanwar:new()