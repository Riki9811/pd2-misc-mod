if _G.BLT_CarryStacker then
    while managers.player:is_carrying() do
        managers.player:drop_carry()
    end
else
    managers.hud._hud_presenter:_present_information({
        text = managers.localization:text("hint_no_carry_stacker_text"),
        title = managers.localization:text("hint_no_carry_stacker_title"),
        time = 4
    })
end
