-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Menus
LoadMenus = require("Scripts.Menu.LoadMenu")
--Dialogs
DialogShowColors = require("Scripts.Dialogs.DialogShowColor")
DialogAutomations = require("Scripts.Dialogs.DialogAutomations")
DialogSaveColor = require("Scripts.Dialogs.DialogSaveColor")
--Actions
RemoveColor = require("Scripts.Actions.RemoveColor")
-------------------------------
local MainMenu = {}

--Include the access to this extension in View Menu
function MainMenu:CreateMenu(plugin)
    plugin:newMenuGroup{
        id ="colors-To-Layers",
        title ="Paint Layer",
        group = "layer_popup_properties"
    }
    plugin:newMenuGroup{
        id = "default-colors",
        title = "Default Colors",
        group = "colors-To-Layers",
    }

    LoadMenus:DefaultColorOptions(plugin)

    plugin:newMenuGroup{
        id ="id-saved-colors",
        title = "Saved Colors",
        group = "colors-To-Layers",
    }
    --if the table is empty not start the menu
    LoadMenus:NewColorOptions(plugin)

    plugin:newCommand{
        id ="id-remove-colors",
        title = "Clean Color",
        group = "colors-To-Layers",
        onclick = function ()
            RemoveColor:RemoveCheckings()
        end
    }
    plugin:newMenuSeparator{ group = "colors-To-Layers"}
    plugin:newCommand{
        id = "show-saved-colors-seetings",
        title = "Show All Colors",
        group = "colors-To-Layers",
        onclick = function ()
            DialogShowColors:ShowMenu(plugin)
        end
    }
    plugin:newCommand{
        id = "saved-colors-seetings",
        title = "Save new color",
        group = "colors-To-Layers",
        onclick = function ()
            DialogSaveColor:ShowMenu(plugin)
        end
    }
    plugin:newMenuSeparator{ group = "colors-To-Layers"}
    plugin:newCommand{
        id ="automations-seetings",
        title = "Automations",
        group = "colors-To-Layers",
        onclick = function ()
            DialogAutomations:ShowMenu()
        end
    }
end

return MainMenu
