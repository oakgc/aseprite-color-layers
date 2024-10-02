-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
-------------------------------
local SearchTables = {}

-- Match the name of Color with the index of Colors values
function SearchTables:SearchByINDEX(tableColor, searchIndex)
    for index,valueColor in pairs(tableColor) do
        if index == searchIndex then
            return valueColor
        end
    end
    return nil
end
-- Match the Color Object to get the name of color
function SearchTables:SearchByValue(tableColor, searchIndex)
    searchIndex = Auxiliar:UpperString(searchIndex)
    for index,value in pairs(tableColor) do
        value = Auxiliar:UpperString(value)
        if value == searchIndex then
            return index
        end
    end
    return nil
end

-- Match the HEX Color to get the name of color
function SearchTables:IndexOfHEX(tableColor, searchIndex)
    searchIndex = CastColors:InsertAstericInHEX(searchIndex)
    searchIndex = Auxiliar:UpperString(searchIndex)
    for index,valueColor in pairs(tableColor) do
        valueColor = Auxiliar:UpperString(valueColor)
        if valueColor == searchIndex then
            return index
        end
    end
    return nil
end

function SearchTables:CheckDeletedColor(table,name)
    local index = SearchTables:SearchByValue(table,name)
    if index ~= nil then
        isDeleted = true
    else
        isDeleted = false    
    end
end    

function SearchTables:CheckDuplicateNewColor(name,hex,tableColor,tableNameColor)
    local indexHEX
    local indexName

    indexHEX = SearchTables:IndexOfHEX(tableColor,hex)
    if indexHEX ~= nil then
        app.alert("This color was added before...Try again!")
        return true
    end

    indexName = SearchTables:SearchByValue(tableNameColor,name)
    if indexName ~= nil then
        app.alert("This name is being used in another color!...Try again!")
        return true
    end
  
    return false
end

return SearchTables
