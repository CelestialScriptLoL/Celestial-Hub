local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- GUI --
local GUI = Mercury:Create{
    Name = "Celestial Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

-- TABS --
local MainFunctionsTab = GUI:Tab{
    Name = "Best Functions 🔥",
    Icon = "rbxassetid://123928868710898"
}

local TravelFunctionsTab = GUI:Tab{
    Name = "Travel Functions 💺🛬",
    Icon = "rbxassetid://130454774717153"
}

local EventFunctionsTab = GUI:Tab{
    Name = "Event Functions 💎",
    Icon = "rbxassetid://125871408037565"
}

-- MAINFUNCTIONSTABINTERACTION --
MainFunctionsTab:Toggle{
    Name = "Kill Aura ☠",
    StartingState = false,
    Description = "Useful for all maps of Vesteria for grinding or leveling up ✨",
    Callback = function(state) end
}

MainFunctionsTab:Toggle{
    Name = "Esp Mobs 👀",
    StartingState = false,
    Description = "Useful for seeing all mobs in the map",
    Callback = function(state) end
}

-- TRAVELFUNCTIONSINTERACTION --
TravelFunctionsTab:Button{
    Name = "Fly",
    Description = "ACTIVATE ONLY ONCE",
    Callback = function() end
}

-- Tabla de lugares Vesteria y sus nombres
local VesteriaPlace = {
    Mushtown = 2064647391,
    GreatCrossroads = 3852057184,
    Nilgarf = 2119298605,
    NilgarfSewers = 2878620739,
    TreeOfLife = 3112029149,
    RedwoodStronghold = 2470481225,
    PortFidelio = 2546689567,
    DragonsPerch = 16039674538,
    TerulsMaw = 9725582014,
    WhisperingDunes = 3303140173,
    ForsakenIsle = 3806158069,
    SpiderQueensLair = 2677014001,
    TheColosseum = 2496503573,
    LostCorridor = 3460262616,
    ThePit = 4789838965,
    ShiprockBottom = 3232913902,
    CrabbyDen = 2544075708,
    MushroomGrotto = 2060360203,
    TributeWars = 4837338537
}

-- Referencia al RemoteFunction
local PlayerRequest = game:GetService("ReplicatedStorage").network.RemoteFunction.playerRequest_useTeleporter

-- Lista de destinos de teleport y mapeo de nombres
local Teleports = {}
local ActualTeleports = {}

-- Buscar todos los teleportDestinations en el workspace
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ObjectValue") and v.Name == "teleportDestination" then
        -- Obtener el valor del destino de teleport
        local teleportValue = v.Value
        local teleportName = "Unknown"  -- Nombre predeterminado

        -- Si el valor coincide con alguna de las IDs de Vesteria, usar el nombre correspondiente
        for name, id in pairs(VesteriaPlace) do
            if teleportValue == id then
                teleportName = name
                break
            end
        end

        -- Agregar el nombre del teleport al Dropdown
        local teleportParent = v.Parent
        Teleports[#Teleports + 1] = teleportName
        ActualTeleports[teleportName] = teleportParent
    end
end

-- Asegurándonos de que 'Teleports' contiene solo los nombres de los lugares y que están correctamente formateados
if #Teleports == 0 then
    warn("No se encontraron destinos de teletransporte en el mapa.")
end

-- Crear el Dropdown con los destinos de teleport
local MyDropdown = TravelFunctionsTab:Dropdown{
    Name = "Maps Travel",
    StartingText = "Select...",
    Description = "Select a teleport location 🌍",
    Items = Teleports, -- Asegúrate de que 'Teleports' contenga solo nombres de lugares
    Callback = function(selected)
        -- Si el nombre seleccionado existe en el mapeo, teletransportar
        if ActualTeleports[selected] then
            local teleport = ActualTeleports[selected]
            local success, result = pcall(function()
                -- Llamar a la función para teletransportarse
                PlayerRequest:InvokeServer(teleport)
            end)
            if not success then
                warn("❌ Error al teletransportarse:", result)
            end
        else
            warn("⚠️ No se encontró el teleporter seleccionado.")
        end
    end
}
