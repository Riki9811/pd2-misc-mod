if RequiredScript == "lib/units/enemies/cop/copbrain" then
    local og_cop_brain_clbk_death = CopBrain.clbk_death

    function CopBrain:clbk_death(...)
        local cheat_on = MiscMods.settings.cheats.no_pagers
        local is_stealth = managers.groupai:state():whisper_mode()
        local has_pager = self._unit:unit_data().has_alarm_pager

        if cheat_on and is_stealth and has_pager then
            self._unit:unit_data().has_alarm_pager = false
        end

        og_cop_brain_clbk_death(self, ...)
    end
end

if RequiredScript == "lib/units/enemies/cop/logics/coplogicintimidated" then
    local og_chk_begin_alarm_pager = CopLogicIntimidated._chk_begin_alarm_pager

    function CopLogicIntimidated._chk_begin_alarm_pager(data)
        local cheat_on = MiscMods.settings.cheats.no_pagers

        if cheat_on then
            return
        end

        og_chk_begin_alarm_pager(data)
    end
end
