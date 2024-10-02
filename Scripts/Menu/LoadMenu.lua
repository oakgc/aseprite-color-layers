-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
PaintColor = require("Scripts.Actions.PaintColor")
-------------------------------

local LoadMenus = {}

--Iterate the array to create all the options of default colors menu
function LoadMenus:DefaultColorOptions(plugin)
    for index,value in ipairs(nameDefaultColorsTable) do
        plugin:newCommand{
            id ="default-color-".. value,
            title = value,
            group = "default-colors",
            onclick = function ()
                PaintColor:PaintCheckings(value,typeColors[1])
            end
        }
    end    
end

--Iterate the array to create all options of new colors menu
function LoadMenus:CreateItemsNewColors(plugin,nameColor)
    plugin:newCommand{
        id ="saved-color-".. nameColor,
        title = nameColor,
        group = "id-saved-colors",
        onclick = function ()
            PaintColor:PaintCheckings(nameColor,typeColors[2])
        end,
        onenabled = function ()
            local index = SearchTables:SearchByINDEX(newColorsTable,nameColor)
            if index == nil then
                return false
            else    
                return true
            end
        end
    }  
end

--Create options of new colors in menu
function LoadMenus:NewColorOptions(plugin)
    if nameNewColorsTable ~= {} then
        for index,value in ipairs(nameNewColorsTable) do
            LoadMenus:CreateItemsNewColors(plugin,value)
        end
    end
end

function LoadMenus:ShadesColors(tableColor,type)
    local shades = {}
    local length = 0
    for index,value in pairs(tableColor) do
        shades[index] = CastColors:HEXToRgb(value)
        if type == typeColors[2] then
            length = length + 1
        end
    end 
    return shades,length
end


return LoadMenus
