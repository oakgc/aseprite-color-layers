
-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local DialogAutomations = {}

function DialogAutomations:ShowMenu()
    dialogSeetings = Dialog("Automations")
    dialogSeetings:check{
        id="checkAlwaysColorGroup",
        text = "Always PAINT the group layer and the layers inside.",
        selected = seetingsAlwaysPaintColorGroup,
        onclick = function()
            seetingsAlwaysPaintColorGroup = dialogSeetings.data.checkAlwaysColorGroup
            preferences.AlwaysPaintColorGroup = dialogSeetings.data.checkAlwaysColorGroup
            actionInGroup = true
        end
    }
    dialogSeetings:newrow()
    dialogSeetings:check{
        id="checkRemoveColorGroup",
        text = "Always CLEAN PAINT of group layer and the layers inside.",
        selected = seetingsAlwaysRemoveColorGroup,
        onclick = function()
            seetingsAlwaysRemoveColorGroup = dialogSeetings.data.checkRemoveColorGroup
            preferences.AlwaysRemoveColorGroup = dialogSeetings.data.checkRemoveColorGroup
            actionInGroup = true
        end
    }
    dialogSeetings:show()
end

return DialogAutomations