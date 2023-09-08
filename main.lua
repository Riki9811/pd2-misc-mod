if not HopLib then
    log("[MiscMod] ERROR: Unmet dependencies, HopLib not found. Install: https://modworkshop.net/mod/21431")
    return
end

MiscMods = {}
MiscMods.mod_path = ModPath

dofile(ModPath .. "/utils/FileReader.lua")
dofile(ModPath .. "/utils/PopUps.lua")

MiscMods.settings = {
    hide_mod_list = 1, -- 1 = OFF, 2 = ALL, 3 = SELECTED ONLY
    select_hide_info_btn = function()
        MiscMods.PopUps:show_select_hide_info()
    end,
    prevent_sh_raid = true
}
MiscMods.settings_params = {
    hide_mod_list = {
        items = {"menu_misc_mods_hide_mods_off", "menu_misc_mods_hide_all_mods", "menu_misc_mods_hide_select_mods"},
        priority = 5,
        callback = function()
            if MiscMods.settings.hide_mod_list == 3 then
                MiscMods.PopUps:show_mods_to_hide_list()
            end
        end
    },
    select_hide_info_btn = {
        priority = 4,
        divider = 16
    },
    prevent_sh_raid = {
        priority = 3
    }
}

local builder = MenuBuilder:new("misc_mods", MiscMods.settings, MiscMods.settings_params)

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInitAdjustableWeaponSway", function(loc)
    HopLib:load_localization(MiscMods.mod_path .. "loc/", loc)
end)

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusPlayerWeaponSway", function(menu_manager, nodes)
    builder:create_menu(nodes)
end)
