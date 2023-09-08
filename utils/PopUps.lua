MiscMods.PopUps = {}

function MiscMods.PopUps:show_select_hide_info()
    local menu_title = managers.localization:text("popup_select_hide_info_title")
    local menu_message = managers.localization:text("popup_select_hide_info_message")
    QuickMenu:new("Misc Mods - " .. menu_title, menu_message, {}):Show()
end

function MiscMods.PopUps:show_mods_to_hide_list()
    local menu_title = managers.localization:text("popup_mods_to_hide_list_title")
    local menu_message = ""
    local mods_to_hide = MiscMods.FileReader:get_mods_to_hide()
    for name, hide in pairs(mods_to_hide) do
        menu_message = menu_message .. name .. "\n"
    end
    menu_message = menu_message .. managers.localization:text("popup_mods_to_hide_list_message")

    QuickMenu:new("Misc Mods - " .. menu_title, menu_message, {}):Show()
end
