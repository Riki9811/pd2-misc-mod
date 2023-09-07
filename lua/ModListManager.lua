ModListManager = class()

function ModListManager:init()
    self._og_build_mods_list = MenuCallbackHandler.build_mods_list
    self._og_is_modded_client = MenuCallbackHandler.is_modded_client
    self._og_is_not_modded_client = MenuCallbackHandler.is_not_modded_client
    self:update()
end

function ModListManager:update()
    if MiscMods.settings.hide_mod_list == 1 then

        function MenuCallbackHandler:is_modded_client(...)
            return self._og_is_modded_client(...)
        end

        function MenuCallbackHandler:is_not_modded_client(...)
            return self._og_is_not_modded_client(...)
        end

        function MenuCallbackHandler:build_mods_list(...)
            return self._og_orig_func_build_mods_list(...)
        end

    elseif MiscMods.settings.hide_mod_list == 2 then

        function MenuCallbackHandler:is_modded_client()
            return false
        end

        function MenuCallbackHandler:is_not_modded_client()
            return true
        end

        function MenuCallbackHandler:build_mods_list()
            return {}
        end

    elseif MiscMods.settings.hide_mod_list == 3 then
        log("========================================= TO BE IMPLEMENTED =========================================")
    end
end
