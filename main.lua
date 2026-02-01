-- ╔═══════════════════════════════════════════════════════════╗
-- ║           LAG TECK | BLOX FRUITS SCRIPT                   ║
-- ║                    Versão 3.0 Final                       ║
-- ║              Criado por: 𝕷𝖆𝖌 𝕸𝖊𝖓𝖙𝖆𝖑                       ║
-- ║         Discord: discord.gg/RnZ6XHHFj7                    ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Aguardar o jogo carregar
if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

-- Evitar execução dupla
if _G.LagTeckExecuted then 
    return 
end
_G.LagTeckExecuted = true

-- ============================================
-- SERVIÇOS DO ROBLOX
-- ============================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- IDENTIFICAÇÃO DE MUNDO
-- ============================================
local World1, World2, World3 = false, false, false
local WorldName = ""

if game.PlaceId == 2753915549 then 
    World1 = true
    WorldName = "Sea 1"
elseif game.PlaceId == 4442272183 then 
    World2 = true
    WorldName = "Sea 2"
elseif game.PlaceId == 7449423635 then 
    World3 = true
    WorldName = "Sea 3"
end

-- ============================================
-- CARREGANDO RAYFIELD UI LIBRARY
-- ============================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ============================================
-- CRIANDO A JANELA PRINCIPAL
-- ============================================
local Window = Rayfield:CreateWindow({
   Name = "Lag Teck",
   Icon = 134586849523908, -- SUA LOGO AQUI
   LoadingTitle = "Lag Teck",
   LoadingSubtitle = "by ⌁𝕷𝖆𝖌 𝕸𝖊𝖓𝖙𝖆𝖑⌁",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LagTeck",
      FileName = "Scripts"
   },
   Discord = {
      Enabled = true,
      Invite = "RnZ6XHHFj7",
      RememberJoins = true
   },
   KeySystem = false
})

-- ============================================
-- NOTIFICAÇÃO DE BEM-VINDO
-- ============================================
Rayfield:Notify({
   Title = "🔥 Lag Teck Loaded!",
   Content = "Bem-vindo, " .. LocalPlayer.Name .. "!\nVocê está no " .. WorldName,
   Duration = 6,
   Image = 134586849523908
})

-- ============================================
-- PROTEÇÃO ANTI-KICK
-- ============================================
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then 
        return wait(9e9) 
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- ============================================
-- VARIÁVEIS GLOBAIS
-- ============================================
_G.Settings = {
    -- FARMS
    AutoFarmLevel = false,
    AutoFarmBoss = false,
    AutoFarmMastery = false,
    AutoFarmBone = false,
    AutoFarmEctoplasm = false,
    
    -- COMBATE
    FastAttack = true,
    AutoHaki = true,
    SelectWeapon = "Melee",
    
    -- STATS
    AutoMelee = false,
    AutoDefense = false,
    AutoSword = false,
    AutoGun = false,
    AutoFruit = false,
    
    -- RAIDS
    AutoRaid = false,
    SelectRaid = "Flame",
    
    -- FRUTAS
    AutoStoreFruit = true,
    
    -- MISC
    NoClip = false,
    FastMode = false,
    
    -- TELEPORTE
    ManualTeleport = false
}

-- ============================================
-- FUNÇÕES ESSENCIAIS
-- ============================================

-- Pausar todos os farms
function StopAllFarms()
    _G.Settings.AutoFarmLevel = false
    _G.Settings.AutoFarmBoss = false
    _G.Settings.AutoFarmMastery = false
    _G.Settings.AutoFarmBone = false
    _G.Settings.AutoFarmEctoplasm = false
    _G.Settings.AutoRaid = false
    _G.Settings.ManualTeleport = true
    
    Rayfield:Notify({
        Title = "⚠️ Proteção Ativada",
        Content = "Farms pausados para teleporte seguro!",
        Duration = 3,
        Image = 134586849523908
    })
end

-- Equipar arma
function EquipWeapon()
    pcall(function()
        for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                if (_G.Settings.SelectWeapon == "Melee" and v.ToolTip == "Melee") or
                   (_G.Settings.SelectWeapon == "Sword" and v.ToolTip == "Sword") or
                   (_G.Settings.SelectWeapon == "Fruit" and v.ToolTip == "Blox Fruit") or
                   (_G.Settings.SelectWeapon == "Gun" and v.ToolTip == "Gun") then
                    LocalPlayer.Character.Humanoid:EquipTool(v)
                end
            end
        end
    end)
end

-- Click automático
function AutoClick()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(1280, 672))
    end)
end

-- ============================================
-- AUTO HAKI
-- ============================================
spawn(function()
    while wait(1) do
        if _G.Settings.AutoHaki then
            pcall(function()
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)

-- ============================================
-- STATUS DO SERVIDOR (DETECTORES)
-- ============================================
local function CheckMirage()
    if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
        return "✅ Spawned"
    else
        return "❌ Not Found"
    end
end

local function CheckKitsune()
    if workspace.Map:FindFirstChild("Kitsune Island") then
        return "✅ Spawned"
    else
        return "❌ Not Found"
    end
end

local function CheckFrozenDimension()
    if workspace.Map:FindFirstChild("FrozenDimension") then
        return "✅ Open"
    else
        return "❌ Closed"
    end
end

local function CheckFullMoon()
    local moon = game:GetService("Lighting"):FindFirstChild("Sky")
    if moon and moon.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
        return "✅ Full Moon"
    else
        return "❌ No Full Moon"
    end
end

-- ============================================
-- CRIANDO AS ABAS
-- ============================================

-- ╔════════════════════════════════════════╗
-- ║          TAB 1: HOME / STATUS          ║
-- ╚════════════════════════════════════════╝
local HomeTab = Window:CreateTab("🏠 Home", 134586849523908)

HomeTab:CreateSection("👤 Informações do Jogador")

HomeTab:CreateLabel("Jogador: " .. LocalPlayer.Name)
HomeTab:CreateLabel("Level: " .. LocalPlayer.Data.Level.Value)
HomeTab:CreateLabel("Beli: $" .. LocalPlayer.Data.Beli.Value)
HomeTab:CreateLabel("Fragmentos: " .. (LocalPlayer.Data.Fragments.Value or 0))
HomeTab:CreateLabel("Mundo Atual: " .. WorldName)

HomeTab:CreateSection("🌊 Status do Servidor")

local MirageLabel = HomeTab:CreateLabel("Mirage Island: Verificando...")
local KitsuneLabel = HomeTab:CreateLabel("Kitsune Island: Verificando...")
local FrozenLabel = HomeTab:CreateLabel("Frozen Dimension: Verificando...")
local MoonLabel = HomeTab:CreateLabel("Lua Cheia: Verificando...")

-- Atualizar status a cada 2 segundos
spawn(function()
    while wait(2) do
        pcall(function()
            MirageLabel:Set("Mirage Island: " .. CheckMirage())
            KitsuneLabel:Set("Kitsune Island: " .. CheckKitsune())
            FrozenLabel:Set("Frozen Dimension: " .. CheckFrozenDimension())
            MoonLabel:Set("Lua Cheia: " .. CheckFullMoon())
        end)
    end
end)

HomeTab:CreateSection("📢 Comunidade")

HomeTab:CreateButton({
    Name = "📱 Copiar Discord",
    Callback = function()
        setclipboard("https://discord.gg/RnZ6XHHFj7")
        Rayfield:Notify({
            Title = "Discord Copiado!",
            Content = "Cole no navegador: discord.gg/RnZ6XHHFj7",
            Duration = 5,
            Image = 134586849523908
        })
    end
})

-- ╔════════════════════════════════════════╗
-- ║         TAB 2: AUTO FARM               ║
-- ╚════════════════════════════════════════╝
local FarmTab = Window:CreateTab("🎯 Auto Farm", 4483362458)

FarmTab:CreateSection("⚔️ Configurações de Combate")

local WeaponDropdown = FarmTab:CreateDropdown({
    Name = "Selecionar Arma",
    Options = {"Melee", "Sword", "Fruit", "Gun"},
    CurrentOption = {"Melee"},
    MultipleOptions = false,
    Flag = "Weapon",
    Callback = function(Option)
        _G.Settings.SelectWeapon = Option[1]
    end
})

local FastAttackToggle = FarmTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = true,
    Flag = "FastAttack",
    Callback = function(Value)
        _G.Settings.FastAttack = Value
    end
})

local AutoHakiToggle = FarmTab:CreateToggle({
    Name = "Auto Haki",
    CurrentValue = true,
    Flag = "AutoHaki",
    Callback = function(Value)
        _G.Settings.AutoHaki = Value
    end
})

FarmTab:CreateSection("🔥 Farms Principais")

local AutoFarmToggle = FarmTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(Value)
        _G.Settings.AutoFarmLevel = Value
        _G.Settings.ManualTeleport = false
        if Value then
            Rayfield:Notify({
                Title = "Auto Farm Ativado!",
                Content = "Farmando level automaticamente!",
                Duration = 3,
                Image = 134586849523908
            })
        end
    end
})

local AutoBossToggle = FarmTab:CreateToggle({
    Name = "Auto Farm Boss",
    CurrentValue = false,
    Flag = "AutoBoss",
    Callback = function(Value)
        _G.Settings.AutoFarmBoss = Value
    end
})

local AutoMasteryToggle = FarmTab:CreateToggle({
    Name = "Auto Farm Mastery",
    CurrentValue = false,
    Flag = "AutoMastery",
    Callback = function(Value)
        _G.Settings.AutoFarmMastery = Value
    end
})

-- ╔════════════════════════════════════════╗
-- ║         TAB 3: MATERIAIS               ║
-- ╚════════════════════════════════════════╝
local MaterialTab = Window:CreateTab("💎 Materiais", 4483362458)

if World3 then
    MaterialTab:CreateSection("🦴 Sea 3 - Materiais")
    
    local AutoBoneToggle = MaterialTab:CreateToggle({
        Name = "Auto Farm Bone",
        CurrentValue = false,
        Flag = "AutoBone",
        Callback = function(Value)
            _G.Settings.AutoFarmBone = Value
        end
    })
    
    MaterialTab:CreateButton({
        Name = "Girar Surpresa de Ossos",
        Callback = function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
            Rayfield:Notify({
                Title = "Ossos",
                Content = "Girando surpresa de ossos!",
                Duration = 3,
                Image = 134586849523908
            })
        end
    })
end

if World2 then
    MaterialTab:CreateSection("👻 Sea 2 - Materiais")
    
    local AutoEctoToggle = MaterialTab:CreateToggle({
        Name = "Auto Farm Ectoplasm",
        CurrentValue = false,
        Flag = "AutoEcto",
        Callback = function(Value)
            _G.Settings.AutoFarmEctoplasm = Value
        end
    })
end

-- ╔════════════════════════════════════════╗
-- ║         TAB 4: AUTO STATS              ║
-- ╚════════════════════════════════════════╝
local StatsTab = Window:CreateTab("📊 Auto Stats", 4483362458)

StatsTab:CreateSection("💪 Distribuição de Pontos")

local MeleeToggle = StatsTab:CreateToggle({
    Name = "Auto Melee",
    CurrentValue = false,
    Flag = "AutoMelee",
    Callback = function(Value)
        _G.Settings.AutoMelee = Value
    end
})

local DefenseToggle = StatsTab:CreateToggle({
    Name = "Auto Defense",
    CurrentValue = false,
    Flag = "AutoDefense",
    Callback = function(Value)
        _G.Settings.AutoDefense = Value
    end
})

local SwordToggle = StatsTab:CreateToggle({
    Name = "Auto Sword",
    CurrentValue = false,
    Flag = "AutoSword",
    Callback = function(Value)
        _G.Settings.AutoSword = Value
    end
})

local GunToggle = StatsTab:CreateToggle({
    Name = "Auto Gun",
    CurrentValue = false,
    Flag = "AutoGun",
    Callback = function(Value)
        _G.Settings.AutoGun = Value
    end
})

local FruitStatToggle = StatsTab:CreateToggle({
    Name = "Auto Blox Fruit",
    CurrentValue = false,
    Flag = "AutoFruitStat",
    Callback = function(Value)
        _G.Settings.AutoFruit = Value
    end
})

-- Loop Auto Stats
spawn(function()
    while wait(0.1) do
        pcall(function()
            local Points = LocalPlayer.Data.Points.Value
            if Points > 0 then
                if _G.Settings.AutoMelee then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                end
                if _G.Settings.AutoDefense then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                end
                if _G.Settings.AutoSword then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                end
                if _G.Settings.AutoGun then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
                end
                if _G.Settings.AutoFruit then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                end
            end
        end)
    end
end)

-- ╔════════════════════════════════════════╗
-- ║         TAB 5: TELEPORTES              ║
-- ╚════════════════════════════════════════╝
local TeleportTab = Window:CreateTab("🌍 Teleportes", 4483362458)

TeleportTab:CreateSection("🌊 Mudar de Mar")

TeleportTab:CreateButton({
    Name = "🌊 Teleportar para Sea 1",
    Callback = function()
        StopAllFarms()
        wait(0.5)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
    end
})

TeleportTab:CreateButton({
    Name = "🌊 Teleportar para Sea 2",
    Callback = function()
        StopAllFarms()
        wait(0.5)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

TeleportTab:CreateButton({
    Name = "🌊 Teleportar para Sea 3",
    Callback = function()
        StopAllFarms()
        wait(0.5)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
    end
})

TeleportTab:CreateSection("🏝️ Ilhas Especiais")

if World3 then
    TeleportTab:CreateButton({
        Name = "🌸 Mirage Island",
        Callback = function()
            StopAllFarms()
            wait(0.5)
            local mirage = workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island")
            if mirage then
                LocalPlayer.Character.HumanoidRootPart.CFrame = mirage.WorldPivot * CFrame.new(0, 50, 0)
                Rayfield:Notify({
                    Title = "Teleporte",
                    Content = "Teleportado para Mirage Island!",
                    Duration = 3,
                    Image = 134586849523908
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Mirage Island não está spawned!",
                    Duration = 3,
                    Image = 134586849523908
                })
            end
        end
    })
    
    TeleportTab:CreateButton({
        Name = "🦊 Kitsune Island",
        Callback = function()
            StopAllFarms()
            wait(0.5)
            local kitsune = workspace.Map:FindFirstChild("Kitsune Island")
            if kitsune then
                LocalPlayer.Character.HumanoidRootPart.CFrame = kitsune.WorldPivot
                Rayfield:Notify({
                    Title = "Teleporte",
                    Content = "Teleportado para Kitsune Island!",
                    Duration = 3,
                    Image = 134586849523908
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Kitsune Island não está spawned!",
                    Duration = 3,
                    Image = 134586849523908
                })
            end
        end
    })
end

-- ╔════════════════════════════════════════╗
-- ║         TAB 6: RAIDS                   ║
-- ╚════════════════════════════════════════╝
local RaidTab = Window:CreateTab("⚔️ Raids", 4483362458)

RaidTab:CreateSection("🎫 Configuração de Raid")

local RaidDropdown = RaidTab:CreateDropdown({
    Name = "Selecionar Raid",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix", "Dough"},
    CurrentOption = {"Flame"},
    Flag = "RaidSelect",
    Callback = function(Option)
        _G.Settings.SelectRaid = Option[1]
    end
})

local AutoRaidToggle = RaidTab:CreateToggle({
    Name = "Auto Farm Raid",
    CurrentValue = false,
    Flag = "AutoRaid",
    Callback = function(Value)
        _G.Settings.AutoRaid = Value
    end
})

RaidTab:CreateButton({
    Name = "Comprar Chip",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.Settings.SelectRaid)
        Rayfield:Notify({
            Title = "Raid",
            Content = "Comprando chip de " .. _G.Settings.SelectRaid,
            Duration = 3,
            Image = 134586849523908
        })
    end
})

-- ╔════════════════════════════════════════╗
-- ║         TAB 7: SHOP                    ║
-- ╚════════════════════════════════════════╝
local ShopTab = Window:CreateTab("🛒 Shop", 4483362458)

ShopTab:CreateSection("🍇 Frutas")

local AutoStoreToggle = ShopTab:CreateToggle({
    Name = "Auto Guardar Fruta",
    CurrentValue = true,
    Flag = "AutoStore",
    Callback = function(Value)
        _G.Settings.AutoStoreFruit = Value
    end
})

ShopTab:CreateButton({
    Name = "Girar Fruta Aleatória",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin","Buy")
        Rayfield:Notify({
            Title = "Fruta",
            Content = "Girando fruta aleatória!",
            Duration = 3,
            Image = 134586849523908
        })
    end
})

ShopTab:CreateSection("🥋 Estilos de Luta")

ShopTab:CreateButton({
    Name = "Comprar Godhuman",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})

ShopTab:CreateButton({
    Name = "Comprar Superhuman",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})

ShopTab:CreateButton({
    Name = "Comprar Dragon Talon",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})

ShopTab:CreateButton({
    Name = "Comprar Electric Claw",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})

-- ╔════════════════════════════════════════╗
-- ║         TAB 8: MISC                    ║
-- ╚════════════════════════════════════════╝
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateSection("🎮 Servidor")

MiscTab:CreateButton({
    Name = "Rejoin (Reentrar)",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

MiscTab:CreateSection("🎁 Códigos")

MiscTab:CreateButton({
    Name = "Resgatar Todos os Códigos",
    Callback = function()
        local codes = {
            "NEWTROLL", "KITT_RESET", "Sub2CaptainMaui", "DEVSCOOKING", "kittgaming",
            "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy",
            "fudd10_v2", "Fudd10", "BIGNEWS", "THEGREATACE", "SUB2GAMERROBOT_RESET1",
            "SUB2GAMERROBOT_EXP1", "Sub2OfficialNoobie", "StrawHatMaine", "TantaiGaming"
        }
        for _, code in pairs(codes) do
            ReplicatedStorage.Remotes.Redeem:InvokeServer(code)
            wait(0.1)
        end
        Rayfield:Notify({
            Title = "Códigos",
            Content = "Todos os códigos foram resgatados!",
            Duration = 5,
            Image = 134586849523908
        })
    end
})

MiscTab:CreateSection("🎨 Performance")

MiscTab:CreateButton({
    Name = "FPS Boost (Tela Branca)",
    Callback = function()
        RunService:Set3dRenderingEnabled(false)
        Rayfield:Notify({
            Title = "FPS Boost",
            Content = "Renderização 3D desativada!",
            Duration = 3,
            Image = 134586849523908
        })
    end
})

MiscTab:CreateButton({
    Name = "Voltar Tela Normal",
    Callback = function()
        RunService:Set3dRenderingEnabled(true)
    end
})

-- ╔════════════════════════════════════════╗
-- ║         TAB 9: CONFIGURAÇÕES           ║
-- ╚════════════════════════════════════════╝
local ConfigTab = Window:CreateTab("⚙️ Config", 4483362458)

ConfigTab:CreateSection("💾 Sistema")

ConfigTab:CreateButton({
    Name = "🔄 Reativar Farms",
    Callback = function()
        _G.Settings.ManualTeleport = false
        Rayfield:Notify({
            Title = "Sistema Reativado",
            Content = "Você pode ligar os farms novamente!",
            Duration = 3,
            Image = 134586849523908
        })
    end
})

ConfigTab:CreateButton({
    Name = "❌ Fechar Script",
    Callback = function()
        Rayfield:Destroy()
    end
})

-- ============================================
-- AUTO STORE FRUIT
-- ============================================
spawn(function()
    while wait(1) do
        if _G.Settings.AutoStoreFruit then
            pcall(function()
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                    end
                end
                for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- ANTI-AFK
-- ============================================
spawn(function()
    LocalPlayer.Idled:connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- ============================================
-- INICIALIZAÇÃO FINAL
-- ============================================
print("╔═══════════════════════════════════════════╗")
print("║      LAG TECK - BLOX FRUITS v3.0          ║")
print("║      Script carregado com sucesso!        ║")
print("║      Jogador: " .. LocalPlayer.Name)
print("║      Mundo: " .. WorldName)
print("║      Discord: discord.gg/RnZ6XHHFj7       ║")
print("╚═══════════════════════════════════════════╝")
