--[[
MIT LICENSE
Copyright © 2024 Gabriel Carvalho [oakgc]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

######################################
Author: Gabriel Carvalho
Last Update: October/2024
Release Updates:
    Version 1.0 (10/24)
        First version of the extension.
######################################

]]
-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

-------------------------------
-- * SCRIPTS 
-------------------------------
--Auxiliar
Auxiliar = require("Scripts.Auxiliar.Auxiliar")
UserData = require("Scripts.Auxiliar.UserData")
--Menus
MainMenu = require("Scripts.Menu.MainMenu")
--Tables
SaveTables = require("Scripts.Tables.SaveTables")
-------------------------------
-- * GLOBAL VARIABLES
-------------------------------
    actionInGroup = false                               -- define the action will act in all layers of group
    isDuplicated = false                                -- check if the color is save in the table
    isDeleted = false
    IsRangeSelected = false                             -- check if the selection layer is a range of layer is empty
    isHEXColor = false
    seetingsAlwaysPaintColorGroup = false               -- automatize the paint of all layers in an group
    seetingsAlwaysRemoveColorGroup = false              -- automatize the remotion of all layers in an group
    defaultColorTheme = app.theme.color.color_name      -- default color of your theme    
    
    keyJsonPreferences = {"NewColors","NameNewColors"}
    typeTables = {"Index","Value"}
    typeActions = {"Paint","Clean"}
    typeColors = {"Default","New"}
    typeAddNewColors = {"Change","New","Deleted"}
    txtMode = {" paint ", " clean "}

    nameDefaultColorsTable = {"Red","Orange","Yellow","Green","Blue","Violet","Gray"}
    defaultColorsTable ={
        ["Red"] = "#b45252",
        ["Orange"] = "#d3a068",      
        ["Yellow"] = "#cfc278",      
        ["Green"] = "#8ab060",        
        ["Blue"] = "#68c2d3",        
        ["Violet"] = "#4b4158",         
        ["Gray"] = "#868188", 
    }      
    preferences = {["AlwaysPaintColorGroup"] = false, ["AlwaysRemoveColorGroup"] = false } -- new table for user seetings
    nameNewColorsTable = {} -- new table to create the menu with the name of new colors (Save color in HEX here)
    newColorsTable = {} -- new table for new colors the user set to use
    deleteColorsTable = {}

--Initialize the extension 
function init(plugin)
    UserData:GetUserDataFromFile(plugin)
    newColorsTable = UserData:LoadNewColorsFromPreferences(preferences,keyJsonPreferences[1])
    nameNewColorsTable = UserData:LoadNewColorsFromPreferences(preferences,keyJsonPreferences[2])
    MainMenu:CreateMenu(plugin)
end

--Finalize the extension
function exit(plugin)
    UserData:SavePreferencesClose(plugin)
end

