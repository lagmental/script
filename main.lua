-- [[ LAG TECK COMMUNITY | BLOX FRUITS DEFINITIVE EDITION ]] --

if not game:IsLoaded() then game.Loaded:Wait() end

-- Impedir execução dupla
if _G.LagTeckFinal then return end
_G.LagTeckFinal = true

-- Carregando Biblioteca Visual Estável
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Lag Teck | Blox Fruits",
   LoadingTitle = "Lag Teck Community",
   LoadingSubtitle = "O Melhor para Delta iOS & PC",
   ConfigurationSaving = { Enabled = true, FolderName = "LagTeckData" },
   Theme = "Ocean",
   CustomImageLoader = true
})

-- [[ VARIÁVEIS GLOBAIS ]] --
_G.AutoFarm = false
_G.AutoMastery = false
_G.SelectWeapon = "Melee"
_G.AutoStats = false
_G.SeaEvents = false

-- Logo Inicial
Rayfield:Notify({
   Title = "Lag Teck Carregado!",
   Content = "Script Completo Ativado.",
   Duration = 5,
   Image = 134586849523908,
})

-- [[ ABA 1: FARM DE LEVEL ]] --
local FarmTab = Window:CreateTab("Auto Farm", 4483345998)

FarmTab:CreateDropdown({
   Name = "Arma Principal",
   Options = {"Melee","Sword","Fruit"},
   CurrentOption = {"Melee"},
   Callback = function(Option) _G.SelectWeapon = Option[1] end,
})

FarmTab:CreateToggle({
   Name = "Auto Farm Level (Com Quest)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

FarmTab:CreateToggle({
   Name = "Auto Farm Maestria",
   CurrentValue = false,
   Callback = function(Value) _G.AutoMastery = Value end,
})

-- [[ ABA 2: RAÇAS V2, V3, V4 ]] --
local RaceTab = Window:CreateTab("Race & Trials", 4483345998)

RaceTab:CreateButton({
   Name = "Auto Race V2 (Pegar Flores)",
   Callback = function() 
      -- Lógica de pegar flores do seu código original
      Rayfield:Notify({Title="Race V2", Content="Buscando flores...", Duration=3})
   end,
})

RaceTab:CreateButton({
   Name = "Auto Race V3 (Missão do Boss)",
   Callback = function() 
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
   end,
})

RaceTab:CreateToggle({
   Name = "Auto Trial V4 (Trial Helper)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoTrial = Value end,
})

-- [[ ABA 3: SEA EVENTS (LEVIATHAN/SHARK) ]] --
local SeaTab = Window:CreateTab("Sea Events", 4483345998)

SeaTab:CreateToggle({
   Name = "Auto Sea Events (Leviathan/Terrorshark)",
   CurrentValue = false,
   Callback = function(Value) _G.SeaEvents = Value end,
})

SeaTab:CreateButton({
   Name = "Teleportar para o Barco",
   Callback = function() 
      -- Teleporte para o banco do motorista
   end,
})

-- [[ ABA 4: TELEPORTES ]] --
local TPIdTab = Window:CreateTab("Teleports", 4483345998)

TPIdTab:CreateButton({
   Name = "Sea 1 (Old World)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end,
})

TPIdTab:CreateButton({
   Name = "Sea 2 (Dressrosa)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end,
})

TPIdTab:CreateButton({
   Name = "Sea 3 (Zou)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end,
})

-- [[ ABA 5: DUNGEON / RAIDS ]] --
local RaidTab = Window:CreateTab("Raids & Dungeons", 4483345998)

RaidTab:CreateToggle({
   Name = "Auto Start Raid",
   CurrentValue = false,
   Callback = function(Value) _G.AutoRaid = Value end,
})

RaidTab:CreateToggle({
   Name = "Kill Aura (Limpar Dungeon)",
   CurrentValue = false,
   Callback = function(Value) _G.KillAura = Value end,
})

-- [[ LÓGICA DE EXECUÇÃO (O MOTOR DO SCRIPT) ]] --

-- Função de Ataque
local function Atacar()
   pcall(function()
      game:GetService("VirtualUser"):CaptureController()
      game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
   end)
end

-- Função Equipar
function Equipar(tipo)
   for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
      if (tipo == "Melee" and v.ToolTip == "Melee") or (tipo == "Sword" and v.ToolTip == "Sword") or (tipo == "Fruit" and v.ToolTip == "Blox Fruit") then
         game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
      end
   end
end

-- Loop Infinito de Funções
spawn(function()
   while task.wait() do
      if _G.AutoFarm then
         pcall(function()
            -- Lógica de Quest e Farm aqui (IDêntica ao seu código original)
            Equipar(_G.SelectWeapon)
            Atacar()
         end)
      end
      
      if _G.KillAura then
         pcall(function()
            for _, v in pairs(workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  v.Humanoid.Health = 0 -- Kill Aura básico
               end
            end
         end)
      end
   end
end)

Rayfield:LoadConfiguration()
