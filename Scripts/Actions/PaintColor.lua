-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
LayersInfo = require("Scripts.Auxiliar.LayersInfo")
CastColors = require("Scripts.Auxiliar.CastColors")
--Dialog
DialogGroup = require("Scripts.Dialogs.DialogGroup")
--Tables
SearchTables = require("Scripts.Tables.SearchTables")
SaveTables = require("Scripts.Tables.SaveTables")
-------------------------------
local PaintColor = {}

--Set the color what was selected by user
function PaintColor:PaintLayer(layer,nameColor,typeColor)
    local color
    local hexColor
    if typeColor == typeColors[2] then --typeColors[2] = new
        hexColor = SearchTables:SearchByINDEX(newColorsTable,nameColor)
    else
        hexColor = SearchTables:SearchByINDEX(defaultColorsTable,nameColor)
    end
    color = CastColors:HEXToRgb(hexColor)
    layer.color = color
end    

--Paint the layer group
function PaintColor:PaintRange(rangeInfo,nameColor,typeColor)
    local rangeLayers = rangeInfo.layers
    for index in ipairs(rangeLayers) do
        --LayersInfo:LayerIsGroup(rangeLayers)
        if rangeLayers[index].layers ~= nil then --recursive function to paint all the subgroups 
            if actionInGroup == false then    
                DialogGroup:ModeDialog(typeActions[1])
            end    
            PaintColor:PaintLayer(rangeLayers[index],nameColor,typeColor)
            if actionInGroup == true then
                PaintColor:PaintRange(rangeLayers[index],nameColor,typeColor)
            end    
        else
            PaintColor:PaintLayer(rangeLayers[index],nameColor,typeColor)
        end
    end
end   

function PaintColor:RepaintOldColor(allLayers,oldColor,newColor)
    local oldRGBColor = CastColors:HEXToRgb(oldColor)
    local newRGBColor = CastColors:HEXToRgb(newColor)

    for index in ipairs(allLayers) do
        if allLayers[index].color == oldRGBColor then
            allLayers[index].color = newRGBColor
        end
        if allLayers[index].layers ~= nil then
            PaintColor:RepaintOldColor(allLayers[index].layers,oldColor,newColor)
        end
    end
end
--Main function to paint the color selected after check many options
function PaintColor:PaintCheckings(nameColor,typeColor)
    LayersInfo:PreparationsToStart()
    LayersInfo:ValidationToAction(typeActions[1],nameColor,typeColor)
    
end
return PaintColor