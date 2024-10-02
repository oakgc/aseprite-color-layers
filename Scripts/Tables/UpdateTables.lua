-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
--Dialogs
DialogChangeColor = require("Scripts.Dialogs.DialogChangeColor")
--Menu
LoadMenus = require("Scripts.Menu.LoadMenu")
--Tables 
DeleteTables = require("Scripts.Tables.DeleteTables")
SearchTables = require("Scripts.Tables.SaveTables")
-------------------------------

local UpdateTables = {}

function UpdateTables:ChangeItemColorTable(tableNameColor,tableColor,originalName)
    -- change the name in the nameNewColor tables
    for index,value in ipairs(tableNameColor) do
        if value == originalName then
            nameNewColorsTable[index] = nameNewColor
        end
    end 
    --remove the old color and the add new color in newColorTable
    newColorsTable = DeleteTables:SearchAndRemoveItem(originalName,tableColor,typeTables[1])
    newColorsTable[nameNewColor] = Auxiliar:UpperString(hexNewColor)
end

--Change the color in the array of new colors
function UpdateTables:ChangeSavedColor(plugin,name,hex)
    local originalName = name
    local originalHEX = hex

    DialogChangeColor:ShowMenu()
    if IsChangeCanceled == false then
        --iterate all the layer and change the old color to new color
        PaintColor:RepaintOldColor(LayersInfo:GetAllLayersInSprite(),originalHEX,hexNewColor) 
        UpdateTables:ChangeItemColorTable(nameNewColorsTable,newColorsTable,originalName)
        LoadMenus:CreateItemsNewColors(plugin,nameNewColor)
        app.alert(originalHEX.." - "..originalName.." was change to "..hexNewColor.." - "..nameNewColor)      
    end
end  
    
return UpdateTables