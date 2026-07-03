--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyButtonGui"
screenGui.Parent = gui
local button = Instance.new("TextButton")
button.Name = "MyButton"
button.Font = Enum.Font.SourceSansBold
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0, 10, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(255,255,255)
button.Text = "Stop Tween"
button.Parent = screenGui
local function onClick()
    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
end
button.MouseButton1Click:Connect(onClick)

local RepoBase = "https://raw.githubusercontent.com/D4RK7H3N/DarkZhub/refs/heads/master"
local Fluent = loadstring(game:HttpGet(RepoBase .. "/Libs/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet(RepoBase .. "/Libs/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet(RepoBase .. "/Libs/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Byte Hub",
    SubTitle = "by damthien | https://discord.gg/PF36rvJXN4",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 320),
    Acrylic = true,
    Theme = "Black",
    MinimizeKey = Enum.KeyCode.End
})
local Tabs = {
    profile = Window:AddTab({ Title = "Information", Icon = "scan-face" }),
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Sea = Window:AddTab({ Title = "Sea Event", Icon = "anchor" }),
    Setting = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Status = Window:AddTab({ Title = "Server Stats", Icon = "activity" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "plus-circle" }),
    Player = Window:AddTab({ Title = "Player pvp", Icon = "baby" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "palmtree" }),
    Fruit = Window:AddTab({ Title = "Fruit Blox ESP", Icon = "apple" }),
    Raid = Window:AddTab({ Title = "Dungeon", Icon = "swords" }),
    Race = Window:AddTab({ Title = "Race Trial V4", Icon = "chevrons-right" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "list-plus" }),
    Hop = Window:AddTab({ Title = "Hop Server", Icon = "wifi" }),
}
local Options = Fluent.Options

-- Sea World check
First_Sea = false
Second_Sea = false
Third_Sea = false
local pid = game.PlaceId
if pid == 2753915549 then First_Sea = true
elseif pid == 4442272183 then Second_Sea = true
elseif pid == 7449423635 then Third_Sea = true
else game:Shutdown() end

function AntiBan()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
                v:Destroy()
            end
        end
    end
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp" or v.Name == "PlayerList" then
                v:Destroy()
            end
        end
    end
end
AntiBan()

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Default values
posX = 0; posY = 30; posZ = 0
SkillZ = true; SkillX = true; SkillC = true; SkillV = true; SkillF = false
_G.Fast_Delay = 0.12
bringmob = false

local QuestLevel = {
	["1"] = "1",
	["2"] = "2",
	["3"] = "3",
	["4"] = "4",
	["5"] = "5",
}
function CheckLevel()
    local Level = game:GetService("Players").LocalPlayer.Data.Level.Value
    local SelectMonster = ""
    local SelectArea = ""
    if First_Sea then
        if Level == 0 or Level == 1 then SelectMonster = "Bandit" SelectArea = "Jungle" end
        if Level >= 10 then SelectMonster = "Monkey" SelectArea = "Jungle" end
        if Level >= 15 then SelectMonster = "Gorilla" SelectArea = "Jungle" end
        if Level >= 30 then SelectMonster = "Mercenary" SelectArea = "Arena" end
        if Level >= 60 then SelectMonster = "Snowman" SelectArea = "FrostMountain" end
        if Level >= 90 then SelectMonster = "Chief" SelectArea = "FrostMountain" end
        if Level >= 100 then SelectMonster = "SnowMountain" SelectArea = "FrostMountain" end
        if Level >= 120 then SelectMonster = "Mage" SelectArea = "Magma" end
        if Level >= 150 then SelectMonster = "Mugger" SelectArea = "PortTown" end
        if Level >= 180 then SelectMonster = "DesertOfficer" SelectArea = "Desert" end
        if Level >= 210 then SelectMonster = "DesertBandit" SelectArea = "Desert" end
        if Level >= 240 then SelectMonster = "DesertChief" SelectArea = "Desert" end
        if Level >= 270 then SelectMonster = "Pirate" SelectArea = "SnowIsland" end
        if Level >= 300 then SelectMonster = "Brute" SelectArea = "SnowIsland" end
        if Level >= 330 then SelectMonster = "Thunder" SelectArea = "Sky" end
        if Level >= 375 then SelectMonster = "Shark" SelectArea = "Prison" end
        if Level >= 400 then SelectMonster = "Shanda" SelectArea = "Sky" end
        if Level >= 450 then SelectMonster = "RebornSkeleton" SelectArea = "Fountain" end
        if Level >= 480 then SelectMonster = "LivingZombie" SelectArea = "Fountain" end
        if Level >= 500 then SelectMonster = "DemonicSoul" SelectArea = "Fountain" end
        if Level >= 525 then SelectMonster = "RebornSkeleton" SelectArea = "Ghost" end
        if Level >= 550 then SelectMonster = "LivingZombie" SelectArea = "Ghost" end
        if Level >= 575 then SelectMonster = "DemonicSoul" SelectArea = "Ghost" end
        if Level >= 625 then SelectMonster = "Undead" SelectArea = "Graveyard" end
        if Level >= 650 then SelectMonster = "Undead" SelectArea = "Graveyard" end
        if Level >= 675 then SelectMonster = "Militia" SelectArea = "Colosseum" end
        if Level >= 700 then SelectMonster = "Cobra" SelectArea = "Colosseum" end
        if Level >= 725 then SelectMonster = "Mercenary" SelectArea = "Colosseum" end
        if Level >= 750 then SelectMonster = "GodsGuardian" SelectArea = "Citadel" end
        if Level >= 775 then SelectMonster = "GodsGuardian" SelectArea = "Temple" end
        if Level >= 800 then SelectMonster = "Wally" SelectArea = "SharkPark" end
        if Level >= 850 then SelectMonster = "Dragon" SelectArea = "GreatTree" end
        if Level >= 875 then SelectMonster = "Dragon" SelectArea = "GreatTree" end
        if Level >= 900 then SelectMonster = "Hydra" SelectArea = "GreatTree" end
        if Level >= 950 then SelectMonster = "Hydra" SelectArea = "GreatTree" end
    end
    if Second_Sea then
        if Level >= 700 then SelectMonster = "Raider" SelectArea = "Rabbit" end
        if Level >= 725 then SelectMonster = "Mercenary" SelectArea = "Rabbit" end
        if Level >= 750 then SelectMonster = "Swan" SelectArea = "Rabbit" end
        if Level >= 775 then SelectMonster = "FactoryStaff" SelectArea = "Factory" end
        if Level >= 800 then SelectMonster = "Monster" SelectArea = "Factory" end
        if Level >= 825 then SelectMonster = "Monster" SelectArea = "Factory" end
        if Level >= 850 then SelectMonster = "Dragon" SelectArea = "Usoapp" end
        if Level >= 875 then SelectMonster = "Dragon" SelectArea = "Usoapp" end
        if Level >= 900 then SelectMonster = "Pirate" SelectArea = "Usoapp" end
        if Level >= 950 then SelectMonster = "Pirate" SelectArea = "Usoapp" end
        if Level >= 1000 then SelectMonster = "Fish" SelectArea = "Fish" end
        if Level >= 1050 then SelectMonster = "Fish" SelectArea = "Fish" end
        if Level >= 1100 then SelectMonster = "Dragon" SelectArea = "Zombie" end
        if Level >= 1125 then SelectMonster = "Dragon" SelectArea = "Zombie" end
        if Level >= 1150 then SelectMonster = "Dragon" SelectArea = "Zombie" end
        if Level >= 1175 then SelectMonster = "Monster" SelectArea = "Zombie" end
        if Level >= 1200 then SelectMonster = "Monster" SelectArea = "Zombie" end
        if Level >= 1225 then SelectMonster = "Monster" SelectArea = "Zombie" end
        if Level >= 1250 then SelectMonster = "Monster" SelectArea = "Zombie" end
        if Level >= 1300 then SelectMonster = "Raider" SelectArea = "Marine" end
        if Level >= 1325 then SelectMonster = "Raider" SelectArea = "Marine" end
        if Level >= 1350 then SelectMonster = "Mercenary" SelectArea = "Marine" end
        if Level >= 1400 then SelectMonster = "Sniper" SelectArea = "Marine" end
        if Level >= 1425 then SelectMonster = "Sniper" SelectArea = "Marine" end
        if Level >= 1450 then SelectMonster = "Sniper" SelectArea = "Marine" end
        if Level >= 1475 then SelectMonster = "Sniper" SelectArea = "Marine" end
        if Level >= 1500 then SelectMonster = "Sniper" SelectArea = "Marine" end
        if Level >= 1525 then SelectMonster = "GalleyPirate" SelectArea = "Galley" end
        if Level >= 1550 then SelectMonster = "GalleyPirate" SelectArea = "Galley" end
        if Level >= 1575 then SelectMonster = "GalleyPirate" SelectArea = "Galley" end
        if Level >= 1600 then SelectMonster = "GalleyPirate" SelectArea = "Galley" end
        if Level >= 1625 then SelectMonster = "GalleyPirate" SelectArea = "Galley" end
        if Level >= 1650 then SelectMonster = "Mercenary" SelectArea = "Seal" end
        if Level >= 1675 then SelectMonster = "Mercenary" SelectArea = "Seal" end
        if Level >= 1700 then SelectMonster = "Mercenary" SelectArea = "Seal" end
        if Level >= 1725 then SelectMonster = "Mercenary" SelectArea = "Seal" end
        if Level >= 1750 then SelectMonster = "Mercenary" SelectArea = "Seal" end
        if Level >= 1775 then SelectMonster = "Monster" SelectArea = "Seal" end
        if Level >= 1800 then SelectMonster = "Monster" SelectArea = "Seal" end
        if Level >= 1825 then SelectMonster = "Monster" SelectArea = "Seal" end
        if Level >= 1850 then SelectMonster = "Monster" SelectArea = "Seal" end
        if Level >= 1875 then SelectMonster = "Monster" SelectArea = "Seal" end
        if Level >= 1900 then SelectMonster = "Fish" SelectArea = "Fish" end
    end
    if Third_Sea then
        if Level >= 1500 then SelectMonster = "Raider" SelectArea = "Forest" end
        if Level >= 1525 then SelectMonster = "Raider" SelectArea = "Forest" end
        if Level >= 1550 then SelectMonster = "Mercenary" SelectArea = "Forest" end
        if Level >= 1575 then SelectMonster = "Mercenary" SelectArea = "Forest" end
        if Level >= 1600 then SelectMonster = "Mercenary" SelectArea = "Forest" end
        if Level >= 1625 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1650 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1675 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1700 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1725 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1750 then SelectMonster = "Sniper" SelectArea = "Savannah" end
        if Level >= 1775 then SelectMonster = "GalleyPirate" SelectArea = "Jungle" end
        if Level >= 1800 then SelectMonster = "GalleyPirate" SelectArea = "Jungle" end
        if Level >= 1825 then SelectMonster = "GalleyPirate" SelectArea = "Jungle" end
        if Level >= 1850 then SelectMonster = "GalleyPirate" SelectArea = "Jungle" end
        if Level >= 1875 then SelectMonster = "GalleyPirate" SelectArea = "Jungle" end
        if Level >= 1900 then SelectMonster = "Mercenary" SelectArea = "Pirates" end
        if Level >= 1925 then SelectMonster = "Mercenary" SelectArea = "Pirates" end
        if Level >= 1950 then SelectMonster = "Mercenary" SelectArea = "Pirates" end
        if Level >= 1975 then SelectMonster = "Mercenary" SelectArea = "Pirates" end
        if Level >= 2000 then SelectMonster = "Fish" SelectArea = "Sea" end
        if Level >= 2100 then SelectMonster = "Fish" SelectArea = "Sea" end
        if Level >= 2200 then SelectMonster = "Fish" SelectArea = "Sea" end
        if Level >= 2300 then SelectMonster = "Fish" SelectArea = "Sea" end
        if Level >= 2400 then SelectMonster = "Fish" SelectArea = "Sea" end
    end
    return SelectMonster, SelectArea
end

local tableMon = {}
local AreaList = {}
if First_Sea then
    tableMon = {
        Bandit = {"Bandit","BanditQuest"},
        Monkey = {"Monkey","JungleQuest"},
        Gorilla = {"Gorilla","JungleQuest"},
        Mercenary = {"Mercenary","ArenaQuest"},
        Snowman = {"Snowman","FrostQuest"},
        Chief = {"Chief","FrostQuest"},
        SnowMountain = {"SnowMountain","FrostQuest"},
        Mage = {"Mage","MagmaQuest"},
        Mugger = {"Mugger","PortQuest"},
        DesertOfficer = {"DesertOfficer","DesertQuest"},
        DesertBandit = {"DesertBandit","DesertQuest"},
        DesertChief = {"DesertChief","DesertQuest"},
        Pirate = {"Pirate","SnowQuest"},
        Brute = {"Brute","SnowQuest"},
        Thunder = {"Thunder","SkyQuest"},
        Shark = {"Shark","PrisonQuest"},
        Shanda = {"Shanda","SkyQuest"},
        RebornSkeleton = {"RebornSkeleton","FountainQuest"},
        LivingZombie = {"LivingZombie","FountainQuest"},
        DemonicSoul = {"DemonicSoul","FountainQuest"},
        Undead = {"Undead","GraveQuest"},
        Militia = {"Militia","ColosseumQuest"},
        Cobra = {"Cobra","ColosseumQuest"},
        GodsGuardian = {"GodsGuardian","CitadelQuest"},
        Wally = {"Wally","SharkQuest"},
        Dragon = {"Dragon","GreatTreeQuest"},
        Hydra = {"Hydra","GreatTreeQuest"},
    }
    AreaList = {
        Jungle = "Jungle", Arena = "Arena", FrostMountain = "FrostMountain",
        Magma = "Magma", PortTown = "PortTown", Desert = "Desert",
        SnowIsland = "SnowIsland", Sky = "Sky", Prison = "Prison",
        Fountain = "Fountain", Ghost = "Ghost", Graveyard = "Graveyard",
        Colosseum = "Colosseum", Citadel = "Citadel", Temple = "Temple",
        SharkPark = "SharkPark", GreatTree = "GreatTree",
    }
elseif Second_Sea then
    tableMon = {
        Raider = {"Raider","RabbitQuest"},
        Swan = {"Swan","RabbitQuest"},
        FactoryStaff = {"FactoryStaff","FactoryQuest"},
        Monster = {"Monster","FactoryQuest"},
        Pirate = {"Pirate","UsoappQuest"},
        Fish = {"Fish","FishQuest"},
        Dragon = {"Dragon","ZombieQuest"},
        Mercenary = {"Mercenary","MarineQuest"},
        Sniper = {"Sniper","MarineQuest"},
        GalleyPirate = {"GalleyPirate","GalleyQuest"},
    }
    AreaList = {
        Rabbit = "Rabbit", Factory = "Factory", Usoapp = "Usoapp",
        Fish = "Fish", Zombie = "Zombie", Marine = "Marine",
        Galley = "Galley", Seal = "Seal",
    }
elseif Third_Sea then
    tableMon = {
        Raider = {"Raider","ForestQuest"},
        Mercenary = {"Mercenary","ForestQuest"},
        Sniper = {"Sniper","SavannahQuest"},
        GalleyPirate = {"GalleyPirate","JungleQuest"},
        Fish = {"Fish","SeaQuest"},
    }
    AreaList = {
        Forest = "Forest", Savannah = "Savannah", Jungle = "Jungle",
        Pirates = "Pirates", Sea = "Sea",
    }
end

function CheckBossQuest()
    local lvl = game:GetService("Players").LocalPlayer.Data.Level.Value
    if First_Sea then
        if lvl >= 0 then return "SaberExpert","SaberExpert" end
        if lvl >= 20 then return "TheStrongest","TheStrongest" end
        if lvl >= 60 then return "Yeti","Yeti" end
        if lvl >= 100 then return "Ice Admiral","IceAdmiral" end
        if lvl >= 130 then return "CursedCaptain","CursedCaptain" end
        if lvl >= 200 then return "Diablo","Diablo" end
        if lvl >= 230 then return "Urban","Urban" end
        if lvl >= 300 then return "God's Guard","GodGuard" end
        if lvl >= 350 then return "Magma Admiral","MagmaAdmiral" end
        if lvl >= 400 then return "Diamond","Diamond" end
        if lvl >= 450 then return "Jeremy","Jeremy" end
        if lvl >= 500 then return "Fajita","Fajita" end
        if lvl >= 550 then return "Order","Order" end
        if lvl >= 600 then return "Awakening","Awakening" end
        if lvl >= 650 then return "V2","V2" end
        if lvl >= 700 then return "SaberExpert","SaberExpert" end
    elseif Second_Sea then
        if lvl >= 700 then return "Diamond","Diamond" end
        if lvl >= 775 then return "Jeremy","Jeremy" end
        if lvl >= 850 then return "Fajita","Fajita" end
        if lvl >= 925 then return "Order","Order" end
        if lvl >= 1000 then return "Awakening","Awakening" end
        if lvl >= 1075 then return "V2","V2" end
        if lvl >= 1150 then return "V3","V3" end
        if lvl >= 1225 then return "V4","V4" end
        if lvl >= 1300 then return "V5","V5" end
    elseif Third_Sea then
        if lvl >= 1500 then return "SaberExpert","SaberExpert" end
        if lvl >= 1600 then return "TheStrongest","TheStrongest" end
        if lvl >= 1700 then return "Yeti","Yeti" end
        if lvl >= 1800 then return "Ice Admiral","IceAdmiral" end
        if lvl >= 1900 then return "CursedCaptain","CursedCaptain" end
        if lvl >= 2000 then return "Diablo","Diablo" end
    end
end

function MaterialMon()
    local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    local Ms = ""
    if First_Sea then
        if MyLevel >= 0 then Ms = "Bandit" end
        if MyLevel >= 10 then Ms = "Monkey" end
        if MyLevel >= 30 then Ms = "Gorilla" end
        if MyLevel >= 60 then Ms = "Mercenary" end
        if MyLevel >= 100 then Ms = "Snowman" end
        if MyLevel >= 120 then Ms = "Chief" end
        if MyLevel >= 150 then Ms = "Mage" end
        if MyLevel >= 180 then Ms = "Mugger" end
        if MyLevel >= 210 then Ms = "DesertOfficer" end
        if MyLevel >= 240 then Ms = "DesertBandit" end
        if MyLevel >= 270 then Ms = "DesertChief" end
        if MyLevel >= 300 then Ms = "Pirate" end
        if MyLevel >= 330 then Ms = "Brute" end
        if MyLevel >= 375 then Ms = "Thunder" end
        if MyLevel >= 400 then Ms = "Shark" end
        if MyLevel >= 450 then Ms = "Shanda" end
        if MyLevel >= 500 then Ms = "RebornSkeleton" end
        if MyLevel >= 525 then Ms = "LivingZombie" end
        if MyLevel >= 550 then Ms = "DemonicSoul" end
        if MyLevel >= 625 then Ms = "Undead" end
        if MyLevel >= 675 then Ms = "Militia" end
        if MyLevel >= 725 then Ms = "Cobra" end
        if MyLevel >= 750 then Ms = "GodsGuardian" end
        if MyLevel >= 800 then Ms = "Wally" end
        if MyLevel >= 850 then Ms = "Dragon" end
        if MyLevel >= 950 then Ms = "Hydra" end
    elseif Second_Sea then
        if MyLevel >= 700 then Ms = "Raider" end
        if MyLevel >= 775 then Ms = "Swan" end
        if MyLevel >= 850 then Ms = "FactoryStaff" end
        if MyLevel >= 925 then Ms = "Monster" end
        if MyLevel >= 1000 then Ms = "Pirate" end
        if MyLevel >= 1100 then Ms = "Fish" end
        if MyLevel >= 1200 then Ms = "Dragon" end
        if MyLevel >= 1300 then Ms = "Mercenary" end
        if MyLevel >= 1400 then Ms = "Sniper" end
        if MyLevel >= 1525 then Ms = "GalleyPirate" end
    elseif Third_Sea then
        if MyLevel >= 1500 then Ms = "Raider" end
        if MyLevel >= 1625 then Ms = "Sniper" end
        if MyLevel >= 1775 then Ms = "GalleyPirate" end
        if MyLevel >= 1900 then Ms = "Mercenary" end
        if MyLevel >= 2000 then Ms = "Fish" end
    end
    return Ms
end

------------------- ESP Functions ------------------------
function UpdateIslandESP()
    for i,v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
        if v.ClassName == "Part" or v.ClassName == "MeshPart" then
            if not v:FindFirstChild("ESPName") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "ESPName"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = v.Name
                txt.TextColor3 = Color3.new(255,255,255)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end

function UpdatePlayerChams()
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game:GetService("Players").LocalPlayer.Name then
            if v.Character and v.Character:FindFirstChild("Highlight") then
                v.Character.Highlight:Destroy()
            end
            if v.Character then
                local hl = Instance.new("Highlight",v.Character)
                hl.FillColor = Color3.fromRGB(255,0,0)
                hl.OutlineColor = Color3.fromRGB(255,255,255)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
            end
        end
    end
end

function UpdateChestChams()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
            if v:FindFirstChild("Highlight") then v.Highlight:Destroy() end
            local hl = Instance.new("Highlight",v)
            hl.FillColor = Color3.fromRGB(0,255,0)
            hl.OutlineColor = Color3.fromRGB(255,255,255)
            hl.FillTransparency = 0.3
            hl.OutlineTransparency = 0
        end
    end
end

function UpdateDevilChams()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "DevilFruit" then
            if v:FindFirstChild("Highlight") then v.Highlight:Destroy() end
            local hl = Instance.new("Highlight",v)
            hl.FillColor = Color3.fromRGB(255,0,255)
            hl.OutlineColor = Color3.fromRGB(255,255,255)
            hl.FillTransparency = 0.3
            hl.OutlineTransparency = 0
        end
    end
end

function UpdateFlowerChams()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "Fruit" or v.Name == "Fruit2" then
            if v:FindFirstChild("Highlight") then v.Highlight:Destroy() end
            local hl = Instance.new("Highlight",v)
            hl.FillColor = Color3.fromRGB(255,165,0)
            hl.OutlineColor = Color3.fromRGB(255,255,255)
            hl.FillTransparency = 0.3
            hl.OutlineTransparency = 0
        end
    end
end

function UpdateRealFruitChams()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:FindFirstChild("Fruit") and not v:FindFirstChild("Highlight") then
            local hl = Instance.new("Highlight",v.Fruit)
            hl.FillColor = Color3.fromRGB(0,255,255)
            hl.OutlineColor = Color3.fromRGB(255,255,255)
            hl.FillTransparency = 0.3
            hl.OutlineTransparency = 0
        end
    end
end

spawn(function()
    while wait(5) do UpdateIslandESP() end
end)
spawn(function()
    while wait(3) do UpdatePlayerChams() end
end)
spawn(function()
    while wait(5) do UpdateChestChams() end
end)
spawn(function()
    while wait(5) do UpdateDevilChams() end
end)
spawn(function()
    while wait(5) do UpdateFlowerChams() end
end)
spawn(function()
    while wait(5) do UpdateRealFruitChams() end
end)

-- MobESP
spawn(function()
    while wait(3) do
        for i,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                if not v.HumanoidRootPart:FindFirstChild("MobESP") then
                    local b = Instance.new("BillboardGui",v.HumanoidRootPart)
                    b.Name = "MobESP"
                    b.Size = UDim2.new(4,0,0.5,0)
                    b.AlwaysOnTop = true
                    b.StudsOffset = Vector3.new(0,3,0)
                    b.Adornee = v.HumanoidRootPart
                    local txt = Instance.new("TextLabel",b)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextScaled = true
                    txt.Text = v.Name
                    txt.TextColor3 = Color3.new(255,0,0)
                    txt.Font = Enum.Font.SourceSansBold
                end
            end
        end
    end
end)

-- SeaESP
spawn(function()
    while wait(5) do
        if game:GetService("Workspace"):FindFirstChild("Sea") then
            for i,v in pairs(game:GetService("Workspace").Sea:GetChildren()) do
                if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                    if not v:FindFirstChild("SeaESP") then
                        local b = Instance.new("BillboardGui",v)
                        b.Name = "SeaESP"
                        b.Size = UDim2.new(4,0,0.5,0)
                        b.AlwaysOnTop = true
                        b.StudsOffset = Vector3.new(0,2,0)
                        b.Adornee = v
                        local txt = Instance.new("TextLabel",b)
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.BackgroundTransparency = 1
                        txt.TextScaled = true
                        txt.Text = v.Name
                        txt.TextColor3 = Color3.new(0,150,255)
                        txt.Font = Enum.Font.SourceSansBold
                    end
                end
            end
        end
    end
end)

-- NpcESP
spawn(function()
    while wait(5) do
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name == "Npc" and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                if not v.HumanoidRootPart:FindFirstChild("NpcESP") then
                    local b = Instance.new("BillboardGui",v.HumanoidRootPart)
                    b.Name = "NpcESP"
                    b.Size = UDim2.new(4,0,0.5,0)
                    b.AlwaysOnTop = true
                    b.StudsOffset = Vector3.new(0,2,0)
                    b.Adornee = v.HumanoidRootPart
                    local txt = Instance.new("TextLabel",b)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextScaled = true
                    txt.Text = v.Name
                    txt.TextColor3 = Color3.new(255,255,0)
                    txt.Font = Enum.Font.SourceSansBold
                end
            end
        end
    end
end)

-- MirageIslandESP
function MirageIslandESP()
    if game:GetService("Workspace"):FindFirstChild("MirageIsland") then
        for i,v in pairs(game:GetService("Workspace").MirageIsland:GetDescendants()) do
            if v.ClassName == "Part" and not v:FindFirstChild("MIESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "MIESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Mirage Island"
                txt.TextColor3 = Color3.new(0,255,255)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do MirageIslandESP() end end)

-- PrehistoricIslandESP
function PrehistoricIslandESP()
    if game:GetService("Workspace"):FindFirstChild("PrehistoricIsland") then
        for i,v in pairs(game:GetService("Workspace").PrehistoricIsland:GetDescendants()) do
            if v.ClassName == "Part" and not v:FindFirstChild("PIESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "PIESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Prehistoric Island"
                txt.TextColor3 = Color3.new(255,100,0)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do PrehistoricIslandESP() end end)

-- AdvancedFruitDealerESP
function AdvancedFruitDealerESP()
    if game:GetService("Workspace"):FindFirstChild("AdvancedFruitDealer") then
        for i,v in pairs(game:GetService("Workspace").AdvancedFruitDealer:GetDescendants()) do
            if v.ClassName == "Part" and not v:FindFirstChild("AFDESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "AFDESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Fruit Dealer"
                txt.TextColor3 = Color3.new(255,215,0)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do AdvancedFruitDealerESP() end end)

-- AuraESP
function AuraESP()
    if game:GetService("Workspace"):FindFirstChild("Auras") then
        for i,v in pairs(game:GetService("Workspace").Auras:GetDescendants()) do
            if v:IsA("Part") and not v:FindFirstChild("AuraESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "AuraESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Aura"
                txt.TextColor3 = Color3.new(255,0,255)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do AuraESP() end end)

-- LegendarySwordESP
function LegendarySwordESP()
    if game:GetService("Workspace"):FindFirstChild("LegendarySword") then
        for i,v in pairs(game:GetService("Workspace").LegendarySword:GetDescendants()) do
            if v:IsA("Part") and not v:FindFirstChild("LSESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "LSESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Legendary Sword"
                txt.TextColor3 = Color3.new(255,165,0)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do LegendarySwordESP() end end)

-- GearESP
function GearESP()
    if game:GetService("Workspace"):FindFirstChild("Gears") then
        for i,v in pairs(game:GetService("Workspace").Gears:GetDescendants()) do
            if v:IsA("Part") and not v:FindFirstChild("GearESP") then
                local b = Instance.new("BillboardGui",v)
                b.Name = "GearESP"
                b.Size = UDim2.new(4,0,0.5,0)
                b.AlwaysOnTop = true
                b.StudsOffset = Vector3.new(0,2,0)
                b.Adornee = v
                local txt = Instance.new("TextLabel",b)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextScaled = true
                txt.Text = "Gear"
                txt.TextColor3 = Color3.new(0,255,0)
                txt.Font = Enum.Font.SourceSansBold
            end
        end
    end
end
spawn(function() while wait(5) do GearESP() end end)

------------------- Tween Functions ------------------------
function Tween(target)
    local tween_s = game:GetService("TweenService")
    local info = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - target.Position).Magnitude/300, Enum.EasingStyle.Linear)
    tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target.CFrame})
    tween:Play()
end

function toTarget(p)
    local tween_s = game:GetService("TweenService")
    local info = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - p.Position).Magnitude/300, Enum.EasingStyle.Linear)
    tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, info, {CFrame = p.CFrame})
    tween:Play()
end

function toTargetP(p)
    local tween_s = game:GetService("TweenService")
    local info = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - p).Magnitude/300, Enum.EasingStyle.Linear)
    tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, info, {CFrame = CFrame.new(p)})
    tween:Play()
end

function TweenShip(p)
    local tween_s = game:GetService("TweenService")
    local boat = game:GetService("Workspace").Boats:FindFirstChild(game:GetService("Players").LocalPlayer.Name)
    if boat then
        local info = TweenInfo.new((boat.PrimaryPart.Position - p.Position).Magnitude/300, Enum.EasingStyle.Linear)
        tween = tween_s:Create(boat.PrimaryPart, info, {CFrame = p.CFrame})
        tween:Play()
    end
end

function TweenBoat(p)
    local tween_s = game:GetService("TweenService")
    local boat = game:GetService("Workspace").Boats:FindFirstChild(game:GetService("Players").LocalPlayer.Name)
    if boat then
        local info = TweenInfo.new((boat.PrimaryPart.Position - p.Position).Magnitude/300, Enum.EasingStyle.Linear)
        tween = tween_s:Create(boat.PrimaryPart, info, {CFrame = p.CFrame})
        tween:Play()
    end
end

function Tween2(target)
    local tween_s = game:GetService("TweenService")
    local info = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - target.Position).Magnitude/300, Enum.EasingStyle.Linear)
    tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target.CFrame})
    tween:Play()
end

function CancelTween()
    if tween then tween:Cancel() end
end

------------------- Combat System ------------------------
function AttackNoCoolDown()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v.ClassName == "RemoteEvent" and v.Name == "MouseEvent" then
            v:InvokeServer({},{},{1,1,1})
        end
    end
end

local combo = 0
function NormalAttack()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local target = hrp.CFrame * CFrame.new(0,0,-3)
        combo = combo + 1
        if combo >= 2 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack")
            combo = 0
        end
    end
end

function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Haki") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

local currentTool = nil
function EquipTool(toolName)
    local player = game:GetService("Players").LocalPlayer
    local backpack = player.Backpack
    local char = player.Character
    for i,v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == toolName then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:EquipTool(v)
                currentTool = v
            end
        end
    end
    for i,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") and v.Name == toolName then
            currentTool = v
        end
    end
end

function EquipAllWeapon()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player.Backpack
    for i,v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:EquipTool(v)
            end
        end
    end
end

------------------- BodyGyro / NoClip / Stun ------------------------
local bodyGyro = nil
function BodyGyro()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if bodyGyro then bodyGyro:Destroy() end
        bodyGyro = Instance.new("BodyGyro", char.HumanoidRootPart)
        bodyGyro.MaxTorque = Vector3.new(0, 40000, 0)
        bodyGyro.D = 500
        bodyGyro.P = 20000
        bodyGyro.CFrame = CFrame.new(char.HumanoidRootPart.Position, char.HumanoidRootPart.Position + Vector3.new(0, -1, 0))
    end
end

function NoClip()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if char then
        for i,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end

spawn(function()
    while wait(0.5) do
        NoClip()
    end
end)

function AntiStun()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.PlatformStand = false
    end
end

spawn(function()
    while wait(0.3) do
        AntiStun()
    end
end)

------------------- UI: Main Farm Tab ------------------------
local MainFarm = Tabs.Main
MainFarm:AddParagraph("Main Farm","Auto level and combat settings")

MainFarm:AddToggle("AutoLevel", {Title = "Auto Level", Default = false})
Options.AutoLevel:OnChanged(function() _G.AutoLevel = Options.AutoLevel.Value end)

MainFarm:AddDropdown("WeaponSelect", {Title = "Select Weapon", Values = {"Melee","Sword","Gun","Fruit"}, Default = 1})
Options.WeaponSelect:OnChanged(function() _G.WeaponSelect = Options.WeaponSelect.Value end)

MainFarm:AddToggle("KillNear", {Title = "Kill Near", Default = false})
Options.KillNear:OnChanged(function() _G.KillNear = Options.KillNear.Value end)

MainFarm:AddToggle("CastleRaid", {Title = "Castle Raid", Default = false})
Options.CastleRaid:OnChanged(function() _G.CastleRaid = Options.CastleRaid.Value end)

MainFarm:AddToggle("AutoChest", {Title = "Auto Chest", Default = false})
Options.AutoChest:OnChanged(function() _G.AutoChest = Options.AutoChest.Value end)

MainFarm:AddButton({Title = "Redeem Code", Description = "Enter a code to redeem", Callback = function()
    local code = Fluent:Prompt("Enter Code", "Input your code here", "")
    if code then
        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
        Fluent:Notify({Title = "Success", Content = "Code redeemed: " .. code, Duration = 3})
    end
end})

MainFarm:AddToggle("AutoFPS", {Title = "Auto FPS", Default = false})
Options.AutoFPS:OnChanged(function() _G.AutoFPS = Options.AutoFPS.Value end)

MainFarm:AddToggle("AutoMastery", {Title = "Auto Mastery", Default = false})
Options.AutoMastery:OnChanged(function() _G.AutoMastery = Options.AutoMastery.Value end)

MainFarm:AddToggle("AutoBone", {Title = "Auto Bone", Default = false})
Options.AutoBone:OnChanged(function() _G.AutoBone = Options.AutoBone.Value end)

MainFarm:AddToggle("AutoKatakuri", {Title = "Auto Katakuri", Default = false})
Options.AutoKatakuri:OnChanged(function() _G.AutoKatakuri = Options.AutoKatakuri.Value end)

MainFarm:AddToggle("AutoEctoplasm", {Title = "Auto Ectoplasm", Default = false})
Options.AutoEctoplasm:OnChanged(function() _G.AutoEctoplasm = Options.AutoEctoplasm.Value end)

MainFarm:AddToggle("AutoBoss", {Title = "Auto Boss", Default = false})
Options.AutoBoss:OnChanged(function() _G.AutoBoss = Options.AutoBoss.Value end)

MainFarm:AddToggle("AutoMaterial", {Title = "Auto Material", Default = false})
Options.AutoMaterial:OnChanged(function() _G.AutoMaterial = Options.AutoMaterial.Value end)

MainFarm:AddToggle("AutoElite", {Title = "Auto Elite", Default = false})
Options.AutoElite:OnChanged(function() _G.AutoElite = Options.AutoElite.Value end)

------------------- UI: Sea Event Tab ------------------------
local SeaTab = Tabs.Sea
SeaTab:AddParagraph("Sea Events","Kitsune, Sea Beast, Mirage, Prehistoric Island and more")

SeaTab:AddToggle("AutoKitsune", {Title = "Auto Kitsune", Default = false})
Options.AutoKitsune:OnChanged(function() _G.AutoKitsune = Options.AutoKitsune.Value end)

SeaTab:AddToggle("AutoAzure", {Title = "Auto Azure", Default = false})
Options.AutoAzure:OnChanged(function() _G.AutoAzure = Options.AutoAzure.Value end)

SeaTab:AddToggle("AutoBoat", {Title = "Auto Boat", Default = false})
Options.AutoBoat:OnChanged(function() _G.AutoBoat = Options.AutoBoat.Value end)

SeaTab:AddToggle("AutoRoughSea", {Title = "Auto Rough Sea", Default = false})
Options.AutoRoughSea:OnChanged(function() _G.AutoRoughSea = Options.AutoRoughSea.Value end)

SeaTab:AddToggle("AutoSeaBeast", {Title = "Auto Sea Beast", Default = false})
Options.AutoSeaBeast:OnChanged(function() _G.AutoSeaBeast = Options.AutoSeaBeast.Value end)

SeaTab:AddToggle("AutoMirage", {Title = "Auto Mirage", Default = false})
Options.AutoMirage:OnChanged(function() _G.AutoMirage = Options.AutoMirage.Value end)

SeaTab:AddToggle("AutoPrehistoricIsland", {Title = "Auto Prehistoric Island", Default = false})
Options.AutoPrehistoricIsland:OnChanged(function() _G.AutoPrehistoricIsland = Options.AutoPrehistoricIsland.Value end)

------------------- Auto Sea Event Loops ------------------------
-- Sea event detection helpers
local function FindSeaEvent(name)
    return game:GetService("Workspace"):FindFirstChild(name)
end

local function FindIslandParts(name)
    local island = FindSeaEvent(name)
    if island then
        for i,v in pairs(island:GetDescendants()) do
            if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                return v
            end
        end
    end
    return nil
end

local function TweenToIsland(name)
    local part = FindIslandParts(name)
    if part then
        toTarget(part)
        return true
    end
    return false
end

local CommF = function(...)
    return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(...)
end

-- Auto Kitsune
spawn(function()
    while wait(3) do
        if _G.AutoKitsune and Third_Sea then
            local island = FindSeaEvent("KitsuneIsland")
            if island then
                local part = FindIslandParts("KitsuneIsland")
                if part then
                    local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if dist > 200 then
                        toTarget(part)
                    else
                        for i,v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "Kitsune" or v.Name == "KitsuneMonster" then
                                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                                    wait(0.1)
                                    NormalAttack()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Azure Ember (Kitsune island)
spawn(function()
    while wait(3) do
        if _G.AutoAzure and Third_Sea then
            for i,v in pairs(workspace:GetDescendants()) do
                if v.Name == "AzureEmber" or v.Name == "Azure" then
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if dist > 50 then
                            toTarget(v)
                        else
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                            wait(0.1)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                        end
                        break
                    end
                end
            end
        end
    end
end)

-- Auto Boat
spawn(function()
    while wait(3) do
        if _G.AutoBoat and Third_Sea then
            local boat = workspace.Boats:FindFirstChild(game.Players.LocalPlayer.Name)
            if not boat then
                CommF("BuyBoat")
            end
        end
    end
end)

-- Auto Rough Sea
spawn(function()
    while wait(3) do
        if _G.AutoRoughSea and Third_Sea then
            CommF("SetSail", "RoughSea")
        end
    end
end)

-- Auto Sea Beast
spawn(function()
    while wait(3) do
        if _G.AutoSeaBeast and Third_Sea then
            for i,v in pairs(workspace:GetDescendants()) do
                if v.Name == "SeaBeast" or v.Name == "TerrorShark" then
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist > 200 then
                            toTarget(v.HumanoidRootPart)
                        else
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,10)
                            wait(0.1)
                            NormalAttack()
                        end
                    end
                    break
                end
            end
        end
    end
end)

-- Auto Mirage
spawn(function()
    while wait(3) do
        if _G.AutoMirage and Third_Sea then
            local island = FindSeaEvent("MirageIsland")
            if island then
                local part = FindIslandParts("MirageIsland")
                if part then
                    local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if dist > 200 then
                        toTarget(part)
                    end
                end
            end
        end
    end
end)

-- Auto Prehistoric Island (Volcano Event)
spawn(function()
    while wait(3) do
        if _G.AutoPrehistoricIsland and Third_Sea then
            local island = FindSeaEvent("PrehistoricIsland")
            if island then
                local part = FindIslandParts("PrehistoricIsland")
                if part then
                    local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if dist > 200 then
                        toTarget(part)
                        wait(1)
                    else
                        local skull = island:FindFirstChild("FossilAncientRelic") or island:FindFirstChild("TrexSkull") or island:FindFirstChild("Skull")
                        if skull then
                            local sdist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - skull.Position).Magnitude
                            if sdist > 20 then
                                toTarget(skull)
                                wait(0.5)
                            else
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, skull, 0)
                                wait(0.1)
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, skull, 1)
                                CommF("VolcanoEvent")
                            end
                        end
                        for i,v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == "LavaGolem" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,8)
                                wait(0.1)
                                NormalAttack()
                            end
                        end
                    end
                end
            end
        end
    end
end)

------------------- UI: Settings Tab ------------------------
local SettingTab = Tabs.Setting
SettingTab:AddParagraph("Settings","Configure your experience")

SettingTab:AddToggle("FastAttack", {Title = "Fast Attack", Default = false})
Options.FastAttack:OnChanged(function() _G.FastAttack = Options.FastAttack.Value end)

SettingTab:AddToggle("BringMob", {Title = "Bring Mob", Default = false})
Options.BringMob:OnChanged(function() bringmob = Options.BringMob.Value end)

SettingTab:AddToggle("BypassTP", {Title = "Bypass TP", Default = false})
Options.BypassTP:OnChanged(function() _G.BypassTP = Options.BypassTP.Value end)

SettingTab:AddToggle("RemoveEffects", {Title = "Remove Effects", Default = false})
Options.RemoveEffects:OnChanged(function() _G.RemoveEffects = Options.RemoveEffects.Value end)

SettingTab:AddToggle("Skills", {Title = "Skills", Default = true})
Options.Skills:OnChanged(function() _G.Skills = Options.Skills.Value end)

SettingTab:AddSlider("Distance", {Title = "Distance", Default = 100, Min = 10, Max = 500})
Options.Distance:OnChanged(function() _G.Distance = Options.Distance.Value end)

------------------- UI: Server Stats Tab ------------------------
local StatusTab = Tabs.Status
StatusTab:AddParagraph("Server Stats","Current server information")

StatusTab:AddButton({Title = "Refresh Stats", Description = "Update server stats", Callback = function()
    local serverTime = math.floor(workspace.DistributedGameTime/60)
    local fullMoon = workspace:FindFirstChild("FullMoon") and "Yes" or "No"
    local bossAlive = "Unknown"
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Boss") then
            bossAlive = "Alive"
            break
        end
    end
    Fluent:Notify({Title = "Server Stats", Content = "Time: " .. serverTime .. "m | Full Moon: " .. fullMoon .. " | Boss: " .. bossAlive, Duration = 5})
end})

StatusTab:AddButton({Title = "Copy Job ID", Description = "Copy server JobId to clipboard", Callback = function()
    setclipboard(game.JobId)
    Fluent:Notify({Title = "Success", Content = "Job ID copied!", Duration = 3})
end})

------------------- UI: Stats Tab ------------------------
local StatsTab = Tabs.Stats
StatsTab:AddParagraph("Auto Stats","Automatically assign stat points")

StatsTab:AddToggle("AutoMelee", {Title = "Auto Melee", Default = false})
Options.AutoMelee:OnChanged(function() _G.AutoMelee = Options.AutoMelee.Value end)

StatsTab:AddToggle("AutoDefense", {Title = "Auto Defense", Default = false})
Options.AutoDefense:OnChanged(function() _G.AutoDefense = Options.AutoDefense.Value end)

StatsTab:AddToggle("AutoSword", {Title = "Auto Sword", Default = false})
Options.AutoSword:OnChanged(function() _G.AutoSword = Options.AutoSword.Value end)

StatsTab:AddToggle("AutoGun", {Title = "Auto Gun", Default = false})
Options.AutoGun:OnChanged(function() _G.AutoGun = Options.AutoGun.Value end)

StatsTab:AddToggle("AutoFruit", {Title = "Auto Fruit Stat", Default = false})
Options.AutoFruit:OnChanged(function() _G.AutoFruit = Options.AutoFruit.Value end)

------------------- UI: Player Tab ------------------------
local PlayerTab = Tabs.Player
PlayerTab:AddParagraph("Player PVP","Combat and spectate settings")

local playerNames = {}
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= game:GetService("Players").LocalPlayer.Name then
        table.insert(playerNames, v.Name)
    end
end

PlayerTab:AddDropdown("SelectPlayer", {Title = "Select Player", Values = playerNames, Default = 1})
Options.SelectPlayer:OnChanged(function() _G.SelectPlayer = Options.SelectPlayer.Value end)

PlayerTab:AddButton({Title = "Teleport to Player", Description = "Tween to selected player", Callback = function()
    local target = game:GetService("Players"):FindFirstChild(_G.SelectPlayer)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        toTarget(target.Character.HumanoidRootPart)
    end
end})

PlayerTab:AddButton({Title = "Spectate Player", Description = "Spectate selected player", Callback = function()
    local target = game:GetService("Players"):FindFirstChild(_G.SelectPlayer)
    if target then
        workspace.CurrentCamera.CameraSubject = target.Character
        workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
    end
end})

PlayerTab:AddToggle("Combat", {Title = "Combat", Default = false})
Options.Combat:OnChanged(function() _G.Combat = Options.Combat.Value end)

PlayerTab:AddSlider("FOV", {Title = "FOV", Default = 90, Min = 30, Max = 120})
Options.FOV:OnChanged(function() workspace.CurrentCamera.FieldOfView = Options.FOV.Value end)

PlayerTab:AddToggle("Aimbot", {Title = "Aimbot", Default = false})
Options.Aimbot:OnChanged(function() _G.Aimbot = Options.Aimbot.Value end)

------------------- UI: Teleport Tab ------------------------
local TeleportTab = Tabs.Teleport
TeleportTab:AddParagraph("Teleport","Quick travel around the map")

TeleportTab:AddButton({Title = "Teleport to First Sea", Description = "Go to First Sea", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
end})

TeleportTab:AddButton({Title = "Teleport to Second Sea", Description = "Go to Second Sea", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelSecond")
end})

TeleportTab:AddButton({Title = "Teleport to Third Sea", Description = "Go to Third Sea", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelThird")
end})

local islandNames = {}
for k,v in pairs(AreaList) do table.insert(islandNames, k) end
TeleportTab:AddDropdown("IslandSelect", {Title = "Select Island", Values = islandNames, Default = 1})
Options.IslandSelect:OnChanged(function() _G.IslandSelect = Options.IslandSelect.Value end)

TeleportTab:AddButton({Title = "Teleport to Island", Description = "Tween to selected island", Callback = function()
    local islandName = _G.IslandSelect
    local island = game:GetService("Workspace"):FindFirstChild(islandName) or game:GetService("Workspace").Map:FindFirstChild(islandName)
    if island then
        local pos = island:GetPivot().p + Vector3.new(0,50,0)
        toTargetP(pos)
    end
end})

------------------- UI: Fruit Tab ------------------------
local FruitTab = Tabs.Fruit
FruitTab:AddParagraph("Fruit Blox ESP","Devil Fruit management")

FruitTab:AddButton({Title = "Buy Fruit", Description = "Purchase a random fruit", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit")
end})

FruitTab:AddButton({Title = "Store Fruit", Description = "Store current fruit", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit")
end})

FruitTab:AddButton({Title = "Random Fruit", Description = "Random fruit", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RandomFruit")
end})

FruitTab:AddButton({Title = "Collect Fruit", Description = "Collect nearest fruit", Callback = function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "DevilFruit" and v:FindFirstChild("Handle") then
            toTarget(v.Handle)
            wait(0.5)
            firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
            break
        end
    end
end})

FruitTab:AddToggle("FruitESP", {Title = "Fruit ESP", Default = false})
Options.FruitESP:OnChanged(function() _G.FruitESP = Options.FruitESP.Value end)

FruitTab:AddToggle("ChestESP", {Title = "Chest ESP", Default = false})
Options.ChestESP:OnChanged(function() _G.ChestESP = Options.ChestESP.Value end)

FruitTab:AddToggle("FlowerESP", {Title = "Flower ESP", Default = false})
Options.FlowerESP:OnChanged(function() _G.FlowerESP = Options.FlowerESP.Value end)

FruitTab:AddToggle("DevilFruitChams", {Title = "Devil Fruit Chams", Default = false})
Options.DevilFruitChams:OnChanged(function() _G.DevilFruitChams = Options.DevilFruitChams.Value end)

FruitTab:AddToggle("IslandESP", {Title = "Island ESP", Default = false})
Options.IslandESP:OnChanged(function() _G.IslandESP = Options.IslandESP.Value end)

FruitTab:AddToggle("PlayerChams", {Title = "Player Chams", Default = false})
Options.PlayerChams:OnChanged(function() _G.PlayerChams = Options.PlayerChams.Value end)

FruitTab:AddToggle("ChestChams", {Title = "Chest Chams", Default = false})
Options.ChestChams:OnChanged(function() _G.ChestChams = Options.ChestChams.Value end)

FruitTab:AddToggle("RealFruitChams", {Title = "Real Fruit Chams", Default = false})
Options.RealFruitChams:OnChanged(function() _G.RealFruitChams = Options.RealFruitChams.Value end)

------------------- UI: Raid Tab ------------------------
local RaidTab = Tabs.Raid
RaidTab:AddParagraph("Dungeon","Raid and Awakening controls")

RaidTab:AddDropdown("ChipSelect", {Title = "Select Chip", Values = {"Flame","Ice","Quake","Light","Dark","String","Dragon","Rumble","Soul","Dough"}, Default = 1})
Options.ChipSelect:OnChanged(function() _G.ChipSelect = Options.ChipSelect.Value end)

RaidTab:AddButton({Title = "Buy Chip", Description = "Purchase selected raid chip", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyChip", _G.ChipSelect)
end})

RaidTab:AddButton({Title = "Start Raid", Description = "Start the raid", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartRaid")
end})

RaidTab:AddToggle("KillAura", {Title = "Kill Aura", Default = false})
Options.KillAura:OnChanged(function() _G.KillAura = Options.KillAura.Value end)

RaidTab:AddToggle("ToggleHumanandghoul", {Title = "Human and Ghoul", Default = false})
Options.ToggleHumanandghoul:OnChanged(function() _G.ToggleHumanandghoul = Options.ToggleHumanandghoul.Value end)

RaidTab:AddButton({Title = "Next Island", Description = "Teleport to next raid island", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("NextIsland")
end})

RaidTab:AddButton({Title = "Awaken", Description = "Awaken selected fruit", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awaken", _G.ChipSelect)
end})

------------------- UI: Race Tab (Draco V4) ------------------------
local RaceTab = Tabs.Race
RaceTab:AddParagraph("Draco V4 Trial","Draco race V4 awakening and trial automation")

-- Draco Dojo Navigation
RaceTab:AddButton({Title = "Teleport to Dragon Dojo", Description = "Go to Hydra Island Dragon Dojo", Callback = function()
    local dojo = game:GetService("Workspace"):FindFirstChild("DragonDojo") or game:GetService("Workspace").Map:FindFirstChild("DragonDojo")
    if dojo then
        toTarget(dojo:GetPivot().p + Vector3.new(0,50,0))
    else
        CommF("requestEntrance", "HydraIsland")
        wait(2)
        toTargetP(Vector3.new(-5376, 15, -604))
    end
end})

RaceTab:AddButton({Title = "Dragon Wizard", Description = "Talk to Dragon Wizard for Dragon Tether", Callback = function()
    CommF("DragonWizard")
    Fluent:Notify({Title = "Draco", Content = "Interacted with Dragon Wizard", Duration = 3})
end})

RaceTab:AddButton({Title = "Get Dragon Tether", Description = "Learn Dragon Tether ability", Callback = function()
    CommF("DragonTether")
    Fluent:Notify({Title = "Draco", Content = "Dragon Tether learned!", Duration = 3})
end})

RaceTab:AddButton({Title = "Craft Volcanic Magnet", Description = "Craft item to boost Prehistoric Island spawn", Callback = function()
    CommF("CraftVolcanicMagnet")
end})

RaceTab:AddSeparator("Volcano Event")

RaceTab:AddToggle("AutoVolcanoEvent", {Title = "Auto Volcano Event", Default = false})
Options.AutoVolcanoEvent:OnChanged(function() _G.AutoVolcanoEvent = Options.AutoVolcanoEvent.Value end)

RaceTab:AddToggle("AutoKillLavaGolem", {Title = "Auto Kill Lava Golem", Default = false})
Options.AutoKillLavaGolem:OnChanged(function() _G.AutoKillLavaGolem = Options.AutoKillLavaGolem.Value end)

RaceTab:AddToggle("AutoCollectDragonEgg", {Title = "Auto Collect Dragon Egg", Default = false})
Options.AutoCollectDragonEgg:OnChanged(function() _G.AutoCollectDragonEgg = Options.AutoCollectDragonEgg.Value end)

RaceTab:AddSeparator("Trial of Flames (Draco V4)")

RaceTab:AddButton({Title = "Enter Trial Cave", Description = "Go to Trial of Flames cave entrance on Prehistoric Island", Callback = function()
    local island = game:GetService("Workspace"):FindFirstChild("PrehistoricIsland")
    if island then
        local cave = island:FindFirstChild("TrialCave") or island:FindFirstChild("Cave") or island:FindFirstChild("FlameCave")
        if cave then
            toTarget(cave:GetPivot().p + Vector3.new(0,10,0))
        else
            for i,v in pairs(island:GetDescendants()) do
                if v.Name == "Cave" or v.Name == "Door" or v:IsA("Part") and v.Position.Y < 50 then
                    toTarget(v)
                    break
                end
            end
        end
    else
        Fluent:Notify({Title = "Error", Content = "Prehistoric Island not found in workspace", Duration = 3})
    end
end})

RaceTab:AddButton({Title = "Start Trial of Flames", Description = "Interact with trial force in cave", Callback = function()
    CommF("TrialOfFlames")
end})

RaceTab:AddToggle("AutoTrialOfFlames", {Title = "Auto Trial of Flames", Default = false})
Options.AutoTrialOfFlames:OnChanged(function() _G.AutoTrialOfFlames = Options.AutoTrialOfFlames.Value end)

RaceTab:AddButton({Title = "Collect Ember", Description = "Interact with Flames of Hearth after trial", Callback = function()
    CommF("FlamesOfHearth")
end})

RaceTab:AddButton({Title = "Open Flames of Hearth", Description = "Replace embers to awaken Draco V4", Callback = function()
    local hearth = game:GetService("Workspace"):FindFirstChild("FlamesOfHearth") or game:GetService("Workspace").Map:FindFirstChild("FlamesOfHearth")
    if hearth then
        toTarget(hearth)
        wait(0.5)
        CommF("ReplaceEmbers")
    end
end})

RaceTab:AddSeparator("Materials")

RaceTab:AddButton({Title = "Craft Dragonheart", Description = "Craft Dragonheart sword at Dragon Hunter", Callback = function()
    CommF("CraftDragonheart")
end})

RaceTab:AddButton({Title = "Craft Dragonstorm", Description = "Craft Dragonstorm gun at Dragon Hunter", Callback = function()
    CommF("CraftDragonstorm")
end})

RaceTab:AddToggle("AutoNevaSoulGuitar", {Title = "Auto Soul Guitar", Default = false})
Options.AutoNevaSoulGuitar:OnChanged(function() _G.AutoSoulGuitar = Options.AutoNevaSoulGuitar.Value end)

-- Auto Volcano Event Loop (with Lava Golem kill + Dragon Egg collection)
spawn(function()
    while wait(3) do
        if _G.AutoVolcanoEvent and Third_Sea then
            local island = game:GetService("Workspace"):FindFirstChild("PrehistoricIsland")
            if island then
                local part
                for i,v in pairs(island:GetDescendants()) do
                    if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                        part = v
                        break
                    end
                end
                if part then
                    local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if dist > 200 then
                        toTarget(part)
                    else
                        local relic = island:FindFirstChild("FossilAncientRelic") or island:FindFirstChild("Relic")
                        if relic then
                            local rdist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - relic.Position).Magnitude
                            if rdist > 15 then
                                toTarget(relic)
                            else
                                CommF("VolcanoEvent")
                                wait(0.5)
                            end
                        end
                        if _G.AutoKillLavaGolem then
                            for i,v in pairs(workspace.Enemies:GetChildren()) do
                                if string.find(v.Name, "Lava") or string.find(v.Name, "Golem") then
                                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,8)
                                        wait(0.1)
                                        NormalAttack()
                                    end
                                end
                            end
                        end
                        if _G.AutoCollectDragonEgg then
                            local egg = island:FindFirstChild("DragonEgg") or island:FindFirstChild("Egg")
                            if egg then
                                local edist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - egg.Position).Magnitude
                                if edist > 15 then
                                    toTarget(egg)
                                else
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, egg, 0)
                                    wait(0.1)
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, egg, 1)
                                    wait(0.5)
                                    CommF("DragonTether")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Trial of Flames Loop (Draco V4)
spawn(function()
    while wait(3) do
        if _G.AutoTrialOfFlames and Third_Sea then
            local island = game:GetService("Workspace"):FindFirstChild("PrehistoricIsland")
            if island then
                local cave = island:FindFirstChild("TrialCave") or island:FindFirstChild("FlameCave") or island:FindFirstChild("Cave")
                if cave then
                    local cdist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - cave:GetPivot().p).Magnitude
                    if cdist > 30 then
                        toTarget(cave:GetPivot().p + Vector3.new(0,10,0))
                    else
                        CommF("TrialOfFlames")
                        wait(1)
                        for i = 1, 3 do
                            local relic = workspace:FindFirstChild("TrialRelic" .. i) or workspace:FindFirstChild("Relic" .. i)
                            if relic then
                                toTarget(relic)
                                wait(0.5)
                                CommF("PlaceRelic", i)
                                wait(1)
                            end
                        end
                        local gate = workspace:FindFirstChild("MagicalGate") or workspace:FindFirstChild("CircularGate")
                        if gate then
                            toTarget(gate)
                            wait(0.5)
                        end
                    end
                end
            end
        end
    end
end)

------------------- UI: Shop Tab ------------------------
local ShopTab = Tabs.Shop
ShopTab:AddParagraph("Shop","Buy Haki, Fighting Styles and Items")

ShopTab:AddButton({Title = "Buy Haki", Description = "Buy Buso Haki", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
end})

ShopTab:AddButton({Title = "Buy Observation", Description = "Buy Ken Haki", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ken")
end})

ShopTab:AddButton({Title = "Buy Electro", Description = "Buy Electro fighting style", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
end})

ShopTab:AddButton({Title = "Buy Water Kung Fu", Description = "Buy Water Kung Fu", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyWaterKungFu")
end})

ShopTab:AddButton({Title = "Buy Dragon Breath", Description = "Buy Dragon Breath", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonBreath")
end})

ShopTab:AddButton({Title = "Buy Superhuman", Description = "Buy Superhuman", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
end})

ShopTab:AddButton({Title = "Buy Death Step", Description = "Buy Death Step", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
end})

ShopTab:AddButton({Title = "Buy Sharkman Karate", Description = "Buy Sharkman Karate", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})

ShopTab:AddButton({Title = "Buy Electric Claw", Description = "Buy Electric Claw", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
end})

ShopTab:AddButton({Title = "Buy Dragon Talon", Description = "Buy Dragon Talon", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
end})

ShopTab:AddButton({Title = "Buy Godhuman", Description = "Buy Godhuman", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
end})

ShopTab:AddSeparator("Misc Items")

ShopTab:AddButton({Title = "Buy Microchip", Description = "Buy microchip", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyMicrochip")
end})

ShopTab:AddButton({Title = "Buy Boat", Description = "Buy boat", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat")
end})

ShopTab:AddButton({Title = "Buy Sword", Description = "Buy sword", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySword")
end})

ShopTab:AddButton({Title = "Buy Gun", Description = "Buy gun", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGun")
end})

ShopTab:AddButton({Title = "Buy Accessory", Description = "Buy accessory", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyAccessory")
end})

------------------- UI: Misc Tab ------------------------
local MiscTab = Tabs.Misc
MiscTab:AddParagraph("Miscellaneous","Extra utilities and features")

MiscTab:AddDropdown("TeamSelect", {Title = "Select Team", Values = {"Pirate","Marine"}, Default = 1})
Options.TeamSelect:OnChanged(function() _G.TeamSelect = Options.TeamSelect.Value end)

MiscTab:AddButton({Title = "Join Team", Description = "Join selected team", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", _G.TeamSelect)
end})

MiscTab:AddButton({Title = "Open UI", Description = "Open/Close UI", Callback = function()
    Window:Minimize()
end})

MiscTab:AddToggle("Troll", {Title = "Troll", Default = false})
Options.Troll:OnChanged(function() _G.Troll = Options.Troll.Value end)

MiscTab:AddToggle("AutoRejoin", {Title = "Auto Rejoin", Default = false})
Options.AutoRejoin:OnChanged(function() _G.AutoRejoin = Options.AutoRejoin.Value end)

MiscTab:AddToggle("ShowItems", {Title = "Show Items", Default = false})
Options.ShowItems:OnChanged(function() _G.ShowItems = Options.ShowItems.Value end)

MiscTab:AddToggle("Fog", {Title = "Fog", Default = false})
Options.Fog:OnChanged(function()
    if Options.Fog.Value then
        game:GetService("Lighting").FogEnd = 99999
    else
        game:GetService("Lighting").FogEnd = 100000
    end
end)

MiscTab:AddToggle("RainFruit", {Title = "Rain Fruit", Default = false})
Options.RainFruit:OnChanged(function() _G.RainFruit = Options.RainFruit.Value end)

------------------- UI: Hop Tab ------------------------
local HopTab = Tabs.Hop
HopTab:AddParagraph("Hop Server","Server hopping utilities")

HopTab:AddButton({Title = "Rejoin", Description = "Rejoin current server", Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end})

HopTab:AddButton({Title = "Server Hop", Description = "Hop to a new server", Callback = function()
    local servers = {}
    local req = syn.request({
        Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100",
        Method = "GET"
    })
    local data = game:GetService("HttpService"):JSONDecode(req.Body)
    for i,v in pairs(data.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end
    if #servers > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1,#servers)], game:GetService("Players").LocalPlayer)
    end
end})

HopTab:AddButton({Title = "Full Moon Hop", Description = "Hop to full moon server", Callback = function()
    local servers = {}
    local req = syn.request({
        Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100",
        Method = "GET"
    })
    local data = game:GetService("HttpService"):JSONDecode(req.Body)
    for i,v in pairs(data.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end
    Fluent:Notify({Title = "Hop", Content = "Searching for Full Moon server...", Duration = 3})
    for i,id in pairs(servers) do
        local jobreq = syn.request({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100&cursor=" .. id,
            Method = "GET"
        })
    end
end})

HopTab:AddButton({Title = "Mirage Hop", Description = "Hop to mirage island server", Callback = function()
    Fluent:Notify({Title = "Hop", Content = "Searching for Mirage server...", Duration = 3})
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end})

------------------- UI: Profile Tab ------------------------
local ProfileTab = Tabs.profile
ProfileTab:AddParagraph("Byte Hub v1.0","Welcome to Byte Hub!")

ProfileTab:AddButton({Title = "Copy Discord", Description = "https://discord.gg/PF36rvJXN4", Callback = function()
    setclipboard("https://discord.gg/PF36rvJXN4")
    Fluent:Notify({Title = "Success", Content = "Discord link copied!", Duration = 3})
end})

ProfileTab:AddButton({Title = "Copy Script", Description = "Copy script link", Callback = function()
    setclipboard("Byte Hub - https://discord.gg/PF36rvJXN4")
    Fluent:Notify({Title = "Success", Content = "Script link copied!", Duration = 3})
end})

ProfileTab:AddLabel("Owner: damthien | Version: 1.0")
ProfileTab:AddLabel("Thanks for using Byte Hub!")

-- Final Notification
Fluent:Notify({
    Title = "Byte Hub",
    Content = "Script loaded successfully!",
    Duration = 3
})
