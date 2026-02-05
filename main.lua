--[[===================================================
    LagTeck Hub - Auto Farm Implementation
    Farm functions for Blox Fruits
=====================================================]]--

-- =========================
-- SERVIÇOS
-- =========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- CONFIGURAÇÕES
-- =========================
local HubConfig = {
    Aberto = true,
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
    SelectedBoss = nil,
    FastAttackEnabled = false
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

local function GetNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = v
            end
        end
    end
    
    return nearestEnemy
end

local function GetQuestInfo()
    local MyLevel = LocalPlayer.Data.Level.Value
    local QuestData = {}
    
    -- Sistema básico de quest por level
    if MyLevel >= 1 and MyLevel <= 9 then
        QuestData.QuestGiver = "BanditQuest1"
        QuestData.QuestName = "BanditQuest1"
        QuestData.LevelRequired = 1
        QuestData.MobName = "Bandit"
    elseif MyLevel >= 10 and MyLevel <= 14 then
        QuestData.QuestGiver = "BanditQuest2"
        QuestData.QuestName = "BanditQuest2"
        QuestData.LevelRequired = 10
        QuestData.MobName = "Monkey"
    -- Adicione mais quests conforme necessário
    else
        QuestData.QuestGiver = "BanditQuest1"
        QuestData.QuestName = "BanditQuest1"
        QuestData.LevelRequired = 1
        QuestData.MobName = "Bandit"
    end
    
    return QuestData
end

local function HasQuest()
    local player = LocalPlayer
    if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("Main") then
        local questUI = player.PlayerGui.Main:FindFirstChild("Quest")
        if questUI and questUI.Visible then
            return true
        end
    end
    return false
end

local function GetQuest()
    local questInfo = GetQuestInfo()
    local questGiver = game:GetService("Workspace").NPCs:FindFirstChild(questInfo.QuestGiver)
    
    if questGiver and questGiver:FindFirstChild("HumanoidRootPart") then
        TeleportTo(questGiver.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
        wait(0.5)
        
        -- Clica no NPC para pegar a quest
        local Remote = ReplicatedStorage:FindFirstChild("Remotes")
        if Remote then
            Remote:FindFirstChild("CommF_"):InvokeServer("StartQuest", questInfo.QuestName, questInfo.LevelRequired)
        end
        
        wait(0.5)
    end
end

-- =========================
-- FAST ATTACK
-- =========================
local AttackConnection = nil

local function EnableFastAttack()
    if AttackConnection then return end
    
    AttackConnection = RunService.RenderStepped:Connect(function()
        if FarmSettings.FastAttackEnabled then
            local combat = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_")
            if combat then
                pcall(function()
                    combat:InvokeServer("weaponMasteryDealer", {["tool"] = LocalPlayer.Character:FindFirstChildOfClass("Tool")})
                end)
            end
        end
    end)
end

local function DisableFastAttack()
    if AttackConnection then
        AttackConnection:Disconnect()
        AttackConnection = nil
    end
end

-- =========================
-- AUTO FARM LEVEL
-- =========================
local FarmLevelConnection = nil

local function StartAutoFarmLevel()
    if FarmLevelConnection then return end
    
    FarmSettings.FastAttackEnabled = true
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
            end
            
            -- Procura o mob da quest
            local questInfo = GetQuestInfo()
            local mob = nil
            
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == questInfo.MobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    mob = v
                    break
                end
            end
            
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                -- Teleporta pro mob
                TeleportTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                
                -- Ativa ataque
                char.Humanoid:ChangeState(11) -- Remove fall damage
                
                -- Equipa arma
                local tool = char:FindFirstChildOfClass("Tool")
                if not tool then
                    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and (v.ToolTip == "Sword" or v.ToolTip == "Melee") then
                            LocalPlayer.Character.Humanoid:EquipTool(v)
                            break
                        end
                    end
                end
            else
                -- Se não achar o mob, pega nova quest
                GetQuest()
            end
        end)
    end)
end

local function StopAutoFarmLevel()
    if FarmLevelConnection then
        FarmLevelConnection:Disconnect()
        FarmLevelConnection = nil
    end
    FarmSettings.FastAttackEnabled = false
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
                if v.Name:find("Chest") and v:FindFirstChild("Part") then
                    TeleportTo(v.Part.CFrame)
                    wait(0.3)
                    
                    -- Tenta abrir o baú
                    if (LocalPlayer.Character.HumanoidRootPart.Position - v.Part.Position).Magnitude < 10 then
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
-- FUNÇÃO TWEEN (GUI base mantida igual)
-- =========================

-- =========================
-- GUI BASE
-- =========================
local Gui = Instance.new("ScreenGui")
Gui.Name = "LagTeckHub"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- BOLINHA FLUTUANTE
-- =========================
local Bubble = Instance.new("TextButton", Gui)
Bubble.Size = UDim2.fromOffset(55,55)
Bubble.Position = UDim2.fromScale(0.05,0.5)
Bubble.Text = "LT"
Bubble.TextColor3 = Color3.new(1,1,1)
Bubble.BackgroundColor3 = HubConfig.Tema.Botao
Bubble.BorderSizePixel = 0
Bubble.Active = true
Bubble.Draggable = true
Bubble.Font = Enum.Font.GothamBold
Bubble.TextSize = 16

Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)

-- =========================
-- JANELA PRINCIPAL
-- =========================
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromScale(0.48,0.6)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = HubConfig.Tema.Fundo
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- =========================
-- TOPO
-- =========================
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundColor3 = HubConfig.Tema.Secundario
Top.BorderSizePixel = 0

Instance.new("UICorner", Top).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-20,1,0)
Title.Position = UDim2.fromOffset(10,0)
Title.Text = "LagTeck Hub v1.0"
Title.TextColor3 = HubConfig.Tema.Texto
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

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
Search.PlaceholderText = "Pesquisar opções..."
Search.Text = ""
Search.BackgroundColor3 = HubConfig.Tema.Botao
Search.TextColor3 = HubConfig.Tema.Texto
Search.BorderSizePixel = 0
Search.Font = Enum.Font.Gotham
Search.TextSize = 14

Instance.new("UICorner", Search).CornerRadius = UDim.new(0,10)

-- =========================
-- BARRA DE ABAS
-- =========================
local TabBar = Instance.new("Frame", Body)
TabBar.Position = UDim2.fromOffset(10,45)
TabBar.Size = UDim2.new(0,120,1,-55)
TabBar.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.Padding = UDim.new(0,6)

-- =========================
-- CONTEÚDO
-- =========================
local Content = Instance.new("Frame", Body)
Content.Position = UDim2.fromOffset(140,45)
Content.Size = UDim2.new(1,-150,1,-55)
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
    Btn.Size = UDim2.new(1,0,0,36)
    Btn.Text = nome
    Btn.BackgroundColor3 = HubConfig.Tema.Botao
    Btn.TextColor3 = HubConfig.Tema.Texto
    Btn.BorderSizePixel = 0
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

    local Frame = Instance.new("ScrollingFrame", Content)
    Frame.Size = UDim2.fromScale(1,1)
    Frame.CanvasSize = UDim2.fromScale(0,0)
    Frame.ScrollBarImageTransparency = 1
    Frame.Visible = false
    Frame.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", Frame)
    Layout.Padding = UDim.new(0,8)
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Frame.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 10)
    end)

    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Tabs) do
            v.Visible = false
        end
        Frame.Visible = true
        CurrentTab = Frame
    end)

    Tabs[nome] = Frame
end

-- =========================
-- CRIANDO ABAS
-- =========================
CriarAba("🌴 Fazenda")
CriarAba("⚔️ Combate")
CriarAba("🍏 Frutas")
CriarAba("🧭 Teleport")
CriarAba("👁️ Visual / ESP")
CriarAba("🛡️ Jogador")
CriarAba("🧠 Sistema")

Tabs["🌴 Fazenda"].Visible = true
CurrentTab = Tabs["🌴 Fazenda"]

-- =========================
-- COMPONENTES
-- =========================
local function Toggle(parent, texto, callback)
    local Box = Instance.new("Frame", parent)
    Box.Size = UDim2.new(1,0,0,40)
    Box.BackgroundColor3 = HubConfig.Tema.Botao
    Box.BorderSizePixel = 0
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0,8)

    local Label = Instance.new("TextLabel", Box)
    Label.Size = UDim2.new(1,-60,1,0)
    Label.Position = UDim2.fromOffset(10,0)
    Label.Text = texto
    Label.BackgroundTransparency = 1
    Label.TextColor3 = HubConfig.Tema.Texto
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Btn = Instance.new("TextButton", Box)
    Btn.Size = UDim2.fromOffset(36,18)
    Btn.Position = UDim2.new(1,-50,0.5,-9)
    Btn.BackgroundColor3 = Color3.fromRGB(120,120,120)
    Btn.Text = ""
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)
    
    local Circle = Instance.new("Frame", Btn)
    Circle.Size = UDim2.fromOffset(14,14)
    Circle.Position = UDim2.fromOffset(2,2)
    Circle.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)
    
    local enabled = false
    
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        if enabled then
            Tween(Circle, 0.2, {Position = UDim2.fromOffset(20,2)})
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

-- =========================
-- FARM COM CALLBACKS
-- =========================
Toggle(Tabs["🌴 Fazenda"], "Auto Farm Level", function(enabled)
    FarmSettings.AutoFarmLevel = enabled
    if enabled then
        StartAutoFarmLevel()
        print("✅ Auto Farm Level ATIVADO")
    else
        StopAutoFarmLevel()
        print("❌ Auto Farm Level DESATIVADO")
    end
end)

Toggle(Tabs["🌴 Fazenda"], "Auto Farm Quest", function(enabled)
    FarmSettings.AutoFarmQuest = enabled
    print(enabled and "✅ Auto Quest ON" or "❌ Auto Quest OFF")
end)

Toggle(Tabs["🌴 Fazenda"], "Auto Farm Boss", function(enabled)
    FarmSettings.AutoFarmBoss = enabled
    print(enabled and "✅ Auto Boss ON" or "❌ Auto Boss OFF")
end)

Toggle(Tabs["🌴 Fazenda"], "Auto Chest", function(enabled)
    FarmSettings.AutoChest = enabled
    if enabled then
        StartAutoChest()
        print("✅ Auto Chest ATIVADO")
    else
        StopAutoChest()
        print("❌ Auto Chest DESATIVADO")
    end
end)

Toggle(Tabs["🌴 Fazenda"], "Auto Sea Event", function(enabled)
    FarmSettings.AutoSeaEvent = enabled
    print(enabled and "✅ Sea Events ON" or "❌ Sea Events OFF")
end)

-- =========================
-- COMBATE
-- =========================
Toggle(Tabs["⚔️ Combate"], "Auto Attack", function(enabled)
    print(enabled and "✅ Auto Attack ON" or "❌ Auto Attack OFF")
end)

Toggle(Tabs["⚔️ Combate"], "Fast Attack", function(enabled)
    FarmSettings.FastAttackEnabled = enabled
    if enabled then
        EnableFastAttack()
    else
        DisableFastAttack()
    end
    print(enabled and "✅ Fast Attack ON" or "❌ Fast Attack OFF")
end)

Toggle(Tabs["⚔️ Combate"], "Kill Aura", function(enabled)
    print(enabled and "✅ Kill Aura ON" or "❌ Kill Aura OFF")
end)

Toggle(Tabs["⚔️ Combate"], "Auto Haki", function(enabled)
    print(enabled and "✅ Auto Haki ON" or "❌ Auto Haki OFF")
end)

-- Adicione os outros toggles sem função por enquanto...

-- =========================
-- ABRIR/FECHAR
-- =========================
Bubble.MouseButton1Click:Connect(function()
    HubConfig.Aberto = not HubConfig.Aberto
    Main.Visible = HubConfig.Aberto
end)

print("🚀 LagTeck Hub carregado!")
