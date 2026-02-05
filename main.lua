--[[===================================================
    LagTeck Hub - v1.0 COMPLETO
    Auto Farm + Combat + Frutas + Teleport
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
local LocalPlayer = Players.LocalPlayer

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
-- VARIÁVEIS DE FARM
-- =========================
local FarmSettings = {
    AutoFarmLevel = false,
    AutoFarmQuest = false,
    AutoFarmBoss = false,
    AutoChest = false,
    AutoSeaEvent = false,
    SelectedBoss = "All",
    SelectedChest = "All",
    
    -- Combat
    AutoAttack = false,
    FastAttack = false,
    KillAura = false,
    AutoHaki = false,
    BringMob = false,
    
    -- Player
    InfiniteEnergy = false,
    NoClip = false,
    Fly = false,
    AntiAFK = false
}

-- Lista de Bosses (atualizada conforme o jogo)
local BossList = {
    "All",
    "Saber Expert",
    "The Gorilla King",
    "Bobby",
    "Yeti",
    "Vice Admiral",
    "Warden",
    "Chief Warden",
    "Swan",
    "Magma Admiral",
    "Fishman Lord",
    "Wysper",
    "Thunder God",
    "Cyborg"
}

-- =========================
-- FUNÇÕES AUXILIARES
-- =========================
local function Tween(obj, tempo, props)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(tempo, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    )
    tween:Play()
    return tween
end

local function TeleportTo(cframe)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - cframe.Position).Magnitude
    local speed = distance > 300 and 350 or 250
    
    local tween = Tween(
        LocalPlayer.Character.HumanoidRootPart,
        distance / speed,
        {CFrame = cframe}
    )
    
    return tween
end

local function GetQuestInfo()
    local MyLevel = LocalPlayer.Data.Level.Value
    local QuestData = {}
    
    -- Sistema de quests baseado no level
    if MyLevel >= 1 and MyLevel <= 9 then
        QuestData.QuestGiver = game:GetService("Workspace").Map.Jungle.QuestGiver
        QuestData.QuestName = "BanditQuest1"
        QuestData.LevelRequired = 1
        QuestData.MobName = "Bandit"
        QuestData.MobLocation = CFrame.new(1145, 17, 1634)
    elseif MyLevel >= 10 and MyLevel <= 14 then
        QuestData.QuestGiver = game:GetService("Workspace").Map.Jungle.QuestGiver
        QuestData.QuestName = "JungleQuest"
        QuestData.LevelRequired = 10
        QuestData.MobName = "Monkey"
        QuestData.MobLocation = CFrame.new(-1448, 50, 38)
    elseif MyLevel >= 15 and MyLevel <= 29 then
        QuestData.QuestGiver = game:GetService("Workspace").Map.Pirate.QuestGiver
        QuestData.QuestName = "BuggyQuest1"
        QuestData.LevelRequired = 15
        QuestData.MobName = "Pirate"
        QuestData.MobLocation = CFrame.new(-1103, 13, 3896)
    else
        -- Fallback para levels mais altos
        QuestData.QuestGiver = game:GetService("Workspace").Map.Jungle.QuestGiver
        QuestData.QuestName = "BanditQuest1"
        QuestData.LevelRequired = 1
        QuestData.MobName = "Bandit"
        QuestData.MobLocation = CFrame.new(1145, 17, 1634)
    end
    
    return QuestData
end

local function HasQuest()
    if LocalPlayer.PlayerGui.Main.Quest.Visible then
        return true
    end
    return false
end

local function GetQuest()
    local questInfo = GetQuestInfo()
    
    if questInfo.QuestGiver and questInfo.QuestGiver:FindFirstChild("HumanoidRootPart") then
        repeat
            TeleportTo(questInfo.QuestGiver.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
            wait(0.5)
        until (LocalPlayer.Character.HumanoidRootPart.Position - questInfo.QuestGiver.HumanoidRootPart.Position).Magnitude < 5 or not FarmSettings.AutoFarmLevel
        
        wait(0.3)
        
        local Remote = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_")
        if Remote then
            Remote:InvokeServer("StartQuest", questInfo.QuestName, questInfo.LevelRequired)
        end
        
        wait(0.5)
    end
end

-- =========================
-- COMBAT FUNCTIONS
-- =========================
local AttackConnection = nil

local function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

local function EnableFastAttack()
    if AttackConnection then return end
    
    AttackConnection = RunService.Heartbeat:Connect(function()
        if FarmSettings.FastAttack then
            pcall(function()
                Click()
            end)
        end
    end)
end

local function DisableFastAttack()
    if AttackConnection then
        AttackConnection:Disconnect()
        AttackConnection = nil
    end
end

local function EquipWeapon()
    pcall(function()
        for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and (v.ToolTip == "Sword" or v.ToolTip == "Melee" or v.ToolTip == "Blox Fruit") then
                LocalPlayer.Character.Humanoid:EquipTool(v)
                return
            end
        end
    end)
end

local function AutoHakiFunction()
    if not FarmSettings.AutoHaki then return end
    
    pcall(function()
        if not LocalPlayer.Character:FindFirstChild("HasBuso") then
            local Remote = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_")
            if Remote then
                Remote:InvokeServer("Buso")
            end
        end
    end)
end

-- =========================
-- AUTO FARM LEVEL
-- =========================
local FarmLevelConnection = nil

local function StartAutoFarmLevel()
    if FarmLevelConnection then return end
    
    FarmSettings.FastAttack = true
    EnableFastAttack()
    
    FarmLevelConnection = RunService.Heartbeat:Connect(function()
        if not FarmSettings.AutoFarmLevel then return end
        
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            -- Pega quest se não tiver
            if not HasQuest() then
                GetQuest()
                wait(1)
                return
            end
            
            -- Equipa arma
            EquipWeapon()
            
            -- Ativa Haki
            AutoHakiFunction()
            
            -- Procura mob da quest
            local questInfo = GetQuestInfo()
            local mob = nil
            
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == questInfo.MobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    mob = v
                    break
                end
            end
            
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                repeat
                    -- Teleporta e ataca
                    TeleportTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                    char.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                    
                    -- Desativa gravidade
                    char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    char.Humanoid:ChangeState(11)
                    
                    wait()
                until not mob.Parent or mob.Humanoid.Health <= 0 or not FarmSettings.AutoFarmLevel
            else
                -- Se não achar mob, vai pra área
                TeleportTo(questInfo.MobLocation)
            end
        end)
    end)
end

local function StopAutoFarmLevel()
    if FarmLevelConnection then
        FarmLevelConnection:Disconnect()
        FarmLevelConnection = nil
    end
    FarmSettings.FastAttack = false
    DisableFastAttack()
end

-- =========================
-- AUTO FARM BOSS
-- =========================
local BossFarmConnection = nil

local function StartAutoFarmBoss()
    if BossFarmConnection then return end
    
    FarmSettings.FastAttack = true
    EnableFastAttack()
    
    BossFarmConnection = RunService.Heartbeat:Connect(function()
        if not FarmSettings.AutoFarmBoss then return end
        
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            EquipWeapon()
            AutoHakiFunction()
            
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                    if FarmSettings.SelectedBoss == "All" or v.Name == FarmSettings.SelectedBoss then
                        repeat
                            TeleportTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                            char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            char.Humanoid:ChangeState(11)
                            wait()
                        until not v.Parent or v.Humanoid.Health <= 0 or not FarmSettings.AutoFarmBoss
                    end
                end
            end
        end)
    end)
end

local function StopAutoFarmBoss()
    if BossFarmConnection then
        BossFarmConnection:Disconnect()
        BossFarmConnection = nil
    end
    FarmSettings.FastAttack = false
    DisableFastAttack()
end

-- =========================
-- AUTO CHEST
-- =========================
local ChestFarmConnection = nil

local function StartAutoChest()
    if ChestFarmConnection then return end
    
    ChestFarmConnection = RunService.Heartbeat:Connect(function()
        if not FarmSettings.AutoChest then return end
        
        pcall(function()
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v.Name:find("Chest") and v:FindFirstChild("Part") or v:FindFirstChild("MeshPart") then
                    local chestPart = v:FindFirstChild("Part") or v:FindFirstChild("MeshPart")
                    
                    if (LocalPlayer.Character.HumanoidRootPart.Position - chestPart.Position).Magnitude < 5000 then
                        TeleportTo(chestPart.CFrame)
                        wait(0.5)
                    end
                end
            end
        end)
    end)
end

local function StopAutoChest()
    if ChestFarmConnection then
        ChestFarmConnection:Disconnect()
        ChestFarmConnection = nil
    end
end

-- =========================
-- PLAYER FUNCTIONS
-- =========================
local NoClipConnection = nil
local FlyConnection = nil

local function EnableNoClip()
    NoClipConnection = RunService.Stepped:Connect(function()
        if FarmSettings.NoClip then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end

local function EnableAntiAFK()
    LocalPlayer.Idled:Connect(function()
        if FarmSettings.AntiAFK then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

-- =========================
-- GUI BASE
-- =========================
local Gui = Instance.new("ScreenGui")
Gui.Name = "LagTeckHub"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- BOLINHA COM LOGO
-- =========================
local Bubble = Instance.new("ImageButton", Gui)
Bubble.Size = UDim2.fromOffset(60,60)
Bubble.Position = UDim2.fromScale(0.05,0.5)
Bubble.Image = "rbxassetid://118708232212462" -- ID da sua logo
Bubble.BackgroundColor3 = HubConfig.Tema.Botao
Bubble.BorderSizePixel = 0
Bubble.Active = true
Bubble.Draggable = true
Bubble.ScaleType = Enum.ScaleType.Fit

Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)

-- Sombra na bolinha
local BubbleShadow = Instance.new("ImageLabel", Bubble)
BubbleShadow.Size = UDim2.fromScale(1.2, 1.2)
BubbleShadow.Position = UDim2.fromScale(0.5, 0.5)
BubbleShadow.AnchorPoint = Vector2.new(0.5, 0.5)
BubbleShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
BubbleShadow.ImageColor3 = Color3.new(0,0,0)
BubbleShadow.ImageTransparency = 0.7
BubbleShadow.BackgroundTransparency = 1
BubbleShadow.ZIndex = 0

-- =========================
-- JANELA PRINCIPAL (COM TRANSPARÊNCIA)
-- =========================
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromScale(0,0) -- Começa invisível para animação
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = HubConfig.Tema.Fundo
Main.BackgroundTransparency = 0.35 -- 35% de transparência
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
Title.Text = "Lag Teck" -- Nome atualizado
Title.TextColor3 = HubConfig.Tema.Texto
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão fechar
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

CloseBtn.MouseButton1Click:Connect(function()
    -- Animação de saída
    Tween(Main, 0.3, {Size = UDim2.fromScale(0,0), BackgroundTransparency = 1})
    wait(0.3)
    Main.Visible = false
    HubConfig.Aberto = false
end)

-- =========================
-- CORPO
-- =========================
local Body = Instance.new("Frame", Main)
Body.Position = UDim2.fromOffset(0,50)
Body.Size = UDim2.new(1,0,1,-50)
Body.BackgroundTransparency = 1

-- =========================
-- BUSCA
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
-- BARRA DE ABAS (CORRIGIDA)
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
-- CONTEÚDO
-- =========================
local Content = Instance.new("Frame", Body)
Content.Position = UDim2.fromOffset(130,45)
Content.Size = UDim2.new(1,-140,1,-55)
Content.BackgroundTransparency = 1

-- =========================
-- TABELAS
-- =========================
local Tabs = {}
local CurrentTab = nil

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
        CurrentTab = Frame
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
            callback(enabled)
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
    Btn.TextSize = 12
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
    
    local DropFrame = Instance.new("Frame", Box)
    DropFrame.Size = UDim2.new(0.45,-10,0,0)
    DropFrame.Position = UDim2.new(0.55,0,1,5)
    DropFrame.BackgroundColor3 = HubConfig.Tema.Secundario
    DropFrame.BorderSizePixel = 0
    DropFrame.Visible = false
    DropFrame.ZIndex = 10
    Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0,6)
    
    local DropLayout = Instance.new("UIListLayout", DropFrame)
    DropLayout.Padding = UDim.new(0,2)
    
    local isOpen = false
    
    Btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            DropFrame.Visible = true
            Tween(DropFrame, 0.2, {Size = UDim2.new(0.45,-10,0,math.min(#options * 32, 150))})
        else
            Tween(DropFrame, 0.2, {Size = UDim2.new(0.45,-10,0,0)})
            wait(0.2)
            DropFrame.Visible = false
        end
    end)
    
    for _, option in pairs(options) do
        local OptBtn = Instance.new("TextButton", DropFrame)
        OptBtn.Size = UDim2.new(1,0,0,30)
        OptBtn.Text = option
        OptBtn.BackgroundColor3 = HubConfig.Tema.Botao
        OptBtn.TextColor3 = HubConfig.Tema.Texto
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 11
        OptBtn.BorderSizePixel = 0
        
        OptBtn.MouseButton1Click:Connect(function()
            Btn.Text = option
            isOpen = false
            Tween(DropFrame, 0.2, {Size = UDim2.new(0.45,-10,0,0)})
            wait(0.2)
            DropFrame.Visible = false
            
            if callback then
                callback(option)
            end
        end)
    end
end

-- =========================
-- CRIANDO ABAS
-- =========================
local FarmTab = CriarAba("🌴 Farm")
local CombatTab = CriarAba("⚔️ Combat")
local FruitTab = CriarAba("🍏 Frutas")
local TeleportTab = CriarAba("🧭 TP")
local VisualTab = CriarAba("👁️ ESP")
local PlayerTab = CriarAba("🛡️ Player")
local SystemTab = CriarAba("⚙️ Config")

-- Ativa primeira aba
Tabs["🌴 Farm"].Frame.Visible = true
Tween(Tabs["🌴 Farm"].Btn, 0.2, {BackgroundColor3 = HubConfig.Tema.Ativo})

-- =========================
-- ABA FARM
-- =========================
Toggle(FarmTab, "Auto Farm Level", function(enabled)
    FarmSettings.AutoFarmLevel = enabled
    if enabled then
        StartAutoFarmLevel()
    else
        StopAutoFarmLevel()
    end
end)

Toggle(FarmTab, "Auto Farm Boss", function(enabled)
    FarmSettings.AutoFarmBoss = enabled
    if enabled then
        StartAutoFarmBoss()
    else
        StopAutoFarmBoss()
    end
end)

Dropdown(FarmTab, "Selecionar Boss", BossList, function(selected)
    FarmSettings.SelectedBoss = selected
    print("Boss selecionado:", selected)
end)

Toggle(FarmTab, "Auto Chest", function(enabled)
    FarmSettings.AutoChest = enabled
    if enabled then
        StartAutoChest()
    else
        StopAutoChest()
    end
end)

Dropdown(FarmTab, "Tipo de Baú", {"All", "Common", "Rare", "Legendary"}, function(selected)
    FarmSettings.SelectedChest = selected
    print("Tipo de baú:", selected)
end)

-- =========================
-- ABA COMBAT
-- =========================
Toggle(CombatTab, "Fast Attack", function(enabled)
    FarmSettings.FastAttack = enabled
    if enabled then
        EnableFastAttack()
    else
        DisableFastAttack()
    end
end)

Toggle(CombatTab, "Auto Haki", function(enabled)
    FarmSettings.AutoHaki = enabled
end)

-- =========================
-- ABA PLAYER
-- =========================
Toggle(PlayerTab, "No Clip", function(enabled)
    FarmSettings.NoClip = enabled
    if enabled and not NoClipConnection then
        EnableNoClip()
    elseif not enabled and NoClipConnection then
        NoClipConnection:Disconnect()
        NoClipConnection = nil
    end
end)

Toggle(PlayerTab, "Anti AFK", function(enabled)
    FarmSettings.AntiAFK = enabled
    if enabled then
        EnableAntiAFK()
    end
end)

-- =========================
-- ANIMAÇÃO DE ABERTURA
-- =========================
local function OpenHub()
    if HubConfig.Aberto then return end
    HubConfig.Aberto = true
    
    Main.Visible = true
    Main.Size = UDim2.fromScale(0,0)
    Main.BackgroundTransparency = 1
    
    -- Animação de entrada
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
    
    wait(0.3)
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

-- =========================
-- INICIALIZAÇÃO
-- =========================
wait(1)
print("🚀 Lag Teck Hub v1.0 carregado!")
print("✅ Criado por LagTeck")
print("📱 Suporte: Mobile + PC")

-- Abre automaticamente na primeira vez
OpenHub()
