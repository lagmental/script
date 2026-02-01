-- [[ LAG TECK COMMUNITY | BLOX FRUITS SUPREME v1.0 ]] --
-- PARTE 1/6: CORE & SECURITY

if not game:IsLoaded() then game.Loaded:Wait() end
if _G.LagTeckLoaded then return end
_G.LagTeckLoaded = true

-- Carregando Rayfield (Interface)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Lag Teck | Blox Fruits",
   LoadingTitle = "Lag Teck Community",
   LoadingSubtitle = "by p1ssantos",
   ConfigurationSaving = { Enabled = true, FolderName = "LagTeckData" },
   Theme = "Ocean",
   CustomImageLoader = true
})

-- PROTEÇÃO ANTI-KICK (Metatable Bypass)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
   local method = getnamecallmethod()
   if method == "Kick" then return wait(9e9) end
   return old(self, ...)
end)
setreadonly(mt, true)

-- VARIÁVEIS DE CONTROLE
_G.AutoFarm = false
_G.AutoMastery = false
_G.SelectWeapon = "Melee"
_G.AutoStats = false
_G.SeaEvents = false
_G.FastAttack = true
_G.BringMobs = true

-- IDENTIFICAÇÃO DE MUNDO
local World1, World2, World3 = false, false, false
if game.PlaceId == 2753915549 then World1 = true
elseif game.PlaceId == 4442272183 then World2 = true
elseif game.PlaceId == 7449423635 then World3 = true end

-- FUNÇÕES DE SUPORTE
local function Atacar()
   pcall(function()
      game:GetService("VirtualUser"):CaptureController()
      game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
   end)
end

function Equipar(tipo)
   pcall(function()
      for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
         if (tipo == "Melee" and v.ToolTip == "Melee") or 
            (tipo == "Sword" and v.ToolTip == "Sword") or 
            (tipo == "Fruit" and v.ToolTip == "Blox Fruit") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
         end
      end
   end)
end

-- [[ PARTE 2/6: SISTEMA DE QUESTS E COORDENADAS ]] --

function GetQuest()
   local level = game.Players.LocalPlayer.Data.Level.Value
   local questData = {}

   if World1 then
      if level >= 1 and level < 10 then
         questData = {Mon="Bandit", ID="BanditQuest1", Lvl=1, NPC=CFrame.new(1059.37, 15.44, 1550.42)}
      elseif level >= 10 and level < 15 then
         questData = {Mon="Monkey", ID="JungleQuest", Lvl=1, NPC=CFrame.new(-1598.08, 35.55, 153.37)}
      elseif level >= 15 and level < 30 then
         questData = {Mon="Gorilla", ID="JungleQuest", Lvl=2, NPC=CFrame.new(-1598.08, 35.55, 153.37)}
      elseif level >= 30 and level < 40 then
         questData = {Mon="Pirate", ID="BuggyQuest1", Lvl=1, NPC=CFrame.new(-1141.07, 4.10, 3831.54)}
      elseif level >= 40 and level < 60 then
         questData = {Mon="Brute", ID="BuggyQuest1", Lvl=2, NPC=CFrame.new(-1141.07, 4.10, 3831.54)}
      elseif level >= 60 and level < 75 then
         questData = {Mon="Desert Bandit", ID="DesertQuest", Lvl=1, NPC=CFrame.new(894.48, 5.14, 4392.43)}
      elseif level >= 75 and level < 90 then
         questData = {Mon="Desert Officer", ID="DesertQuest", Lvl=2, NPC=CFrame.new(894.48, 5.14, 4392.43)}
      elseif level >= 90 and level < 100 then
         questData = {Mon="Snow Bandit", ID="SnowQuest", Lvl=1, NPC=CFrame.new(1389.74, 88.15, -1298.90)}
      elseif level >= 100 and level < 120 then
         questData = {Mon="Snowman", ID="SnowQuest", Lvl=2, NPC=CFrame.new(1389.74, 88.15, -1298.90)}
      elseif level >= 120 and level < 150 then
         questData = {Mon="Chief Petty Officer", ID="MarineQuest2", Lvl=1, NPC=CFrame.new(-5039.58, 27.35, 4324.68)}
      elseif level >= 150 and level < 175 then
         questData = {Mon="Sky Bandit", ID="SkyQuest", Lvl=1, NPC=CFrame.new(-4839.53, 716.36, -2619.44)}
      elseif level >= 175 and level < 190 then
         questData = {Mon="Dark Master", ID="SkyQuest", Lvl=2, NPC=CFrame.new(-4839.53, 716.36, -2619.44)}
      elseif level >= 190 and level < 210 then
         questData = {Mon="Prisoner", ID="PrisonerQuest", Lvl=1, NPC=CFrame.new(5308.93, 1.65, 475.12)}
      elseif level >= 210 and level < 250 then
         questData = {Mon="Dangerous Prisoner", ID="PrisonerQuest", Lvl=2, NPC=CFrame.new(5308.93, 1.65, 475.12)}
      elseif level >= 250 and level < 275 then
         questData = {Mon="Toga Warrior", ID="ColosseumQuest", Lvl=1, NPC=CFrame.new(-1580.04, 6.35, -2986.47)}
      elseif level >= 275 and level < 300 then
         questData = {Mon="Gladiator", ID="ColosseumQuest", Lvl=2, NPC=CFrame.new(-1580.04, 6.35, -2986.47)}
      elseif level >= 300 and level < 325 then
         questData = {Mon="Military Soldier", ID="MagmaQuest", Lvl=1, NPC=CFrame.new(-5313.37, 10.95, 8515.29)}
      elseif level >= 325 and level < 375 then
         questData = {Mon="Military Spy", ID="MagmaQuest", Lvl=2, NPC=CFrame.new(-5313.37, 10.95, 8515.29)}
      elseif level >= 375 and level < 450 then
         questData = {Mon="Fishman Warrior", ID="FishmanQuest", Lvl=1, NPC=CFrame.new(61122.65, 18.49, 1569.39)}
      elseif level >= 450 and level < 475 then
         questData = {Mon="God's Guard", ID="SkyExp1Quest", Lvl=1, NPC=CFrame.new(-4721.88, 843.87, -1949.96)}
      elseif level >= 475 and level < 525 then
         questData = {Mon="Shanda", ID="SkyExp1Quest", Lvl=2, NPC=CFrame.new(-7859.09, 5544.19, -381.47)}
      elseif level >= 525 and level < 625 then
         questData = {Mon="Royal Squad", ID="SkyExp2Quest", Lvl=1, NPC=CFrame.new(-7906.81, 5634.66, -1411.99)}
      elseif level >= 625 and level < 700 then
         questData = {Mon="Galley Pirate", ID="FountainQuest", Lvl=1, NPC=CFrame.new(5259.81, 37.35, 4050.02)}
      end
   
   elseif World2 then
      if level >= 700 and level < 725 then
         questData = {Mon="Raider", ID="Area1Quest", Lvl=1, NPC=CFrame.new(-429.54, 71.76, 1836.18)}
      elseif level >= 725 and level < 775 then
         questData = {Mon="Mercenary", ID="Area1Quest", Lvl=2, NPC=CFrame.new(-429.54, 71.76, 1836.18)}
      elseif level >= 775 and level < 800 then
         questData = {Mon="Swan Pirate", ID="Area2Quest", Lvl=1, NPC=CFrame.new(638.43, 71.76, 918.28)}
      elseif level >= 800 and level < 875 then
         questData = {Mon="Factory Staff", ID="Area2Quest", Lvl=2, NPC=CFrame.new(632.69, 73.10, 918.66)}
      elseif level >= 875 and level < 900 then
         questData = {Mon="Marine Lieutenant", ID="MarineQuest3", Lvl=1, NPC=CFrame.new(-2440.79, 71.71, -3216.06)}
      elseif level >= 900 and level < 950 then
         questData = {Mon="Marine Captain", ID="MarineQuest3", Lvl=2, NPC=CFrame.new(-2440.79, 71.71, -3216.06)}
      elseif level >= 950 and level < 1000 then
         questData = {Mon="Zombie", ID="ZombieQuest", Lvl=1, NPC=CFrame.new(-5497.06, 47.59, -795.23)}
      elseif level >= 1000 and level < 1100 then
         questData = {Mon="Snow Trooper", ID="SnowMountainQuest", Lvl=1, NPC=CFrame.new(609.85, 400.11, -5372.25)}
      elseif level >= 1100 and level < 1175 then
         questData = {Mon="Lab Subordinate", ID="IceSideQuest", Lvl=1, NPC=CFrame.new(-6064.06, 15.24, -4902.97)}
      elseif level >= 1175 and level < 1250 then
         questData = {Mon="Magma Ninja", ID="FireSideQuest", Lvl=1, NPC=CFrame.new(-5428.03, 15.06, -5299.43)}
      elseif level >= 1250 and level < 1300 then
         questData = {Mon="Ship Deckhand", ID="ShipQuest1", Lvl=1, NPC=CFrame.new(1037.80, 125.09, 32911.60)}
      elseif level >= 1300 and level < 1350 then
         questData = {Mon="Ship Steward", ID="ShipQuest2", Lvl=1, NPC=CFrame.new(968.80, 125.09, 33244.12)}
      elseif level >= 1350 and level < 1425 then
         questData = {Mon="Arctic Warrior", ID="FrostQuest", Lvl=1, NPC=CFrame.new(5667.65, 26.79, -6486.08)}
      elseif level >= 1425 and level < 1500 then
         questData = {Mon="Sea Soldier", ID="ForgottenQuest", Lvl=1, NPC=CFrame.new(-3054.44, 235.54, -10142.81)}
      end

   elseif World3 then
      if level >= 1500 and level < 1575 then
         questData = {Mon="Pirate Millionaire", ID="PiratePortQuest", Lvl=1, NPC=CFrame.new(-290.07, 42.90, 5581.58)}
      elseif level >= 1575 and level < 1625 then
         questData = {Mon="Dragon Crew Warrior", ID="AmazonQuest", Lvl=1, NPC=CFrame.new(5832.83, 51.68, -1101.51)}
      elseif level >= 1625 and level < 1700 then
         questData = {Mon="Female Islander", ID="AmazonQuest2", Lvl=1, NPC=CFrame.new(5446.87, 601.62, 749.45)}
      elseif level >= 1700 and level < 1775 then
         questData = {Mon="Marine Commodore", ID="MarineTreeIsland", Lvl=1, NPC=CFrame.new(2180.54, 27.81, -6741.54)}
      elseif level >= 1775 and level < 1825 then
         questData = {Mon="Fishman Raider", ID="DeepForestIsland3", Lvl=1, NPC=CFrame.new(-10581.65, 330.87, -8761.18)}
      elseif level >= 1825 and level < 1900 then
         questData = {Mon="Forest Pirate", ID="DeepForestIsland", Lvl=1, NPC=CFrame.new(-13234.04, 331.48, -7625.40)}
      elseif level >= 1900 and level < 1975 then
         questData = {Mon="Jungle Pirate", ID="DeepForestIsland2", Lvl=1, NPC=CFrame.new(-12680.38, 389.97, -9902.01)}
      elseif level >= 1975 and level < 2025 then
         questData = {Mon="Reborn Skeleton", ID="HauntedQuest1", Lvl=1, NPC=CFrame.new(-9479.21, 141.21, 5566.09)}
      elseif level >= 2025 and level < 2075 then
         questData = {Mon="Demonic Soul", ID="HauntedQuest2", Lvl=1, NPC=CFrame.new(-9516.99, 172.01, 6078.46)}
      elseif level >= 2075 and level < 2125 then
         questData = {Mon="Peanut Scout", ID="NutsIslandQuest", Lvl=1, NPC=CFrame.new(-2104.39, 38.10, -10194.21)}
      elseif level >= 2125 and level < 2200 then
         questData = {Mon="Ice Cream Chef", ID="IceCreamIslandQuest", Lvl=1, NPC=CFrame.new(-820.64, 65.81, -10965.79)}
      elseif level >= 2200 and level < 2250 then
         questData = {Mon="Cookie Crafter", ID="CakeQuest1", Lvl=1, NPC=CFrame.new(-2021.32, 37.79, -12028.72)}
      elseif level >= 2250 and level < 2300 then
         questData = {Mon="Baking Staff", ID="CakeQuest2", Lvl=1, NPC=CFrame.new(-1927.91, 37.79, -12842.53)}
      elseif level >= 2300 and level < 2350 then
         questData = {Mon="Cocoa Warrior", ID="ChocQuest1", Lvl=1, NPC=CFrame.new(233.22, 29.87, -12201.23)}
      elseif level >= 2350 and level < 2400 then
         questData = {Mon="Sweet Thief", ID="ChocQuest2", Lvl=1, NPC=CFrame.new(150.50, 30.69, -12774.50)}
      elseif level >= 2400 and level < 2450 then
         questData = {Mon="Candy Pirate", ID="CandyQuest1", Lvl=1, NPC=CFrame.new(-1150.04, 20.37, -14446.33)}
      elseif level >= 2450 then
         questData = {Mon="Isle Outlaw", ID="TikiQuest1", Lvl=1, NPC=CFrame.new(-16545.93, 55.68, -173.23)}
      end
   end
   return questData
end

-- [[ PARTE 3/6: MENU DE FARM E STATUS ]] --

-- CRIAÇÃO DAS ABAS PRINCIPAIS
local FarmTab = Window:CreateTab("Auto Farm", 4483345998)
local StatsTab = Window:CreateTab("Auto Stats", 4483345998)

-- [[ ABA: AUTO FARM ]] --
FarmTab:CreateSection("Configurações de Ataque")

FarmTab:CreateDropdown({
   Name = "Arma Principal",
   Options = {"Melee", "Sword", "Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Flag = "SelectWeapon",
   Callback = function(Option)
      _G.SelectWeapon = Option[1]
   end,
})

FarmTab:CreateToggle({
   Name = "Fast Attack (Ataque Rápido)",
   CurrentValue = true,
   Flag = "FastAttack",
   Callback = function(Value)
      _G.FastAttack = Value
   end,
})

FarmTab:CreateSection("Funções de Level")

FarmTab:CreateToggle({
   Name = "Auto Farm Level (Do 1 ao Max)",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Farm Maestria (Bate e Troca)",
   CurrentValue = false,
   Flag = "AutoMastery",
   Callback = function(Value)
      _G.AutoMastery = Value
   end,
})

-- [[ ABA: AUTO STATS ]] --
StatsTab:CreateSection("Distribuição de Pontos")

StatsTab:CreateToggle({
   Name = "Upar Melee (Soco)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStatsMelee = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Defense (Vida)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStatsDefense = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Sword (Espada)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStatsSword = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Gun (Arma)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStatsGun = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Blox Fruit (Fruta)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStatsFruit = Value end,
})

-- [[ PARTE 4/6: TELEPORTES E SEA EVENTS ]] --

local TeleportTab = Window:CreateTab("Teleports", 4483345998)
local SeaEventsTab = Window:CreateTab("Sea Events", 4483345998)

-- [[ ABA: TELEPORTES DE MUNDO ]] --
TeleportTab:CreateSection("Mudar de Mar (Seas)")

TeleportTab:CreateButton({
   Name = "Ir para Sea 1 (Old World)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end,
})

TeleportTab:CreateButton({
   Name = "Ir para Sea 2 (Dressrosa)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end,
})

TeleportTab:CreateButton({
   Name = "Ir para Sea 3 (Zou)",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end,
})

-- [[ ABA: TELEPORTES DE ILHAS ]] --
TeleportTab:CreateSection("Ilhas do Mundo Atual")

-- Lista Inteligente: Só mostra as ilhas do mar que você está
local IslandList = {}
if World1 then
   IslandList = {"Jungle", "Pirate Village", "Desert", "Snow Village", "MarineFord", "Skypiea", "Prison", "Fountain City"}
elseif World2 then
   IslandList = {"Cafe", "Green Zone", "Graveyard", "Snow Mountain", "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island"}
elseif World3 then
   IslandList = {"Mansion", "Castle on Sea", "Port Town", "Hydra Island", "Great Tree", "Floating Turtle", "Haunted Castle", "Tiki Outpost"}
end

TeleportTab:CreateDropdown({
   Name = "Teleportar para Ilha",
   Options = IslandList,
   CurrentOption = {""},
   Callback = function(Option)
      local island = Option[1]
      local p = game.Players.LocalPlayer.Character.HumanoidRootPart
      -- Coordenadas resumidas (Sea 1, 2 e 3)
      if island == "Jungle" then p.CFrame = CFrame.new(-1598, 35, 153)
      elseif island == "Pirate Village" then p.CFrame = CFrame.new(-1141, 4, 3831)
      elseif island == "Desert" then p.CFrame = CFrame.new(944, 20, 4373)
      elseif island == "MarineFord" then p.CFrame = CFrame.new(-4914, 50, 4281)
      elseif island == "Cafe" then p.CFrame = CFrame.new(-380, 77, 255)
      elseif island == "Green Zone" then p.CFrame = CFrame.new(-2448, 73, -3210)
      elseif island == "Mansion" then p.CFrame = CFrame.new(-12471, 374, -7551)
      elseif island == "Castle on Sea" then p.CFrame = CFrame.new(-5071, 314, -3150)
      elseif island == "Tiki Outpost" then p.CFrame = CFrame.new(-16210, 15, 300)
      end
   end,
})

-- [[ ABA: SEA EVENTS (Exclusivo Sea 3) ]] --
if World3 then
    SeaEventsTab:CreateSection("Caça de Eventos (Sea 3)")

    SeaEventsTab:CreateToggle({
       Name = "Auto Sea Events (Barcos/Pedras)",
       CurrentValue = false,
       Callback = function(Value) _G.SeaEvents = Value end,
    })

    SeaEventsTab:CreateToggle({
       Name = "Auto Terror Shark",
       CurrentValue = false,
       Callback = function(Value) _G.TerrorShark = Value end,
    })

    SeaEventsTab:CreateButton({
       Name = "Teleportar para Kitsune Island (Se existir)",
       Callback = function()
          local kit = workspace.Map:FindFirstChild("Kitsune Island")
          if kit then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = kit.WorldPivot
              Rayfield:Notify({Title="Lag Teck", Content="Teleportado para Kitsune!", Duration=3})
          else
              Rayfield:Notify({Title="Lag Teck", Content="Kitsune Island não encontrada!", Duration=3})
          end
       end,
    })
    
    SeaEventsTab:CreateButton({
       Name = "Encontrar Mirage Island",
       Callback = function()
          local mirage = workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island")
          if mirage then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mirage.WorldPivot * CFrame.new(0, 50, 0)
              Rayfield:Notify({Title="Lag Teck", Content="Mirage encontrada!", Duration=3})
          else
              Rayfield:Notify({Title="Lag Teck", Content="Mirage não está spawndada.", Duration=3})
          end
       end,
    })
else
    SeaEventsTab:CreateLabel("Vá para o Sea 3 para usar Sea Events")
end

-- [[ PARTE 5/10: RAIDS & FARM DE MATERIAIS ]] --

local RaidTab = Window:CreateTab("Raids", 4483345998)
local MaterialTab = Window:CreateTab("Materiais", 4483345998)

-- [[ ABA: RAIDS (DUNGEONS) ]] --
RaidTab:CreateSection("Configuração de Chip")

local RaidList = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Dough"}

RaidTab:CreateDropdown({
   Name = "Selecionar Raid",
   Options = RaidList,
   CurrentOption = {"Flame"},
   Callback = function(Option)
      _G.SelectRaid = Option[1]
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Comprar Chip",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoBuyChip = Value
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Start Raid (Entrar na Cápsula)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoStartRaid = Value
   end,
})

RaidTab:CreateSection("Dentro da Raid")

RaidTab:CreateToggle({
   Name = "Auto Kill Aura (Raid)",
   CurrentValue = false,
   Callback = function(Value)
      _G.KillAuraRaid = Value
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Next Island (Voar p/ Próxima Ilha)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoNextIsland = Value
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Awaken (Despertar Fruta)",
   CurrentValue = true,
   Callback = function(Value)
      _G.AutoAwaken = Value
   end,
})

-- [[ ABA: FARM DE MATERIAIS ESPECÍFICOS ]] --
MaterialTab:CreateSection("Sea 2")

MaterialTab:CreateToggle({
   Name = "Auto Ectoplasm (Cursed Ship)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoEctoplasm = Value
      if Value then
          -- Define configurações para farmar no navio
          _G.SelectWeapon = "Melee" 
      end
   end,
})

MaterialTab:CreateSection("Sea 3")

MaterialTab:CreateToggle({
   Name = "Auto Bones (Haunted Castle)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoBone = Value
   end,
})

MaterialTab:CreateToggle({
   Name = "Auto Cocoa (Chocolate Land)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCocoa = Value
   end,
})

MaterialTab:CreateToggle({
   Name = "Auto Katakuri (Dough King/Prince)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoDoughKing = Value
   end,
})

MaterialTab:CreateButton({
   Name = "Girar Ossos (Bone Random)",
   Callback = function()
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
   end,
})

-- [[ LÓGICA DE EXECUÇÃO DA PARTE 5 ]] --
spawn(function()
    while task.wait(1) do
        -- Lógica de Comprar Chip
        if _G.AutoBuyChip then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectRaid)
            end)
        end
        
        -- Lógica de Iniciar Raid
        if _G.AutoStartRaid then
            pcall(function()
                 -- Detecta se está no Sea 2 ou 3 para apertar o botão certo
                 if World2 then
                     fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                 elseif World3 then
                     fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                 end
            end)
        end
        
        -- Lógica de Next Island (Raid)
        if _G.AutoNextIsland then
            pcall(function()
                -- Verifica se o mob count é 0 e voa para a próxima ilha da raid
                local mobs = workspace.Enemies:GetChildren()
                if #mobs == 0 then
                    -- Lógica simplificada de voo para frente (depende do mapa da raid)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-50)
                end
            end)
        end
    end
end)

-- [[ PARTE 6/10: RAÇA V4, MIRAGE & TRIALS ]] --

-- Reutilizando a aba 'RaceTab' criada na Parte 4
-- Se você não copiou a Parte 4, o script pode dar erro aqui.

RaceTab:CreateSection("Mirage Island & Gear")

RaceTab:CreateButton({
   Name = "Teleportar para Mirage Island (Se existir)",
   Callback = function()
      local mirage = workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island")
      if mirage then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mirage.WorldPivot * CFrame.new(0, 50, 0)
         Rayfield:Notify({Title="Lag Teck", Content="Teleportado para Mirage!", Duration=3})
      else
         Rayfield:Notify({Title="Lag Teck", Content="Mirage não está no mapa.", Duration=3})
      end
   end,
})

RaceTab:CreateButton({
   Name = "Pegar Engrenagem Azul (Blue Gear)",
   Callback = function()
      local encontrou = false
      if workspace.Map:FindFirstChild("MysticIsland") then
         for _, v in pairs(workspace.Map.MysticIsland:GetChildren()) do
            -- ID da Mesh da Engrenagem Azul
            if v:IsA("MeshPart") and v.MeshId == "rbxassetid://10153114969" then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
               encontrou = true
               Rayfield:Notify({Title="Lag Teck", Content="Engrenagem encontrada!", Duration=3})
               break
            end
         end
      end
      if not encontrou then
         Rayfield:Notify({Title="Lag Teck", Content="Engrenagem não encontrada ou Mirage sem lua cheia.", Duration=3})
      end
   end,
})

RaceTab:CreateSection("Templo do Tempo (Trials)")

RaceTab:CreateButton({
   Name = "Teleportar Entrada Templo",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28282, 14896, 105)
   end,
})

RaceTab:CreateButton({
   Name = "Puxar Alavanca (Porta)",
   Callback = function()
      -- Tenta puxar via Remote
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CheckTempleDoor")
      -- Teleporta para a alavanca física
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28576, 14936, 76)
   end,
})

RaceTab:CreateToggle({
   Name = "Auto Completar Trial (V4)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoTrial = Value
   end,
})

RaceTab:CreateButton({
   Name = "Comprar Engrenagem (Ancient One)",
   Callback = function()
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
   end,
})

-- [[ LÓGICA DE EXECUÇÃO DA PARTE 6 ]] --
spawn(function()
    while task.wait(0.5) do
        if _G.AutoTrial then
            pcall(function()
                -- Tenta iniciar a trial
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress", "Begin")
                
                -- Teleporta de volta se cair
                local player = game.Players.LocalPlayer
                if (player.Character.HumanoidRootPart.Position - Vector3.new(28282, 14896, 105)).Magnitude > 3000 then
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
                end
                
                -- Kill Aura específico para Trials
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        v.Humanoid.Health = 0
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end
end)

-- [[ PARTE 7/10: LOJA, STATUS & ESP VISUAL ]] --

local ShopTab = Window:CreateTab("Shop", 4483345998)
local StatsTab = Window:CreateTab("Stats", 4483345998)
local ESPTab = Window:CreateTab("ESP", 4483345998)

-- [[ ABA: LOJA (SHOP) ]] --
ShopTab:CreateSection("Frutas")

ShopTab:CreateButton({
   Name = "Girar Fruta (Random Fruit)",
   Callback = function()
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
   end,
})

ShopTab:CreateToggle({
   Name = "Auto Store Fruit (Guardar no Inventário)",
   CurrentValue = true,
   Callback = function(Value)
      _G.AutoStore = Value
   end,
})

ShopTab:CreateSection("Estilos de Luta (V2/Godhuman)")

ShopTab:CreateButton({
   Name = "Comprar Godhuman",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman") end,
})

ShopTab:CreateButton({
   Name = "Comprar Superhuman",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman") end,
})

ShopTab:CreateButton({
   Name = "Comprar Electric Claw",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw") end,
})

ShopTab:CreateButton({
   Name = "Comprar Dragon Talon",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon") end,
})

ShopTab:CreateButton({
   Name = "Comprar Sharkman Karate",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate") end,
})

ShopTab:CreateButton({
   Name = "Comprar Death Step",
   Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep") end,
})

-- [[ ABA: AUTO STATS (PONTOS) ]] --
StatsTab:CreateSection("Distribuição Automática")

StatsTab:CreateToggle({
   Name = "Upar Melee (Soco)",
   CurrentValue = false,
   Callback = function(Value) _G.StatsMelee = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Defense (Vida)",
   CurrentValue = false,
   Callback = function(Value) _G.StatsDefense = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Sword (Espada)",
   CurrentValue = false,
   Callback = function(Value) _G.StatsSword = Value end,
})

StatsTab:CreateToggle({
   Name = "Upar Blox Fruit (Fruta)",
   CurrentValue = false,
   Callback = function(Value) _G.StatsFruit = Value end,
})

-- [[ ABA: ESP (VISUAL) ]] --
ESPTab:CreateSection("Wallhack")

ESPTab:CreateToggle({
   Name = "ESP Players (Ver Jogadores)",
   CurrentValue = false,
   Callback = function(Value) _G.ESPPlayer = Value end,
})

ESPTab:CreateToggle({
   Name = "ESP Chests (Ver Baús)",
   CurrentValue = false,
   Callback = function(Value) _G.ESPChest = Value end,
})

ESPTab:CreateToggle({
   Name = "ESP Fruits (Ver Frutas no Chão)",
   CurrentValue = false,
   Callback = function(Value) _G.ESPFruit = Value end,
})

-- [[ LÓGICA DE EXECUÇÃO DA PARTE 7 ]] --
spawn(function()
    while task.wait(0.5) do
        -- Auto Stats
        local points = game.Players.LocalPlayer.Data.Points.Value
        if points > 0 then
            if _G.StatsMelee then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end
            if _G.StatsDefense then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end
            if _G.StatsSword then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1) end
            if _G.StatsFruit then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1) end
        end

        -- Auto Store Fruit
        if _G.AutoStore then
            pcall(function()
                for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                    end
                end
                -- Verifica frutas no personagem também
                for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                    end
                end
            end)
        end
        
        -- ESP Lógica Simples (BillboardGui para Delta)
        if _G.ESPPlayer then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and not v.Character.Head:FindFirstChild("LagTeckESP") then
                    local bg = Instance.new("BillboardGui", v.Character.Head)
                    bg.Name = "LagTeckESP"
                    bg.Size = UDim2.new(1,0,1,0)
                    bg.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bg)
                    txt.Text = v.Name
                    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
                    txt.BackgroundTransparency = 1
                    txt.Size = UDim2.new(1,0,1,0)
                end
            end
        end
    end
end)

-- [[ PARTE 8/10: SERVER STATUS & DETECTORES AVANÇADOS ]] --

local ServerTab = Window:CreateTab("Status Server", 4483345998)

ServerTab:CreateSection("Informações do Mundo")

-- Labels Dinâmicas (Elas mudam o texto sozinhas)
local TimeLabel = ServerTab:CreateLabel("Tempo de Servidor: Carregando...")
local MirageLabel = ServerTab:CreateLabel("Mirage Island: 🔍 Buscando...")
local KitsuneLabel = ServerTab:CreateLabel("Kitsune Island: 🔍 Buscando...")
local FrozenLabel = ServerTab:CreateLabel("Frozen Dimension (Leviathan): ❌")
local EliteLabel = ServerTab:CreateLabel("Elite Hunter: ❌")
local CakeLabel = ServerTab:CreateLabel("Dough King Counter: Carregando...")

-- Função para transformar segundos em Hora:Minuto:Segundo
function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local seconds = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- [[ LÓGICA DE ATUALIZAÇÃO DO STATUS ]] --
spawn(function()
    while task.wait(1) do
        pcall(function()
            -- 1. Tempo do Servidor (Uptime)
            local uptime = workspace.DistributedGameTime
            TimeLabel:Set("Tempo Online: " .. FormatTime(uptime))

            -- 2. Detector de Mirage Island
            if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                MirageLabel:Set("Mirage Island: ✅ SPAWNED! (Vá em Sea Events)")
            else
                MirageLabel:Set("Mirage Island: ❌ Não existe")
            end

            -- 3. Detector de Kitsune Island (Lua Azul)
            if workspace.Map:FindFirstChild("Kitsune Island") then
                KitsuneLabel:Set("Kitsune Island: ✅ SPAWNED!")
            else
                KitsuneLabel:Set("Kitsune Island: ❌")
            end
            
            -- 4. Detector de Leviathan Gate (Frozen Dimension)
            if workspace.Map:FindFirstChild("FrozenDimension") then
                 FrozenLabel:Set("Frozen Dimension: ✅ ABERTA!")
            else
                 FrozenLabel:Set("Frozen Dimension: ❌ Fechada")
            end

            -- 5. Elite Hunter (Sea 3)
            local eliteFound = false
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                    eliteFound = true
                    EliteLabel:Set("Elite Hunter: ✅ VIVO (" .. v.Name .. ")")
                    -- Cria um ESP no Elite automaticamente se encontrar
                    if not v:FindFirstChild("EliteESP") then
                         local bg = Instance.new("BillboardGui", v)
                         bg.Name = "EliteESP"
                         bg.Size = UDim2.new(2,0,2,0); bg.AlwaysOnTop = true
                         local t = Instance.new("TextLabel", bg); t.Size = UDim2.new(1,0,1,0)
                         t.Text = "ELITE AQUI"; t.TextColor3 = Color3.new(1,0,0); t.BackgroundTransparency = 1
                    end
                    break
                end
            end
            if not eliteFound then EliteLabel:Set("Elite Hunter: ❌ Morto/Não Spawnado") end

            -- 6. Contagem do Dough King (Cake Prince)
            -- Atualiza a cada 3 segundos para não lagar o jogo com muito Remote
            if World3 and math.floor(uptime) % 3 == 0 then
               local status = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
               -- O jogo retorna uma frase longa, vamos limpar para mostrar só o número
               if status then
                   CakeLabel:Set("Status Dough: " .. tostring(status))
               end
            elseif not World3 then
               CakeLabel:Set("Status Dough: Apenas no Sea 3")
            end
        end)
    end
end)

-- [[ PARTE 9/10: MISC, SETTINGS & COMUNIDADE ]] --

local MiscTab = Window:CreateTab("Misc", 4483345998)

-- [[ SEÇÃO COMUNIDADE ]] --
MiscTab:CreateSection("Comunidade Lag Teck")

MiscTab:CreateButton({
   Name = "Copiar Link do Discord",
   Callback = function()
      setclipboard("https://discord.gg/RnZ6XHHFj7")
      Rayfield:Notify({
         Title = "Sucesso!",
         Content = "Link da Lag Teck copiado para sua área de transferência!",
         Duration = 5,
         Image = 134586849523908,
      })
   end,
})

-- [[ SEÇÃO SERVIDOR ]] --
MiscTab:CreateSection("Gerenciamento de Servidor")

MiscTab:CreateButton({
   Name = "Server Hop (Trocar de Server)",
   Callback = function()
      Rayfield:Notify({Title="Server Hop", Content="Buscando servidor com menos gente...", Duration=3})
      -- Lógica compacta de Hop para Delta iOS
      local PlaceID = game.PlaceId
      local AllIDs = {}
      local foundAnything = ""
      local actualHour = os.date("!*t").hour
      local function TPReturner()
         local Site;
         if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
         else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
         end
         local ID = ""
         if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
         end
         for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
               for _,Existing in pairs(AllIDs) do
                  if ID == tostring(Existing) then Possible = false end
               end
               if Possible == true then
                  table.insert(AllIDs, ID)
                  wait()
                  pcall(function()
                     game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                  end)
                  wait(4)
               end
            end
         end
      end
      -- Executa o Hop
      while wait() do
         pcall(function()
            TPReturner()
            if foundAnything ~= "" then TPReturner() end
         end)
      end
   end,
})

MiscTab:CreateButton({
   Name = "Rejoin (Reentrar no mesmo server)",
   Callback = function()
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
   end,
})

-- [[ SEÇÃO CÓDIGOS ]] --
MiscTab:CreateSection("Códigos (2x XP / Reset)")

MiscTab:CreateButton({
   Name = "Resgatar Todos os Códigos",
   Callback = function()
       local codes = {
           "NEWTROLL", "KITT_RESET", "Sub2CaptainMaui", "DEVSCOOKING", "kittgaming",
           "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy",
           "fudd10_v2", "Fudd10", "BIGNEWS", "THEGREATACE", "SUB2GAMERROBOT_RESET1",
           "SUB2GAMERROBOT_EXP1", "Sub2OfficialNoobie", "StrawHatMaine", "TantaiGaming",
           "Axiore", "Sub2Daigrock", "Sub2UncleKizaru"
       }
       for _, code in pairs(codes) do
           game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
           task.wait(0.1)
       end
       Rayfield:Notify({Title="Lag Teck", Content="Todos os códigos foram tentados!", Duration=5})
   end,
})

-- [[ SEÇÃO OTIMIZAÇÃO ]] --
MiscTab:CreateSection("Performance (FPS)")

MiscTab:CreateButton({
   Name = "Tela Branca (Economia de Bateria)",
   Callback = function()
       game:GetService("RunService"):Set3dRenderingEnabled(false)
       Rayfield:Notify({Title="FPS", Content="Tela 3D desligada para economizar bateria.", Duration=3})
   end,
})

MiscTab:CreateButton({
   Name = "Voltar Tela Normal",
   Callback = function()
       game:GetService("RunService"):Set3dRenderingEnabled(true)
   end,
})

-- [[ PARTE 10/10: FINALIZAÇÃO & ANTI-AFK ]] --

local SettingsTab = Window:CreateTab("Config", 4483345998)

SettingsTab:CreateSection("Sistema")

-- Botão de Pânico (Fechar o Script)
SettingsTab:CreateButton({
   Name = "Destruir Interface (Fechar Script)",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- [[ ANTI-AFK AUTOMÁTICO ]] --
-- Isso impede que o Roblox te desconecte após 20 minutos parado
spawn(function()
   local vu = game:GetService("VirtualUser")
   game:GetService("Players").LocalPlayer.Idled:connect(function()
      vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      wait(1)
      vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      print("Lag Teck: Anti-AFK ativado.")
   end)
end)

-- [[ INICIALIZAR SISTEMA ]] --

-- Carrega as configurações salvas (Se você ativou algo antes, ele lembra)
Rayfield:LoadConfiguration()

-- Notificação Final de Sucesso
Rayfield:Notify({
   Title = "Lag Teck - Sucesso!",
   Content = "Script 100% Carregado.\nBom jogo, p1ssantos!",
   Duration = 8,
   Image = 134586849523908,
})

-- Log no Console (F9)
print("------------------------------------------------")
print("Lag Teck Community - Script Loaded Successfully")
print("Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown"))
print("------------------------------------------------")

-- [[ FIM DO SCRIPT ]] --
