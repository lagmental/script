--[[====================================================
    LagTeck Hub - Skeleton UI
    Apenas interface (SEM funções de farm/exploit)
    Mobile + PC | Português | Open Source
====================================================]]--

-- =========================
-- SERVIÇOS
-- =========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
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
-- FUNÇÃO TWEEN
-- =========================
local function Tween(obj, time, props)
    TweenService:Create(
        obj,
        TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    ):Play()
end

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
Title.Text = "LagTeck Hub"
Title.TextColor3 = HubConfig.Tema.Texto
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Left

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
CriarAba("🌴 Farm")
CriarAba("⚔️ Combat")
CriarAba("🍏 Fruits")
CriarAba("🧭 Teleport")
CriarAba("👁️ Visual / ESP")
CriarAba("🛡️ Player")
CriarAba("🧠 System")

Tabs["🌴 Farm"].Visible = true
CurrentTab = Tabs["🌴 Farm"]

-- =========================
-- COMPONENTES
-- =========================
local function Toggle(parent, texto)
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
    Label.TextXAlignment = Left

    local Btn = Instance.new("Frame", Box)
    Btn.Size = UDim2.fromOffset(36,18)
    Btn.Position = UDim2.new(1,-50,0.5,-9)
    Btn.BackgroundColor3 = Color3.fromRGB(120,120,120)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)

    -- CALLBACK VAZIO
    -- Aqui entra a função no futuro
end

-- =========================
-- FARM (SÓ VISUAL)
-- =========================
Toggle(Tabs["🌴 Farm"], "Auto Farm Level")
Toggle(Tabs["🌴 Farm"], "Auto Farm Quest")
Toggle(Tabs["🌴 Farm"], "Auto Farm Boss")
Toggle(Tabs["🌴 Farm"], "Auto Chest")
Toggle(Tabs["🌴 Farm"], "Auto Eventos do Mar")

-- =========================
-- COMBAT
-- =========================
Toggle(Tabs["⚔️ Combat"], "Auto Attack")
Toggle(Tabs["⚔️ Combat"], "Fast Attack")
Toggle(Tabs["⚔️ Combat"], "Kill Aura")
Toggle(Tabs["⚔️ Combat"], "Auto Haki")

-- =========================
-- FRUITS
-- =========================
Toggle(Tabs["🍏 Fruits"], "ESP Fruit")
Toggle(Tabs["🍏 Fruits"], "Teleportar para Fruta")
Toggle(Tabs["🍏 Fruits"], "Auto Store Fruit")
Toggle(Tabs["🍏 Fruits"], "Fruit Sniper")

-- =========================
-- TELEPORT
-- =========================
Toggle(Tabs["🧭 Teleport"], "Teleportar Ilhas")
Toggle(Tabs["🧭 Teleport"], "Teleportar NPCs")
Toggle(Tabs["🧭 Teleport"], "Teleportar Boss")
Toggle(Tabs["🧭 Teleport"], "Server Hop")

-- =========================
-- VISUAL / ESP
-- =========================
Toggle(Tabs["👁️ Visual / ESP"], "ESP Players")
Toggle(Tabs["👁️ Visual / ESP"], "ESP Mobs")
Toggle(Tabs["👁️ Visual / ESP"], "Remover Neblina")
Toggle(Tabs["👁️ Visual / ESP"], "Full Bright")

-- =========================
-- PLAYER
-- =========================
Toggle(Tabs["🛡️ Player"], "Infinite Energy")
Toggle(Tabs["🛡️ Player"], "No Clip")
Toggle(Tabs["🛡️ Player"], "Fly")
Toggle(Tabs["🛡️ Player"], "Anti AFK")

-- =========================
-- SYSTEM
-- =========================
Toggle(Tabs["🧠 System"], "Salvar Configurações")
Toggle(Tabs["🧠 System"], "Auto Rejoin")
Toggle(Tabs["🧠 System"], "FPS Boost")
Toggle(Tabs["🧠 System"], "Modo Mobile Lite")

-- =========================
-- ABRIR / FECHAR HUB
-- =========================
Bubble.MouseButton1Click:Connect(function()
    HubConfig.Aberto = not HubConfig.Aberto
    Main.Visible = HubConfig.Aberto
end)
