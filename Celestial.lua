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
	Description = "Usefull for all maps of Vesteria for grind or lvl up ✨",
	Callback = function(state) end
}

MainFunctionsTab:Toggle{
	Name = "Esp Mobs 👀",
	StartingState = false,
	Description = "Usefull for see all mobs in the map ",
	Callback = function(state) end
}

-- TRAVELFUNCTIONSINTERACTION --
TravelFunctionsTab:Button{
	Name = "Fly",
	Description = "ACTIVATE ONLY ONCE",
	Callback = function() end
}

-- Servicios
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerRequest = ReplicatedStorage.network.RemoteFunction.playerRequest_useTeleporter

-- Tabla de lugares Vesteria
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

-- Función para invertir la tabla VesteriaPlace (para buscar nombre por ID)
local placeNamesById = {}
for name, id in pairs(VesteriaPlace) do
    placeNamesById[id] = name
end

-- Recolectar todos los teleportDestination válidos
local teleportDestinations = {}

local function buscarDestinosEn(path)
    if path and path:IsA("Folder") or path:IsA("Model") then
        for _, obj in ipairs(path:GetDescendants()) do
            if obj:IsA("IntValue") and obj.Name == "teleportDestination" then
                local id = obj.Value
                local displayName = placeNamesById[id] or ("Unknown (" .. tostring(id) .. ")")
                table.insert(teleportDestinations, {
                    displayName,
                    id
                })
            end
        end
    end
end

-- Buscar en los paths
buscarDestinosEn(workspace:FindFirstChild("TeleportBrick"))
buscarDestinosEn(workspace:FindFirstChild("teleportPart"))

-- Crear el Dropdown con callback funcional
TravelFunctionsTab:Dropdown{
    Name = "Maps Travel",
    StartingText = "Select...",
    Description = "Select a place to teleport 😎",
    Items = teleportDestinations,
    Callback = function(placeId)
        if placeId and typeof(placeId) == "number" then
            local success, err = pcall(function()
                PlayerRequest:InvokeServer(placeId)
            end)
            if not success then
                warn("Error al teletransportarse:", err)
            end
        end
    end
}
