-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-------------------------------
-- * SCRIPTS 
-------------------------------
--Tables
SearchTables = require("Scripts.Tables.SearchTables")
-------------------------------
local CastColors = {}

function CastColors:RemoveAstericInHEX(hex)
    if string.sub(hex,1,1) == "#" then
        hex = string.sub(hex,2,string.len(hex))
    end
	return hex
end

function CastColors:InsertAstericInHEX(hex)
    local asteric = string.sub(hex,1,1)
    if asteric ~= "#" then
        hex = "#"..hex
    end 
    return hex
end

--check if the format of the color is HEX
function CastColors:isHEXColor(color)
    color = CastColors:InsertAstericInHEX(color)
    -- check if the string has #RRGGBB or #RRGGBBAA format
    local format6dig = string.match(color,"^#%x%x%x%x%x%x$")
    local format8dig = string.match(color,"^#%x%x%x%x%x%x%x%x$")
    
    if (format6dig or format8dig) ~= nil then
        isHEXColor = true
    else
        isHEXColor = false
    end        
  end
--convert Hex color to RGB color
function CastColors:HEXToRgb(hex)
    hex = CastColors:RemoveAstericInHEX(hex)
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return Color(r, g, b)
end
--conver RGB to HEX
function CastColors:RGBToHex(red, green, blue, alpha)
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end
	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end
end

--Get the HEX and the name of colors to use in the Show Colors menu
function CastColors:GetNameAndHEXShadeColors(ev,type)
    local hex = CastColors:RGBToHex(ev.color.red,ev.color.green,ev.color.blue) 
    local name
    if type == typeColors[1] then
        name = SearchTables:IndexOfHEX(defaultColorsTable,hex)
    else
        name = SearchTables:IndexOfHEX(newColorsTable,hex)
    end
    if name == nil then
        name = ""
    end
    return hex,name
end


return CastColors