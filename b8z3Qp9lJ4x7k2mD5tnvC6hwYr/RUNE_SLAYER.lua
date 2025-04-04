-- // Rune Slayer Progress // -- 
rune_fun = {};
rune_config = {};

-- // Error Handling - Debug Purposes
err_codes = {
    [100] = "Variable Issue",
    [101] = "Game Variable Changed",
    [102] = "Function Issue",
    [103] = "Detection AntiCheat",
};

function format_error(err)
    if type(err) == "table" then
        local msg = err_codes[err.code] or "Unknown Error";
        return string.format("Error Code: %d | Message: %s", err.code, msg);
    end;
    return "Runtime Error: " .. tostring(err);
end;

function safe_execute(func, ...)
    local status, result = xpcall(func, format_error, ...);
    if (not status) then
        print("Error: " .. result);
    end;
    return status, result;
end; 

-- safe_execute(...)

rune_fun.Entry = function(check)
    check = check or false;
    if not game:IsLoaded() then
        print("Waiting for the game to load..");
        repeat task.wait(math.clamp(1,2,5)) until game:IsLoaded() or check;
    end;
    print("Game loaded successfully!");
    return check;
end;
rune_fun.Entry(true)

rune_fun.GetUser = function(userid, username, accountage)
    if not Char then repeat task.wait(math.random()) until LclPlr.Character Char = LclPlr.Character or Char return; end;

    if Char and LclPlr then 
        userid = LclPlr.UserId;
        username = LclPlr.Name;
        accountage = LclPlr.AccountAge;
        return userid, username, accountage
    else 
        print(type(Char), type(LclPlr))
    end;
end;

rune_fun.GetGame = function()
    local m_service = game:GetService("MarketplaceService");
    local succ, m_info = pcall(m_service.GetProductInfo, m_service, game.PlaceId);
    return succ and m_info.Name or "Couldnt get GameValues"
end;

rune_fun.GetApples = function()
    local apples = {};
    for _, v in pairs(Harvestable:GetChildren()) do 
        if v:IsA("MeshPart") and v.Name == "Apple" then 
            table.insert(apples, v)
        end;
    end;
    return apples;
end;

rune_fun.GetEggs = function()
    local eggs = {};
    for _, v in pairs(Effects:GetChildren()) do 
        if v.Name == "Egg" and v:FindFirstChild("Handle") then 
            table.insert(eggs, v)
        end;
    end;
    return eggs;
end;

rune_fun.GetTrees = function()
    local trees = {}
    for _, v in pairs(Harvestable:GetChildren()) do 
        if v:IsA("Model") then
            if v:FindFirstChildOfClass("MeshPart") then table.insert(trees, v)
            end;
        end;
    end;
    return trees;
end;

-- // WalkSpeed Variables cba
WalkSpeedValue = 16; WalkSpeedEnabled = false; MoveDirection = Vector3.zero; local WalkSpeedConnection;

rune_fun.WalkSpeed = function(enabled)
    WalkSpeedEnabled = enabled;

    if WalkSpeedConnection then
        WalkSpeedConnection:Disconnect();
        WalkSpeedConnection = nil;
    end;

    if not WalkSpeedEnabled then return; end;

    local function updateDirection()
        local character = LclPlr.Character;
        if not character or not character:FindFirstChild("HumanoidRootPart") then return; end;

        local camera = workspace.CurrentCamera;
        local moveVector = Vector3.zero;

        if Uis:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + camera.CFrame.LookVector;
        end;
        if Uis:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - camera.CFrame.LookVector;
        end;
        if Uis:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - camera.CFrame.RightVector;
        end;
        if Uis:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + camera.CFrame.RightVector;
        end;
        MoveDirection = Vector3.new(moveVector.X, 0, moveVector.Z).Unit;
    end;

    local function teleportWalk()
        local character = LclPlr.Character;
        if not character or not character:FindFirstChild("HumanoidRootPart") then return; end;

        local hrp = character.HumanoidRootPart;
        if MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (MoveDirection * (WalkSpeedValue / 100))
        end;
    end;

    WalkSpeedConnection = Run.Heartbeat:Connect(function()
        if WalkSpeedEnabled then
            updateDirection()
            teleportWalk()
        end;
    end)
end;

rune_fun.AutoLoad = function()
    if identifyexecutor() then
        pcall(function()
            task.defer(function()
                print("in queue..");
                queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG/vVoZlsyDgeOvBT90QbnXoFDQ/refs/heads/main/b8z3Qp9lJ4x7k2mD5tnvC6hwYr/RUNE_SLAYER.lua"))()]])
            end);
        end);
    else
        print("Something went wrong, AutoLoad Issue", type(queue_on_teleport))
    end;
end;

rune_fun.GetWeapon = function()
    local weaponFolder = LclPlr:FindFirstChild("Backpack") and LclPlr.Backpack:FindFirstChild("Weapon");

    if (not weaponFolder) then 
        print("couldnt find checked path?")
        return; 
    end;

    for _, v in pairs(weaponFolder:GetChildren()) do
        if v:IsA("Folder") then
            return v;
        end;
    end;
    return nil;
end;

rune_fun.GetMobs = function()
    local mobs = {};
    local uniqueMobTypes = {};
    local mobFolder = Alive;
    local dist, mob = math.huge;

    if not mobFolder then 
        print("Mob folder not found?");
        return {};
    end;

    for _, v in pairs(mobFolder:GetChildren()) do
        if v:IsA("Model") and not v:FindFirstChild("ComboCount") then
            local rootPart = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart");
            if rootPart then
                local mobType = v.Name:match("^(%a+)");
                if mobType and not uniqueMobTypes[mobType] then
                    uniqueMobTypes[mobType] = true;
                    table.insert(mobs, mobType);
                end;
            end;
        end;
    end;
    return mobs; 
end;

rune_fun.GetUsedStorage_Slots = function()
    local Storage = PlayerGui.BankGui.MainFrame.Slots.ScrollingFrame
    local usedSlots = {};

    for _, slot in pairs(Storage:GetChildren()) do
        if slot:IsA("ImageLabel") and slot:FindFirstChild("ToolFrame") then 
            table.insert(usedSlots, slot.Name);
            print("Used slot:", slot.Name)
        end;
    end;
    return usedSlots;
end;

rune_fun.GetInventory = function()
    local Backpack = LclPlr.Backpack
    local items = {};

    for _, tool in pairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local itemName = tool.Name

            if not items[itemName] then
                items[itemName] = {
                    Name = itemName,
                    Quantity = 1,
                    Tool = tool 
                }
            else
                items[itemName].Quantity = items[itemName].Quantity + 1
            end;
        end;
    end;
    return items;
end;

rune_fun.FindEmptySlot = function()
    local StorageUI = {
        [1] = {
            ["player"] = LclPlr,
            ["Object"] = workspace:WaitForChild("Effects"):WaitForChild("NPCS"):WaitForChild("Banker"),
            ["Action"] = "Storage"
        }}
        game:GetService("Players").LocalPlayer.Character.CharacterHandler.Input.Events.Interact:FireServer(unpack(StorageUI))
        task.wait(.1);

        local usedSlots = rune_fun.GetUsedStorage_Slots();

        for i = 1, 50 do
            if not table.find(usedSlots, tostring(i)) then
                return tostring(i);
            end;
        end;
    return nil;
end;

local SelectedFoods = {}; -- // nil cuz none selected
rune_fun.GetFood_Items = function()
    local inv = rune_fun.GetInventory();
    local foodItems = {};

    for _, i in pairs(inv) do 
        if i.Name and i.Quantity then 
            table.insert(foodItems, i.Name)
        end;
    end;
    return foodItems;
end;

rune_fun.currentTween = nil
rune_fun.Tween = function(targetCFrame, speed)
    if not Hrp then 
        print("Hrp not found", type(Hrp));
        return;
    end;

    if typeof(targetCFrame) ~= "CFrame" then 
        print("Invalid target CFrame:", targetCFrame);
        return;
    end;

    if rune_fun.currentTween and rune_fun.currentTween.PlaybackState == Enum.PlaybackState.Playing then
        rune_fun.currentTween:Cancel();
    end;

    if Hrp:FindFirstChild("BodyVelocity") then 
        Hrp.BodyVelocity:Destroy();
    end;

    local antifall = Instance.new("BodyVelocity")
    antifall.Parent = Hrp
    antifall.Velocity = Vector3.new(0, 0, 0)
    antifall.MaxForce = Vector3.new(4000, 4000, 4000)

    local function disableCollisions()
        for _, part in ipairs(Hrp.Parent:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false;
            end;
        end;
    end;

    local noclipConnection = game:GetService("RunService").Stepped:Connect(disableCollisions)

    local distance = (Hrp.Position - targetCFrame.Position).Magnitude
    local info = TweenInfo.new(
        distance / speed, 
        Enum.EasingStyle.Linear
    )

    local tween = TweenService:Create(Hrp, info, {CFrame = targetCFrame})
    rune_fun.currentTween = tween

    tween:Play()
    tween.Completed:Connect(function()
        if noclipConnection then 
            noclipConnection:Disconnect() 
        end
        if antifall then 
            antifall:Destroy();
        end;
        rune_fun.currentTween = nil;
    end)
end;

local noFogConnection;
rune_fun.NoFog = function(Check)
    Check = Check or false;
    local Lighting = game:GetService("Lighting");

    if (not Check) then
        if noFogConnection then
            noFogConnection:Disconnect();
            noFogConnection = nil;
        end;

        Lighting.FogEnd = 10000;
        local atmosphere = Lighting:FindFirstChild("Atmosphere")
        if atmosphere then
            atmosphere.Density = 0.3
        end;
        return;
    end;

    if Check and getgenv().noFog == true then
    Lighting.FogEnd = 1000000;
    local atmosphere = Lighting:FindFirstChild("Atmosphere")
    if atmosphere then
        atmosphere.Density = 0;
    end;

    noFogConnection = Run.RenderStepped:Connect(function()
        Lighting.FogEnd = 1000000;
        local atmosphere = Lighting:FindFirstChild("Atmosphere");
        if atmosphere then
            atmosphere.Density = 0;
        end;
    end)
else 
    getgenv().noFog = false;
end
end;

rune_fun.ChangeTime = function(day, night)
    local timeValue = Rs.GlobalSettings.Time;
    if day then
        timeValue.Value = "Day";
    elseif night then
        timeValue.Value = "Night";
    end;
end;

rune_fun.InstaKill = function(check)
    check = check or false;
    local Username = LclPlr.Name;

    while check and getgenv().InstaKill do task.wait();
        for _, v in pairs(Alive:GetChildren()) do
            local HC = v:FindFirstChild("HitCredit");
            if v.PrimaryPart and HC and v:IsA("Model") and isnetworkowner(v.PrimaryPart) then
                local Credit = HC:FindFirstChild(Username)
                if Credit and Credit.Value >= getgenv().InstaKillVal then
                    v.Humanoid.Health = 0
                end;
            elseif (not isnetworkowner) then 
                print("#100")
            else
                print("something went wrong")
            end;
        end;
    end;
end;

local j_con;
rune_fun.InfiniteJump = function(check)
    check = check or false;

    if not check and j_con then
        j_con:Disconnect();
        j_con = nil;
        return;
    end;

    if check then
        j_con = Run.Heartbeat:Connect(function()
            local character = LclPlr.Character
            if not character then return; end;

            local humanoid = character:FindFirstChildOfClass("Humanoid");
            local rootPart = character.PrimaryPart;

            if humanoid and rootPart and Uis:IsKeyDown(Enum.KeyCode.Space) then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end;
        end)
    end;
end;

rune_fun.NoRollCd = newcclosure(function(cCheck)
    cCheck = cCheck or false;
    local net = require(Rs.Modules.Network);
    getgenv().noRollCdActive = cCheck;

    local function remove_cd()
        while getgenv().noRollCdActive do
            if Char:FindFirstChild("RollCD") then
                Char.RollCD:Destroy();
            end;
            task.wait(0.1);
        end;
    end;

    if cCheck then
        task.spawn(remove_cd);
        local rollData = { Config = "Roll" }
        net.connect("MasterEvent", "FireServer", Char, rollData)
    else
        getgenv().noRollCdActive = false;
    end;
end);

local invisInstance;
rune_fun.Invisible = newcclosure(function(check)
    check = check or false;
    local InvisModule = require(game:GetService("ReplicatedStorage").Modules.InvisModule);
    getgenv().setInvisible = check;

    if getgenv().setInvisible and check then
        if LclPlr and LclPlr.Character or Char then
            invisInstance = InvisModule.SetInvis({
                char = Char,
                Length = nil;
            })
        end
    elseif not check and invisInstance then
        invisInstance.Stop()
        invisInstance = nil 
    end
end);

-- No fall by #Bored
local old; 
rune_fun.NoFall = newcclosure(function(Check)
    Check = Check or false;
    local Remote = LclPlr.Character.CharacterHandler.Input.Events.MasterEvent;
    if Check then
        if not old then
            old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local args = { ... }
                local method = getnamecallmethod()

                if not checkcaller() and self == Remote and method == "FireServer" then
                    if typeof(args[1]) == "table" and args[1]["Config"] == "FallDamage" then
                        return;
                    end;
                end;
                return old(self, ...)
            end))
        end;
    else
        if old then
            hookmetamethod(game, "__namecall", old)
            old = nil;
        end;
    end;
end);

local oldSt
rune_fun.NoStun = newcclosure(function(check)
    check = check or false
    local StunHandler = require(Rs.Modules.StunHandler);
    local mt = getrawmetatable(game)
    setreadonly(mt, false)

    if check then
        if not oldSt then
            oldSt = mt.__index 

            mt.__index = newcclosure(function(self, key)
                if key == "Stun" then
                    return function(...) return; end;
                end;
                return oldSt(self, key) 
            end)
        end;
    else
        if oldSt then
            mt.__index = oldSt; 
            oldSt = nil;
        end;
    end;
    setreadonly(mt, true)
end)

rune_fun.UseBedAnywhere = function()
    local bedCFrame = CFrame.new(765, 156, 469);
    local bed = workspace:WaitForChild("Map"):FindFirstChild("Bed");

    if Hrp and bed then
        Hrp.CFrame = bedCFrame;
        task.wait(.5);

        local args = {
            [1] = {
                ["player"] = LclPlr,
                ["Object"] = bed,
                ["Action"] = "Sleep"
            }
        }

        local remote = Char.CharacterHandler.Input.Events.Interact;
        remote:FireServer(unpack(args))
    else
        warn("Seems like something happened");
    end;
end;

rune_fun.TpBypass = function(Location)
    Location = Location or CFrame.new(0,0,0);

    if Hrp then
        local args = {
            [1] = {
                ["player"] = LclPlr,
                ["Object"] = workspace:WaitForChild("InvisibleParts"):WaitForChild("ColosseumEntrance"),
                ["Action"] = "Enter"
            }
        }

        LclPlr.Character.CharacterHandler.Input.Events.Interact:FireServer(unpack(args))

        task.wait(.1);
        Hrp.CFrame = Location;
    else
        warn("Hrp not found", type(Hrp));
    end;
end;

rune_fun.FairyFarm = function()
    fairyFound = false;
    local hopDelay = getgenv().hopDelay or 4;
    local autoHop = getgenv().serverHop or false;
    
    local function findFairy()
        if Alive then
            for _, v in pairs(Alive:GetChildren()) do
                if v:IsA("Model") and string.find(v.Name, "Fairy") then
                    return v:FindFirstChildWhichIsA("MeshPart") 
                end;
            end;
        end;
        
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Model") and string.find(v.Name, "Fairy") then
                return v:FindFirstChildWhichIsA("MeshPart")
            end;
        end;
        return nil;
    end;

    while getgenv().fairyFarm do
        local fairy = findFairy()
        if fairy then
            fairyFound = true
            rune_fun.TpBypass(fairy.CFrame + Vector3.new(0, 2, 0))
            task.wait(0.5) 
            Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.5)
            Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            task.wait(2)
        else
            fairyFound = false
            if autoHop then
                print("Server hopping in " .. hopDelay .. " seconds")
                task.wait(hopDelay)
                game:GetService("TeleportService"):Teleport(game.PlaceId, LclPlr)
            end;
        end;
        task.wait(1);
    end;
end;

rune_fun.CookFood = function(checked)
    checked = checked or false;

    if not LclPlr.Backpack then 
        return;
    end;

    if checked == nil then 
        safe_execute(rune_fun.CookFood());
        print("forgot to boolean");
    end;

    if checked == true then
    task.spawn(function()
        while getgenv().cookFood do task.wait() 
                if LclPlr.Backpack:FindFirstChild("Raw Deer Meat") then
                    local arguments1 = {
                        [1] = {
                            ["AmountToCraft"] = getgenv().cookAmount,
                            ["SelectedItem"] = {
                                ["Materials"] = {
                                    [1] = {
                                        ["Name"] = "Raw Deer Meat",
                                        ["Amount"] = 1
                                    }
                                },
                                ["ToolTip"] = "",
                                ["Station"] = "Cooker",
                                ["Name"] = "Cooked Deer Meat"
                            }
                        }
                    }
                    PlayerGui.CraftingGui.LocalScript.RemoteEvent:FireServer(unpack(arguments1))
                elseif LclPlr.Backpack:FindFirstChild("Raw Prime Meat") then
                    local arguments2 = {
                        [1] = {
                            ["AmountToCraft"] = getgenv().cookAmount,
                            ["SelectedItem"] = {
                                ["Materials"] = {
                                    [1] = {
                                        ["Name"] = "Raw Prime Meat",
                                        ["Amount"] = 1
                                    }
                                },
                                ["ToolTip"] = "",
                                ["Station"] = "Cooker",
                                ["Name"] = "Cooked Prime Meat"
                            }
                        }
                    }
                    PlayerGui.CraftingGui.LocalScript.RemoteEvent:FireServer(unpack(arguments2))
                elseif LclPlr.Backpack:FindFirstChild("Raw Crocodile Meat") then
                    local arguments3 = {
                        [1] = {
                            ["AmountToCraft"] = getgenv().cookAmount,
                            ["SelectedItem"] = {
                                ["Materials"] = {
                                    [1] = {
                                        ["Name"] = "Raw Crocodile Meat",
                                        ["Amount"] = 1
                                    }
                                },
                                ["ToolTip"] = "",
                                ["Station"] = "Cooker",
                                ["Name"] = "Cooked Crocodile Meat"
                            }
                        }
                    }
                    PlayerGui.CraftingGui.LocalScript.RemoteEvent:FireServer(unpack(arguments3))
                elseif LclPlr.Backpack:FindFirstChild("Raw Serpent Meat") then
                    local arguments4 = {
                        [1] = {
                            ["AmountToCraft"] = getgenv().cookAmount,
                            ["SelectedItem"] = {
                                ["Materials"] = {
                                    [1] = {
                                        ["Name"] = "Raw Serpent Meat",
                                        ["Amount"] = 1
                                    }
                                },
                                ["ToolTip"] = "",
                                ["Station"] = "Cooker",
                                ["Name"] = "Cooked Serpent Meat"
                            }
                        }
                    }
                PlayerGui.CraftingGui.LocalScript.RemoteEvent:FireServer(unpack(arguments4))
            end;
        end;
    end)
end;
end;

rune_fun.ModDetection = function(check)
    check = check or false;

    if check then 
        task.wait()
        Players.PlayerAdded:Connect(function(Plr)
            if Plr:IsInGroup(15431531) then
                LclPlr:Kick("Spotted a Mod (" .. Plr.Name .. "), " .. tostring(err_codes[100]))
            end;

        task.spawn(function()
            pcall(function()
                for _, Plr in Players:GetPlayers() do
                    if Plr:IsInGroup(15431531) then
                        LclPlr:Kick("Spotted a Mod (" .. Plr.Name .. "), " .. tostring(err_codes[100]))
                    end;
                end;
            end)
        end)
    end)
end;
end;

rune_fun.NoHeat = function(check)
    check = check or false;

    if check then 
        task.spawn(function()
             local args = {
                [1] = Rs:WaitForChild("WorldModel"):WaitForChild("Areas"):WaitForChild("Wilderness"),
                [2] = "Cloudy"
            }
            
            LclPlr:WaitForChild("AreaChangeEvent"):FireServer(unpack(args))
        end)
    end;
end;

-- // Variables 

LclPlr = game:GetService("Players").LocalPlayer;
Players = game:GetService("Players");
Char = LclPlr.Character or LclPlr.CharacterAdded:Wait();
Humanoid = Char:FindFirstChildOfClass("Humanoid");
Hrp = Char:WaitForChild("HumanoidRootPart");
GuiService = game:GetService("GuiService");
Vim = game:GetService("VirtualInputManager");
Run = game:GetService("RunService");
TweenService = game:GetService("TweenService");
Uis = game:GetService("UserInputService");
Rs = game:GetService("ReplicatedStorage");
PlayerGui = LclPlr:WaitForChild("PlayerGui") or LclPlr:FindFirstChild("PlayerGui");

local function assignHrp(newCh)
    Char = newCh;
    Hrp = Char:WaitForChild("HumanoidRootPart");
end;
LclPlr.CharacterAdded:Connect(assignHrp);

-- // Game Variables

Harvestable = workspace.Harvestable;
Effects = workspace.Effects;
Alive = workspace.Alive;

-- // UI

local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
local Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))() 
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))() 
local FileService = Setup:File();
local VIM = Setup:VirtualInputManager();
Setup:Basics()

Library.Paths.Folder = "\\Tuah";
userid = select(1, rune_fun.GetUser());
Library.Paths.Secondary = "\\" .. tostring(userid);
Library.Paths.Data = "\\" .. tostring(game.PlaceId);

local Window = Library:CreateWindow({ Title = "Tuah " ..rune_fun.GetGame(); });

local Tabs = {
    Dashboard = Window:CreateTab({ Title = "Dashboard", Icon = "rbxassetid://130289250570665"}),
    Misc = Window:CreateTab({ Title = "Misc", Icon = "rbxassetid://130819053773683"}),
    Parry = Window:CreateTab({ Title = "Parry", Icon = "rbxassetid://106479339281996"}),
    Esp = Window:CreateTab({ Title = "Esp", Icon = "rbxassetid://138343944779037"}),
    Config = Window:CreateTab({ Title = "Config", Icon = "rbxassetid://95750721918044"}),
};

local Sections = {
    Collect = Tabs.Dashboard:CreateSection({ Title = "Collect", Side = "Left",}),
    Player = Tabs.Dashboard:CreateSection({ Title = "Local", Side = "Left",}),
    Automatic = Tabs.Dashboard:CreateSection({ Title = "Automatic", Side = "Right",}),
    Farm = Tabs.Dashboard:CreateSection({ Title = "Farm", Side = "Right",}),
    Data = Tabs.Config:CreateSection({ Title = "Data", Side = "Right",}),
    Debug = Tabs.Config:CreateSection({ Title = "Debug", Side = "Left",}),
    Misc_Stuff = Tabs.Misc:CreateSection({ Title = "Misc", Side = "Left",}),
    Insta_Kill = Tabs.Misc:CreateSection({ Title = "Helper", Side = "Right",}),
    Misc_Class = Tabs.Misc:CreateSection({ Title = "Classes", Side = "Right",}),
    Esp_Settings = Tabs.Esp:CreateSection({ Title = "Esp", Side = "Full",}),
    RageBait = Tabs.Misc:CreateSection({ Title = "Rage", Side = "Right",}),
    Fairy_Farm = Tabs.Misc:CreateSection({ Title = "Fairy", Side = "Right",}),
    ParrySection = Tabs.Parry:CreateSection({ Title = "Parry Config", Side = "Full",}),
};

getgenv().chopTrees = false;
getgenv().collectApples = false;
getgenv().collectEggs = false;
getgenv().AppleDelay = math.random(.4,.5);
getgenv().TweenSpeed = 160;

local Method = "Tween";
local Collect_ApplesDelay = Sections.Collect:CreateSlider({
    Text = "Delay time";
    Alignment = "Left";
    Default = getgenv().AppleDelay;
    Callback = function(v) 
        getgenv().AppleDelay = v;
    end;
    Flag = "AppleDelay";
    Floats = 0; 
    Limits = {0.5, 10}; 
    Increment = 0.5;
})

local Collect_ApplesTweenSpeed = Sections.Collect:CreateSlider({
    Text = "Tween Speed";
    Alignment = "Left";
    Default = getgenv().TweenSpeed;
    Callback = (function() 
        local lastPrintedSpeed = nil;

        return function(v)
            getgenv().TweenSpeed = v;

            if (v > getgenv().TweenSpeed and v ~= lastPrintedSpeed) or (v < getgenv().TweenSpeed and v ~= lastPrintedSpeed) then
                print("Tween Speed now at: " .. tostring(v))
                lastPrintedSpeed = v;
            elseif v == getgenv().TweenSpeed and lastPrintedSpeed ~= getgenv().TweenSpeed then 
                lastPrintedSpeed = 2;
            end;
        end;
    end)();
    Flag = "TweenSpeed";
    Floats = 0; 
    Limits = {5, 200}; 
    Increment = 1;
})

local Collect_ApplesMethod = Sections.Collect:CreateDropdown({
    Text = "Method";
    Subtext = "Teleport Options";
    Alignment = "Left";
    Choices = { "Tween", "Teleport" };
    Multi = false;
    Default = "Tween";
    Callback = function(v)
        Method = v;
    end;
    Flag = "AppleMethod";
})

local function getNearestApple()
    local apples = rune_fun.GetApples()
    local nearestApple = nil
    local shortestDistance = math.huge

    for _, apple in pairs(apples) do
        local distance = (Hrp.Position - apple.Position).Magnitude
        if distance < shortestDistance then
            shortestDistance = distance
            nearestApple = apple
        end;
    end;
    return nearestApple;
end;

local Collect_Apples = Sections.Collect:CreateToggle({
    Text = "Collect Apples";
    Subtext = "Gets all the Apples";
    Alignment = "Left";
    Default = false;
    Callback = function(a) 
        getgenv().collectApples = a;

        print(typeof(getgenv().collectApples))
        if a and (not getgenv().chopTrees) then
            task.spawn(pcall, function()
                if not Hrp then print("HRP not found") return; end;
                
                while getgenv().collectApples do
                    local apple = getNearestApple()
                    if not apple then print("No apples found!") break end

                    if Method == "Tween" then
                        rune_fun.Tween(apple.CFrame * CFrame.new(0, math.random(1, 2), 0), getgenv().TweenSpeed);
                    else
                        Hrp.CFrame = apple.CFrame + Vector3.new(0, math.random(1, 2), 0);
                    end; task.wait(1);

                    Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game) task.wait(0.2) Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
                end;
            end);
        end;
    end;
    Flag = "appleCollect";
})

local function getNearestEgg()
    local eggs = rune_fun.GetEggs()
    local nearestEgg = nil
    local shortestDistance = math.huge

    for _, egg in pairs(eggs) do
        local handle = egg:FindFirstChild("Handle") 
        if handle then
            local distance = (Hrp.Position - handle.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEgg = handle 
            end;
        end;
    end;
    return nearestEgg;
end;

local Collect_Eggs = Sections.Collect:CreateToggle({
    Text = "Collect Eggs";
    Subtext = "Gets all the Eggs";
    Alignment = "Left";
    Default = false;
    Callback = function(a) 
        getgenv().collectEggs = a;

        print(typeof(getgenv().collectEggs))
        if a and (not defaultConfig.chopTrees) or (not getgenv().collectApples) then
            task.spawn(pcall, function()
                if not Hrp then print("HRP not found") return; end;
                
                while getgenv().collectEggs do
                    local egg = getNearestEgg()
                    if not egg then print("No eggs found!") break end

                    if Method == "Tween" then
                        rune_fun.Tween(egg.CFrame * CFrame.new(0, math.random(1, 2), 0), getgenv().TweenSpeed);
                    else
                        Hrp.CFrame = egg.CFrame + Vector3.new(0, math.random(1, 2), 0);
                    end; task.wait(1);

                    Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game) task.wait(0.2) Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
                end;
            end);
        end;
    end;
    Flag = "eggCollect";
})

local function getNearestTree()
    local trees = rune_fun.GetTrees();
    local nearestTree = nil;
    local shortestDistance = math.huge;

    for _, tree in pairs(trees) do
        local health = tree:FindFirstChild("Health");
        local leaves = tree:FindFirstChild("leaves");

        if not leaves or not leaves.Parent then return end;

        local treePart = tree:FindFirstChildOfClass("MeshPart")
        if treePart then
            local distance = (Hrp.Position - treePart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestTree = tree
            end;
        end;
    end;
    return nearestTree;
end;

local Collect_Trees = Sections.Collect:CreateToggle({
    Text = "Collect Trees";
    Subtext = "Gets all the Trees";
    Alignment = "Left";
    Default = false;
    Callback = function(a) 
        getgenv().chopTrees = a

        print(typeof(getgenv().chopTrees))
        if a and (not getgenv().collectApples) then
            task.spawn(pcall, function()
                local Hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not Hrp then print("HRP not found") return end

                while getgenv().chopTrees do
                    local tree = getNearestTree()
                    local treePart = tree:FindFirstChildOfClass("MeshPart")
                    if treePart then
                        if Method == "Tween" then
                            rune_fun.Tween(treePart.CFrame * CFrame.new(0, -3, -3), getgenv().TweenSpeed)
                        elseif not getgenv().chopTrees then 
                            break;
                        else
                            local targetPos = treePart.Position + Vector3.new(0, 0, -3)
                            Hrp.CFrame = CFrame.new(targetPos, treePart.Position)
                        end;
                    end;
                    task.wait(1)
                    local args = {
                        [1] = {["player"] = game:GetService("Players").LocalPlayer,["Object"] = tree,["Action"] = "Chop"}}
                        LclPlr.Character.CharacterHandler.Input.Events.Interact:FireServer(unpack(args))

                    local health = tree:FindFirstChild("Health") local leaves = tree:FindFirstChild("leaves")
                    repeat
                        task.wait(0.1)
                        if (health and health.Value == 0) or not tree.Parent or not tree:FindFirstChild("Health") or (leaves and not leaves.Parent) then
                            break;
                        end;
                    until not tree.Parent or (health and health.Value == 0) or (leaves and not leaves.Parent)
                    task.wait(0.3);
                end;
            end);
        end;
    end;
    Flag = "treeCollect";
})

-- // AUTO QUEST 
local Quests = {
    ["Jane"] = {
        ["Position"] = 931.006531, 125.154938, 389.696198,
        ["Speak"] = {
            [1] = {
                ["player"] = LclPlr,
                ["Object"] = workspace:WaitForChild("Effects"):WaitForChild("NPCS"):WaitForChild("Jane"),
                ["Action"] = "NPC"
            };
        };
        ["Skip"] = {
             [1] = "Sure." 
        }
    };
};

--[[local JaneQuest = Sections.Collect:CreateToggle({
    Text = "Auto Jane Quest";
    Subtext = "Not fully done yet";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        getgenv().autoQuest_Jane = v;

        if v then
            task.spawn(function()
                if (not Hrp) then print("HRP not found") return; end;

                while getgenv().autoQuest_Jane do
                    local janePosition = Vector3.new(931.006531, 125.154938, 389.696198)
                    rune_fun.Tween(CFrame.new(janePosition), TweenSpeed)
                    task.wait(1);

                    local args = {
                        [1] = {
                            ["player"] = game.Players.LocalPlayer,
                            ["Object"] = workspace:WaitForChild("Effects"):WaitForChild("NPCS"):WaitForChild("Jane"),
                            ["Action"] = "NPC"
                        }
                    }
                    game.Players.LocalPlayer.Character.CharacterHandler.Input.Events.Interact:FireServer(unpack(args))
                    task.wait(1);

                    for i = 1, 3 do
                        local args = { [1] = "Sure." }
                        LclPlr.Character.CharacterHandler.Input.Events.DialogueEvent:FireServer(unpack(args))
                        task.wait(0.5);
                    end;

                    local appleCount = 0;
                    while appleCount < 3 and getgenv().autoQuest_Jane do
                        local apple = getNearestApple()
                        if apple then
                            rune_fun.Tween(apple.CFrame * CFrame.new(0, math.random(1, 2), 0), TweenSpeed);
                            task.wait(1);
                            Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game);
                            task.wait(0.2);
                            Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
                            appleCount = appleCount + 1;
                        else
                            print("No apples found");
                            break;
                        end;
                    end;

                    local eggCount = 0;
                    while eggCount < 2 and getgenv().autoQuest_Jane do
                        local egg = getNearestEgg();
                        if egg then
                            rune_fun.Tween(egg.CFrame * CFrame.new(0, math.random(1, 2), 0), TweenSpeed);
                            task.wait(1);
                            Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game);
                            task.wait(0.2);
                            Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
                            eggCount = eggCount + 1;
                        else
                            print("No eggs found");
                            break;
                        end;
                    end;

                    rune_fun.Tween(CFrame.new(janePosition), TweenSpeed);
                    task.wait(1);

                    local args = {
                        [1] = {
                            ["player"] = game.Players.LocalPlayer,
                            ["Object"] = workspace:WaitForChild("Effects"):WaitForChild("NPCS"):WaitForChild("Jane"),
                            ["Action"] = "NPC"
                        }}
                    LclPlr.Character.CharacterHandler.Input.Events.Interact:FireServer(unpack(args));
                    task.wait(1);
                    if not getgenv().autoQuest_Jane then break; end;
                end;
            end)
        end;
    end;
    Flag = "autoQuest_Jane";
})]]

local Debug_Apples = Sections.Debug:CreateButton({
    Text = "Debug Apples";
    Alignment = "Left"; 
    Callback = function()
         local apples = rune_fun.GetApples();

         for _, v in pairs(apples) do
            if apples then
            print(v.Name);
            task.defer(function()
                print("Total found: " ..#apples);
                print(type(apples));
            end)
        else 
            print("None found")
            end;
         end;
    end;
})

local Debug_Eggs = Sections.Debug:CreateButton({
    Text = "Debug Eggs";
    Alignment = "Left"; 
    Callback = function()
         local eggs = rune_fun.GetEggs();

         for _, v in pairs(eggs) do
            if eggs then
            print(v.Name);
            task.defer(function()
                print("Total found: " ..#eggs);
                print(type(eggs));
            end)
        else 
            print("None found");
            end;
         end;
    end;
})

local WalkSpeedSlider = Sections.Player:CreateSlider({
    Text = "WalkSpeed",
    Alignment = "Left",
    Default = 16,
    Callback = function(v)
        WalkSpeedValue = v;
    end,
    Flag = "walkSpeedValue",
    Floats = 0,
    Limits = {16, 100},
    Increment = 1,
})

local WalkSpeedToggle = Sections.Player:CreateToggle({
    Text = "Enabled",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(s)
        rune_fun.WalkSpeed(s);
    end,
    Flag = "walkSpeed",
})

local isEquipped = false;
local function equipWeapon()
    local weapon = rune_fun.GetWeapon()
    if weapon then
        Vim:SendKeyEvent(true, Enum.KeyCode.X, false, game)
        task.wait(.2)
        Vim:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        isEquipped = true;
    end;
end;

local Equip_Weapon = Sections.Automatic:CreateToggle({
    Text = "Equip Weapon",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(s)
        if s then
            equipWeapon()
        else
            isEquipped = false;
        end;
    end,
    Flag = "equipWeapon",
})

LclPlr.CharacterAdded:Connect(function()
    task.wait(10) 
    if isEquipped == true then 
    equipWeapon()
    else
        isEquipped = false;
    end
end)

--[[local Dex = Sections.Debug:CreateButton({
    Text = "Dex Explorer";
    Alignment = "Left"; 
    Callback = function()
        task.spawn(pcall, function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))();
        end)
    end;
})]]

--[[local Rspy = Sections.Debug:CreateButton({
    Text = "R-Spy";
    Alignment = "Left"; 
    Callback = function()
        task.spawn(pcall, function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))();
        end)
    end;
})]]

local KeyBind__ = "N";
local UI_ToggleKeybind = Sections.Data:CreateKeybind({
    Text = "Toggle UI";
    Subtext = "Default [" .. tostring(KeyBind__) .. "] to Toggle";
    Alignment = "Left"; 
    Default = KeyBind__; 
    Callback = function() 
        Window:Visibility();
    end;
});

local Button_Exit = Sections.Data:CreateButton({
    Text = "Exit UI";
    Alignment = "Left"; 
    Callback = function() 
        Window:Exit();
    end;
});

local SaveUI_Toggle = Sections.Data:CreateButton({
    Text = "Save",
    Callback = function()
        Library:Save();

        task.delay(1, function()
            Library:Notify("Saved Config for \n" .. LclPlr.Name .. ":" ..tostring(LclPlr.UserId) .. "", 4, "Tuah")
        end
        )
    end,
});

SaveUI_Toggle:CreateSettings():CreateToggle({
    Text = "Auto Save",
    Callback = function(Value)
        UI_AutoSave = Value;
        task.spawn(function()
            while UI_AutoSave do
                SaveUI_Toggle:Fire();
                task.wait(10)
            end;
        end);
    end,
    Flag = "UI_AutoSave",
});

local AutoLoad_Toggle = Sections.Data:CreateToggle({
    Text = "Auto Load";
    Subtext = "Loads script on Teleport";
    Alignment = "Left";
    Default = false;
    Callback = function(al)
        if al then 
            task.spawn(function()
                rune_fun.AutoLoad()
            end);
        end;
    end;
    Flag = "AutoLoad"
});

local Debug_Toggle = Sections.Data:CreateToggle({
    Text = "Debug Mode";
    Subtext = "For Debugging Purposes";
    Alignment = "Left"; 
    Default = false;
    Callback = function(v) 
        if v then
            print("Not made yet");
        end;
    end;
    Flag = "Debug"
});

local last_t = tick();
local last_fps = 0;
Run.RenderStepped:Connect(function()
    local current_t = tick();
    last_fps = math.floor(1 / (current_t - last_t));
    last_t = current_t;
end)

local Fps_Toggle = Sections.Data:CreateButton({
    Text = "Unlock Fps";
    Alignment = "Left"; 
    Callback = function() 
        if (not setfpscap) then print("Executor not supported"); return; end;

        setfpscap(math.max(60, 9999));
        print("FPS: " ..tostring(last_fps));
    end;
});

--[[
local GodMode = Sections.Misc_Stuff:CreateToggle({
    Text = "God Mode",
    Subtext = "[Patched]",
    Alignment = "Left",
    Default = false,
    Callback = function()
        -- Patched
    end,
    Flag = "godMode",
})]]

local NoFall = Sections.Misc_Stuff:CreateToggle({
    Text = "No Fall Dmg",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        task.spawn(function()
            if v then 
                rune_fun.NoFall(true);
            else
                rune_fun.NoFall(false);
            end;
        end)
    end,
    Flag = "noFall",
})

getgenv().noFog = false;
local NoFog = Sections.Misc_Stuff:CreateToggle({
    Text = "No Fog",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().noFog = v
            if getgenv().noFog then 
                rune_fun.NoFog(true);
            else
                rune_fun.NoFog(false);
            end;
    end,
    Flag = "noFog",
})

getgenv().noRollCd = false;
local NoRollCooldown = Sections.Misc_Stuff:CreateToggle({
    Text = "No Roll Cooldown",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().noRollCd = v
        rune_fun.NoRollCd(v); 
    end,
    Flag = "noRollCd",
})

getgenv().noHeat = false;
local NoHeat = Sections.Misc_Stuff:CreateToggle({
    Text = "No Heat",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().noHeat = v;

        if getgenv().noHeat then 
            rune_fun.NoHeat(true)
        end;
    end,
    Flag = "noHeat",
})

getgenv().Respawn = false;
local Respawn_Shit = Sections.Misc_Stuff:CreateToggle({
    Text = "Auto Respawn";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().Respawn = v;

        task.spawn(function()
            while getgenv().Respawn do task.wait(math.sqrt(4) * .1);

                local overlay = PlayerGui.InfoOverlays:FindFirstChild("ConfirmButton", true);
                if (not overlay) then return end;  

                for _, confirm in pairs(PlayerGui.InfoOverlays:GetChildren()) do
                    if confirm:IsA("ImageLabel") and confirm.Name == "ConfirmFrame" then
                        local mainFrame = confirm:FindFirstChild("MainFrame");
                        if mainFrame then
                            local textLabel = mainFrame:FindFirstChild("TextLabel");
                            local tGetTxt = textLabel.Text;
                            if textLabel and (textLabel.Text:match("Would you like to respawn?")) then --or string.find(tGetTxt, "respawn")) then -- Fallback if Text is Translated i guess, (didnt test ts)
                                local buttonFrame = mainFrame:FindFirstChild("ButtonFrame");
                                if buttonFrame then
                                    local respawnButton = buttonFrame:FindFirstChild("ConfirmButton");
                                    if respawnButton and respawnButton:FindFirstChild("TextLabel") then
                                        local respawnLabel = respawnButton.TextLabel;
                                        if respawnLabel.Text == "Confirm" then
                                            if game:GetService("GuiService").SelectedObject ~= respawnButton then
                                                game:GetService("GuiService").SelectedObject = respawnButton;
                                            end;
                                            Vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game);
                                            Vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game);
                                            task.wait(.5);
                                            game:GetService("GuiService").SelectedObject = nil;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end;
    Flag = "respawnShit";
})

getgenv().infiniteJump = false;
local InfJump = Sections.Misc_Stuff:CreateToggle({
    Text = "Infinite Jump";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().infiniteJump = v

        if getgenv().infiniteJump then
            rune_fun.InfiniteJump(true)
        else
            rune_fun.InfiniteJump(false)
        end
         end;
    Flag = "infiniteJump";
})

getgenv().setInvisible = false
local Invisible = Sections.Misc_Stuff:CreateToggle({
    Text = "Invisible";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        if v then
            rune_fun.Invisible(true) 
        else
            rune_fun.Invisible(false)
        end
    end;
    Flag = "infiniteJump";
})

local ModDetection = Sections.Misc_Stuff:CreateToggle({
    Text = "Mod Detection";
    Subtext = "Kick if in a Server with Mod";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        if v then
            rune_fun.ModDetection(true)
        else
            rune_fun.ModDetection(false)
        end
    end;
    Flag = "modDetection";
})

local DayTime = Sections.Misc_Stuff:CreateButton({
    Text = "Day Time";
    Alignment = "Left"; 
    Callback = function()
        local timeCheck = Rs.GlobalSettings.Time.Value;
        local solve = timeCheck.Value;

        rune_fun.ChangeTime("Day", nil);
    end;
})

local NightTime = Sections.Misc_Stuff:CreateButton({
    Text = "Night Time";
    Alignment = "Left"; 
    Callback = function()
        local timeCheck = Rs.GlobalSettings.Time.Value;
        local solve2 = timeCheck.Value;

        rune_fun.ChangeTime(nil, "Night");
    end;
})

local UseBed = Sections.Misc_Stuff:CreateButton({
    Text = "Use Bed Anywhere (Risky)";
    Alignment = "Left"; 
    Callback = function()
        rune_fun.UseBedAnywhere();
    end;
})

local AutoStoreValue = 49; 
local AutoStore_Value = Sections.Automatic:CreateSlider({
    Text = "Store at";
    Alignment = "Left";
    Default = 49;
    Callback = function(Value)
         AutoStoreValue = Value; 
    end;
    Flag = "autoStoreval";
    Floats = 0; 
    Limits = { 2, 50 }; 
    Increment = 1;
})

local AutoStoreToggle = false;
local AutoStore = Sections.Automatic:CreateToggle({
    Text = "Auto Store Food",
    Subtext = "Will store Inventory Only",
    Alignment = "Left",
    Default = false,
    Callback = function(state)
        AutoStoreToggle = state;

        task.spawn(function()
            while AutoStoreToggle do
                local inventory = rune_fun.GetInventory()
                local emptySlot = rune_fun.FindEmptySlot()
    
                if emptySlot then 
                    for _, item in pairs(inventory) do
                        if item.Quantity >= AutoStoreValue then
                            local args = {
                                [1] = {
                                    ["Config"] = "FillSlot",
                                    ["tool"] = item.Tool, 
                                    ["SlotNumber"] = emptySlot 
                                }
                            }
                            LclPlr.Character.CharacterHandler.Input.Events.BankEvent:FireServer(unpack(args))
                            print("Stored:", item.Name, "Quantity:", item.Quantity, "into Slot:", emptySlot);
                        end;
                    end;
                else
                    print("No empty slots available in the bank")
                end;
                task.wait(1);
            end;
        end)
    end,
    Flag = "storeFood"
})

local AutoStore_SelectedOnly = Sections.Automatic:CreateDropdown({
    Text = "Food",
    Subtext = "Choose to Store",
    Alignment = "Left",
    Choices = rune_fun.GetFood_Items(), 
    Multi = true,
    Default = nil,
    Callback = function(Value) 
        SelectedFoods = Value;
    end,
    Flag = "AutoStoreSelectedDrop",
})

local AutoStore_SelectedToggle = false
local AutoStore_Selected = Sections.Automatic:CreateToggle({
    Text = "Auto Store Selected",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(state)
        AutoStore_SelectedToggle = state;

        task.spawn(function()
            while AutoStore_SelectedToggle do
                local inventory = rune_fun.GetInventory()
                local emptySlot = rune_fun.FindEmptySlot() 
    
                if emptySlot then
                    for _, item in pairs(inventory) do
                        if table.find(SelectedFoods, item.Name) and item.Quantity >= AutoStoreValue then
                            local args = {
                                [1] = {
                                    ["Config"] = "FillSlot",
                                    ["tool"] = item.Tool, 
                                    ["SlotNumber"] = emptySlot
                                }
                            }
                            
                            LclPlr.Character.CharacterHandler.Input.Events.BankEvent:FireServer(unpack(args))
                            print("Stored:", item.Name, "Quantity:", item.Quantity, "into Slot:", emptySlot)
                        end;
                    end;
                else
                    print("No empty slots available in the bank.")
                end;
                task.wait(1);
            end;
        end)
    end,
    Flag = "AutoStoreSelected"
})

getgenv().cookFood = false;
getgenv().cookAmount = 1;

local CookAmount = Sections.Automatic:CreateSlider({
    Text = "Cook Amount";
    Alignment = "Left";
    Default = getgenv().cookAmount;
    Callback = function(v) 
        getgenv().cookAmount = v
     end;
    Flag = "cookAmount";
    Floats = 1; 
    Limits = { 0, 10 }; 
    Increment = 1;
})

local AutoCook = Sections.Automatic:CreateToggle({
    Text = "Auto Cook Food",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        if v then 
            rune_fun.CookFood(true);
        else
            rune_fun.CookFood(false);
        end
    end,
    Flag = "cookFood"
})

local offset = 5;
getgenv().farmMobs = false;
local positionType = "Behind"
local selectedMobs = {};

local MobsDropdown = Sections.Farm:CreateDropdown({
    Text = "Select Mobs";
    Subtext = "";
    Alignment = "Left";
    Choices = rune_fun.GetMobs();
    Multi = true;
    Default = nil;
    Callback = function(selectedList)
        selectedMobs = selectedList;
    end;
    Flag = "selectedMobs";
})

autoRefresh = false;
MobsDropdown:CreateSettings():CreateToggle({
    Text = "Auto Refresh",
    Callback = function(v)
        autoRefresh = v;
        
        task.spawn(function()
            while autoRefresh do task.wait(10); 
                local mobs = rune_fun.GetMobs();
                MobsDropdown:SetOptions(mobs);
            end;
        end);
    end,
    Flag = "autoRefreshMobs",
});

local MobsPosition = Sections.Farm:CreateDropdown({
    Text = "Position";
    Subtext = "";
    Alignment = "Left";
    Choices = { "Behind", "Above", "Below", "SpinRadius" };
    Multi = false;
    Default = positionType;
    Callback = function(v) 
        positionType = v;
    end;
    Flag = "positionMobsFarm";
})

local MobsOffset = Sections.Farm:CreateSlider({
    Text = "Offset";
    Alignment = "Left";
    Default = offset;
    Callback = function(v) 
        offset = v;
     end;
    Flag = "offsetMobs";
    Floats = 0; 
    Limits = { 1, 20 }; 
    Increment = 1;
})

MobsToggle = Sections.Farm:CreateToggle({
    Text = "Auto Farm";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        getgenv().farmMobs = v;
       
        if (not selectedMobs or #selectedMobs == 0) then 
            return;
        end;
        
        task.spawn(function()
            while getgenv().farmMobs do
                local mobs = Alive:GetChildren();
                local closestMob, closestDist = nil, math.huge;
        
                for _, mob in ipairs(mobs) do
                    if typeof(mob) == "Instance" and mob.Name then
                        local mobType = mob.Name:match("^(.-)%.%d+$") or mob.Name;
                        
                        local rootPart = mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart;
                        local humanoid = mob:FindFirstChildOfClass("Humanoid");
                
                        for _, selectedMobType in ipairs(selectedMobs) do
                            if selectedMobType:match("^(%a+)") == mobType and humanoid and humanoid.Health > 0 and rootPart then
                                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude;
                                if distance < closestDist then
                                    closestDist = distance;
                                    closestMob = mob;
                                end;
                            end;
                        end;
                    else
                        warn("Seems like something Happened here") 
                    end;
                end;
                

                if closestMob then
                    local rootPart = closestMob:FindFirstChild("HumanoidRootPart") or closestMob.PrimaryPart;
                    local humanoid = closestMob:FindFirstChildOfClass("Humanoid");
        
                    while humanoid and humanoid.Health > 0 and getgenv().farmMobs do
                        if rootPart then
                            local targetCFrame;
        
                            if positionType == "Behind" then
                                targetCFrame = rootPart.CFrame * CFrame.new(0, 0, offset);
        
                            elseif positionType == "Above" then
                                targetCFrame = CFrame.new(rootPart.Position + Vector3.new(0, offset, 0), rootPart.Position); 
        
                            elseif positionType == "Below" then
                                targetCFrame = CFrame.new(rootPart.Position + Vector3.new(0, -offset, 0), rootPart.Position); 
        
                            elseif positionType == "SpinRadius" then
                                local angle = tick() * 2 % (2 * math.pi);
                                local xOffset = math.cos(angle) * offset;
                                local zOffset = math.sin(angle) * offset;
                                targetCFrame = CFrame.new(rootPart.Position + Vector3.new(xOffset, 0, zOffset), rootPart.Position);
                            end;
        
                            rune_fun.Tween(targetCFrame, getgenv().TweenSpeed or 160);
                        end;
        
                        Vim:SendMouseButtonEvent(0, 0, 0, true, game, 0);
                        task.wait();
                        Vim:SendMouseButtonEvent(0, 0, 0, false, game, 0);
                    end;
                end;
                task.wait();
            end;
        end);              
    end;
    Flag = "farmMobs";
})

local MobsRefresh = Sections.Farm:CreateButton({
    Text = "Refresh Mobs";
    Alignment = "Left";
    Callback = function() 
        local mobs = rune_fun.GetMobs();

        if #mobs == 0 then
            print("No mobs found!");
        end

        MobsDropdown:SetOptions(mobs);
    end;
})

local selectedClass;
local rankUp = false;
local Classes_SelectRankup = Sections.Misc_Class:CreateDropdown({
    Text = "Class";
    Subtext = "Select your Class";
    Alignment = "Left";
    Choices = { "Thief", "Archer", "Warrior", "Magician", "Priest", "Striker" };
    Multi = false;
    Default = nil;
    Callback = function(v) 
        selectedClass = v;
    end;
    Flag = "classSelection";
})

local Classes_RankUpToggle = Sections.Misc_Class:CreateToggle({
    Text = "Auto Rankup";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        rankUp = v;

        task.spawn(function()
            while rankUp do
                task.wait()

                if (not selectedClass) then
                    print("No Class selected ", type(selectedClass));
                    task.wait(1);
                    return
                end;

                local args = {
                    [1] = {
                        ["FinalSelections"] = { ["Class"] = tostring(selectedClass) },
                        ["Config"] = "VerifyClassResults"
                    }
                }
                LclPlr.ClientNetwork.ClassRemote:FireServer(unpack(args));

                task.wait(math.exp(2));
            end;
        end)
    end;
    Flag = "classRankup";
})

getgenv().instaKill = false;
getgenv().instaKillVal = 300;

local instaKillVal = Sections.Insta_Kill:CreateSlider({
    Text = "Health";
    Alignment = "Left";
    Default = 300;
    Callback = function(v) 
        getgenv().InstaKillVal = v
     end;
    Flag = "";
    Floats = 0; 
    Limits = { 10, 500 }; 
    Increment = 5;
})

local InstaKill = Sections.Insta_Kill:CreateToggle({
    Text = "Insta Kill";
    Subtext = "One shot mobs";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().InstaKill = v;

        task.spawn(function()
            if getgenv().InstaKill then task.wait();
                rune_fun.InstaKill(true)
            elseif not getgenv().InstaKill then 
                rune_fun.InstaKill(false)
            end;
        end)
    end;
    Flag = "instaKill";
})

local KillYourself = Sections.Misc_Stuff:CreateButton({
    Text = "Kill yourself";
    Alignment = "Left";
    Callback = function() 
        Char.Humanoid.Health = 0;
    end;
})
-- // This i fully to make them rage quit ;F ´

local gPlrs = game:GetService("Players");
local detectedKid = {
    clipped = true,
    reported = true,
    hacker = true,
    cheater = true,
    report = true,
    clip = true,
    banned = true,
    exploiter = true,
    exploit = true,
    admin = false
}

getgenv().killReporters = false

Players.PlayerChatted:Connect(function(player, message)
    if not getgenv().killReporters then return end
    if type(message) ~= "string" then return end 
    if player == LclPlr then return end 

    for word in message:lower():gmatch("%S+") do 
        if detectedKid[word] then
            print("Found reporter:", player.Name)

            task.spawn(function()
                local targetChar = player.Character
                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")

                    while getgenv().killReporters do
                        local angle = tick() * 2 % (2 * math.pi)
                        local xOffset = math.cos(angle) * 5
                        local zOffset = math.sin(angle) * 5
                        local targetPosition = targetHrp.Position + Vector3.new(xOffset, 0, zOffset)

                        rune_fun.Tween(CFrame.new(targetPosition, targetHrp.Position), 150)
                        
                        Vim:SendMouseButtonEvent(0, 0, 0, true, game, 0);
                        task.wait();
                        Vim:SendMouseButtonEvent(0, 0, 0, false, game, 0);

                        task.wait(0.3)
                    end
                end
            end)
        end
    end
end)

local KillReporters = Sections.RageBait:CreateToggle({
    Text = "Hunt Reporters",
    Subtext = "Uses Filtered Chat words",
    Alignment = "Left",
    Default = false,
    Callback = function(r)
        getgenv().killReporters = r
    end,
    Flag = "killReporters"
})

getgenv().hopDelay = 4;
getgenv().serverHop = false;
getgenv().fairyFarm = false;

local ServerHopDleay = Sections.Fairy_Farm:CreateSlider({
    Text = "Hop Delay";
    Alignment = "Left";
    Default = getgenv().hopDelay;
    Callback = function(v) 
        getgenv().hopDelay = v;
    end;
    Flag = "hopDelay";
    Floats = 0; 
    Limits = { 1, 20 }; 
    Increment = 1;
})

local ServerHop = Sections.Fairy_Farm:CreateToggle({
    Text = "Auto Server Hop",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(r)
        getgenv().serverHop = r;
    end,
    Flag = "serverHop"
})

local FairyFarm = Sections.Fairy_Farm:CreateToggle({
    Text = "Auto Fairy",
    Subtext = "Will get Fairy if found",
    Alignment = "Left",
    Default = false,
    Callback = function(r)
        getgenv().fairyFarm = r;
        if r then
            rune_fun.FairyFarm()
        else
            getgenv().fairyFarm = false;
        end;
    end,
    Flag = "fairyFarm"
})

-- Too lazy rn
local ESP = {};

local LazyLabel = Sections.Esp_Settings:CreateLabel({
    Text = "Not made yet (lazy asf)";
    Alignment = "Center"; 
})

-- // Auto Parry by Bored


local InfoParry = Sections.ParrySection:CreateLabel({
    Text = "Get near entity to get Animation Helper [Right-Click to Config]";
    Alignment = "Left"; -- Enum.TextXAlignment
})
local Log = Sections.ParrySection:CreateLog({ Max = 20, Size = 120 });
Sections.ParrySection:CreateButton({ Text = "Clear", Callback = function() Log:Clear(); end, });
Sections.ParrySection:CreateSlider({
    Text = "Replay Speed",
    Default = 1,
    Callback = function(Value)
        getgenv().replaySpeed = Value;
    end,

    Floats = 1,
    Limits = { 0.1, 2 }, 
    Increment = .1,
});

local function GetAliveInRad(Rad)
    local rv = {}

    for _, v in pairs(workspace.Alive:GetChildren()) do
        if v == Char then continue end 
        
        local pHRP = v:FindFirstChild("HumanoidRootPart")
        if not pHRP then continue end 
        
        local Distance = (Hrp.Position - pHRP.Position).Magnitude
        if Distance <= Rad then
            table.insert(rv, v)
        end
    end

    return rv 
end


local IgnoreAnims = {
    "http://www.roblox.com/asset/?id=180435571",
    "http://www.roblox.com/asset/?id=180435792",
    "rbxassetid://10567552667",
    "rbxassetid://11666515506",
    "rbxassetid://11666512870",
};

local Timing = {
    ["rbxassetid://10568172474"] = { .4 },
};

local Fired, Cloned, Replaying = {}, {}, {};
while not getgenv().EStop do
    for _, v in pairs(GetAliveInRad(15)) do
        local isPlayer = Players:GetPlayerFromCharacter(v);
        local Species = (not isPlayer and v.Name:gsub("[^%a]", "")) or v.Name;

        local pHUM = v:FindFirstChildOfClass("Humanoid");
        if not pHUM then continue end;

        local Animator = pHUM:FindFirstChildOfClass("Animator");
        if not Animator then continue end;

        task.spawn(function()
            if not Cloned[Species] then
                if isPlayer then
                    Cloned[Species] = Players:CreateHumanoidModelFromDescription(Humanoid:GetAppliedDescription(),
                        Enum.HumanoidRigType.R6);
                else
                    Cloned[Species] = v:Clone();
                end;

                Cloned[Species].Name = Cloned[Species].Name .. "_clone";
            end;
        end);

        local Playing = Animator:GetPlayingAnimationTracks();
        if #Playing > 0 then
            for _, track in Playing do
                local Animation = track.Animation
                local id = Animation and Animation.AnimationId;
                if (not id) or (table.find(IgnoreAnims, tostring(id))) then continue end;

                local timeIn, maxTime = track.TimePosition, track.Length;
                local percent = timeIn / maxTime;
                local found = Timing[tostring(id)];
                local idDigets = id:match("%d+");

                task.spawn(function()
                    for _, v in pairs(Log.Logs) do
                        if v[1] == (Species .. "-" .. idDigets) then
                            return;
                        end;
                    end;

                    local e = Log:AddEntry(Species .. "-" .. idDigets);
                    local es = e:CreateSettings(UDim2.new(0, 300, 0, 200));

                    if not Timing[id] then
                        Timing[id] = {};
                    end;

                    es:CreateLabel({
                        Text = track.Name,
                        Alignment = "Center"
                    });

                    es:CreateLabel({
                        Text = "User: " .. Species,
                    });

                    es:CreateLabel({ Text = "" });

                    es:CreateToggle({
                        Text = "Ignore",
                        Callback = function(Value)
                            if Value then
                                if not table.find(IgnoreAnims, id) then
                                    table.insert(IgnoreAnims, id);
                                end;
                            else
                                local Found = table.find(IgnoreAnims, id);
                                if Found then
                                    table.remove(IgnoreAnims, Found);
                                end;
                            end;
                        end,
                    });

                    es:CreateButton({
                        Text = "Replay",
                        Callback = function()
                            if Replaying[Species] then
                                Replaying[Species]:Disconnect(); Replaying[Species] = nil;
                            end;

                            local cHRP = Cloned[Species]:FindFirstChild("HumanoidRootPart");
                            local cHUM = Cloned[Species]:FindFirstChildOfClass("Humanoid");
                            local cAnimator = cHUM:FindFirstChildOfClass("Animator");

                            local Billboard, TextUI = cHRP:FindFirstChildOfClass("BillboardGui"), nil;
                            if not Billboard then
                                Billboard = Instance.new("BillboardGui");
                                Billboard.Parent = cHRP;
                                Billboard.Size = UDim2.new(1, 0, 1, 0);
                                Billboard.Adornee = cHRP;
                                Billboard.AlwaysOnTop = true;
                                Billboard.Active = true;
                                TextUI = Instance.new("TextLabel");
                                TextUI.Parent = Billboard;
                                TextUI.Size = UDim2.new(1, 0, 1, 0);
                                TextUI.BackgroundTransparency = 1;
                                TextUI.TextSize = 20;
                                TextUI.TextColor3 = Color3.new(1, 1, 1);
                            else
                                TextUI = Billboard:FindFirstChildOfClass("TextLabel");
                            end;

                            for _, track in pairs(cAnimator:GetPlayingAnimationTracks()) do
                                track:Stop();
                            end;

                            Cloned[Species].Parent = workspace;
                            cHRP.CFrame = Hrp.CFrame * CFrame.new(0, 0, -5);

                            local cTrack = cAnimator:LoadAnimation(Animation);
                            print((replaySpeed and track.Speed * replaySpeed) )
                            cTrack.Looped = track.Looped;
                            cTrack:Play();
                            cTrack:AdjustSpeed((replaySpeed and track.Speed * replaySpeed) or track.Speed);

                            task.spawn(function()
                                while cTrack.IsPlaying do
                                    local timeIn, maxTime = cTrack.TimePosition, cTrack.Length;
                                    local percent = timeIn / maxTime;

                                    TextUI.Text = tostring(math.round(percent * 100));
                                    task.wait();
                                end;
                            end);

                            Replaying[Species] = cTrack.Stopped:Once(function()
                                Cloned[Species].Parent = nil;
                            end);
                        end,
                    });

                    es:CreateLabel({ Text = "Timings" });
                    es:CreateButton({
                        Text = "Add Parry",
                        Callback = function()
                            local size = (Timing[id] and #Timing[id] + 1) or 1;

                            es:CreateSlider({
                                Text = "Parry Timing",
                                Default = 0,
                                Callback = function(Value)
                                    Timing[id][size] = (Value and Value > 0 and Value / 100) or nil;
                                end,

                                Floats = 0,
                                Limits = { 0, 100 }, -- Min / Max
                                Increment = 1,
                            });
                        end,
                    });

                    for i, Timed in next, (Timing[id]) do
                        es:CreateSlider({
                            Text = "Parry Timing",
                            Default = (Timed and Timed * 100) or 0,
                            Callback = function(Value)
                                Timing[id][i] = (Value and Value > 0 and Value / 100) or nil;
                            end,

                            Floats = 0,
                            Limits = { 0, 100 }, -- Min / Max
                            Increment = 1,
                        });
                    end;
                end);

                local CurrentPoint = Fired[track] or 1;
                if found and CurrentPoint and found[CurrentPoint] and percent >= found[CurrentPoint] then
                    Fired[track] = Fired[track] or 0;
                    Fired[track] = Fired[track] + 1;
                    track.Ended:Once(function()
                        Fired[track] = nil;
                    end);

                    VIM:Press("F");
                end;
            end;
        end;
    end;

    task.wait();
end;

Library:Load();
