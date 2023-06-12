local hit = new('hitmarker')

function hit.prototype.____constructor(self)
    self._function = {}
    self._function.damage = function(...) self:damage(self,...) end
    addEventHandler('onClientPlayerDamage', root, self._function.damage)
end

function hit.prototype:damage(self,attacker)
    if attacker == localPlayer then
        self.effect = Sound('assets/effect.mp3')
        self.effect.volume = 0.5
    end
end

load(hit)