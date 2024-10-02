-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local ElementsDialog = {}

function ElementsDialog:ModifyText(dialogName,idName,newText)
    dialogName:modify{
        id = idName,
        text = newText
    }
end

function ElementsDialog:ModifyVisibility(dialogName,idName,visibility)
    dialogName:modify{
        id = idName,
        visible = visibility
    }
end

function ElementsDialog:ModifyColors(dialogName,idName,shadeColors)
    dialogName:modify{
        id = idName,
        colors = shadeColors
    }
end

return ElementsDialog