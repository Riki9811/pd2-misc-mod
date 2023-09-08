MiscMods.FileReader = {}

function MiscMods.FileReader:file_exists(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

function MiscMods.FileReader:get_mods_to_hide()
    local path = MiscMods.mod_path .. "mods_to_hide.txt"
    -- Check file exists
    if not MiscMods.FileReader:file_exists(path) then
        return {}
    end
    -- Read lines
    local lines = {}
    for line in io.lines(path) do
        lines[line] = true
    end
    return lines
end
