-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local LayersInfo = {}

--check if there are some selection of layers
function LayersInfo:LayerHasRange()
    if app.range.isEmpty == false and app.range.type == 4 then 
        IsRangeSelected = true
    else
        IsRangeSelected = false 
    end
end

--Receive the currente Layer Selected
function LayersInfo:GetSelectedLayer()
    if IsRangeSelected == true then   
        selectedLayer = app.range
    else
        selectedLayer = app.layer 
    end
end

--Get all the layers in the current sprite
function LayersInfo:GetAllLayersInSprite()
    allLayers = app.sprite.layers
    return allLayers
end

--check if all the requirements are ok to start the plugin
function LayersInfo:PreparationsToStart()
    LayersInfo:LayerHasRange()
    LayersInfo:GetSelectedLayer()
end   

function LayersInfo:SetGroupAction(typeAction)

    if seetingsAlwaysPaintColorGroup and typeAction == typeActions[1] then
        actionInGroup = true
        return
    end
    if seetingsAlwaysRemoveColorGroup and typeAction == typeActions[2] then
        actionInGroup = true
        return
    end
    actionInGroup = false
end    

function LayersInfo:ValidationToAction(typeAction,nameColor,typeColor)
    --Verify automations before to start
    LayersInfo:SetGroupAction(typeAction)
    
    if IsRangeSelected == true then
        if typeAction == typeActions[1] then
            PaintColor:PaintRange(selectedLayer,nameColor,typeColor)
        else
            RemoveColor:RemoveRange(selectedLayer)
        end
    else -- SIMPLE LAYER
        if typeAction == typeActions[1] then    
            PaintColor:PaintLayer(selectedLayer,nameColor,typeColor)
        else
            RemoveColor:RemoveLayer(selectedLayer)
        end        
    end    
end

return LayersInfo