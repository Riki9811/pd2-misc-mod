NumberPadToKeyPadHack = NumberPadToKeyPadHack or {}

function NumberPadToKeyPadHack:Main(__in)
    __in = tostring(__in)
    local __allow_keys_type1 = {
        __ids = Idstring("units/pd2_dlc_casino/props/cas_prop_keypad/cas_prop_button"):key(),
        cas_button_01 = true,
        cas_button_02 = true,
        cas_button_03 = true,
        cas_button_04 = true,
        cas_button_05 = true,
        cas_button_06 = true,
        cas_button_07 = true,
        cas_button_08 = true,
        cas_button_09 = true,
        cas_button_0 = true,
        cas_button_clear = true,
        cas_button_enter = true
    }
    local __allow_keys_type2 = {
        __ids = Idstring("units/pd2_dlc_sand/props/sand_prop_intercom/sand_interactable_intercom_button"):key(),
        cas_button_01 = true,
        cas_button_02 = true,
        cas_button_03 = true,
        cas_button_04 = true,
        cas_button_05 = true,
        cas_button_06 = true,
        cas_button_07 = true,
        cas_button_08 = true,
        cas_button_09 = true,
        cas_button_0 = true,
        cas_button_clear = true,
        cas_button_enter = true,
        sand_button_number_sign = true
    }
    local __allow_keys_type3 = {
        __ids = Idstring("units/pd2_dlc_sand/props/sand_prop_keypad/sand_interactable_button"):key(),
        cas_button_01 = true,
        cas_button_02 = true,
        cas_button_03 = true,
        cas_button_04 = true,
        cas_button_05 = true,
        cas_button_06 = true,
        cas_button_07 = true,
        cas_button_08 = true,
        cas_button_09 = true,
        cas_button_0 = true,
        cas_button_clear = true,
        cas_button_enter = true
    }
    local __allow_keys_type4 = {
        __ids = Idstring("units/pd2_dlc_casino/props/cas_prop_keypad/cas_prop_button"):key(),
        cas_prop_button_001 = true,
        cas_prop_button_002 = true,
        cas_prop_button_003 = true,
        cas_prop_button_004 = true,
        cas_prop_button_005 = true,
        cas_prop_button_006 = true,
        cas_prop_button_007 = true,
        cas_prop_button_008 = true,
        cas_prop_button_009 = true,
        cas_prop_button_000 = true,
        cas_prop_button_clear = true,
        cas_prop_button_enter = true
    }
    local __allow_keys_type5 = {
        __ids = Idstring("units/pd2_dlc_bph/props/bph_prop_keypad/bph_interactable_button"):key(),
        button001 = true,
        button002 = true,
        button003 = true,
        button004 = true,
        button005 = true,
        button006 = true,
        button007 = true,
        button008 = true,
        button009 = true,
        button000 = true,
        buttonC = true,
        buttonE = true
    }
    local __allow_keys_type6 = {
        __ids = Idstring("units/pd2_dlc_vit/equipment/vit_interactable_button/vit_interactable_button"):key(),
        button_001 = true,
        button_002 = true,
        button_003 = true,
        button_004 = true,
        button_005 = true,
        button_006 = true,
        button_007 = true,
        button_008 = true,
        button_009 = true,
        button_000 = true,
        button_c = true,
        button_e = true
    }
    local __allows_pads = {
        [Idstring("units/pd2_dlc_tag/props/tag_prop_keypad/tag_prop_keypad"):key()] = __allow_keys_type1,
        [Idstring("units/pd2_dlc_casino/props/cas_prop_keypad/cas_prop_keypad"):key()] = __allow_keys_type1,
        [Idstring("units/pd2_dlc_sand/props/sand_prop_intercom/sand_prop_intercom"):key()] = __allow_keys_type2,
        [Idstring("units/pd2_dlc_sand/props/sand_prop_keypad/sand_prop_keypad"):key()] = __allow_keys_type3,
        [Idstring("units/pd2_dlc_tag/props/tag_prop_keypad/tag_prop_keypad"):key()] = __allow_keys_type4,
        [Idstring("units/pd2_dlc_bph/props/bph_prop_keypad/bph_prop_keypad"):key()] = __allow_keys_type5,
        [Idstring("units/pd2_dlc_vit/equipment/vit_interactable_button/vit_interactable_button"):key()] = __allow_keys_type6,
        [Idstring("units/pd2_dlc_vit/equipment/vit_interactable_sec_safe/vit_interactable_sec_safe"):key()] = __allow_keys_type6
    }

    local __ply = managers.player:player_unit()
    if not __ply or not __ply:movement() then
        return
    end

    local camera = __ply:movement()._current_state._ext_camera
    local mvec_to = Vector3()
    local from_pos = camera:position()
    mvector3.set(mvec_to, camera:forward())
    mvector3.multiply(mvec_to, 20000)
    mvector3.add(mvec_to, from_pos)

    local __rays = World:raycast("ray", from_pos, mvec_to, "slot_mask", 1)

    if not (type(__rays) == "table" and __rays.unit) then
        return
    elseif not __allows_pads[__rays.unit:name():key()] then
        log("Pad " .. __rays.unit:name():key() .. " not allowed.")
        return
    end

    local __pad_data = __allows_pads[__rays.unit:name():key()]
    local __units = World:find_units("sphere", __rays.unit:position(), 100, 1)

    if not __pad_data then
        return
    end

    for _, __unit in pairs(__units) do
        if __unit and alive(__unit) and type(__unit.interaction) == "function" and __unit:name():key() ==
            __pad_data.__ids and __unit:interaction() and tostring(__unit:interaction().tweak_data) == __in then
            local __key_button = __unit:interaction()

            if __key_button:can_select(__ply) and __key_button:can_interact(__ply) and __key_button:active() and
                not __key_button:disabled() then
                __unit:interaction():interact(__ply)
                break
            end
        end
    end
end
