-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Tables
SaveTables = require("Scripts.Tables.SaveTables")
-------------------------------
local UserData = {}
--Save the scale the user defined
function UserData:SaveUserDataInFile(plugin)
    plugin.preferences = preferences
    plugin.preferences.save()
end
--Receive the last scale the user defined
function UserData:GetUserDataFromFile(plugin)
    preferences = plugin.preferences
end    

--Load the information of preferences to use in the beginning of the plugin
function UserData:LoadNewColorsFromPreferences(tablePreferences,key)
    local jsonNewColors = tablePreferences[key]
    jsonNewColors = json.decode(jsonNewColors)
    if jsonNewColors == nil then
        jsonNewColors = {}
    else
        if #jsonNewColors == 0 then
            jsonNewColors = {}
        end
    end    
    return jsonNewColors
end

--Save the new color in the preferences table
function UserData:SaveNewColorsToPreferences(key,tablePreferences,tableColors)
    local jsonNewColors = json.encode(tableColors)
    if #jsonNewColors ~= 0 then
        tablePreferences[key] = jsonNewColors
    end 
end

function UserData:SavePreferencesClose(plugin)
    UserData:SaveNewColorsToPreferences(keyJsonPreferences[1],preferences,newColorsTable)
    UserData:SaveNewColorsToPreferences(keyJsonPreferences[2],preferences,nameNewColorsTable)
    UserData:SaveUserDataInFile(plugin)
end

return UserData
