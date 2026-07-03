-- Byte Hub for Delta Android
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
local player = game.Players.LocalPlayer
repeat task.wait() until player.Character

local pcall = pcall
local task_wait = task.wait
local task_spawn = task.spawn
local Vector2_new = Vector2.new
local UDim2_new = UDim2.new
local Color3_new = Color3.fromRGB
local Instance_new = Instance.new

-- HTTP Polyfill
local http_request = (syn and syn.request) or (http_request) or (request) or function(t) return {Body="",StatusCode=404} end

-- AFK bypass
task_spawn(function()
    while task.wait(120) do
        pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button2Down(Vector2_new(0,0), workspace.CurrentCamera.CFrame)
            task_wait(0.1)
            game:GetService("VirtualUser"):Button2Up(Vector2_new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- Sea check
local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea = game.PlaceId == 7449423635
if not (First_Sea or Second_Sea or Third_Sea) then return end

-- Globals
_G = _G or {}
_G.Fast_Delay = 0.12
_G.Weapon = "Melee"
_G.SkillZ = true; _G.SkillX = true; _G.SkillC = true; _G.SkillV = true; _G.SkillF = false
_G.SelectTool = ""
_G.Magnet = false
_G.StartRaid = false
_G.SelectRaid = ""
_G.SelectBoss = ""
_G.SelectNPC = ""

-- SafeHRP
local function SafeHRP()
    local c = player.Character if not c then return nil end
    local hrp = c:FindFirstChild("HumanoidRootPart") if not hrp then return nil end
    return hrp
end

-- CommF
local function CommF(...)
    return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(...)
end

-- AntiBan
pcall(function()
    local c = player.Character
    if c then
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("LocalScript") and (v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" or v.Name == "CamBob" or v.Name == "JumpCD") then
                v:Destroy()
            end
        end
    end
    for _,v in pairs(player.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") and (v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes") then
            v:Destroy()
        end
    end
end)

-- Tween function
local tweenService = game:GetService("TweenService")
local function Tween(target)
    local hrp = SafeHRP() if not hrp then return end
    local dist = (hrp.Position - target.Position).Magnitude
    if dist < 1 then return end
    local info = TweenInfo.new(dist/300, Enum.EasingStyle.Linear)
    local t = tweenService:Create(hrp, info, {CFrame = target.CFrame})
    t:Play(); _G._tween = t
    return t
end

function CancelTween()
    if _G._tween then pcall(function() _G._tween:Cancel() end) _G._tween = nil end
end

function toTarget(p)
    local hrp = SafeHRP() if not hrp then return end
    local dist = (hrp.Position - p.Position).Magnitude
    if dist < 1 then return end
    local info = TweenInfo.new(dist/300, Enum.EasingStyle.Linear)
    local t = tweenService:Create(hrp, info, {CFrame = p.CFrame})
    t:Play(); _G._tween = t
    return t
end

-- Combat
local function NormalAttack()
    pcall(function()
        local hrp = SafeHRP() if not hrp then return end
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Z, false, hrp)
        task_wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Z, false, hrp)
        task_wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.X, false, hrp)
        task_wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.X, false, hrp)
    end)
end

-- ESP
local function AddESP(obj, name, color)
    if not obj or obj:FindFirstChild("_ESP") then return end
    local b = Instance_new("BillboardGui", obj)
    b.Name = "_ESP"; b.Size = UDim2_new(4,0,0.5,0); b.AlwaysOnTop = true
    b.StudsOffset = Vector3.new(0,2,0); b.Adornee = obj
    local t = Instance_new("TextLabel", b)
    t.Size = UDim2_new(1,0,1,0); t.BackgroundTransparency = 1; t.TextScaled = true
    t.Text = name; t.TextColor3 = color; t.Font = Enum.Font.SourceSansBold
end

-- Sea event finder
local function FindSeaEvent(name)
    return workspace:FindFirstChild(name)
end

local function FindIslandParts(name)
    local island = workspace:FindFirstChild(name)
    if island then
        for _,v in pairs(island:GetDescendants()) do
            if v:IsA("BasePart") and v.Size.Magnitude > 10 then return v end
        end
        for _,v in pairs(island:GetChildren()) do
            if v:IsA("BasePart") then return v end
        end
    end
    return nil
end

--==========================--
--  LIGHTWEIGHT UI SYSTEM   --
--==========================--
local gui = player:WaitForChild("PlayerGui")
local screenGui = Instance_new("ScreenGui", gui)
screenGui.Name = "ByteHub"
screenGui.ResetOnSpawn = false

local Acrylic = Instance_new("Frame")
Acrylic.BackgroundColor3 = Color3_new(15,15,15)
Acrylic.BorderSizePixel = 0
Acrylic.Size = UDim2_new(0,600,0,400)
Acrylic.Position = UDim2_new(0.5,-300,0.5,-200)
Acrylic.Active = true
Acrylic.Draggable = true
Acrylic.Parent = screenGui

local UICorner = Instance_new("UICorner", Acrylic)
UICorner.CornerRadius = UDim.new(0,6)

-- Title bar
local TitleBar = Instance_new("Frame", Acrylic)
TitleBar.BackgroundColor3 = Color3_new(25,25,25)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2_new(1,0,0,30)
TitleBar.Position = UDim2_new(0,0,0,0)
local UICornerT = Instance_new("UICorner", TitleBar)
UICornerT.CornerRadius = UDim.new(0,6)

local TitleText = Instance_new("TextLabel", TitleBar)
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2_new(1,-30,1,0)
TitleText.Position = UDim2_new(0,10,0,0)
TitleText.Text = "Byte Hub [Delta]"
TitleText.TextColor3 = Color3_new(255,255,255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 14

local CloseBtn = Instance_new("TextButton", TitleBar)
CloseBtn.BackgroundColor3 = Color3_new(255,50,50)
CloseBtn.Size = UDim2_new(0,20,0,20)
CloseBtn.Position = UDim2_new(1,-25,0,5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3_new(255,255,255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
local UICornerC = Instance_new("UICorner", CloseBtn)
UICornerC.CornerRadius = UDim.new(0,4)
CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- Tabs sidebar
local Sidebar = Instance_new("ScrollingFrame", Acrylic)
Sidebar.BackgroundColor3 = Color3_new(20,20,20)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2_new(0,130,1,-35)
Sidebar.Position = UDim2_new(0,0,0,35)
Sidebar.ScrollBarThickness = 0
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.CanvasSize = UDim2_new(0,0,0,0)

-- Content area
local ContentBG = Instance_new("Frame", Acrylic)
ContentBG.BackgroundColor3 = Color3_new(18,18,18)
ContentBG.BorderSizePixel = 0
ContentBG.Size = UDim2_new(1,-135,1,-35)
ContentBG.Position = UDim2_new(0,135,0,35)
local UICornerBG = Instance_new("UICorner", ContentBG)
UICornerBG.CornerRadius = UDim.new(0,4)

local ContentFrame = Instance_new("ScrollingFrame", ContentBG)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Size = UDim2_new(1,-10,1,-10)
ContentFrame.Position = UDim2_new(0,5,0,5)
ContentFrame.ScrollBarThickness = 4
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.CanvasSize = UDim2_new(0,0,0,0)

-- Tab system
local tabs = {}
local currentTab = nil

-- Helper to create elements
local elementY = 0
local function ResetContent()
    for _,v in pairs(ContentFrame:GetChildren()) do v:Destroy() end
    elementY = 0
end

local function CreateLabel(text)
    local l = Instance_new("TextLabel", ContentFrame)
    l.BackgroundTransparency = 1
    l.Size = UDim2_new(1,0,0,25)
    l.Position = UDim2_new(0,5,0,elementY)
    l.Text = text
    l.TextColor3 = Color3_new(200,200,200)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Gotham
    l.TextSize = 14
    elementY = elementY + 28
    return l
end

local function CreateParagraph(text)
    local l = Instance_new("TextLabel", ContentFrame)
    l.BackgroundTransparency = 1
    l.Size = UDim2_new(1,0,0,20)
    l.Position = UDim2_new(0,5,0,elementY)
    l.Text = text
    l.TextColor3 = Color3_new(140,140,140)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    elementY = elementY + 22
    return l
end

local function CreateSeparator()
    local s = Instance_new("Frame", ContentFrame)
    s.BackgroundColor3 = Color3_new(40,40,40)
    s.BorderSizePixel = 0
    s.Size = UDim2_new(0.95,0,0,1)
    s.Position = UDim2_new(0.025,0,0,elementY)
    elementY = elementY + 8
    return s
end

local function CreateButton(title, desc, cb)
    local bg = Instance_new("Frame", ContentFrame)
    bg.BackgroundColor3 = Color3_new(28,28,28)
    bg.BorderSizePixel = 0
    bg.Size = UDim2_new(1,0,0,40)
    bg.Position = UDim2_new(0,0,0,elementY)
    local UICornerB = Instance_new("UICorner", bg)
    UICornerB.CornerRadius = UDim.new(0,4)

    local t = Instance_new("TextLabel", bg)
    t.BackgroundTransparency = 1
    t.Size = UDim2_new(1,-60,1,0)
    t.Position = UDim2_new(0,8,0,0)
    t.Text = title
    t.TextColor3 = Color3_new(220,220,220)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Font = Enum.Font.Gotham
    t.TextSize = 14

    if desc then
        local d = Instance_new("TextLabel", bg)
        d.BackgroundTransparency = 1
        d.Size = UDim2_new(1,-60,0,15)
        d.Position = UDim2_new(0,8,0,20)
        d.Text = desc
        d.TextColor3 = Color3_new(120,120,120)
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.Font = Enum.Font.Gotham
        d.TextSize = 11
    end

    local btn = Instance_new("TextButton", bg)
    btn.BackgroundColor3 = Color3_new(45,120,200)
    btn.Size = UDim2_new(0,50,0,25)
    btn.Position = UDim2_new(1,-58,0,7)
    btn.Text = "Go"
    btn.TextColor3 = Color3_new(255,255,255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    local UICornerBtn = Instance_new("UICorner", btn)
    UICornerBtn.CornerRadius = UDim.new(0,4)
    btn.MouseButton1Click:Connect(function()
        task_spawn(function()
            pcall(cb)
        end)
    end)

    elementY = elementY + 44
    return bg
end

local toggleElements = {}
local function CreateToggle(id, title, desc, default)
    local bg = Instance_new("Frame", ContentFrame)
    bg.BackgroundColor3 = Color3_new(28,28,28)
    bg.BorderSizePixel = 0
    bg.Size = UDim2_new(1,0,0,36)
    bg.Position = UDim2_new(0,0,0,elementY)
    local UICornerT = Instance_new("UICorner", bg)
    UICornerT.CornerRadius = UDim.new(0,4)

    local t = Instance_new("TextLabel", bg)
    t.BackgroundTransparency = 1
    t.Size = UDim2_new(1,-55,1,0)
    t.Position = UDim2_new(0,8,0,0)
    t.Text = title
    t.TextColor3 = Color3_new(220,220,220)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Font = Enum.Font.Gotham
    t.TextSize = 14

    local val = default or false
    local tog = Instance_new("TextButton", bg)
    tog.BackgroundColor3 = val and Color3_new(45,180,60) or Color3_new(50,50,50)
    tog.Size = UDim2_new(0,40,0,20)
    tog.Position = UDim2_new(1,-48,0,8)
    tog.Text = val and "ON" or "OFF"
    tog.TextColor3 = Color3_new(255,255,255)
    tog.TextSize = 10
    tog.Font = Enum.Font.GothamBold
    tog.BorderSizePixel = 0
    local UICornerTog = Instance_new("UICorner", tog)
    UICornerTog.CornerRadius = UDim.new(0,4)

    local callbacks = {}
    function tog:SetValue(v)
        val = v
        tog.BackgroundColor3 = val and Color3_new(45,180,60) or Color3_new(50,50,50)
        tog.Text = val and "ON" or "OFF"
        _G[id] = val
        for _,cb in pairs(callbacks) do pcall(cb, val) end
    end

    tog.MouseButton1Click:Connect(function() tog:SetValue(not val) end)

    toggleElements[id] = {
        set = function(v) tog:SetValue(v) end,
        get = function() return val end,
        onChange = function(cb) table.insert(callbacks, cb) end
    }

    elementY = elementY + 40
    return toggleElements[id]
end

local function CreateDropdown(id, title, options, default)
    local bg = Instance_new("Frame", ContentFrame)
    bg.BackgroundColor3 = Color3_new(28,28,28)
    bg.BorderSizePixel = 0
    bg.Size = UDim2_new(1,0,0,36)
    bg.Position = UDim2_new(0,0,0,elementY)
    local UICornerD = Instance_new("UICorner", bg)
    UICornerD.CornerRadius = UDim.new(0,4)
    bg.ClipsDescendants = true

    local t = Instance_new("TextLabel", bg)
    t.BackgroundTransparency = 1
    t.Size = UDim2_new(0.5,-5,1,0)
    t.Position = UDim2_new(0,8,0,0)
    t.Text = title
    t.TextColor3 = Color3_new(220,220,220)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Font = Enum.Font.Gotham
    t.TextSize = 14

    local val = options[default or 1] or options[1]
    local dropdown = Instance_new("TextButton", bg)
    dropdown.BackgroundColor3 = Color3_new(40,40,40)
    dropdown.Size = UDim2_new(0,140,0,24)
    dropdown.Position = UDim2_new(1,-148,0,6)
    dropdown.Text = val
    dropdown.TextColor3 = Color3_new(200,200,200)
    dropdown.TextSize = 12
    dropdown.Font = Enum.Font.Gotham
    dropdown.BorderSizePixel = 0
    local UICornerDrop = Instance_new("UICorner", dropdown)
    UICornerDrop.CornerRadius = UDim.new(0,4)

    local listFrame = Instance_new("ScrollingFrame", bg)
    listFrame.BackgroundColor3 = Color3_new(35,35,35)
    listFrame.BorderSizePixel = 0
    listFrame.Size = UDim2_new(0,140,0,0)
    listFrame.Position = UDim2_new(1,-148,0,30)
    listFrame.Visible = false
    listFrame.ScrollBarThickness = 0
    listFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local listOpen = false
    local function closeList()
        listOpen = false; listFrame.Visible = false; bg.Size = UDim2_new(1,0,0,36)
    end

    for _,opt in pairs(options) do
        local optBtn = Instance_new("TextButton", listFrame)
        optBtn.BackgroundColor3 = Color3_new(40,40,40)
        optBtn.Size = UDim2_new(1,0,0,24)
        optBtn.Text = opt
        optBtn.TextColor3 = Color3_new(200,200,200)
        optBtn.TextSize = 12
        optBtn.Font = Enum.Font.Gotham
        optBtn.BorderSizePixel = 0
        optBtn.MouseButton1Click:Connect(function()
            val = opt; dropdown.Text = opt; _G[id] = opt; closeList()
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        listOpen = not listOpen
        listFrame.Visible = listOpen
        local h = math.min(#options * 24, 120)
        bg.Size = UDim2_new(1,0,0,36 + 4 + h)
        listFrame.Size = UDim2_new(0,140,0,h)
    end)

    elementY = elementY + 40
    local obj = {set = function(v) val = v; dropdown.Text = v; _G[id] = v end, get = function() return val end}
    return obj
end

local function CreateSlider(id, title, min, max, default, suffix)
    local bg = Instance_new("Frame", ContentFrame)
    bg.BackgroundColor3 = Color3_new(28,28,28)
    bg.BorderSizePixel = 0
    bg.Size = UDim2_new(1,0,0,40)
    bg.Position = UDim2_new(0,0,0,elementY)
    local UICornerS = Instance_new("UICorner", bg)
    UICornerS.CornerRadius = UDim.new(0,4)

    local t = Instance_new("TextLabel", bg)
    t.BackgroundTransparency = 1
    t.Size = UDim2_new(1,-10,0,16)
    t.Position = UDim2_new(0,8,0,2)
    t.Text = title .. ": " .. tostring(default or min) .. (suffix or "")
    t.TextColor3 = Color3_new(220,220,220)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Font = Enum.Font.Gotham
    t.TextSize = 13

    local val = default or min
    local sliderBg = Instance_new("Frame", bg)
    sliderBg.BackgroundColor3 = Color3_new(50,50,50)
    sliderBg.BorderSizePixel = 0
    sliderBg.Size = UDim2_new(0.9,0,0,4)
    sliderBg.Position = UDim2_new(0.05,0,0,28)
    local UICornerSl = Instance_new("UICorner", sliderBg)
    UICornerSl.CornerRadius = UDim.new(0,2)

    local fill = Instance_new("Frame", sliderBg)
    fill.BackgroundColor3 = Color3_new(45,120,200)
    fill.BorderSizePixel = 0
    fill.Size = UDim2_new((val-min)/(max-min),0,1,0)
    local UICornerFl = Instance_new("UICorner", fill)
    UICornerFl.CornerRadius = UDim.new(0,2)

    local callbacks = {}
    function UpdateSlider(v)
        val = math.clamp(v, min, max)
        fill.Size = UDim2_new((val-min)/(max-min),0,1,0)
        t.Text = title .. ": " .. tostring(val) .. (suffix or "")
        _G[id] = val
        for _,cb in pairs(callbacks) do pcall(cb, val) end
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local con
            con = input:GetPropertyChangedSignal("Position"):Connect(function()
                local pos = input.Position.X - sliderBg.AbsolutePosition.X
                local pct = pos / sliderBg.AbsoluteSize.X
                UpdateSlider(min + pct * (max - min))
            end)
            input:GetPropertyChangedSignal("UserInputState"):Connect(function()
                if input.UserInputState == Enum.UserInputState.End then con:Disconnect() end
            end)
        end
    end)

    elementY = elementY + 44
    return {set = UpdateSlider, get = function() return val end, onChange = function(cb) table.insert(callbacks, cb) end}
end

-- Tab creation
local function CreateTab(name, icon)
    local tabFrame = Instance_new("Frame", ContentFrame)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2_new(1,0,0,0)
    tabFrame.Visible = false
    tabFrame.Name = name

    local btn = Instance_new("TextButton", Sidebar)
    btn.BackgroundColor3 = Color3_new(25,25,25)
    btn.Size = UDim2_new(1,0,0,30)
    btn.Text = icon .. "  " .. name
    btn.TextColor3 = Color3_new(160,160,160)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.AutomaticSize = Enum.AutomaticSize.Y

    local highlight = Instance_new("Frame", btn)
    highlight.BackgroundColor3 = Color3_new(45,120,200)
    highlight.BorderSizePixel = 0
    highlight.Size = UDim2_new(0,3,1,0)
    highlight.Visible = false

    local function SelectTab()
        if currentTab then
            currentTab.btn.BackgroundColor3 = Color3_new(25,25,25)
            currentTab.btn.TextColor3 = Color3_new(160,160,160)
            currentTab.highlight.Visible = false
            currentTab.frame.Visible = false
            currentTab.contentY = elementY
        end
        currentTab = {btn=btn, highlight=highlight, frame=tabFrame, content={}, contentY=0}
        btn.BackgroundColor3 = Color3_new(30,30,30)
        btn.TextColor3 = Color3_new(255,255,255)
        highlight.Visible = true
        -- Move content into tab frame
        for _,v in pairs(ContentFrame:GetChildren()) do
            if v ~= tabFrame then v.Parent = tabFrame end
        end
        tabFrame.Visible = true
        tabFrame.Size = UDim2_new(1,0,0,elementY + 10)
    end

    btn.MouseButton1Click:Connect(SelectTab)

    table.insert(tabs, {name=name, btn=btn, frame=tabFrame, highlight=highlight, select=SelectTab})
    return {
        frame = tabFrame,
        AddLabel = function(self, text) return CreateLabel(text) end,
        AddParagraph = function(self, text) return CreateParagraph(text) end,
        AddSeparator = function(self) return CreateSeparator() end,
        AddButton = function(self, args) return CreateButton(args.Title, args.Description, args.Callback) end,
        AddToggle = function(self, id, args) return CreateToggle(id, args.Title, args.Description, args.Default) end,
        AddDropdown = function(self, id, args) return CreateDropdown(id, args.Title, args.Values, args.Default) end,
        AddSlider = function(self, id, args) return CreateSlider(id, args.Title, args.Min, args.Max, args.Default, args.Suffix) end,
    }
end

-- Select first tab
local function SelectFirstTab()
    if #tabs > 0 then
        task_spawn(tabs[1].select)
    end
end

--==========================--
--      UI BUILDING         --
--==========================--
local Tabs = {
    Info = CreateTab("Info", "ℹ"),
    Main = CreateTab("Main", "⚔"),
    Sea = CreateTab("Sea", "🌊"),
    Draco = CreateTab("Draco", "🐉"),
    Teleport = CreateTab("TP", "🌍"),
    Stats = CreateTab("Stats", "📊"),
    Misc = CreateTab("Misc", "🔧"),
    Hop = CreateTab("Hop", "🔄"),
}

-- Info Tab
Tabs.Info:AddLabel("Byte Hub v1.1 [Delta]")
Tabs.Info:AddParagraph("by damthien | discord.gg/PF36rvJXN4")
Tabs.Info:AddSeparator()
Tabs.Info:AddLabel("Compatible with Delta Executor on Android")
Tabs.Info:AddLabel("Script loaded successfully!")

-- Main Farm Tab
Tabs.Main:AddLabel("Main Farm")
local FarmToggle = Tabs.Main:AddToggle("AutoFarm", {Title = "Auto Farm", Default = false})
Tabs.Main:AddDropdown("SelectNPC", {Title = "Select NPC", Values = {"Bandit","Monkey","Viking","Mercenary","Swan","Marine","Sky","Galley","Fishman","Boss"}, Default = 1})
Tabs.Main:AddDropdown("SelectWeapon", {Title = "Weapon", Values = {"Melee","Sword","Gun"}, Default = 1})
Tabs.Main:AddSeparator()
Tabs.Main:AddLabel("Boss Farm")
local BossToggle = Tabs.Main:AddToggle("AutoBoss", {Title = "Auto Boss", Default = false})
Tabs.Main:AddDropdown("SelectBoss", {Title = "Select Boss", Values = {"Diamond","Jeremy","Dave","D","Saw","Rich","Cobra","Order","Thunder","Castle Guard"}, Default = 1})
Tabs.Main:AddSeparator()
Tabs.Main:AddLabel("Mastery")
local MasteryToggle = Tabs.Main:AddToggle("AutoMastery", {Title = "Auto Mastery", Default = false})
Tabs.Main:AddDropdown("MasteryType", {Title = "Mastery Type", Values = {"Sword","Gun","Fighting Style"}, Default = 1})

-- Sea Events Tab
Tabs.Sea:AddLabel("Sea Events (Third Sea)")
local KitsuneToggle = Tabs.Sea:AddToggle("AutoKitsune", {Title = "Auto Kitsune Island", Default = false})
local AzureToggle = Tabs.Sea:AddToggle("AutoAzure", {Title = "Auto Azure Ember", Default = false})
local BoatToggle = Tabs.Sea:AddToggle("AutoBoat", {Title = "Auto Buy Boat", Default = false})
local RoughSeaToggle = Tabs.Sea:AddToggle("AutoRoughSea", {Title = "Auto Rough Sea", Default = false})
local SeaBeastToggle = Tabs.Sea:AddToggle("AutoSeaBeast", {Title = "Auto Sea Beast", Default = false})
local MirageToggle = Tabs.Sea:AddToggle("AutoMirage", {Title = "Auto Mirage Island", Default = false})
local PrehistoricToggle = Tabs.Sea:AddToggle("AutoPrehistoricIsland", {Title = "Auto Prehistoric Island", Default = false})

-- Draco V4 Tab
Tabs.Draco:AddLabel("Draco Race V4 Trial")
Tabs.Draco:AddButton({Title = "TP Dragon Dojo", Description = "Teleport to Dragon Dojo", Callback = function()
    local p = workspace:FindFirstChild("DragonDojo") or workspace:FindFirstChild("DragonIsland")
    if p then
        local part = p:FindFirstChild("Part") or p:FindFirstChildWhichIsA("BasePart")
        if part then Tween(part) end
    end
end})
Tabs.Draco:AddButton({Title = "TP Dragon Wizard", Description = "Teleport to Dragon Wizard NPC", Callback = function()
    local w = workspace:FindFirstChild("DragonWizard") or workspace:FindFirstChild("Wizard")
    if w and w:FindFirstChild("HumanoidRootPart") then Tween(w.HumanoidRootPart) end
end})
Tabs.Draco:AddButton({Title = "TP Dragon Tether", Description = "Teleport to Dragon Tether NPC", Callback = function()
    local p = workspace:FindFirstChild("DragonTether")
    if p and p:FindFirstChildWhichIsA("BasePart") then Tween(p:FindFirstChildWhichIsA("BasePart")) end
end})
Tabs.Draco:AddSeparator()
Tabs.Draco:AddButton({Title = "Craft Volcanic Magnet", Description = "Craft Volcanic Magnet", Callback = function()
    CommF("CraftVolcanicMagnet")
end})
Tabs.Draco:AddButton({Title = "Craft Dragonheart", Description = "Craft Dragonheart", Callback = function()
    CommF("CraftDragonheart")
end})
Tabs.Draco:AddButton({Title = "Craft Dragonstorm", Description = "Craft Dragonstorm", Callback = function()
    CommF("CraftDragonstorm")
end})
Tabs.Draco:AddButton({Title = "Buy Flames of Hearth", Description = "Buy Flames of Hearth", Callback = function()
    CommF("BuyFlamesOfHearth")
end})
Tabs.Draco:AddSeparator()
local VolcanoToggle = Tabs.Draco:AddToggle("AutoVolcanoEvent", {Title = "Auto Volcano Event", Default = false})
local LavaGolemToggle = Tabs.Draco:AddToggle("AutoKillLavaGolem", {Title = "Auto Kill Lava Golem", Default = false})
local DragonEggToggle = Tabs.Draco:AddToggle("AutoCollectDragonEgg", {Title = "Auto Collect Dragon Egg", Default = false})
Tabs.Draco:AddSeparator()
local TrialOfFlamesToggle = Tabs.Draco:AddToggle("AutoTrialOfFlames", {Title = "Auto Trial of Flames", Default = false})

-- Teleport Tab
Tabs.Teleport:AddLabel("Teleports")
local teleportLocations = {"Jungle","Buggy","Desert","Frozen Village","Marine Fortress","Skylands","Prison","Colosseum","Magma Village","Underwater City","Fountain Town","House","Great Tree","Castle on the Sea","Mansion","Port Town","Cafe","Factory","Haunted Castle","Fishing Village"}
Tabs.Teleport:AddDropdown("SelectTP", {Title = "Location", Values = teleportLocations, Default = 1})
Tabs.Teleport:AddButton({Title = "Teleport", Description = "Teleport to selected location", Callback = function()
    local loc = _G.SelectTP
    if loc then
        local found = workspace:FindFirstChild(loc) or workspace:FindFirstChild(loc.."_Island") or workspace:FindFirstChild(loc.." Island")
        if found then
            local p = found:FindFirstChildWhichIsA("BasePart")
            if p then Tween(p) end
        end
    end
end})
Tabs.Teleport:AddButton({Title = "Cancel Tween", Description = "Stop current tween", Callback = CancelTween})

-- Stats Tab
Tabs.Stats:AddLabel("Stats Distribution")
Tabs.Stats:AddSlider("MeleeLevel", {Title = "Melee", Min = 1, Max = 2600, Default = 2600})
Tabs.Stats:AddSlider("DefenseLevel", {Title = "Defense", Min = 1, Max = 2600, Default = 2600})
Tabs.Stats:AddSlider("SwordLevel", {Title = "Sword", Min = 1, Max = 2600, Default = 1})
Tabs.Stats:AddSlider("GunLevel", {Title = "Gun", Min = 1, Max = 2600, Default = 1})
Tabs.Stats:AddSlider("BloxFruitLevel", {Title = "Blox Fruit", Min = 1, Max = 2600, Default = 1})
local AutoStatsToggle = Tabs.Stats:AddToggle("AutoStats", {Title = "Auto Stats", Default = false})

-- Misc Tab
Tabs.Misc:AddLabel("Miscellaneous")
Tabs.Misc:AddButton({Title = "Buy Haki (Buso)", Description = "Buy Buso Haki", Callback = function()
    CommF("Buso")
end})
Tabs.Misc:AddButton({Title = "Buy Observation (Ken)", Description = "Buy Ken Haki", Callback = function()
    CommF("Ken")
end})
Tabs.Misc:AddSeparator()
Tabs.Misc:AddButton({Title = "Buy Boat", Description = "Buy a boat", Callback = function()
    CommF("BuyBoat")
end})
Tabs.Misc:AddButton({Title = "Buy Microchip", Description = "Buy microchip", Callback = function()
    CommF("BuyMicrochip")
end})
Tabs.Misc:AddSeparator()
local FogToggle = Tabs.Misc:AddToggle("Fog", {Title = "Disable Fog", Default = false})
FogToggle.onChange(function(v)
    if v then
        game:GetService("Lighting").FogEnd = 99999
    else
        game:GetService("Lighting").FogEnd = 100000
    end
end)
local RejoinToggle = Tabs.Misc:AddToggle("AutoRejoin", {Title = "Auto Rejoin", Default = false})

-- Hop Tab
Tabs.Hop:AddLabel("Server Hop")
Tabs.Hop:AddButton({Title = "Rejoin Server", Description = "Rejoin current server", Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end})
Tabs.Hop:AddButton({Title = "Server Hop (HTTP)", Description = "Hop to new server via Roblox API", Callback = function()
    task_spawn(function()
        local ok, data = pcall(function()
            return game:GetService("HttpService"):GetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")
        end)
        if ok and data then
            local decoded = game:GetService("HttpService"):JSONDecode(data)
            local servers = {}
            for _,v in pairs(decoded.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, v.id)
                end
            end
            if #servers > 0 then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1,#servers)], player)
            end
        end
    end)
end})
Tabs.Hop:AddButton({Title = "Copy Server ID", Description = "Copy current JobId", Callback = function()
    if setclipboard then pcall(setclipboard, game.JobId) end
end})

-- Select first tab
SelectFirstTab()

--==========================--
--       AUTO LOOPS         --
--==========================--

-- Auto Farm
task_spawn(function()
    while task.wait(_G.Fast_Delay or 0.12) do
        pcall(function()
            if _G.AutoFarm then
                local hrp = SafeHRP() if not hrp then return end
                local npcName = _G.SelectNPC or "Bandit"
                local shortest = math.huge; local target = nil
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name:find(npcName) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist < shortest then shortest = dist; target = v end
                    end
                end
                if target then
                    if shortest > 15 then
                        Tween(target.HumanoidRootPart)
                    else
                        hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                        NormalAttack()
                    end
                else
                    local npcs = {
                        Bandit = Vector3_new(1060, 17, 1426);
                        Monkey = Vector3_new(-1220, 22, -470);
                        Viking = Vector3_new(1060, 12, 1320);
                        Mercenary = Vector3_new(-940, 16, 690);
                        Swan = Vector3_new(780, 72, 1230);
                        Marine = Vector3_new(-2640, 12, 2080);
                        Sky = Vector3_new(-4950, 295, -790);
                        Galley = Vector3_new(-5430, 15, -540);
                        Fishman = Vector3_new(61200, 19, 1620);
                        Boss = Vector3_new(2900, 20, -700);
                    }
                    local pos = npcs[npcName]
                    if pos and First_Sea then
                        local p = Instance_new("Part", workspace)
                        p.Size = Vector3_new(1,1,1); p.Anchored = true; p.Transparency = 1
                        p.CFrame = CFrame.new(pos)
                        Tween(p)
                        task.wait(2)
                        p:Destroy()
                    end
                end
            end
        end)
    end
end)

-- Auto Boss
task_spawn(function()
    while task.wait(0.15) do
        pcall(function()
            if _G.AutoBoss then
                local hrp = SafeHRP() if not hrp then return end
                local bossName = _G.SelectBoss or "Diamond"
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name:find(bossName) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist > 15 then
                            Tween(v.HumanoidRootPart)
                        else
                            hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                            NormalAttack()
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Mastery
task_spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.AutoMastery then
                local hrp = SafeHRP() if not hrp then return end
                local mt = _G.MasteryType or "Sword"
                for _,v in pairs(player.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        if (mt == "Sword" and v.ToolTip == "Sword") or (mt == "Gun" and v.ToolTip == "Gun") or (mt == "Fighting Style" and v.ToolTip == "Melee") then
                            if player.Character then
                                player.Character.Humanoid:EquipTool(v)
                            end
                            break
                        end
                    end
                end
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        local dist = (hrp.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist < 25 then
                            hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                            NormalAttack()
                        elseif dist < 300 then
                            Tween(v.HumanoidRootPart)
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Stats
task_spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.AutoStats then
                local stats = {
                    Melee = (_G.MeleeLevel or 2600);
                    Defense = (_G.DefenseLevel or 2600);
                    Sword = (_G.SwordLevel or 1);
                    Gun = (_G.GunLevel or 1);
                    ["Demon Fruit"] = (_G.BloxFruitLevel or 1);
                }
                for stat,val in pairs(stats) do
                    CommF("AddPoint", stat, val)
                    task.wait(0.1)
                end
            end
        end)
    end
end)

-- Sea Event: Auto Kitsune
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoKitsune and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                local island = FindSeaEvent("KitsuneIsland")
                if island then
                    local part = FindIslandParts("KitsuneIsland")
                    if part then
                        if (hrp.Position - part.Position).Magnitude > 200 then
                            Tween(part)
                        else
                            for _,v in pairs(workspace.Enemies:GetChildren()) do
                                if (v.Name == "Kitsune" or v.Name == "KitsuneMonster") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                    hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                                    task_wait(0.1)
                                    NormalAttack()
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Sea Event: Auto Azure Ember
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoAzure and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                for _,v in pairs(workspace:GetDescendants()) do
                    if (v.Name == "AzureEmber" or v.Name == "Azure") and v:IsA("BasePart") then
                        if (hrp.Position - v.Position).Magnitude > 50 then
                            Tween(v)
                        else
                            pcall(function() firetouchinterest(hrp, v, 0) task_wait(0.1) firetouchinterest(hrp, v, 1) end)
                        end
                        break
                    end
                end
            end
        end)
    end
end)

-- Sea Event: Auto Boat
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoBoat and Third_Sea then
                local boat = workspace.Boats:FindFirstChild(player.Name)
                if not boat then CommF("BuyBoat") end
            end
        end)
    end
end)

-- Sea Event: Auto Rough Sea
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoRoughSea and Third_Sea then
                CommF("SetSail", "RoughSea")
            end
        end)
    end
end)

-- Sea Event: Auto Sea Beast
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoSeaBeast and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                for _,v in pairs(workspace:GetDescendants()) do
                    if (v.Name == "SeaBeast" or v.Name == "TerrorShark") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        if (hrp.Position - v.HumanoidRootPart.Position).Magnitude > 200 then
                            Tween(v.HumanoidRootPart)
                        else
                            hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,10)
                            task_wait(0.1)
                            NormalAttack()
                        end
                        break
                    end
                end
            end
        end)
    end
end)

-- Sea Event: Auto Mirage
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoMirage and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                local island = FindSeaEvent("MirageIsland")
                if island then
                    local part = FindIslandParts("MirageIsland")
                    if part and (hrp.Position - part.Position).Magnitude > 200 then
                        Tween(part)
                    end
                end
            end
        end)
    end
end)

-- Sea Event: Auto Prehistoric Island
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoPrehistoricIsland and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                local island = FindSeaEvent("PrehistoricIsland")
                if island then
                    local part = FindIslandParts("PrehistoricIsland")
                    if part then
                        if (hrp.Position - part.Position).Magnitude > 200 then
                            Tween(part)
                            task_wait(1)
                        else
                            local skull = island:FindFirstChild("FossilAncientRelic") or island:FindFirstChild("TrexSkull") or island:FindFirstChild("Skull")
                            if skull and (hrp.Position - skull.Position).Magnitude > 15 then
                                Tween(skull)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Draco V4: Auto Volcano Event
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoVolcanoEvent and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                local island = workspace:FindFirstChild("PrehistoricIsland")
                if island then
                    local part = FindIslandParts("PrehistoricIsland")
                    if part then
                        if (hrp.Position - part.Position).Magnitude > 200 then
                            Tween(part)
                        else
                            local relic = island:FindFirstChild("FossilAncientRelic") or island:FindFirstChild("Relic")
                            if relic and (hrp.Position - relic.Position).Magnitude > 15 then
                                Tween(relic)
                            else
                                CommF("VolcanoEvent")
                                task_wait(0.5)
                            end
                            if _G.AutoKillLavaGolem then
                                for _,v in pairs(workspace.Enemies:GetChildren()) do
                                    if (v.Name:find("Lava") or v.Name:find("Golem")) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                        hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,8)
                                        task_wait(0.1)
                                        NormalAttack()
                                    end
                                end
                            end
                            if _G.AutoCollectDragonEgg then
                                local egg = island:FindFirstChild("DragonEgg") or island:FindFirstChild("Egg")
                                if egg and egg:IsA("BasePart") then
                                    if (hrp.Position - egg.Position).Magnitude > 15 then
                                        Tween(egg)
                                    else
                                        pcall(function() firetouchinterest(hrp, egg, 0) task_wait(0.1) firetouchinterest(hrp, egg, 1) end)
                                        task_wait(0.5)
                                        CommF("DragonTether")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Draco V4: Auto Trial of Flames
task_spawn(function()
    while task.wait(3) do
        pcall(function()
            if _G.AutoTrialOfFlames and Third_Sea then
                local hrp = SafeHRP() if not hrp then return end
                local island = workspace:FindFirstChild("PrehistoricIsland")
                if island then
                    local cave = island:FindFirstChild("TrialCave") or island:FindFirstChild("FlameCave") or island:FindFirstChild("Cave")
                    if cave then
                        local pivot = cave:GetPivot().p + Vector3_new(0,10,0)
                        local cd = (hrp.Position - pivot).Magnitude
                        if cd > 30 then
                            local p = Instance_new("Part", workspace)
                            p.Size = Vector3_new(1,1,1); p.Anchored = true; p.Transparency = 1
                            p.CFrame = CFrame.new(pivot)
                            Tween(p)
                            task_wait(2)
                            p:Destroy()
                        else
                            CommF("TrialOfFlames")
                            task_wait(1)
                            for i = 1, 3 do
                                local relic = workspace:FindFirstChild("TrialRelic" .. i) or workspace:FindFirstChild("Relic" .. i)
                                if relic and relic:IsA("BasePart") then
                                    Tween(relic)
                                    task_wait(0.5)
                                    CommF("PlaceRelic", i)
                                    task_wait(1)
                                end
                            end
                            local gate = workspace:FindFirstChild("MagicalGate") or workspace:FindFirstChild("CircularGate")
                            if gate and gate:IsA("BasePart") then
                                Tween(gate)
                                task_wait(0.5)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
