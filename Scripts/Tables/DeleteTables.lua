-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
CastColors = require("Scripts.Auxiliar.CastColors")
ElementsDialog = require("Scripts.Auxiliar.ElementsDialog")
--Actions
RemoveColor = require("Scripts.Actions.RemoveColor")
--Tables
SearchTables = require("Scripts.Tables.SearchTables")
-------------------------------

local DeleteTables = {}

function DeleteTables:RemoveItem(nameColor,tableColor)
    local index = SearchTables:SearchByValue(tableColor,nameColor)
        if index ~= nil then
            table.remove(tableColor,index)
            return
        end
end

--Delete color from array of new colors
function DeleteTables:DeleteSavedColor(nameColor)
    
    local spriteLayers = LayersInfo:GetAllLayersInSprite()
    --delete the color of all layers
    RemoveColor:DeleteColorFromLayers(spriteLayers,nameColor)
    --save the name of color in the deletedColor table
    SaveTables:SaveNewColors("",nameColor,typeAddNewColors[3],deleteColorsTable)
    --delete the name of this table
    nameNewColorsTable = DeleteTables:SearchAndRemoveItem(nameColor,nameNewColorsTable,typeTables[2])
    --delete color of new colors
    newColorsTable = DeleteTables:SearchAndRemoveItem(nameColor,newColorsTable,typeTables[1])
    app.alert("Color was deleted!")
    
end


function DeleteTables:SearchAndRemoveItem(infoColor,tableColor,modeSearch)
    local auxTable = {}  
    if modeSearch == typeTables[1] then
        for index,value in pairs(tableColor) do
                if index ~= infoColor then
                    auxTable[index] = value
                end
        end
    end
    if modeSearch == typeTables[2] then
        for index,value in ipairs(tableColor) do
                if value ~= infoColor then
                    auxTable[index] = value
                end
        end 
    end
    if auxTable == nil then
        auxTable = {}
    end
    return auxTable
end
return DeleteTables