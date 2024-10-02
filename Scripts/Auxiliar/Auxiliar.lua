-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local Auxiliar = {}

function Auxiliar:UpperString(text)
    text = string.upper(text)
    return text
end    

return Auxiliar
