-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local DialogGroup = {}

--Alert dialog to confirm if will paint all the layers in the group layers
function DialogGroup:ShowDialog(mode)
    dialogGroupLayers = Dialog{notitlebar=true}
    dialogGroupLayers:label{
        id = "labelGroupLayer",
        text = "This layer is a group!"
    }
    dialogGroupLayers:newrow()
    dialogGroupLayers:label{
        id = "labelGroupLayer2",
        text = "Would you like to ".. mode .."ALL the layers in this group?"
    }
    dialogGroupLayers:button{
        id = "buttonGroupLayerYes",
        text ="Yes",
        onclick = function()
            actionInGroup = true
            dialogGroupLayers:close()
        end
    }
    dialogGroupLayers:button{
        id = "buttonGroupLayerNo",
        text ="No",
        onclick = function()
            actionInGroup = false
            dialogGroupLayers:close()
        end
    }
    dialogGroupLayers:show()
end   

function DialogGroup:ModeDialog(typeAction)
    if actionInGroup == false then--if the seeting to automatize the paint is not checked show a alert
        if typeAction == typeActions[1] then 
            DialogGroup:ShowDialog(txtMode[1]) --Paint 
        else
            DialogGroup:ShowDialog(txtMode[2]) --Clean
        end
    end
end
return DialogGroup