local og = {}
og.build_mods_list = MenuCallbackHandler.build_mods_list
og.is_modded_client = MenuCallbackHandler.is_modded_client
og.is_not_modded_client = MenuCallbackHandler.is_not_modded_client

function MenuCallbackHandler:is_modded_client(...)
    -- 1 = OFF, 2 = ALL, 3 = SELECTED ONLY
    local option = MiscMods.settings.hide_mod_list

    if option == 2 then
        return false -- If hiding all then simply say client is not modded
    else
        return og:is_modded_client(...)
    end
end

function MenuCallbackHandler:is_not_modded_client(...)
    -- 1 = OFF, 2 = ALL, 3 = SELECTED ONLY
    local option = MiscMods.settings.hide_mod_list

    if option == 2 then
        return true -- If hiding all then simply say client is not modded
    else
        return og:is_not_modded_client(...)
    end
end

function MenuCallbackHandler:build_mods_list(...)
    -- 1 = OFF, 2 = ALL, 3 = SELECTED ONLY
    local option = MiscMods.settings.hide_mod_list

    if option == 1 then
        return og:build_mods_list(...)
    elseif option == 2 then
        return {}
    end

    local mods_to_hide = MiscMods.FileReader:get_mods_to_hide()
    local mods = og:build_mods_list(...)
    local filtered_mods = {}

    for _, data in ipairs(mods) do
        if not mods_to_hide[data[1]] then
            table.insert(filtered_mods, data)
        end
    end

    return filtered_mods
end
