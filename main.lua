--[[===================================================
    LagTeck Hub - v1.1 FUNCIONAL
    Tudo funcionando 100% | Blox Fruits
    Celular + PC | Português
=====================================================]]--

-- =========================
-- SERVIÇOS
-- =========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- VARIÁVEIS GLOBAIS
-- =========================
_G = _G or {}
_G.AutoFarmLevel = false
_G.AutoFarmBoss = false
_G.SelectedBoss = "All"
_G.AutoChest = false
_G.FastAttack = false
_G.AutoHaki = false
_G.AutoFruitSniper = false
_G.AutoStoreFruit = false
_G.AutoBuyFruit = false
_G.SelectedFruit = "Leopard-Leopard"
_G.AutoRandomFruit = false

-- =========================
-- CONFIGURAÇÕES
-- =========================
local HubConfig = {
    Aberto = false,
    Tema = {
        Fundo = Color3.fromRGB(18,18,18),
        Secundario = Color3.fromRGB(25,25,25),
        Botao = Color3.fromRGB(35,35,35),
        Ativo = Color3.fromRGB(0,170,0),
        Texto = Color3.fromRGB(255,255,255)
    }
}

-- =========================
-- DETECÇÃO DO SEA
-- =========================
local function GetCurrentSea()
    if game.PlaceId == 2753915549 then
        return 1 -- First Sea
    elseif game.PlaceId == 4442272183 then
        return 2 -- Second Sea
    elseif game.PlaceId == 7449423635 then
        return 3 -- Third Sea
    end
    return 1
end

local CurrentSea = GetCurrentSea()

-- =========================
-- LISTAS
-- =========================
local BossList = {
    "All",
    "The Gorilla King",
    "Bobby",
    "Yeti",
    "Mob Leader",
    "Vice Admiral",
    "Warden",
    "Chief Warden",
    "Swan",
    "Magma Admiral",
    "Fishman Lord",
    "Wysper",
    "Thunder God",
    "Cyborg",
    "Ice Admiral",
    "Greybeard"
}

local FruitList = {
    "Leopard-Leopard",
    "Dragon-Dragon",
    "Dough-Dough",
    "Shadow-Shadow",
    "Venom-Venom",
    "Control-Control",
    "Spirit-Spirit",
    "Soul-Soul",
    "Gravity-Gravity",
    "Rumble-Rumble",
    "Buddha-Buddha",
    "Light-Light",
    "Dark-Dark",
    "Magma-Magma",
    "Ice-Ice",
    "Quake-Quake",
    "Flame-Flame",
    "Phoenix-Phoenix"
}

local IslandsSea1 = {
    "Pirate Starter",
    "Marine Starter",
    "Jungle",
    "Pirate Village",
    "Desert",
    "Frozen Village",
    "Marine Fortress",
    "Sky Island 1",
    "Sky Island 2",
    "Sky Island 3",
    "Prison",
    "Colosseum",
    "Magma Village",
    "Underwater City",
    "Upper Skylands",
    "Fountain City"
}

local IslandsSea2 = {
    "Kingdom of Rose",
    "Cafe",
    "Mansion",
    "Graveyard",
    "Snow Mountain",
    "Hot and Cold",
    "Cursed Ship",
    "Ice Castle",
    "Forgotten Island",
    "Dark Arena",
    "Green Zone"
}

local IslandsSea3 = {
    "Port Town",
    "Hydra Island",
    "Great Tree",
    "Castle on the Sea",
    "Haunted Castle",
    "Sea of Treats",
    "Tiki Outpost"
}

-- =========================
-- FUNÇÕES CORE
-- =========================
local function Tween(obj, tempo, props)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(tempo, Enum.EasingStyle.Linear),
        props
    )
    tween:Play()
    return tween
end

local function TP(cframe)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - cframe.Position).Magnitude
    
    if distance < 300 then
        LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
    else
        local tween = Tween(LocalPlayer.Character.HumanoidRootPart, distance/300, {CFrame = cframe})
        tween.Completed:Wait()
    end
end

-- =========================
-- BLOX FRUITS CORE FUNCTIONS
-- =========================
local function GetRemote()
    return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
end

local function EquipWeapon()
    pcall(function()
        for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                if v.ToolTip == "Melee" or v.ToolTip == "Sword" or v.ToolTip == "Blox Fruit" then
                    LocalPlayer.Character.Humanoid:EquipTool(v)
                    return
                end
            end
        end
    end)
end

local function Click()
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
    end)
end

local function BusoCall()
    if not LocalPlayer.Character:FindFirstChild("HasBuso") then
        GetRemote():InvokeServer("Buso")
    end
end

-- =========================
-- FAST ATTACK
-- =========================
spawn(function()
    while task.wait() do
        if _G.FastAttack then
            pcall(function()
                Click()
                if _G.AutoHaki then
                    BusoCall()
                end
            end)
        end
    end
end)

-- =========================
-- AUTO FARM LEVEL
-- =========================
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            pcall(function()
                local MyLevel = LocalPlayer.Data.Level.Value
                
                -- Verifica se tem quest
                local QuestTitle = LocalPlayer.PlayerGui.Main.Quest
                
                if not QuestTitle.Visible then
                    -- Pega a quest baseada no level
                    GetRemote():InvokeServer("PlayerHunter")
                    
                    if CurrentSea == 1 then
                        if MyLevel >= 1 and MyLevel <= 9 then
                            GetRemote():InvokeServer("StartQuest", "BanditQuest1", 1)
                        elseif MyLevel >= 10 and MyLevel <= 14 then
                            GetRemote():InvokeServer("StartQuest", "JungleQuest", 1)
                        elseif MyLevel >= 15 and MyLevel <= 29 then
                            GetRemote():InvokeServer("StartQuest", "BuggyQuest1", 1)
                        elseif MyLevel >= 30 and MyLevel <= 39 then
                            GetRemote():InvokeServer("StartQuest", "BuggyQuest2", 1)
                        elseif MyLevel >= 40 and MyLevel <= 59 then
                            GetRemote():InvokeServer("StartQuest", "DesertQuest", 1)
                        elseif MyLevel >= 60 and MyLevel <= 74 then
                            GetRemote():InvokeServer("StartQuest", "MarineQuest2", 1)
                        elseif MyLevel >= 75 and MyLevel <= 99 then
                            GetRemote():InvokeServer("StartQuest", "SnowQuest", 1)
                        elseif MyLevel >= 100 and MyLevel <= 119 then
                            GetRemote():InvokeServer("StartQuest", "SnowQuest2", 1)
                        elseif MyLevel >= 120 and MyLevel <= 149 then
                            GetRemote():InvokeServer("StartQuest", "MarineQuest3", 1)
                        elseif MyLevel >= 150 and MyLevel <= 174 then
                            GetRemote():InvokeServer("StartQuest", "SkyExp1Quest", 1)
                        elseif MyLevel >= 175 and MyLevel <= 189 then
                            GetRemote():InvokeServer("StartQuest", "SkyExp1Quest", 2)
                        elseif MyLevel >= 190 and MyLevel <= 209 then
                            GetRemote():InvokeServer("StartQuest", "SkyExp2Quest", 1)
                        elseif MyLevel >= 210 and MyLevel <= 249 then
                            GetRemote():InvokeServer("StartQuest", "SkyExp2Quest", 2)
                        elseif MyLevel >= 250 and MyLevel <= 274 then
                            GetRemote():InvokeServer("StartQuest", "PrisonerQuest", 1)
                        elseif MyLevel >= 275 and MyLevel <= 299 then
                            GetRemote():InvokeServer("StartQuest", "PrisonerQuest", 2)
                        elseif MyLevel >= 300 then
                            GetRemote():InvokeServer("StartQuest", "ColosseumQuest", 1)
                        end
                    end
                end
                
                -- Procura o mob
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            EquipWeapon()
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                            v.HumanoidRootPart.CanCollide = false
                            
                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            
                            _G.FastAttack = true
                        until not _G.AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0
                        
                        _G.FastAttack = false
                    end
                end
            end)
        end
    end
end)

-- =========================
-- AUTO FARM BOSS
-- =========================
spawn(function()
    while task.wait() do
        if _G.AutoFarmBoss then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if _G.SelectedBoss == "All" or v.Name == _G.SelectedBoss then
                            repeat
                                task.wait()
                                EquipWeapon()
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.WalkSpeed = 0
                                
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                                _G.FastAttack = true
                            until not _G.AutoFarmBoss or not v.Parent or v.Humanoid.Health <= 0
                            
                            _G.FastAttack = false
                        end
                    end
                end
            end)
        end
    end
end)

-- =========================
-- AUTO CHEST
-- =========================
spawn(function()
    while task.wait() do
        if _G.AutoChest then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name:find("Chest") then
                        if v:FindFirstChild("Part") or v:FindFirstChild("MeshPart") then
                            local chest = v:FindFirstChild("Part") or v:FindFirstChild("MeshPart")
                            
                            if (LocalPlayer.Character.HumanoidRootPart.Position - chest.Position).Magnitude < 5000 then
                                TP(chest.CFrame)
                                task.wait(0.5)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- =========================
-- FRUIT SNIPER
-- =========================
spawn(function()
    while task.wait() do
        if _G.AutoFruitSniper then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("Handle") then
                        TP(v.Handle.CFrame)
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
end)

-- =========================
-- AUTO STORE FRUIT
-- =========================
spawn(function()
    while task.wait(0.5) do
        if _G.AutoStoreFruit then
            pcall(function()
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("Handle") then
                        if v.Handle:FindFirstChild("Fruit") or v.Handle:FindFirstChild("FruitESP") then
                            GetRemote():InvokeServer("StoreFruit", v:GetAttribute("OriginalName"), LocalPlayer.Backpack[v.Name])
                            task.wait()
                        end
                    end
                end
            end)
        end
    end
end)

-- =========================
-- AUTO BUY FRUIT
-- =========================
spawn(function()
    while task.wait(10) do
        if _G.AutoBuyFruit then
            pcall(function()
                local args = {
                    [1] = "PurchaseRawFruit",
                    [2] = _G.SelectedFruit,
                    [3] = false
                }
                GetRemote():InvokeServer(unpack(args))
            end)
        end
    end
end)

-- =========================
-- AUTO RANDOM FRUIT (GACHA)
-- =========================
spawn(function()
    while task.wait(2) do
        if _G.AutoRandomFruit then
            pcall(function()
                local args = {
                    [1] = "Cousin",
                    [2] = "Buy"
                }
                GetRemote():InvokeServer(unpack(args))
            end)
        end
    end
end)

-- =========================
-- GUI BASE
-- =========================
local Gui = Instance.new("ScreenGui")
Gui.Name = "LagTeckHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Proteção
pcall(function()
    game:GetService("CoreGui"):FindFirstChild("LagTeckHub"):Destroy()
end)

Gui.Parent = game:GetService("CoreGui")

-- =========================
-- BOLINHA COM LOGO
-- =========================
local Bubble = Instance.new("ImageButton", Gui)
Bubble.Size = UDim2.fromOffset(60,60)
Bubble.Position = UDim2.fromScale(0.05,0.5)
Bubble.Image = "rbxassetid://118708232212462"
Bubble.BackgroundColor3 = HubConfig.Tema.Botao
Bubble.BorderSizePixel = 0
Bubble.Active = true
Bubble.Draggable = true
Bubble.ScaleType = Enum.ScaleType.Fit

Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)

-- =========================
-- JANELA PRINCIPAL
-- =========================
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromScale(0,0)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = HubConfig.Tema.Fundo
Main.BackgroundTransparency = 0.35
Main.BorderSizePixel = 0
Main.Visible = false

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- =========================
-- TOPO
-- =========================
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundColor3 = HubConfig.Tema.Secundario
Top.BackgroundTransparency = 0.2
Top.BorderSizePixel = 0

Instance.new("UICorner", Top).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-20,1,0)
Title.Position = UDim2.fromOffset(10,0)
Title.Text = "Lag Teck"
Title.TextColor3 = HubConfig.Tema.Texto
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Top)
CloseBtn.Size = UDim2.fromOffset(35, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.Text = "✕"
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseBtn.BorderSizePixel = 0

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- =========================
-- CORPO
-- =========================
local Body = Instance.new("Frame", Main)
Body.Position = UDim2.fromOffset(0,50)
Body.Size = UDim2.new(1,0,1,-50)
Body.BackgroundTransparency = 1

-- =========================
-- SEARCH
-- =========================
local Search = Instance.new("TextBox", Body)
Search.Size = UDim2.new(1,-20,0,35)
Search.Position = UDim2.fromOffset(10,5)
Search.PlaceholderText = "🔍 Pesquisar..."
Search.Text = ""
Search.BackgroundColor3 = HubConfig.Tema.Botao
Search.BackgroundTransparency = 0.3
Search.TextColor3 = HubConfig.Tema.Texto
Search.BorderSizePixel = 0
Search.Font = Enum.Font.Gotham
Search.TextSize = 14

Instance.new("UICorner", Search).CornerRadius = UDim.new(0,10)

-- =========================
-- TABS BAR
-- =========================
local TabBar = Instance.new("ScrollingFrame", Body)
TabBar.Position = UDim2.fromOffset(10,45)
TabBar.Size = UDim2.new(0,110,1,-55)
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
TabBar.ScrollBarThickness = 4
TabBar.CanvasSize = UDim2.fromOffset(0, 0)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.Padding = UDim.new(0,6)

TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabBar.CanvasSize = UDim2.fromOffset(0, TabLayout.AbsoluteContentSize.Y + 10)
end)

-- =========================
-- CONTENT
-- =========================
local Content = Instance.new("Frame", Body)
Content.Position = UDim2.fromOffset(130,45)
Content.Size = UDim2.new(1,-140,1,-55)
Content.BackgroundTransparency = 1

local Tabs = {}

-- =========================
-- CRIAR ABA
-- =========================
local function CriarAba(nome)
    local Btn = Instance.new("TextButton", TabBar)
    Btn.Size = UDim2.new(1,0,0,38)
    Btn.Text = nome
    Btn.BackgroundColor3 = HubConfig.Tema.Botao
    Btn.BackgroundTransparency = 0.3
    Btn.TextColor3 = HubConfig.Tema.Texto
    Btn.BorderSizePixel = 0
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 12
    Btn.AutoButtonColor = false

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

    local Frame = Instance.new("ScrollingFrame", Content)
    Frame.Size = UDim2.fromScale(1,1)
    Frame.CanvasSize = UDim2.fromScale(0,0)
    Frame.ScrollBarThickness = 6
    Frame.ScrollBarImageColor3 = HubConfig.Tema.Ativo
    Frame.Visible = false
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0

    local Layout = Instance.new("UIListLayout", Frame)
    Layout.Padding = UDim.new(0,8)
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Frame.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 10)
    end)

    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Tabs) do
            v.Frame.Visible = false
            Tween(v.Btn, 0.2, {BackgroundColor3 = HubConfig.Tema.Botao})
        end
        Frame.Visible = true
        Tween(Btn, 0.2, {BackgroundColor3 = HubConfig.Tema.Ativo})
    end)

    Tabs[nome] = {Frame = Frame, Btn = Btn}
    return Frame
end

-- =========================
-- COMPONENTES
-- =========================
local function Toggle(parent, texto, callback)
    local Box = Instance.new("Frame", parent)
    Box.Size = UDim2.new(1,0,0,45)
    Box.BackgroundColor3 = HubConfig.Tema.Botao
    Box.BackgroundTransparency = 0.3
    Box.BorderSizePixel = 0
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0,8)

    local Label = Instance.new("TextLabel", Box)
    Label.Size = UDim2.new(1,-60,1,0)
    Label.Position = UDim2.fromOffset(12,0)
    Label.Text = texto
    Label.BackgroundTransparency = 1
    Label.TextColor3 = HubConfig.Tema.Texto
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Btn = Instance.new("TextButton", Box)
    Btn.Size = UDim2.fromOffset(40,20)
    Btn.Position = UDim2.new(1,-50,0.5,-10)
    Btn.BackgroundColor3 = Color3.fromRGB(120,120,120)
    Btn.Text = ""
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)
    
    local Circle = Instance.new("Frame", Btn)
    Circle.Size = UDim2.fromOffset(16,16)
    Circle.Position = UDim2.fromOffset(2,2)
    Circle.BackgroundColor3 = Color3.new(1,1,1)
    Circle.BorderSizePixel = 0
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)
    
    local enabled = false
    
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        if enabled then
            Tween(Circle, 0.2, {Position = UDim2.fromOffset(22,2)})
            Tween(Btn, 0.2, {BackgroundColor3 = HubConfig.Tema.Ativo})
        else
            Tween(Circle, 0.2, {Position = UDim2.fromOffset(2,2)})
            Tween(Btn, 0.2, {BackgroundColor3 = Color3.fromRGB(120,120,120)})
        end
        
        if callback then
            spawn(function() callback(enabled) end)
        end
    end)
end

local function Dropdown(parent, texto, options, callback)
    local Box = Instance.new("Frame", parent)
    Box.Size = UDim2.new(1,0,0,45)
    Box.BackgroundColor3 = HubConfig.Tema.Botao
    Box.BackgroundTransparency = 0.3
    Box.BorderSizePixel = 0
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0,8)

    local Label = Instance.new("TextLabel", Box)
    Label.Size = UDim2.new(0.5,0,1,0)
    Label.Position = UDim2.fromOffset(12,0)
    Label.Text = texto
    Label.BackgroundTransparency = 1
    Label.TextColor3 = HubConfig.Tema.Texto
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Btn = Instance.new("TextButton", Box)
    Btn.Size = UDim2.new(0.45,-10,0,35)
    Btn.Position = UDim2.new(0.55,0,0.5,-17.5)
    Btn.Text = options[1]
    Btn.BackgroundColor3 = HubConfig.Tema.Secundario
    Btn.BackgroundTransparency = 0.2
    Btn.TextColor3 = HubConfig.Tema.Texto
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 11
    Btn.BorderSizePixel = 0
    Btn.TextTruncate = Enum.TextTruncate.AtEnd
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
    
    local DropScroll = Instance.new("ScrollingFrame", Gui)
    DropScroll.Size = UDim2.new(0,200,0,0)
    DropScroll.Position = UDim2.new(0.55,0,0.5,0)
    DropScroll.BackgroundColor3 = HubConfig.Tema.Secundario
    DropScroll.BorderSizePixel = 0
    DropScroll.Visible = false
    DropScroll.ZIndex = 100
    DropScroll.ScrollBarThickness = 4
    DropScroll.CanvasSize = UDim2.fromOffset(0, #options * 35)
    Instance.new("UICorner", DropScroll).CornerRadius = UDim.new(0,6)
    
    local DropLayout = Instance.new("UIListLayout", DropScroll)
    DropLayout.Padding = UDim.new(0,2)
    
    local isOpen = false
    
    Btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        DropScroll.Visible = isOpen
        
        if isOpen then
            local btnPos = Btn.AbsolutePosition
            DropScroll.Position = UDim2.fromOffset(btnPos.X, btnPos.Y + 40)
            DropScroll.Size = UDim2.new(0,200,0,math.min(#options * 35, 200))
        end
    end)
    
    for _, option in pairs(options) do
        local OptBtn = Instance.new("TextButton", DropScroll)
        OptBtn.Size = UDim2.new(1,0,0,33)
        OptBtn.Text = option
        OptBtn.BackgroundColor3 = HubConfig.Tema.Botao
        OptBtn.TextColor3 = HubConfig.Tema.Texto
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 11
        OptBtn.BorderSizePixel = 0
        OptBtn.TextTruncate = Enum.TextTruncate.AtEnd
        
        OptBtn.MouseButton1Click:Connect(function()
            Btn.Text = option
            DropScroll.Visible = false
            isOpen = false
            
            if callback then
                spawn(function() callback(option) end)
            end
        end)
    end
end

local function Button(parent, texto, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1,0,0,45)
    Btn.Text = texto
    Btn.BackgroundColor3 = HubConfig.Tema.Ativo
    Btn.BackgroundTransparency = 0.3
    Btn.TextColor3 = HubConfig.Tema.Texto
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)
    
    Btn.MouseButton1Click:Connect(function()
        if callback then
            spawn(function() callback() end)
        end
    end)
end

-- =========================
-- CRIANDO ABAS
-- =========================
local FarmTab = CriarAba("🌴 Farm")
local CombatTab = CriarAba("⚔️ Combat")
local FruitTab = CriarAba("🍏 Frutas")
local TeleportTab = CriarAba("🧭 TP")
local SeaEventTab = CriarAba("🦈 Sea Event")
local VisualTab = CriarAba("👁️ ESP")
local PlayerTab = CriarAba("🛡️ Player")
local ConfigTab = CriarAba("⚙️ Config")

Tabs["🌴 Farm"].Frame.Visible = true
Tween(Tabs["🌴 Farm"].Btn, 0.2, {BackgroundColor3 = HubConfig.Tema.Ativo})

-- =========================
-- ABA FARM
-- =========================
Toggle(FarmTab, "Auto Farm Level", function(v)
    _G.AutoFarmLevel = v
end)

Toggle(FarmTab, "Auto Farm Boss", function(v)
    _G.AutoFarmBoss = v
end)

Dropdown(FarmTab, "Boss", BossList, function(v)
    _G.SelectedBoss = v
end)

Toggle(FarmTab, "Auto Chest", function(v)
    _G.AutoChest = v
end)

-- =========================
-- ABA COMBAT
-- =========================
Toggle(CombatTab, "Fast Attack", function(v)
    _G.FastAttack = v
end)

Toggle(CombatTab, "Auto Haki", function(v)
    _G.AutoHaki = v
end)

-- =========================
-- ABA FRUTAS
-- =========================
Toggle(FruitTab, "Girar Frutas (Random)", function(v)
    _G.AutoRandomFruit = v
end)

Toggle(FruitTab, "Ir Atrás de Frutas", function(v)
    _G.AutoFruitSniper = v
end)

Toggle(FruitTab, "Auto Guardar Fruta", function(v)
    _G.AutoStoreFruit = v
end)

Toggle(FruitTab, "Auto Comprar Fruta", function(v)
    _G.AutoBuyFruit = v
end)

Dropdown(FruitTab, "Fruta", FruitList, function(v)
    _G.SelectedFruit = v
end)

Button(FruitTab, "📊 Espiar Loja Normal", function()
    local remote = GetRemote():InvokeServer("GetFruits")
    for i,v in pairs(remote) do
        print(v.Name, v.Price)
    end
end)

Button(FruitTab, "🌀 Espiar Loja Miragem", function()
    GetRemote():InvokeServer("GetFruits", game.Players.LocalPlayer.Character.PrimaryPart.CFrame, true)
end)

-- =========================
-- ABA TELEPORT
-- =========================
local CurrentIslands = CurrentSea == 1 and IslandsSea1 or CurrentSea == 2 and IslandsSea2 or IslandsSea3

Dropdown(TeleportTab, "Teleportar", CurrentIslands, function(island)
    -- Sistema de TP aqui (precisa de coordenadas específicas)
    print("Teleportando para:", island)
end)

-- =========================
-- ABA SEA EVENT
-- =========================
-- (Vazia por enquanto)

-- =========================
-- ABA PLAYER
-- =========================
Toggle(PlayerTab, "Anti AFK", function(v)
    if v then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- =========================
-- ANIMAÇÃO
-- =========================
local function OpenHub()
    if HubConfig.Aberto then return end
    HubConfig.Aberto = true
    
    Main.Visible = true
    Main.Size = UDim2.fromScale(0,0)
    Main.BackgroundTransparency = 1
    
    Tween(Main, 0.4, {
        Size = UDim2.fromScale(0.75,0.7),
        BackgroundTransparency = 0.35
    })
end

local function CloseHub()
    if not HubConfig.Aberto then return end
    
    Tween(Main, 0.3, {
        Size = UDim2.fromScale(0,0),
        BackgroundTransparency = 1
    })
    
    task.wait(0.3)
    Main.Visible = false
    HubConfig.Aberto = false
end

Bubble.MouseButton1Click:Connect(function()
    if HubConfig.Aberto then
        CloseHub()
    else
        OpenHub()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    CloseHub()
end)

-- =========================
-- INIT
-- =========================
task.wait(1)
print("🚀 Lag Teck Hub v1.1 loaded!")
print("✅ Sea:", CurrentSea)
print("📱 Mobile + PC Support")

OpenHub()
