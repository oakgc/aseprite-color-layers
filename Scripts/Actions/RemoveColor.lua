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
--Tables
SearchTables = require("Scripts.Tables.SearchTables")
-------------------------------
local RemoveColor = {}

--remove the color and define the theme color for layer
function RemoveColor:RemoveLayer(layer)
    local defaultColor = defaultColorTheme
    if layer.color == defaultColor then
        app.alert("This layer has the theme color! It is impossible to remove.")
    else
        layer.color = defaultColor
    end
end 

function RemoveColor:RemoveRange(rangeInfo)
    local rangeLayers = rangeInfo.layers 
    for index,value in ipairs(rangeLayers) do
        if rangeLayers[index].layers ~= nil then
            if actionInGroup == false then    
                DialogGroup:ModeDialog(typeActions[2])
            end
            RemoveColor:RemoveLayer(rangeLayers[index])
            if actionInGroup == true then
                RemoveColor:RemoveRange(rangeLayers[index])
            end
        else
            RemoveColor:RemoveLayer(rangeLayers[index])
        end    
    end
end

function RemoveColor:RemoveCheckings()
    LayersInfo:PreparationsToStart()
    LayersInfo:ValidationToAction(typeActions[2])
end

function RemoveColor:DeleteColorFromLayers(spriteLayers,nameColor)
    local removeHEXColor = SearchTables:SearchByINDEX(newColorsTable,nameColor)
    for index in ipairs(spriteLayers) do
        local layerHEXColor = spriteLayers[index].color 
        layerHEXColor = CastColors:RGBToHex(layerHEXColor.red,layerHEXColor.green,layerHEXColor.blue)
        if layerHEXColor == removeHEXColor then
            RemoveColor:RemoveLayer(spriteLayers[index]) 
        end  
        if spriteLayers[index].layers ~= nil then
            RemoveColor:DeleteColorFromLayers(spriteLayers[index].layers,nameColor)
        end
    end
end

return RemoveColor