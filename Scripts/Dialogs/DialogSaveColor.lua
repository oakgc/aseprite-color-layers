-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
CastColors = require("Scripts.Auxiliar.CastColors")
ElementsDialog = require("Scripts.Auxiliar.ElementsDialog")
--Menus
LoadMenus = require("Scripts.Menu.LoadMenu")
--Tables
SaveTables = require("Scripts.Tables.SaveTables")
SearchTables = require("Scripts.Tables.SearchTables")
-------------------------------

local DialogSaveColor = {}

function DialogSaveColor:ShowMenu(plugin)
    dialogSaveColorsSeetings = Dialog{title="Saved Colors"}

    dialogSaveColorsSeetings:entry{
        id = "fieldHexNewColor",
        label = "HEX Code:",
    }
    :newrow()
    dialogSaveColorsSeetings:entry{
        id = "fieldNameNewColor",
        label = "Name:",
    }
    :newrow()
    dialogSaveColorsSeetings:button{
        id = "btCancelChangeNewColor",
        text = "Cancel",
        onclick = function ()
            dialogSaveColorsSeetings:close()
        end
    }
    dialogSaveColorsSeetings:button{
        id = "btSaveNewColor",
        text = "Save",
        onclick = function ()
            local empty = ""
            hexNewColor = CastColors:InsertAstericInHEX(dialogSaveColorsSeetings.data.fieldHexNewColor)
            nameNewColor = dialogSaveColorsSeetings.data.fieldNameNewColor
            SearchTables:CheckDeletedColor(deleteColorsTable,nameNewColor)
            if isDeleted == false then
                CastColors:isHEXColor(hexNewColor)
                if isHEXColor == false then
                    app.alert("This color is not in a valid HEX format! Try again...")
                    ElementsDialog:ModifyText(dialogSaveColorsSeetings,"fieldHexNewColor","")
                    return
                end
                if hexNewColor == empty then
                    app.alert("Insert a HEX value to add a new color...Try again!")
                    return
                end
                if nameNewColor == empty then
                    app.alert("Insert a NAME to add a new color...Try again!")
                    return
                end 
                isDuplicated = SearchTables:CheckDuplicateNewColor(nameNewColor,hexNewColor,newColorsTable,nameNewColorsTable)
                if isDuplicated == false then
                        SaveTables:SaveNewColors(hexNewColor,nameNewColor,typeAddNewColors[2],newColorsTable,nameNewColorsTable)
                        
                        LoadMenus:CreateItemsNewColors(plugin,nameNewColor)
                        app.alert("Color added with sucess!")
                        ElementsDialog:ModifyText(dialogSaveColorsSeetings,"fieldHexNewColor","")
                        ElementsDialog:ModifyText(dialogSaveColorsSeetings,"fieldNameNewColor","")
                end  
            else
                app.alert("Color with this name was deleted. You need to restart the Aseprite to use this name again!")
                ElementsDialog:ModifyText(dialogSaveColorsSeetings,"fieldNameNewColor","")
            end        
        end
    }
    :show()
    
end

return DialogSaveColor