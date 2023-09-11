local og_spawn_head_gadget = CopDamage._spawn_head_gadget

function CopDamage:_spawn_head_gadget(...)
    if MiscMods.settings.no_corpses then
        return
    end

    og_spawn_head_gadget(self, ...)
end
