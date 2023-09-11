local og_getTimer = BaseInteractionExt._get_timer

function BaseInteractionExt:_get_timer()
    local cheat_on = MiscMods.settings.cheats.instant_interactions
    local is_pager = self.tweak_data == "corpse_alarm_pager"

    if cheat_on and is_pager then
        return 0.001
    elseif cheat_on then
        return 0
    else
        return og_getTimer(self)
    end
end
