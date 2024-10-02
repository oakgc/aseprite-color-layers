-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
CastColors = require("Scripts.Auxiliar.CastColors")
ElementsDialog = require("Scripts.Auxiliar.ElementsDialog")
--Tables
SearchTables = require("Scripts.Tables.SearchTables")
-------------------------------

local DialogChangeColor = {}

function DialogChangeColor:ShowMenu()
    IsChangeCanceled = false
    dialogChangeColorsSeetings = Dialog{notitlebar = true}
    
    dialogChangeColorsSeetings:entry{
        id = "fieldHexNewColor",
        label = "HEX Code:",
    }
    :newrow()
    dialogChangeColorsSeetings:entry{
        id = "fieldNameNewColor",
        label = "Name:",
    }
    :newrow()
    dialogChangeColorsSeetings:button{
        id = "btCancelChangeNewColor",
        text = "Cancel",
        onclick = function ()
            IsChangeCanceled = true
            dialogChangeColorsSeetings:close()
        end
    }
    dialogChangeColorsSeetings:button{
        id = "btSaveNewColor",
        text = "Save",
        onclick = function ()
            local empty = ""
            hexNewColor = dialogChangeColorsSeetings.data.fieldHexNewColor
            CastColors:isHEXColor(hexNewColor)
            if isHEXColor == false then
                app.alert("This color is not in a valid HEX format! Try again...")
                ElementsDialog:ModifyText(dialogChangeColorsSeetings,"fieldHexNewColor","")
                return
            end
            hexNewColor = CastColors:InsertAstericInHEX(hexNewColor)
            if hexNewColor == empty then
                app.alert("Insert a HEX value to add a new color...Try again!")
                return
            end
            nameNewColor = dialogChangeColorsSeetings.data.fieldNameNewColor
            if nameNewColor == empty then
                app.alert("Insert a NAME to add a new color...Try again!")
                return
            end 
            isDuplicated = SearchTables:CheckDuplicateNewColor(nameNewColor,hexNewColor,newColorsTable,nameNewColorsTable)
            if isDuplicated == true then
                IsChangeCanceled = true
            return
            end
            dialogChangeColorsSeetings:close()
        end
    }
    :show()   
end

return DialogChangeColor