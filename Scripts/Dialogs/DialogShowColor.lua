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
UpdateTables = require("Scripts.Tables.UpdateTables")
DeleteTables = require("Scripts.Tables.DeleteTables")
-------------------------------

local DialogShowColors = {}

function DialogShowColors:ShowMenu(plugin)
    local shadesNewColors = {}
    local shadesDefaultColors = {}
    local numberColors = 0
    local txtClickColor = "Click in the color to show the name and HEX value"
    local txtAnyColor = "Any colors saved at this moment!"
    shadesNewColors,numberColors = LoadMenus:ShadesColors(newColorsTable,typeColors[2])
    shadesDefaultColors = LoadMenus:ShadesColors(defaultColorsTable,typeColors[1])

    dialogShowSavedColors = Dialog("Show Colors")
        dialogShowSavedColors:label{
            id = "txtDefaultColors",
            text = "Default Colors"
        }
        dialogShowSavedColors:shades{
            id = "shades-default-colors",
            colors = shadesDefaultColors,
            onclick= function (ev)
                if ev.button == MouseButton.LEFT then
                    hexColorSelected,nameSelected = CastColors:GetNameAndHEXShadeColors(ev,typeColors[1])
                    local newText = hexColorSelected.." - "..nameSelected
                    ElementsDialog:ModifyText(dialogShowSavedColors,"list-default-colors",newText)
                end
            end    
        }
        dialogShowSavedColors:label{
            id = "list-default-colors",
            text = txtClickColor
        }
        :separator()
        dialogShowSavedColors:label{
            id = "txtYourColors",
            text = numberColors.." Saved Colors"
        }
        dialogShowSavedColors:shades{
            id = "shades-save-colors",
            colors = shadesNewColors,
            onclick= function (ev)
                if ev.button == MouseButton.LEFT then
                    hexColorSelected,nameSelected = CastColors:GetNameAndHEXShadeColors(ev,typeColors[2])
                    local newText = hexColorSelected.." - "..nameSelected
                    ElementsDialog:ModifyText(dialogShowSavedColors,"list-saved-colors",newText)
                    ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-change-color",true)
                    ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-remove-color",true)
                end
            end   
        }

        if numberColors == 0 then
            ElementsDialog:ModifyText(dialogShowSavedColors,"shades-save-colors",txtAnyColor)
        end

        dialogShowSavedColors:label{
            id = "list-saved-colors",
            text = txtClickColor
        }

        dialogShowSavedColors:button{
            visible = false,
            id = "button-change-color",
            text = "Change Color",
            onclick = function () 
                UpdateTables:ChangeSavedColor(plugin,nameSelected,hexColorSelected)
                if IsChangeCanceled == false then
                    shadesNewColors,numberColors = LoadMenus:ShadesColors(newColorsTable,typeColors[2])
                    ElementsDialog:ModifyColors(dialogShowSavedColors,"shades-save-colors",shadesNewColors)
                    ElementsDialog:ModifyText(dialogShowSavedColors,"list-saved-colors",txtClickColor)
                    ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-change-color",false)
                    ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-remove-color",false)
                    dialogShowSavedColors:repaint()
                end
            end
        }
        dialogShowSavedColors:button{
            visible = false,
            id = "button-remove-color",
            text = "Remove Color",
            onclick = function ()
                DeleteTables:DeleteSavedColor(nameSelected)
                shadesNewColors,numberColors = LoadMenus:ShadesColors(newColorsTable,typeColors[2])
                ElementsDialog:ModifyColors(dialogShowSavedColors,"shades-save-colors",shadesNewColors)
                local auxText = numberColors.." Saved Colors"
                ElementsDialog:ModifyText(dialogShowSavedColors,"txtYourColors",auxText)
                ElementsDialog:ModifyText(dialogShowSavedColors,"list-saved-colors",txtClickColor)
                ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-change-color",false)
                ElementsDialog:ModifyVisibility(dialogShowSavedColors,"button-remove-color",false)

                if numberColors == 0 then
                    ElementsDialog:ModifyText(dialogShowSavedColors,"shades-save-colors",txtAnyColor)
                end
                dialogShowSavedColors:repaint()
            end
        }
        :show()
end


return DialogShowColors