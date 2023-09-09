if not ogFunctions then
    ogFunctions = {}
end

if RequiredScript == "lib/managers/enemymanager" then

    ogFunctions.enemy_manager_init = EnemyManager.init
    ogFunctions.corpse_limit = EnemyManager.corpse_limit
    ogFunctions.add_magazine = EnemyManager.add_magazine

    function EnemyManager:init(...)
        ogFunctions.enemy_manager_init(self, ...)

        -- If the setting is on override these values
        if MiscMods.settings.no_corpses then
            self._corpse_disposal_upd_interval = 0
            self._shield_disposal_upd_interval = 0
            self._shield_disposal_lifetime = 0
            self._MAX_NR_SHIELDS = 0
        end
    end

    function EnemyManager:corpse_limit(...)
        local limit = ogFunctions.corpse_limit(self, ...)
        -- If the setting is on make corpe_limit 0
        if MiscMods.settings.no_corpses and limit and limit > 0 then
            limit = 0
        end
        return limit
    end

    function EnemyManager:add_magazine(magazine, collision)
        if MiscMods.settings.no_corpses then
            if alive(magazine) then
                magazine:set_slot(0)
            end
            if alive(collision) then
                collision:set_slot(0)
            end
        else
            ogFunctions.add_magazine(self, magazine, collision)
        end
    end
end

if RequiredScript == "lib/managers/gameplaycentralmanager" then

    ogFunctions.gamePlayCentralManager_init = GamePlayCentralManager.init
    ogFunctions._play_bullet_hit = GamePlayCentralManager._play_bullet_hit
    ogFunctions.play_impact_flesh = GamePlayCentralManager.play_impact_flesh
    ogFunctions.sync_play_impact_flesh = GamePlayCentralManager.sync_play_impact_flesh

    function GamePlayCentralManager:init(...)
        ogFunctions.gamePlayCentralManager_init(self, ...)

        if MiscMods.settings.no_corpses then
            self._block_bullet_decals = true
            self._block_blood_decals = true
        end
    end

    function GamePlayCentralManager:_play_bullet_hit(...)
        if MiscMods.settings.no_corpses then
            return
        end
        ogFunctions._play_bullet_hit(self, ...)
    end

    function GamePlayCentralManager:play_impact_flesh(...)
        if MiscMods.settings.no_corpses then
            return
        end
        ogFunctions.play_impact_flesh(self, ...)
    end

    function GamePlayCentralManager:sync_play_impact_flesh(...)
        if MiscMods.settings.no_corpses then
            return
        end
        ogFunctions.sync_play_impact_flesh(self, ...)
    end
end
