-- The dafualt behaviour of 'is_being_raided'
local og_is_being_raided = CustomSafehouseManager.is_being_raided

function CustomSafehouseManager:is_being_raided(...)
    if MiscMods.settings.prevent_sh_raid then
        return false
    else
        return og_is_being_raided(self, ...)
    end
end
