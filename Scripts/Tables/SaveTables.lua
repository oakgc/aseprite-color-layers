-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
-------------------------------
local SaveTables = {}

--Save the new color in a auxiliar table to use
function SaveTables:SaveNewColors(hex,name,type,tableColor,tableNameColor)
    hex = Auxiliar:UpperString(hex)
    if type == typeAddNewColors[2] then
        table.insert(tableNameColor,name)  
        tableColor[name] = hex
    end
    if type == typeAddNewColors[3]then
        table.insert(tableColor,name)    
    end
end

return SaveTables