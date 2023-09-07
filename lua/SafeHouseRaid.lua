-- The dafualt behaviour of 'is_being_raided'
local og_is_being_raided = CustomSafehouseManager.is_being_raided


-- TODO: try rewriting using Choice table
function CustomSafehouseManager:is_being_raided(...)
    -- Catch nil value errors
    if not MiscMods then
        log("[MiscMods] ERROR: SafeHouseRaid found 'MiscMods' to be a nil value.")
        return og_is_being_raided(self, ...)
    elseif not MiscMods.settings then
        log("[MiscMods] ERROR: SafeHouseRaid found 'MiscMods.setings' to be a nil value.")
        return og_is_being_raided(self, ...)
    elseif not MiscMods.settings.sh_raid_frequency then
        log("[MiscMods] ERROR: SafeHouseRaid found 'MiscMods.setings.sh_raid_frequency' to be a nil value.")
        return og_is_being_raided(self, ...)
    end

    local option = MiscMods.settings.sh_raid_frequency

    if option == 2 then
        return false
    elseif option == 3 then
        if not self:unlocked() or not self:has_entered_safehouse() then
            return false
        end
        return true
    else
        return og_is_being_raided(self, ...)
    end
end
