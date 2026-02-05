--[[
═══════════════════════════════════════════════════════════════
    🌊 LAG TECK FUSION V4.0 - ULTIMATE EDITION 🌊
    VERSÃO COMPLETA E PROFISSIONAL - TODAS FUNCIONALIDADES
═══════════════════════════════════════════════════════════════
    Discord: discord.gg/RnZ6XHHFj7
    Criado por: Lag Teck Team
    Compatível: Delta X, Xeno, Solara, Wave, Fluxus
    
    ✅ FUNCIONALIDADES COMPLETAS:
    - Sistema de seleção de armas por categoria
    - Auto Farm Level + Mastery + Bosses
    - Sistema completo de Items e Materials
    - ESP para Players, Mobs, Bosses, NPCs, Fruits
    - Teleports para todas ilhas e locations
    - Sea Events (Leviathan, Terrorshark, etc)
    - Shop completo (Abilities, Fighting Styles, Swords)
    - Auto Stats inteligente
    - Server Hop otimizado
    - Sistema de Bug (NoClip, Anti-Água, Remove Fog)
    - Fast Attack otimizado
    - Bring Mobs melhorado
    - Auto Haki funcionando
    - E muito mais...
═══════════════════════════════════════════════════════════════
]]

print("🔵 Iniciando Lag Teck Fusion V4.0 - Ultimate Edition...")

-- ═══════════════════════════════════════════════════════════════
-- VERIFICAÇÃO DE JOGO E MUNDO
-- ═══════════════════════════════════════════════════════════════
repeat wait() until game:IsLoaded()
repeat wait() until game.Players
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")

_G.World1 = false
_G.World2 = false
_G.World3 = false

if game.PlaceId == 2753915549 then
    _G.World1 = true
    print("✅ First Sea Detectado!")
elseif game.PlaceId == 4442272183 then
    _G.World2 = true
    print("✅ Second Sea Detectado!")
elseif game.PlaceId == 7449423635 then
    _G.World3 = true
    print("✅ Third Sea Detectado!")
else
    game.Players.LocalPlayer:Kick("⚠️ Este script é apenas para Blox Fruits!")
    return
end

-- ═══════════════════════════════════════════════════════════════
-- SERVIÇOS DO ROBLOX
-- ═══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ═══════════════════════════════════════════════════════════════
-- PROTEÇÕES ANTI-KICK & ANTI-BAN AVANÇADAS
-- ═══════════════════════════════════════════════════════════════
print("🛡️ Ativando proteções avançadas...")

-- Anti-Kick Namecall Avançado
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__namecall = newcclosure(function(Self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" then
        if tostring(Self) == "RemoteEvent" then
            if args[1] == "true" or args[1] == "false" then
                return wait(9e9)
            end
        end
    elseif method == "Kick" then
        return wait(9e9)
    end
    
    return oldNamecall(Self, ...)
end)

mt.__index = newcclosure(function(Self, Key)
    if Key == "Disabled" and tostring(Self) == "Animate" then
        return false
    end
    return oldIndex(Self, Key)
end)

setreadonly(mt, true)

-- Anti-AFK Avançado
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Remover Scripts Anti-Cheat
task.spawn(function()
    while wait(3) do
        pcall(function()
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("LocalScript") then
                    if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" 
                        or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" 
                        or v.Name == "Looking" or v.Name == "Run" then
                        v:Destroy()
                    end
                end
            end
        end)
    end
end)

-- Auto Reconnect Melhorado
_G.AutoReconnect = true
game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') 
        and child.MessageArea:FindFirstChild("ErrorFrame") then
        if _G.AutoReconnect then
            repeat wait() until game:IsLoaded()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end
end)

print("✅ Proteções ativadas com sucesso!")

-- ═══════════════════════════════════════════════════════════════
-- VARIÁVEIS GLOBAIS E CONFIGURAÇÕES
-- ═══════════════════════════════════════════════════════════════
_G.Settings = {
    -- Armas
    SelectWeapon = "Combat",
    SelectWeaponGun = "",
    
    -- Auto Farm
    AutoFarmLevel = false,
    AutoFarmNearest = false,
    AutoFarmSelectMonster = false,
    SelectMonster = "",
    
    -- Combat
    FastAttack = true,
    FastAttackDelay = 0.1,
    AutoHaki = true,
    AutoEnhancement = true,
    
    -- Bring
    BringMonster = true,
    BringMode = 350,
    
    -- Position
    FarmDistance = 30,
    PosX = 0,
    PosY = 30,
    PosZ = 0,
    
    -- Mastery
    AutoFarmMastery = false,
    TargetMastery = 600,
    MasteryWeapon = "Combat",
    MasteryMode = "Quest",
    
    -- Bosses
    AutoBoss = false,
    SelectedBoss = "",
    AutoFarmAllBoss = false,
    
    -- Items
    FarmBone = false,
    FarmCake = false,
    FarmEctoplasm = false,
    FarmFishTail = false,
    FarmScales = false,
    FarmConjuredCocoa = false,
    
    -- Materials
    FarmMaterials = false,
    SelectedMaterial = "",
    
    -- ESP
    ESPPlayer = false,
    ESPMob = false,
    ESPBoss = false,
    ESPFruit = false,
    ESPNPC = false,
    ESPChest = false,
    
    -- Sea Events
    AutoSeabeast = false,
    AutoTerrorshark = false,
    AutoPiranha = false,
    AutoShip = false,
    
    -- Stats
    AutoStats = false,
    PointMelee = 0,
    PointDefense = 0,
    PointSword = 0,
    PointGun = 0,
    PointFruit = 0,
    
    -- Misc
    AutoRejoin = true,
    WhiteScreen = false,
    RemoveFog = false,
    RemoveDamage = false,
    InfiniteEnergy = false,
    
    -- Bug System
    NoClip = false,
    AntiWater = false,
    AntiDrown = false,
    WalkOnWater = false,
    
    -- Server Hop
    ServerHopWhenBossDead = false,
    ServerHopWhenFullMoon = false,
}

-- Variáveis de controle
_G.StopTween = false
_G.StartMagnet = false
_G.PosMon = nil
_G.Tween = nil

-- ═══════════════════════════════════════════════════════════════
-- CARREGAR BIBLIOTECA UI (FLUENT)
-- ═══════════════════════════════════════════════════════════════
print("🎨 Carregando Interface Fluent UI...")

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🌊 Lag Teck Fusion V4.0 - Ultimate Edition",
    SubTitle = "discord.gg/RnZ6XHHFj7",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 480),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- ═══════════════════════════════════════════════════════════════
-- CRIAÇÃO DE TABS
-- ═══════════════════════════════════════════════════════════════
local Tabs = {
    Home = Window:AddTab({ Title = "🏠 Home", Icon = "home" }),
    Farm = Window:AddTab({ Title = "⚔️ Auto Farm", Icon = "sword" }),
    Mastery = Window:AddTab({ Title = "🎯 Mastery", Icon = "target" }),
    Boss = Window:AddTab({ Title = "👹 Bosses", Icon = "skull" }),
    Items = Window:AddTab({ Title = "💎 Items", Icon = "package" }),
    Materials = Window:AddTab({ Title = "⚒️ Materials", Icon = "box" }),
    Combat = Window:AddTab({ Title = "⚡ Combat", Icon = "zap" }),
    ESP = Window:AddTab({ Title = "👁️ ESP & Visual", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "🌍 Teleports", Icon = "map" }),
    SeaEvent = Window:AddTab({ Title = "🌊 Sea Events", Icon = "anchor" }),
    Shop = Window:AddTab({ Title = "🛒 Shop", Icon = "shopping-cart" }),
    Stats = Window:AddTab({ Title = "📊 Stats", Icon = "bar-chart" }),
    Misc = Window:AddTab({ Title = "🔧 Misc", Icon = "settings" }),
    Bug = Window:AddTab({ Title = "🐛 Bug System", Icon = "bug" }),
}

-- ═══════════════════════════════════════════════════════════════
-- TAB: HOME
-- ═══════════════════════════════════════════════════════════════
Tabs.Home:AddParagraph({
    Title = "🌊 Bem-vindo ao Lag Teck Fusion V4.0!",
    Content = "Script Ultimate Edition Profissional para Blox Fruits\n\n✅ Todas funcionalidades 100% operacionais\n✅ Sistema de armas inteligente\n✅ Auto Farm otimizado com Quest System\n✅ Fast Attack sem delay\n✅ Bring Mobs melhorado\n✅ ESP completo\n✅ Anti-Água e Bug System\n✅ Server Hop inteligente\n\n🎮 Compatível: Delta X, Xeno, Solara, Wave\n💬 Discord: discord.gg/RnZ6XHHFj7"
})

-- Status do Jogador
local StatusSection = Tabs.Home:AddSection("📊 Status do Jogador")

local StatusLabels = {
    Level = Tabs.Home:AddParagraph({Title = "⭐ Level", Content = "Carregando..."}),
    Race = Tabs.Home:AddParagraph({Title = "🧬 Raça", Content = "Carregando..."}),
    Beli = Tabs.Home:AddParagraph({Title = "💰 Beli", Content = "Carregando..."}),
    Fragments = Tabs.Home:AddParagraph({Title = "💎 Fragmentos", Content = "Carregando..."}),
    Fruit = Tabs.Home:AddParagraph({Title = "😈 Fruta", Content = "Carregando..."}),
    World = Tabs.Home:AddParagraph({Title = "🌍 Mundo", Content = "Carregando..."}),
}

-- Atualizar Status em tempo real
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            local plr = LocalPlayer
            StatusLabels.Level:SetDesc("⭐ Level " .. tostring(plr.Data.Level.Value))
            StatusLabels.Race:SetDesc("🧬 " .. tostring(plr.Data.Race.Value))
            
            local beli = plr.Data.Beli.Value
            StatusLabels.Beli:SetDesc("💰 " .. string.format("%s B$", tostring(beli):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
            
            local frags = plr.Data.Fragments.Value
            StatusLabels.Fragments:SetDesc("💎 " .. string.format("%s", tostring(frags):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
            
            if plr.Character:FindFirstChild(plr.Data.DevilFruit.Value) then
                StatusLabels.Fruit:SetDesc("😈 " .. plr.Data.DevilFruit.Value)
            else
                StatusLabels.Fruit:SetDesc("❌ Nenhuma")
            end
            
            local worldText = _G.World1 and "🌊 First Sea" or _G.World2 and "🌴 Second Sea" or "🏝️ Third Sea"
            StatusLabels.World:SetDesc(worldText)
        end)
    end
end)

-- Informações do Servidor
Tabs.Home:AddSection("🖥️ Informações do Servidor")

local ServerInfo = Tabs.Home:AddParagraph({
    Title = "📡 Servidor Atual",
    Content = "Carregando informações..."
})

task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local JobId = game.JobId
            local PlayerCount = #Players:GetPlayers()
            local MaxPlayers = Players.MaxPlayers
            local Ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            
            ServerInfo:SetDesc(string.format(
                "👥 Jogadores: %d/%d\n📶 Ping: %d ms\n🆔 Job ID: %s",
                PlayerCount, MaxPlayers, Ping, JobId:sub(1, 8) .. "..."
            ))
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÕES ESSENCIAIS
-- ═══════════════════════════════════════════════════════════════

-- Função para obter armas por categoria MELHORADA
function GetWeaponsByCategory()
    local Weapons = {
        Espada = {},
        Luta = {},
        Fruta = {},
        Arma = {}
    }
    
    -- Verificar no Backpack
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if not table.find(Weapons.Espada, v.Name) then
                    table.insert(Weapons.Espada, v.Name)
                end
            elseif v.ToolTip == "Melee" then
                if not table.find(Weapons.Luta, v.Name) then
                    table.insert(Weapons.Luta, v.Name)
                end
            elseif v.ToolTip == "Blox Fruit" then
                if not table.find(Weapons.Fruta, v.Name) then
                    table.insert(Weapons.Fruta, v.Name)
                end
            elseif v.ToolTip == "Gun" then
                if not table.find(Weapons.Arma, v.Name) then
                    table.insert(Weapons.Arma, v.Name)
                end
            end
        end
    end
    
    -- Verificar no Character
    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if not table.find(Weapons.Espada, v.Name) then
                    table.insert(Weapons.Espada, v.Name)
                end
            elseif v.ToolTip == "Melee" then
                if not table.find(Weapons.Luta, v.Name) then
                    table.insert(Weapons.Luta, v.Name)
                end
            elseif v.ToolTip == "Blox Fruit" then
                if not table.find(Weapons.Fruta, v.Name) then
                    table.insert(Weapons.Fruta, v.Name)
                end
            elseif v.ToolTip == "Gun" then
                if not table.find(Weapons.Arma, v.Name) then
                    table.insert(Weapons.Arma, v.Name)
                end
            end
        end
    end
    
    -- Adicionar "Combat" como padrão se não houver armas de luta
    if #Weapons.Luta == 0 then
        table.insert(Weapons.Luta, "Combat")
    end
    
    return Weapons
end

-- Sistema de Quest Completo
Mon = ""
LevelQuest = 0
NameQuest = ""
NameMon = ""
CFrameQuest = CFrame.new(0, 0, 0)
CFrameMon = CFrame.new(0, 0, 0)

function CheckQuest()
    local MyLevel = LocalPlayer.Data.Level.Value
    
    if _G.World1 then
        if MyLevel >= 1 and MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
            CFrameMon = CFrame.new(1045.96265, 27.00251, 1560.82031)
        elseif MyLevel >= 10 and MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1448.51807, 67.85301, 11.4657965)
        elseif MyLevel >= 15 and MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            CFrameMon = CFrame.new(-1129.88367, 40.4635468, -525.423706)
        elseif MyLevel >= 30 and MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel >= 40 and MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel >= 60 and MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel >= 75 and MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel >= 90 and MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel >= 100 and MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel >= 120 and MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif MyLevel >= 150 and MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel >= 175 and MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel >= 190 and MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel >= 210 and MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel >= 250 and MyLevel <= 274 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel >= 275 and MyLevel <= 299 then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif MyLevel >= 300 and MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel >= 325 and MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel >= 375 and MyLevel <= 399 then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
        elseif MyLevel >= 400 and MyLevel <= 449 then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
        elseif MyLevel >= 450 and MyLevel <= 474 then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
        elseif MyLevel >= 475 and MyLevel <= 524 then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
        elseif MyLevel >= 525 and MyLevel <= 549 then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel >= 550 and MyLevel <= 624 then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel >= 625 and MyLevel <= 649 then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif _G.World2 then
        if MyLevel >= 700 and MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel >= 725 and MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel >= 775 and MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel >= 800 and MyLevel <= 874 then
            Mon = "Factory Staff"
            LevelQuest = 2
            NameQuest = "Area2Quest"
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
            CFrameMon = CFrame.new(295.8662109375, 73.28115844726562, -56.58790588378906)
        elseif MyLevel >= 875 and MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel >= 900 and MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif MyLevel >= 950 and MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel >= 975 and MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel >= 1000 and MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel >= 1050 and MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel >= 1100 and MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif MyLevel >= 1125 and MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif MyLevel >= 1175 and MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif MyLevel >= 1200 and MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
        elseif MyLevel >= 1250 and MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
        elseif MyLevel >= 1275 and MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
        elseif MyLevel >= 1300 and MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
        elseif MyLevel >= 1325 and MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
        elseif MyLevel >= 1350 and MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
        elseif MyLevel >= 1375 and MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel >= 1425 and MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
        end
    elseif _G.World3 then
        if MyLevel >= 1500 and MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel >= 1525 and MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
            CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
        elseif MyLevel >= 1575 and MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "AmazonQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
            CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
        elseif MyLevel >= 1600 and MyLevel <= 1624 then
            Mon = "Dragon Crew Archer"
            LevelQuest = 2
            NameQuest = "AmazonQuest"
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
            CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
        elseif MyLevel >= 1625 and MyLevel <= 1649 then
            Mon = "Female Islander"
            LevelQuest = 1
            NameQuest = "AmazonQuest2"
            NameMon = "Female Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.62474, 751.130676)
            CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312)
        elseif MyLevel >= 1650 and MyLevel <= 1699 then
            Mon = "Giant Islander"
            LevelQuest = 2
            NameQuest = "AmazonQuest2"
            NameMon = "Giant Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.62474, 751.130676)
            CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
        elseif MyLevel >= 1700 and MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel >= 1725 and MyLevel <= 1774 then
            Mon = "Marine Rear Admiral"
            LevelQuest = 2
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Rear Admiral"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel >= 1775 and MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel >= 1800 and MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
        elseif MyLevel >= 1825 and MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel >= 1850 and MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
            CFrameMon = CFrame.new(-13508.616210937500, 582.46228027343750, -6985.3037109375)
        elseif MyLevel >= 1900 and MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel >= 1925 and MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel >= 1975 and MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel >= 2000 and MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5971.173828125)
        elseif MyLevel >= 2025 and MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9712.03125, 204.69589233398438, 6193.322265625)
        elseif MyLevel >= 2050 and MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
            CFrameMon = CFrame.new(-9545.7763671875, 69.619895935058594, 6339.5615234375)
        elseif MyLevel >= 2075 and MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif MyLevel >= 2100 and MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel >= 2125 and MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel >= 2150 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        end
    end
end

-- Auto Haki MELHORADO
function AutoHaki()
    if not LocalPlayer.Character:FindFirstChild("HasBuso") then
        local success, result = pcall(function()
            return ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end)
    end
end

-- Equipar Arma MELHORADO
function EquipWeapon(ToolName)
    if ToolName == "" or ToolName == nil then return end
    
    pcall(function()
        -- Verificar se já está equipada
        if LocalPlayer.Character:FindFirstChild(ToolName) then
            return
        end
        
        -- Equipar do Backpack
        if LocalPlayer.Backpack:FindFirstChild(ToolName) then
            local Tool = LocalPlayer.Backpack:FindFirstChild(ToolName)
            wait(0.1)
            LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end)
end

-- Sistema de Tween OTIMIZADO E CORRIGIDO
function topos(Pos)
    if not Pos then return end
    
    pcall(function()
        _G.StopTween = false
        
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local Distance = (Pos.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        local Speed
        
        -- Velocidade adaptativa baseada na distância
        if Distance < 250 then
            Speed = 5000
        elseif Distance < 500 then
            Speed = 350
        elseif Distance < 1000 then
            Speed = 300
        elseif Distance < 2500 then
            Speed = 250
        else
            Speed = 200
        end
        
        -- Cancelar tween anterior
        if _G.Tween then
            _G.Tween:Cancel()
        end
        
        -- Criar novo tween
        _G.Tween = TweenService:Create(
            LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        )
        
        _G.Tween:Play()
        
        _G.Tween.Completed:Connect(function()
            _G.StopTween = true
        end)
    end)
end

-- Função para parar Tween
function StopTween()
    _G.StopTween = true
    if _G.Tween then
        _G.Tween:Cancel()
    end
end

-- ═══════════════════════════════════════════════════════════════
-- TAB: AUTO FARM
-- ═══════════════════════════════════════════════════════════════

Tabs.Farm:AddSection("🎯 Seleção de Arma")

local WeaponCategories = GetWeaponsByCategory()
local CurrentCategory = "Luta"

-- Dropdown de Categoria
local CategoryDropdown = Tabs.Farm:AddDropdown("CategoryDropdown", {
    Title = "📂 Categoria de Arma",
    Values = {"Espada", "Luta", "Fruta", "Arma"},
    Default = "Luta",
    Callback = function(Value)
        CurrentCategory = Value
        
        -- Atualizar lista de armas
        local weapons = WeaponCategories[Value]
        if #weapons > 0 then
            WeaponDropdown:SetValues(weapons)
            WeaponDropdown:SetValue(weapons[1])
            _G.Settings.SelectWeapon = weapons[1]
        else
            Fluent:Notify({
                Title = "⚠️ Aviso",
                Content = "Você não possui armas nesta categoria!",
                Duration = 3
            })
        end
    end
})

-- Dropdown de Arma
local WeaponDropdown = Tabs.Farm:AddDropdown("WeaponDropdown", {
    Title = "⚔️ Selecionar Arma",
    Values = WeaponCategories["Luta"],
    Default = "Combat",
    Callback = function(Value)
        _G.Settings.SelectWeapon = Value
    end
})

Tabs.Farm:AddButton({
    Title = "🔄 Atualizar Lista de Armas",
    Description = "Recarrega todas as armas do inventário",
    Callback = function()
        WeaponCategories = GetWeaponsByCategory()
        local weapons = WeaponCategories[CurrentCategory]
        if #weapons > 0 then
            WeaponDropdown:SetValues(weapons)
            Fluent:Notify({
                Title = "✅ Atualizado!",
                Content = "Lista de armas atualizada!",
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "⚠️ Aviso",
                Content = "Nenhuma arma nesta categoria!",
                Duration = 3
            })
        end
    end
})

-- Auto Farm Principal
Tabs.Farm:AddSection("⚔️ Sistema de Auto Farm")

local AutoFarmLevelToggle = Tabs.Farm:AddToggle("AutoFarmLevel", {
    Title = "🔥 Auto Farm Level (Com Quest)",
    Description = "Farma automaticamente com sistema de quest",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoFarmLevel = Value
        if not Value then
            StopTween()
        end
    end
})

local AutoFarmNearestToggle = Tabs.Farm:AddToggle("AutoFarmNearest", {
    Title = "📍 Auto Farm Mob Mais Próximo",
    Description = "Farma o mob mais próximo sem quest",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoFarmNearest = Value
        if not Value then
            StopTween()
        end
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: MASTERY
-- ═══════════════════════════════════════════════════════════════

Tabs.Mastery:AddSection("🎯 Farm de Mastery")

-- Função para verificar Mastery
function GetWeaponMastery(WeaponName)
    local success, result = pcall(function()
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("WeaponMastery", WeaponName)
    end)
    if success then
        return result or 0
    end
    return 0
end

-- Seleção de Arma para Mastery
local MasteryWeaponDropdown = Tabs.Mastery:AddDropdown("MasteryWeapon", {
    Title = "⚔️ Selecionar Arma para Mastery",
    Values = GetWeaponsByCategory()["Luta"],
    Default = "Combat",
    Callback = function(Value)
        _G.Settings.MasteryWeapon = Value
    end
})

-- Slider de Target Mastery
local MasteryTargetSlider = Tabs.Mastery:AddSlider("MasteryTarget", {
    Title = "🎯 Mastery Alvo",
    Description = "Define o objetivo de mastery",
    Min = 100,
    Max = 600,
    Default = 600,
    Rounding = 50,
    Callback = function(Value)
        _G.Settings.TargetMastery = Value
    end
})

-- Toggle Auto Farm Mastery
local AutoMasteryToggle = Tabs.Mastery:AddToggle("AutoMastery", {
    Title = "🎯 Auto Farm Mastery",
    Description = "Farma até atingir o mastery desejado",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoFarmMastery = Value
        if not Value then
            StopTween()
        end
    end
})

-- Modo de Farm Mastery
local MasteryModeDropdown = Tabs.Mastery:AddDropdown("MasteryMode", {
    Title = "📋 Modo de Farm",
    Values = {"Quest", "Nearest"},
    Default = "Quest",
    Callback = function(Value)
        _G.Settings.MasteryMode = Value
    end
})

-- Botão para atualizar armas de Mastery
Tabs.Mastery:AddButton({
    Title = "🔄 Atualizar Armas",
    Description = "Recarrega lista de armas",
    Callback = function()
        local allWeapons = {}
        for category, weapons in pairs(GetWeaponsByCategory()) do
            for _, weapon in ipairs(weapons) do
                table.insert(allWeapons, weapon)
            end
        end
        MasteryWeaponDropdown:SetValues(allWeapons)
        Fluent:Notify({
            Title = "✅ Sucesso",
            Content = "Lista de armas atualizada!",
            Duration = 3
        })
    end
})

-- Mostrar Mastery Atual
local CurrentMasteryLabel = Tabs.Mastery:AddParagraph({
    Title = "📊 Mastery Atual",
    Content = "Selecione uma arma para ver o mastery"
})

task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if _G.Settings.MasteryWeapon and _G.Settings.MasteryWeapon ~= "" then
                local currentMastery = GetWeaponMastery(_G.Settings.MasteryWeapon)
                local progress = math.floor((currentMastery / _G.Settings.TargetMastery) * 100)
                CurrentMasteryLabel:SetDesc(string.format(
                    "⭐ %d / %d (%d%%)",
                    currentMastery,
                    _G.Settings.TargetMastery,
                    progress
                ))
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- TAB: BOSSES
-- ═══════════════════════════════════════════════════════════════

-- Lista de Bosses por World
local BossList = {}

if _G.World1 then
    BossList = {
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
        "Cyborg"
    }
elseif _G.World2 then
    BossList = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    }
elseif _G.World3 then
    BossList = {
        "Stone",
        "Island Empress",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen",
        "Dough King"
    }
end

-- Função para encontrar Boss
function FindBoss(bossName)
    -- Procurar em Enemies
    for i, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == bossName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            return v
        end
    end
    
    -- Procurar em ReplicatedStorage
    for i, v in pairs(ReplicatedStorage:GetChildren()) do
        if v.Name == bossName then
            return v
        end
    end
    
    return nil
end

-- Função para pegar Boss Positions
function GetBossPosition(bossName)
    local BossPositions = {
        -- World 1
        ["The Gorilla King"] = CFrame.new(-1129.88367, 40.4635468, -525.423706),
        ["Bobby"] = CFrame.new(-1147.46289, 13.2039595, 4086.11572),
        ["Yeti"] = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625),
        ["Mob Leader"] = CFrame.new(-2844.7307, 7.4180684, 5356.6353),
        ["Vice Admiral"] = CFrame.new(-5020.49219, 28.6520386, 4324.50293),
        ["Warden"] = CFrame.new(5278.04932, 2.89587474, 747.071533),
        ["Chief Warden"] = CFrame.new(5206.92578, 0.836054921, 814.520691),
        ["Swan"] = CFrame.new(5348.92773, 604.870605, 199.059906),
        ["Magma Admiral"] = CFrame.new(-5530.12207, 22.8769703, 8449.96582),
        ["Fishman Lord"] = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734),
        ["Wysper"] = CFrame.new(-7925.48389, 5550.76074, -636.178345),
        ["Thunder God"] = CFrame.new(-7749.69043, 5607.58984, -2305.42456),
        ["Cyborg"] = CFrame.new(6041.82617, 52.7112198, -1374.26489),
        
        -- World 2
        ["Diamond"] = CFrame.new(-1576.7003173828, 198.59265136719, -3.0251293182373),
        ["Jeremy"] = CFrame.new(2194.47217, 448.931641, 853.302002),
        ["Fajita"] = CFrame.new(-2085.27295, 73.0055847, -4208.41602),
        ["Don Swan"] = CFrame.new(2288.802, 15.1870775, 863.034607),
        ["Smoke Admiral"] = CFrame.new(-5115.72754, 23.7664986, -5338.2207),
        ["Cursed Captain"] = CFrame.new(916.928589, 181.092773, 33422),
        ["Darkbeard"] = CFrame.new(3677.08203, 62.751937866211, -3144.8332519531),
        ["Order"] = CFrame.new(-6217.2021484375, 52.187705993652344, -4864.451171875),
        ["Awakened Ice Admiral"] = CFrame.new(6407.33936, 340.223785, -6892.521),
        ["Tide Keeper"] = CFrame.new(-3570.18652, 123.328949, -11555.9072),
        
        -- World 3
        ["Stone"] = CFrame.new(-1049.25, 40.0495033, -4748.47266),
        ["Island Empress"] = CFrame.new(5713.98877, 601.922974, 202.751251),
        ["Kilo Admiral"] = CFrame.new(2889.35986, 423.503174, -7230.17529),
        ["Captain Elephant"] = CFrame.new(-13485.0283, 331.709259, -8012.4873),
        ["Beautiful Pirate"] = CFrame.new(5283.609375, 22.56223487854, -11.817522048950195),
        ["rip_indra True Form"] = CFrame.new(-5415.42383, 313.9888, -2823.41479),
        ["Longma"] = CFrame.new(-10238.875, 389.7912902832, -9549.7939453125),
        ["Soul Reaper"] = CFrame.new(-9515.62109, 315.925537, 6691.12012),
        ["Cake Queen"] = CFrame.new(-821.66284179688, 64.520835876465, -12319.46484375),
        ["Dough King"] = CFrame.new(-2151.82153, 149.315704, -12404.9053)
    }
    
    return BossPositions[bossName] or CFrame.new(0, 50, 0)
end

Tabs.Boss:AddSection("👹 Farm de Bosses")

-- Seleção de Boss
local BossDropdown = Tabs.Boss:AddDropdown("BossSelect", {
    Title = "👹 Selecionar Boss",
    Values = BossList,
    Default = BossList[1] or "",
    Callback = function(Value)
        _G.Settings.SelectedBoss = Value
    end
})

-- Toggle Auto Farm Boss
local AutoBossToggle = Tabs.Boss:AddToggle("AutoBoss", {
    Title = "👹 Auto Farm Boss Selecionado",
    Description = "Farma o boss selecionado",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoBoss = Value
        if not Value then
            StopTween()
        end
    end
})

-- Toggle Farm All Bosses
local AutoAllBossToggle = Tabs.Boss:AddToggle("AutoAllBoss", {
    Title = "🔥 Auto Farm Todos os Bosses",
    Description = "Farma todos os bosses do mundo atual",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoFarmAllBoss = Value
        if not Value then
            StopTween()
        end
    end
})

-- Status de Bosses
Tabs.Boss:AddSection("📊 Status de Bosses")

local BossStatus = Tabs.Boss:AddParagraph({
    Title = "🎯 Bosses Vivos",
    Content = "Verificando..."
})

task.spawn(function()
    while task.wait(3) do
        pcall(function()
            local aliveBosses = {}
            for _, bossName in pairs(BossList) do
                if FindBoss(bossName) then
                    table.insert(aliveBosses, bossName)
                end
            end
            
            if #aliveBosses > 0 then
                BossStatus:SetDesc("✅ " .. table.concat(aliveBosses, "\n✅ "))
            else
                BossStatus:SetDesc("❌ Nenhum boss vivo no momento")
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- TAB: ITEMS
-- ═══════════════════════════════════════════════════════════════

Tabs.Items:AddSection("💎 Farm de Items Raros")

-- Auto Farm Bone
local AutoBoneToggle = Tabs.Items:AddToggle("AutoBone", {
    Title = "🦴 Auto Farm Bone",
    Description = "Farma ossos em Haunted Castle",
    Default = false,
    Callback = function(Value)
        _G.Settings.FarmBone = Value
        if not Value then
            StopTween()
        end
    end
})

-- Auto Farm Ectoplasm
local AutoEctoToggle = Tabs.Items:AddToggle("AutoEcto", {
    Title = "👻 Auto Farm Ectoplasm",
    Description = "Farma ectoplasma nos ships",
    Default = false,
    Callback = function(Value)
        _G.Settings.FarmEctoplasm = Value
        if not Value then
            StopTween()
        end
    end
})

-- Auto Farm Fish Tail
local AutoFishTailToggle = Tabs.Items:AddToggle("AutoFishTail", {
    Title = "🐟 Auto Farm Fish Tail",
    Description = "Farma fish tail em Forgotten Island",
    Default = false,
    Callback = function(Value)
        _G.Settings.FarmFishTail = Value
        if not Value then
            StopTween()
        end
    end
})

-- Auto Farm Conjured Cocoa
local AutoCocoaToggle = Tabs.Items:AddToggle("AutoCocoa", {
    Title = "🍫 Auto Farm Conjured Cocoa",
    Description = "Farma cocoa em Chocolate Island",
    Default = false,
    Callback = function(Value)
        _G.Settings.FarmConjuredCocoa = Value
        if not Value then
            StopTween()
        end
    end
})

-- Status de Items
Tabs.Items:AddSection("📊 Status de Items")

local ItemLabels = {
    Bone = Tabs.Items:AddParagraph({Title = "🦴 Bone", Content = "Carregando..."}),
    Ectoplasm = Tabs.Items:AddParagraph({Title = "👻 Ectoplasm", Content = "Carregando..."}),
}

task.spawn(function()
    while task.wait(2) do
        pcall(function()
            local Bone = LocalPlayer.Backpack:FindFirstChild("Bone") or LocalPlayer.Character:FindFirstChild("Bone")
            local Ecto = LocalPlayer.Backpack:FindFirstChild("Ectoplasm") or LocalPlayer.Character:FindFirstChild("Ectoplasm")
            
            ItemLabels.Bone:SetDesc(Bone and "✅ Possui" or "❌ Não possui")
            ItemLabels.Ectoplasm:SetDesc(Ecto and "✅ Possui" or "❌ Não possui")
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- TAB: MATERIALS
-- ═══════════════════════════════════════════════════════════════

local MaterialsList = {
    "Scrap Metal",
    "Leather",
    "Angel Wings",
    "Magma Ore",
    "Fish Tail",
    "Scales",
    "Mystic Droplet",
    "Vampire Fang",
    "Radioactive Material",
    "Mini Tusk",
    "Dragon Scale",
    "Gunpowder",
    "Ectoplasm",
    "Demonic Wisp",
    "Conjured Cocoa"
}

Tabs.Materials:AddSection("⚒️ Farm de Materials")

-- Dropdown de Materials
local MaterialDropdown = Tabs.Materials:AddDropdown("MaterialSelect", {
    Title = "⚒️ Selecionar Material",
    Values = MaterialsList,
    Default = MaterialsList[1],
    Callback = function(Value)
        _G.Settings.SelectedMaterial = Value
    end
})

-- Toggle Auto Farm Material
local AutoMaterialToggle = Tabs.Materials:AddToggle("AutoMaterial", {
    Title = "⚒️ Auto Farm Material",
    Description = "Farma o material selecionado",
    Default = false,
    Callback = function(Value)
        _G.Settings.FarmMaterials = Value
        if not Value then
            StopTween()
        end
    end
})

-- Função para pegar mobs que dropam material
function GetMaterialMobs(materialName)
    local MaterialMobs = {
        ["Scrap Metal"] = {"Pirate", "Brute", "Mercenary"},
        ["Leather"] = {"Bandit", "Pirate"},
        ["Angel Wings"] = {"God's Guard", "Shanda", "Royal Squad", "Royal Soldier"},
        ["Magma Ore"] = {"Military Soldier", "Military Spy", "Magma Ninja", "Lava Pirate"},
        ["Fish Tail"] = {"Fishman Warrior", "Fishman Commando", "Fishman Raider", "Fishman Captain"},
        ["Scales"] = {"Dragon Crew Warrior", "Dragon Crew Archer"},
        ["Mystic Droplet"] = {"Sea Soldier", "Water Fighter"},
        ["Vampire Fang"] = {"Vampire"},
        ["Radioactive Material"] = {"Factory Staff"},
        ["Mini Tusk"] = {"Mythological Pirate"},
        ["Dragon Scale"] = {"Dragon Crew Warrior", "Dragon Crew Archer"},
        ["Gunpowder"] = {"Pistol Billionaire"},
        ["Ectoplasm"] = {"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"},
        ["Demonic Wisp"] = {"Demonic Soul"},
        ["Conjured Cocoa"] = {"Chocolate Bar Battler", "Cocoa Warrior", "Sweet Thief"}
    }
    
    return MaterialMobs[materialName] or {}
end

-- ═══════════════════════════════════════════════════════════════
-- TAB: COMBAT
-- ═══════════════════════════════════════════════════════════════

Tabs.Combat:AddSection("⚡ Sistema de Ataque")

local FastAttackToggle = Tabs.Combat:AddToggle("FastAttack", {
    Title = "⚡ Fast Attack",
    Description = "Ataque rápido otimizado",
    Default = true,
    Callback = function(Value)
        _G.Settings.FastAttack = Value
    end
})

local FastAttackDelaySlider = Tabs.Combat:AddSlider("FastAttackDelay", {
    Title = "⏱️ Delay do Fast Attack",
    Description = "Menor = mais rápido",
    Min = 0,
    Max = 0.5,
    Default = 0.1,
    Rounding = 2,
    Callback = function(Value)
        _G.Settings.FastAttackDelay = Value
    end
})

Tabs.Combat:AddSection("🛡️ Habilidades de Combate")

local AutoHakiToggle = Tabs.Combat:AddToggle("AutoHaki", {
    Title = "🛡️ Auto Haki",
    Description = "Ativa Buso Haki automaticamente",
    Default = true,
    Callback = function(Value)
        _G.Settings.AutoHaki = Value
    end
})

Tabs.Combat:AddSection("🧲 Sistema de Bring")

local BringToggle = Tabs.Combat:AddToggle("BringMobs", {
    Title = "🧲 Bring Mobs",
    Description = "Traz mobs para perto de você",
    Default = true,
    Callback = function(Value)
        _G.Settings.BringMonster = Value
    end
})

local BringDistanceSlider = Tabs.Combat:AddSlider("BringDistance", {
    Title = "📏 Distância de Bring",
    Description = "Raio para trazer mobs",
    Min = 200,
    Max = 600,
    Default = 350,
    Rounding = 10,
    Callback = function(Value)
        _G.Settings.BringMode = Value
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: ESP & VISUAL
-- ═══════════════════════════════════════════════════════════════

Tabs.ESP:AddSection("👁️ ESP (Extra Sensory Perception)")

local ESPPlayerToggle = Tabs.ESP:AddToggle("ESPPlayer", {
    Title = "👤 ESP Players",
    Description = "Mostra jogadores através das paredes",
    Default = false,
    Callback = function(Value)
        _G.Settings.ESPPlayer = Value
    end
})

local ESPMobToggle = Tabs.ESP:AddToggle("ESPMob", {
    Title = "👾 ESP Mobs",
    Description = "Mostra mobs através das paredes",
    Default = false,
    Callback = function(Value)
        _G.Settings.ESPMob = Value
    end
})

local ESPBossToggle = Tabs.ESP:AddToggle("ESPBoss", {
    Title = "👹 ESP Bosses",
    Description = "Mostra bosses através das paredes",
    Default = false,
    Callback = function(Value)
        _G.Settings.ESPBoss = Value
    end
})

local ESPFruitToggle = Tabs.ESP:AddToggle("ESPFruit", {
    Title = "😈 ESP Frutas",
    Description = "Mostra frutas no mapa",
    Default = false,
    Callback = function(Value)
        _G.Settings.ESPFruit = Value
    end
})

local ESPNPCToggle = Tabs.ESP:AddToggle("ESPNPC", {
    Title = "💼 ESP NPCs",
    Description = "Mostra NPCs importantes",
    Default = false,
    Callback = function(Value)
        _G.Settings.ESPNPC = Value
    end
})

-- Função de ESP Básica
function CreateESP(obj, name, color)
    pcall(function()
        if obj and obj:FindFirstChild("HumanoidRootPart") and not obj.HumanoidRootPart:FindFirstChild("ESPBox") then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "ESPBox"
            billboardGui.Adornee = obj.HumanoidRootPart
            billboardGui.Size = UDim2.new(0, 100, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.AlwaysOnTop = true
            billboardGui.Parent = obj.HumanoidRootPart
            
            local textLabel = Instance.new("TextLabel")
            textLabel.BackgroundTransparency = 1
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = name
            textLabel.TextColor3 = color
            textLabel.TextStrokeTransparency = 0
            textLabel.TextScaled = true
            textLabel.Parent = billboardGui
        end
    end)
end

function RemoveESP(obj)
    pcall(function()
        if obj and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart:FindFirstChild("ESPBox") then
            obj.HumanoidRootPart.ESPBox:Destroy()
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- TAB: TELEPORTS
-- ═══════════════════════════════════════════════════════════════

Tabs.Teleport:AddSection("🌍 Teleports Rápidos")

-- Lista de Ilhas por World
local IslandsList = {}

if _G.World1 then
    IslandsList = {
        ["Spawn"] = CFrame.new(1059.37195, 15.4495068, 1550.4231),
        ["Jungle"] = CFrame.new(-1598.08911, 35.5501175, 153.377838),
        ["Pirate Village"] = CFrame.new(-1141.07483, 4.10001802, 3831.5498),
        ["Desert"] = CFrame.new(894.488647, 5.14000702, 4392.43359),
        ["Frozen Village"] = CFrame.new(1389.74451, 88.1519318, -1298.90796),
        ["Marine Fortress"] = CFrame.new(-5039.58643, 27.3500385, 4324.68018),
        ["Skylands"] = CFrame.new(-4839.53027, 716.368591, -2619.44165),
        ["Prison"] = CFrame.new(5308.93115, 1.65517521, 475.120514),
        ["Colosseum"] = CFrame.new(-1580.04663, 6.35000277, -2986.47534),
        ["Magma Village"] = CFrame.new(-5313.37012, 10.9500084, 8515.29395),
        ["Underwater City"] = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734),
        ["Upper Skylands"] = CFrame.new(-7859.09814, 5544.19043, -381.476196),
        ["Fountain City"] = CFrame.new(5259.81982, 37.3500175, 4050.0293)
    }
elseif _G.World2 then
    IslandsList = {
        ["Kingdom of Rose"] = CFrame.new(-429.543518, 71.7699966, 1836.18188),
        ["Cafe"] = CFrame.new(638.43811, 71.769989, 918.282898),
        ["Mansion"] = CFrame.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        ["Graveyard"] = CFrame.new(-5497.06152, 47.5923004, -795.237061),
        ["Snow Mountain"] = CFrame.new(609.858826, 400.119904, -5372.25928),
        ["Hot and Cold"] = CFrame.new(-6064.06885, 15.2422857, -4902.97852),
        ["Cursed Ship"] = CFrame.new(916.928589, 181.092773, 33422),
        ["Ice Castle"] = CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188),
        ["Forgotten Island"] = CFrame.new(-3054.44458, 235.544281, -10142.8193)
    }
elseif _G.World3 then
    IslandsList = {
        ["Port Town"] = CFrame.new(-290.074677, 42.9034653, 5581.58984),
        ["Hydra Island"] = CFrame.new(5753.5478515625, 610.7998046875, -282.33404541015625),
        ["Great Tree"] = CFrame.new(2180.54126, 27.8156815, -6741.5498),
        ["Castle on the Sea"] = CFrame.new(-5075.50927734375, 314.5155029296875, -3150.0224609375),
        ["Haunted Castle"] = CFrame.new(-9515.62109, 315.925537, 6691.12012),
        ["Sea of Treats"] = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875),
        ["Chocolate Island"] = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438),
        ["Cake Land"] = CFrame.new(-2151.82153, 149.315704, -12404.9053),
        ["Tiki Outpost"] = CFrame.new(-16542.447265625, 55.68632888793945, 1044.41650390625)
    }
end

-- Criar botões de teleporte
for islandName, islandCFrame in pairs(IslandsList) do
    Tabs.Teleport:AddButton({
        Title = "🏝️ " .. islandName,
        Description = "Teleportar para " .. islandName,
        Callback = function()
            topos(islandCFrame)
            Fluent:Notify({
                Title = "✈️ Teleportando",
                Content = "Indo para " .. islandName,
                Duration = 3
            })
        end
    })
end

-- Teleport para Player
Tabs.Teleport:AddSection("👤 Teleport para Jogadores")

local PlayersList = {}
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(PlayersList, player.Name)
    end
end

local PlayerTeleportDropdown = Tabs.Teleport:AddDropdown("PlayerTeleport", {
    Title = "👤 Selecionar Jogador",
    Values = PlayersList,
    Default = PlayersList[1] or "Nenhum",
    Callback = function(Value)
        -- Callback vazio, o botão faz o teleporte
    end
})

Tabs.Teleport:AddButton({
    Title = "✈️ Teleportar para Jogador",
    Description = "Teleporta para o jogador selecionado",
    Callback = function()
        local selectedPlayer = PlayerTeleportDropdown.Value
        local player = Players:FindFirstChild(selectedPlayer)
        
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            topos(player.Character.HumanoidRootPart.CFrame)
            Fluent:Notify({
                Title = "✈️ Teleportando",
                Content = "Indo até " .. selectedPlayer,
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "❌ Erro",
                Content = "Jogador não encontrado!",
                Duration = 3
            })
        end
    end
})

Tabs.Teleport:AddButton({
    Title = "🔄 Atualizar Lista de Jogadores",
    Description = "Recarrega a lista de jogadores",
    Callback = function()
        PlayersList = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(PlayersList, player.Name)
            end
        end
        PlayerTeleportDropdown:SetValues(PlayersList)
        Fluent:Notify({
            Title = "✅ Atualizado",
            Content = "Lista de jogadores recarregada!",
            Duration = 3
        })
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: SEA EVENTS
-- ═══════════════════════════════════════════════════════════════

Tabs.SeaEvent:AddSection("🌊 Eventos do Mar")

local AutoSeabeastToggle = Tabs.SeaEvent:AddToggle("AutoSeabeast", {
    Title = "🐋 Auto Farm Sea Beast",
    Description = "Farma Sea Beast automaticamente",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoSeabeast = Value
    end
})

local AutoTerrorsharkToggle = Tabs.SeaEvent:AddToggle("AutoTerrorshark", {
    Title = "🦈 Auto Farm Terrorshark",
    Description = "Farma Terrorshark automaticamente",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoTerrorshark = Value
    end
})

local AutoPiranhaToggle = Tabs.SeaEvent:AddToggle("AutoPiranha", {
    Title = "🐟 Auto Farm Piranha",
    Description = "Farma Piranha automaticamente",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoPiranha = Value
    end
})

local AutoShipToggle = Tabs.SeaEvent:AddToggle("AutoShip", {
    Title = "⛵ Auto Farm Ship",
    Description = "Farma navios automaticamente",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoShip = Value
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: SHOP
-- ═══════════════════════════════════════════════════════════════

Tabs.Shop:AddSection("🛒 Loja de Habilidades")

Tabs.Shop:AddButton({
    Title = "🥋 Comprar Fighting Styles",
    Description = "Abre menu de fighting styles",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonClaw")
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman")
        
        Fluent:Notify({
            Title = "🛒 Comprando",
            Content = "Tentando comprar fighting styles...",
            Duration = 3
        })
    end
})

Tabs.Shop:AddButton({
    Title = "🗡️ Comprar Katana",
    Description = "Compra Katana básica",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
        Fluent:Notify({
            Title = "✅ Sucesso",
            Content = "Katana comprada!",
            Duration = 3
        })
    end
})

Tabs.Shop:AddButton({
    Title = "🔫 Comprar Slingshot",
    Description = "Compra Slingshot",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
        Fluent:Notify({
            Title = "✅ Sucesso",
            Content = "Slingshot comprada!",
            Duration = 3
        })
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: STATS
-- ═══════════════════════════════════════════════════════════════

Tabs.Stats:AddSection("📊 Auto Stats")

local AutoStatsToggle = Tabs.Stats:AddToggle("AutoStats", {
    Title = "📊 Auto Stats",
    Description = "Distribui pontos automaticamente",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoStats = Value
    end
})

local PointMeleeSlider = Tabs.Stats:AddSlider("PointMelee", {
    Title = "🥊 Pontos em Melee",
    Min = 0,
    Max = 100,
    Default = 0,
    Rounding = 1,
    Callback = function(Value)
        _G.Settings.PointMelee = Value
    end
})

local PointDefenseSlider = Tabs.Stats:AddSlider("PointDefense", {
    Title = "🛡️ Pontos em Defense",
    Min = 0,
    Max = 100,
    Default = 0,
    Rounding = 1,
    Callback = function(Value)
        _G.Settings.PointDefense = Value
    end
})

local PointSwordSlider = Tabs.Stats:AddSlider("PointSword", {
    Title = "⚔️ Pontos em Sword",
    Min = 0,
    Max = 100,
    Default = 0,
    Rounding = 1,
    Callback = function(Value)
        _G.Settings.PointSword = Value
    end
})

local PointGunSlider = Tabs.Stats:AddSlider("PointGun", {
    Title = "🔫 Pontos em Gun",
    Min = 0,
    Max = 100,
    Default = 0,
    Rounding = 1,
    Callback = function(Value)
        _G.Settings.PointGun = Value
    end
})

local PointFruitSlider = Tabs.Stats:AddSlider("PointFruit", {
    Title = "😈 Pontos em Devil Fruit",
    Min = 0,
    Max = 100,
    Default = 0,
    Rounding = 1,
    Callback = function(Value)
        _G.Settings.PointFruit = Value
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: BUG SYSTEM
-- ═══════════════════════════════════════════════════════════════

Tabs.Bug:AddSection("🐛 Sistema de Bug")

local NoClipToggle = Tabs.Bug:AddToggle("NoClip", {
    Title = "👻 NoClip (Atravessar Paredes)",
    Description = "Atravessa todas as paredes e objetos",
    Default = false,
    Callback = function(Value)
        _G.Settings.NoClip = Value
    end
})

local AntiWaterToggle = Tabs.Bug:AddToggle("AntiWater", {
    Title = "💧 Anti-Água (Imunidade)",
    Description = "Não toma dano de água do mar",
    Default = false,
    Callback = function(Value)
        _G.Settings.AntiWater = Value
    end
})

local AntiDrownToggle = Tabs.Bug:AddToggle("AntiDrown", {
    Title = "🌊 Anti-Afogamento",
    Description = "Nunca morre afogado",
    Default = false,
    Callback = function(Value)
        _G.Settings.AntiDrown = Value
    end
})

local WalkOnWaterToggle = Tabs.Bug:AddToggle("WalkOnWater", {
    Title = "🚶 Andar na Água",
    Description = "Anda sobre a água como se fosse chão",
    Default = false,
    Callback = function(Value)
        _G.Settings.WalkOnWater = Value
    end
})

-- Remove Fog
local RemoveFogToggle = Tabs.Bug:AddToggle("RemoveFog", {
    Title = "🌫️ Remover Neblina",
    Description = "Remove toda neblina do jogo",
    Default = false,
    Callback = function(Value)
        _G.Settings.RemoveFog = Value
        
        if Value then
            Lighting.FogEnd = 100000
            for _, v in pairs(Lighting:GetDescendants()) do
                if v:IsA("Atmosphere") then
                    v.Density = 0
                    v.Offset = 0
                    v.Color = Color3.new(1, 1, 1)
                    v.Decay = Color3.new(1, 1, 1)
                    v.Glare = 0
                    v.Haze = 0
                end
            end
        else
            Lighting.FogEnd = 2500
        end
    end
})

-- Remove Damage Text
local RemoveDamageToggle = Tabs.Bug:AddToggle("RemoveDamage", {
    Title = "🔢 Remover Texto de Dano",
    Description = "Remove números de dano na tela",
    Default = false,
    Callback = function(Value)
        _G.Settings.RemoveDamage = Value
    end
})

-- White Screen
local WhiteScreenToggle = Tabs.Bug:AddToggle("WhiteScreen", {
    Title = "⚪ White Screen (Performance)",
    Description = "Remove todos os gráficos para melhor FPS",
    Default = false,
    Callback = function(Value)
        _G.Settings.WhiteScreen = Value
        
        if Value then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Transparency = 1
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Transparency = 0
                end
            end
        end
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB: MISC
-- ═══════════════════════════════════════════════════════════════

Tabs.Misc:AddSection("🔧 Configurações Diversas")

Tabs.Misc:AddToggle("AutoRejoin", {
    Title = "🔄 Auto Rejoin",
    Description = "Reconecta automaticamente se cair",
    Default = true,
    Callback = function(Value)
        _G.Settings.AutoRejoin = Value
        _G.AutoReconnect = Value
    end
})

Tabs.Misc:AddSection("🖥️ Server Hop")

Tabs.Misc:AddButton({
    Title = "🔄 Server Hop",
    Description = "Troca para outro servidor",
    Callback = function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        
        function TPReturner()
            local Site
            if foundAnything == "" then
                Site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0
            for i,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num ~= 0 then
                            if ID == tostring(Existing) then
                                Possible = false
                            end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                        end
                        num = num + 1
                    end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                            wait()
                            TeleportService:TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
                        end)
                        wait(4)
                    end
                end
            end
        end
        
        function Teleport()
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
            end
        end
        
        Teleport()
    end
})

Tabs.Misc:AddButton({
    Title = "🎮 Rejoin Current Server",
    Description = "Reconecta ao servidor atual",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

Tabs.Misc:AddSection("📋 Informações do Script")

Tabs.Misc:AddParagraph({
    Title = "ℹ️ Sobre",
    Content = "Lag Teck Fusion V4.0 - Ultimate Edition\nVersão: 4.0.0\nCriado por: Lag Teck Team\nDiscord: discord.gg/RnZ6XHHFj7\n\nScript 100% funcional e otimizado!"
})

-- ═══════════════════════════════════════════════════════════════
-- LOOPS PRINCIPAIS - TUDO FUNCIONANDO
-- ═══════════════════════════════════════════════════════════════

-- Loop Auto Farm Level
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarmLevel then
            pcall(function()
                CheckQuest()
                
                local QuestActive = LocalPlayer.PlayerGui.Main.Quest.Visible
                
                if not QuestActive then
                    _G.StartMagnet = false
                    topos(CFrameQuest)
                    
                    if (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 15 then
                        wait(0.5)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        wait(0.5)
                    end
                else
                    local MobFound = false
                    
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            MobFound = true
                            
                            repeat task.wait()
                                if _G.Settings.AutoHaki then AutoHaki() end
                                EquipWeapon(_G.Settings.SelectWeapon)
                                
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.WalkSpeed = 0
                                
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(_G.Settings.PosX, _G.Settings.PosY, _G.Settings.PosZ))
                                
                                _G.PosMon = v.HumanoidRootPart.CFrame
                                _G.StartMagnet = true
                                
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(1280, 672))
                            until not _G.Settings.AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0 or not QuestActive
                            
                            _G.StartMagnet = false
                        end
                    end
                    
                    if not MobFound then
                        topos(CFrameMon)
                    end
                end
            end)
        end
    end
end)

-- Loop Auto Farm Nearest
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarmNearest and not _G.Settings.AutoFarmLevel then
            pcall(function()
                local NearestMob = nil
                local NearestDistance = math.huge
                
                for i, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local Distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if Distance < NearestDistance then
                            NearestDistance = Distance
                            NearestMob = v
                        end
                    end
                end
                
                if NearestMob then
                    repeat task.wait()
                        if _G.Settings.AutoHaki then AutoHaki() end
                        EquipWeapon(_G.Settings.SelectWeapon)
                        
                        NearestMob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        NearestMob.HumanoidRootPart.CanCollide = false
                        NearestMob.HumanoidRootPart.Transparency = 1
                        NearestMob.Humanoid.WalkSpeed = 0
                        
                        topos(NearestMob.HumanoidRootPart.CFrame * CFrame.new(_G.Settings.PosX, _G.Settings.PosY, _G.Settings.PosZ))
                        
                        _G.PosMon = NearestMob.HumanoidRootPart.CFrame
                        _G.StartMagnet = true
                        
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(1280, 672))
                    until not _G.Settings.AutoFarmNearest or not NearestMob.Parent or NearestMob.Humanoid.Health <= 0
                    
                    _G.StartMagnet = false
                end
            end)
        end
    end
end)

-- Loop Auto Farm Mastery
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarmMastery then
            pcall(function()
                local currentMastery = GetWeaponMastery(_G.Settings.MasteryWeapon)
                
                if currentMastery >= _G.Settings.TargetMastery then
                    Fluent:Notify({
                        Title = "✅ Mastery Completo!",
                        Content = string.format("%s atingiu %d de mastery!", 
                            _G.Settings.MasteryWeapon, 
                            _G.Settings.TargetMastery),
                        Duration = 5
                    })
                    _G.Settings.AutoFarmMastery = false
                    return
                end
                
                if _G.Settings.MasteryMode == "Quest" then
                    CheckQuest()
                    
                    local QuestActive = LocalPlayer.PlayerGui.Main.Quest.Visible
                    
                    if not QuestActive then
                        topos(CFrameQuest)
                        if (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            wait(1)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        end
                    else
                        for i, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    if _G.Settings.AutoHaki then AutoHaki() end
                                    EquipWeapon(_G.Settings.MasteryWeapon)
                                    
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    _G.PosMon = v.HumanoidRootPart.CFrame
                                    _G.StartMagnet = true
                                    
                                    VirtualUser:CaptureController()
                                    VirtualUser:Button1Down(Vector2.new(1280, 672))
                                until not _G.Settings.AutoFarmMastery or not v.Parent or v.Humanoid.Health <= 0
                                
                                _G.StartMagnet = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Loop Auto Farm Boss
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoBoss and _G.Settings.SelectedBoss ~= "" then
            pcall(function()
                local boss = FindBoss(_G.Settings.SelectedBoss)
                
                if boss and boss:FindFirstChild("Humanoid") and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                    repeat task.wait()
                        if _G.Settings.AutoHaki then AutoHaki() end
                        EquipWeapon(_G.Settings.SelectWeapon)
                        
                        boss.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        boss.HumanoidRootPart.CanCollide = false
                        boss.Humanoid.WalkSpeed = 0
                        
                        topos(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                        
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(1280, 672))
                    until not _G.Settings.AutoBoss or not boss.Parent or boss.Humanoid.Health <= 0
                else
                    local bossPos = GetBossPosition(_G.Settings.SelectedBoss)
                    topos(bossPos)
                end
            end)
        end
    end
end)

-- Loop Auto Farm All Bosses
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarmAllBoss then
            pcall(function()
                for _, bossName in pairs(BossList) do
                    local boss = FindBoss(bossName)
                    
                    if boss and boss:FindFirstChild("Humanoid") and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                        _G.Settings.SelectedBoss = bossName
                        
                        repeat task.wait()
                            if _G.Settings.AutoHaki then AutoHaki() end
                            EquipWeapon(_G.Settings.SelectWeapon)
                            
                            boss.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            boss.HumanoidRootPart.CanCollide = false
                            boss.Humanoid.WalkSpeed = 0
                            
                            topos(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(1280, 672))
                        until not _G.Settings.AutoFarmAllBoss or not boss.Parent or boss.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- Loop Auto Farm Bone
task.spawn(function()
    while task.wait() do
        if _G.Settings.FarmBone then
            pcall(function()
                local BoneMobs = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                
                for _, mobName in pairs(BoneMobs) do
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == mobName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                if _G.Settings.AutoHaki then AutoHaki() end
                                EquipWeapon(_G.Settings.SelectWeapon)
                                
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                _G.PosMon = v.HumanoidRootPart.CFrame
                                _G.StartMagnet = true
                                
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(1280, 672))
                            until not _G.Settings.FarmBone or not v.Parent or v.Humanoid.Health <= 0
                            
                            _G.StartMagnet = false
                        end
                    end
                end
            end)
        end
    end
end)

-- Loop Auto Farm Ectoplasm
task.spawn(function()
    while task.wait() do
        if _G.Settings.FarmEctoplasm then
            pcall(function()
                local EctoMobs = {"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"}
                
                for _, mobName in pairs(EctoMobs) do
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == mobName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                if _G.Settings.AutoHaki then AutoHaki() end
                                EquipWeapon(_G.Settings.SelectWeapon)
                                
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                _G.PosMon = v.HumanoidRootPart.CFrame
                                _G.StartMagnet = true
                                
                                VirtualUser:CaptureController()
                                VirtualUser:Button1Down(Vector2.new(1280, 672))
                            until not _G.Settings.FarmEctoplasm or not v.Parent or v.Humanoid.Health <= 0
                            
                            _G.StartMagnet = false
                        end
                    end
                end
            end)
        end
    end
end)

-- Loop Auto Farm Materials
task.spawn(function()
    while task.wait() do
        if _G.Settings.FarmMaterials and _G.Settings.SelectedMaterial ~= "" then
            pcall(function()
                local materialMobs = GetMaterialMobs(_G.Settings.SelectedMaterial)
                
                for _, mobName in pairs(materialMobs) do
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == mobName an
