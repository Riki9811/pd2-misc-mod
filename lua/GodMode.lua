local old_player_damage_init = PlayerDamage.init

function PlayerDamage:init(unit)
    old_player_damage_init(self, unit)
    self._invulnerable = true
end
