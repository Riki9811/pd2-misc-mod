if not HopLib then
    log("[MiscMod] ERROR: Unmet dependencies, HopLib not found. Install: https://modworkshop.net/mod/21431")
    return
end

MiscMods = {}
MiscMods.mod_path = ModPath
MiscMods.settings = {
    hide_mod_list = 1, -- 1 = OFF, 2 = ALL, 3 = SELECTED ONLY
    mod_list_info_btn = function()
        show_select_hide_info()
    end,
    sh_raid_frequency = 1 -- 1 = DEFAULT, 2 = NEVER, 3 = ALWAYS
}
MiscMods.settings_params = {
    hide_mod_list = {
        items = {"menu_misc_mods_hide_mods_off", "menu_misc_mods_hide_all_mods", "menu_misc_mods_hide_select_mods"},
        priority = 5
    },
    mod_list_info_btn = {
        priority = 4,
        divider = 16
    },
    sh_raid_frequency = {
        items = {"menu_misc_mods_sh_raid_default", "menu_misc_mods_sh_raid_never", "menu_misc_mods_sh_raid_always"},
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

function show_select_hide_info()
    local menu_title = managers.localization:text("popup_hide_select_mods_title")
    local menu_message = managers.localization:text("popup_hide_select_mods_message")
    QuickMenu:new("Misc Mods - " .. menu_title, menu_message, {}):Show()
end
