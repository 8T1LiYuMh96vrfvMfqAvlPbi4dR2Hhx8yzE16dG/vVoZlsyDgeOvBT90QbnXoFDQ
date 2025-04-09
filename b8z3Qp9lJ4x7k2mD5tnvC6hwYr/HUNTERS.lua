hunters = {};
getgenv().closure = {
    ["Config"] = {
        ["Main"] = {
            ["auto_spin"] = false;
            ["auto_sell_mode"] = {
                ["enabled"] = false;
                ["keep_legendary"] = false;
                ["keep_epic"] = false;
            };
            ["auto_quest"] = false;
            ["no_roll_cd"] = false;
            ["auto_dungeon"] = {
                ["enabled"] = false;
                ["selected_dungeon"] = nil;
                ["auto_leave"] = false;
                ["insta_kill"] = false;
                ["difficulty"] = nil;
            };
            ["auto_sell"] = {
                ["enabled"] = false;
                ["selected_rarity"] = false;
            };
            ["save_hover"] = false;
        };
    };
    ["UI"] = {
        ["keybind"] = "N";
        ["auto_save"] = true;
    }
}

hunters.GetGame = function()
    local m_service = game:GetService("MarketplaceService");
    local succ, m_info = pcall(m_service.GetProductInfo, m_service, game.PlaceId);
    return succ and m_info.Name or "Couldnt get GameValues"
end;

hunters.AutoLoad = function()
    if identifyexecutor() then
        pcall(function()
            task.defer(function()
                print("in queue..");
                queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/TuahScripts/AIuisdgbs-ijbisUDbgisebjHLXJCgdsiutebsKSdge/refs/heads/main/Loader"))()]])
            end);
        end);
    else
        print("Something went wrong, AutoLoad Issue", type(queue_on_teleport))
    end;
end;

hunters.SafeHover = function()
    local gui = Client:WaitForChild("PlayerGui"):FindFirstChild("ScreenGui");
    local wave = gui and gui:FindFirstChild("Wave");

    if wave and wave.Visible then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid then return end

        local hoverHeight = 30;
        local angle = 0;
        local radius = 5;
        local centerPosition = nil;

        while getgenv().closure.Config.Main.safe_hover do
            if not RootPart or not RootPart.Parent then
                hunters.RefreshCharacter()
            end

            local rayOrigin = RootPart.Position
            local rayDirection = Vector3.new(0, -100, 0) 
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.IgnoreWater = true

            local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

            if result then
                local groundY = result.Position.Y
                local targetY = groundY + hoverHeight
                local currentY = RootPart.Position.Y

                if not centerPosition then
                    centerPosition = Vector3.new(RootPart.Position.X, targetY, RootPart.Position.Z)
                end;

                if Humanoid.Health < 50 then
                    angle = angle + math.rad(2)  
                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius
                    local newPosition = Vector3.new(centerPosition.X + offsetX, targetY, centerPosition.Z + offsetZ)
                    RootPart.CFrame = CFrame.new(newPosition, centerPosition)  
                else
                    if math.abs(currentY - targetY) > 0.1 then
                        RootPart.CFrame = CFrame.new(RootPart.Position.X, targetY, RootPart.Position.Z)
                    end;
                end;
            end;
            task.wait();
        end;
    else
        print("not in dungeon;_");
    end;
end;


hunters.AutoSpin = function()
    remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Roll");
    
    while getgenv().closure.Config.Main.auto_spin do task.wait()
    remote:InvokeServer();
    end;
end;

hunters.AutoSell = function()
    if getgenv().closure.Config.Main.auto_sell and not getgenv().closure.Config.Main.auto_sell.keep_legendary then 
        local args = {[1] = 5}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("UpdateAutoSell"):FireServer(unpack(args))
    elseif getgenv().closure.Config.Main.auto_sell.keep_legendary then 
        local args = {[1] = 4}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("UpdateAutoSell"):FireServer(unpack(args))
    end;
end;

hunters.AutoAcceptQuest = function()
    if getgenv().closure.Config.Main.auto_quest then 
        local args = {[1] = 1,[2] = true}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Quests"):FireServer(unpack(args))
    end;        
end;

hunters.NoRollCooldown = function()
    local rollMod = require(ReplicatedStorage.Modules.RollFunctions)
    rollMod.DEFAULT_ROLL_SPEED = 0.01;
    rollMod.calculateRollSpeed = function(config, player, isFast)
        return 0.01;
    end;  
end;

hunters.GetMobs = function()
    local stored = {};
    for i, v in pairs(workspace.Mobs:GetChildren()) do 
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            table.insert(stored, v)
        end
    end;
    return stored;
end;

hunters.AutoDungeon = function()
    local gui = Client:WaitForChild("PlayerGui"):FindFirstChild("ScreenGui");
    local wave = gui and gui:FindFirstChild("Wave");
    local dungeon_end = gui and gui:FindFirstChild("DungeonEnd");

    if wave and wave.Visible then
        print("Already in dungeon")
    else
        local args = {[1] = tostring(getgenv().closure.Config.Main.auto_dungeon.selected_dungeon)}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("createLobby"):InvokeServer(unpack(args))
        task.wait(math.random(2,3))
        local args = {[1] = tostring(getgenv().closure.Config.Main.auto_dungeon.difficulty)}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LobbyDifficulty"):FireServer(unpack(args))   
        task.wait(math.random(2,3))     
        ReplicatedStorage.Remotes.LobbyStart:FireServer()
        task.wait(math.random(2,3))
    end;

    ReplicatedStorage.Remotes.DungeonStart:FireServer()

    while getgenv().closure.Config.Main.auto_dungeon.enabled do
        task.wait()
        if dungeon_end and dungeon_end.Visible and getgenv().closure.Config.Main.auto_dungeon.auto_leave then
            hunters.AutoLeave()
            break;
        end;

        if not RootPart or not RootPart.Parent then
            hunters.RefreshCharacter()
        end;

        local mobs = hunters.GetMobs()
        for _, mob in pairs(mobs) do
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                local mobPos = mob.HumanoidRootPart.Position
                local offset = Vector3.new(-5, 0, 0)
                RootPart.CFrame = CFrame.new(mobPos + offset)
                RootPart.CFrame = CFrame.lookAt(mobPos + offset, mobPos)
                hunters.AutoM1()
            end;
        end;
    end;
end;

hunters.InstantKill = function()
    while getgenv().closure.Config.Main.auto_dungeon.insta_kill do
        local mobs = hunters.GetMobs()

        for _, mob in pairs(mobs) do
            local humanoid = mob:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                task.defer(function()
                    pcall(function()
                        humanoid.Health = 0
                    end)
                end)
            end
        end
        task.wait(.1)
    end
end

hunters.AutoM1 = function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Combat"):FireServer();
end;

hunters.AutoLeave = function()
    if getgenv().closure.Config.Main.auto_dungeon.enabled and getgenv().closure.Config.Main.auto_dungeon.auto_leave then task.wait()
    ReplicatedStorage.Remotes.LeaveToLobby:FireServer()
    end;
end;

hunters.AutoSell = function()
    local sellRemote = ReplicatedStorage.Remotes.Sell;
    local icons = require(ReplicatedStorage.Modules.Icons);
    local inventoryFrame = Client.PlayerGui.ScreenGui.RightAlign.Inventory.ImageLabel.Items.ScrollingFrame;

    local selectedRarities = getgenv().closure.Config.Main.auto_sell.selected_rarity or {}
    if typeof(selectedRarities) ~= "table" then return; end;

    local assetIdToRarity = {}
    for rarity, assetId in pairs(icons) do
        assetIdToRarity[assetId] = rarity;
    end;

    while getgenv().closure.Config.Main.auto_sell.enabled do
        for _, item in pairs(inventoryFrame:GetChildren()) do
            if item:IsA("ImageLabel") and item.Image then
                local imageId = item.Image;
                local matchedRarity = assetIdToRarity[imageId]

                if matchedRarity and table.find(selectedRarities, matchedRarity) then
                    print("AutoSelling:", item.Name, "(rarity:", matchedRarity .. ")")
                    local args = {
                        [1] = {
                            [1] = item.Name
                        }
                    }
                    sellRemote:InvokeServer(unpack(args))
                    task.wait(.1);
                end;
            end;
        end;
        task.wait(2);
    end;
end;

-- // Variables
Players = cloneref(game:GetService("Players"));
Client = cloneref(Players.LocalPlayer);
ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));
Character = Client.Character or Client.CharacterAdded:Wait();
RootPart = Character:WaitForChild("HumanoidRootPart");
Run = game:GetService("RunService");

hunters.RefreshCharacter = function()
    Character = Client.Character or Client.CharacterAdded:Wait()
    RootPart = Character:WaitForChild("HumanoidRootPart")
end;

Client.CharacterAdded:Connect(function()
    hunters.RefreshCharacter()
end)
hunters.RefreshCharacter()

--// UI
local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
local Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))() 
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))()  
local FileService = Setup:File();
local VIM = Setup:VirtualInputManager();
Setup:Basics()

Library.Paths.Folder = "Tuah"
Library.Paths.Secondary = "/" .. tostring(Client.UserId)
Library.Paths.Data = "/" .. tostring(game.PlaceId)

local Window = Library:CreateWindow({ Title = "Hunters" })
local Tabs = {
    Dashboard = Window:CreateTab({ Title = "Dashboard", Icon = "rbxassetid://114287454825054" }),
    Config = Window:CreateTab({ Title = "Config", Icon = "rbxassetid://120211262975365"})
};
local Sections = {
    Data = Tabs.Config:CreateSection({ Title = "Data", Side = "Right",}),
    UI = Tabs.Config:CreateSection({ Title = "UI", Side = "Left",}),
    Main = Tabs.Dashboard:CreateSection({ Title = "Main", Side = "Left",}),
    Dungeon = Tabs.Dashboard:CreateSection({ Title = "Dungeon", Side = "Right",}),
    Sell = Tabs.Dashboard:CreateSection({ Title = "Sell", Side = "Left",}),
};

local UI__Toggle = Sections.UI:CreateKeybind({
    Text = "Toggle UI";
    Subtext = "Default is " ..tostring(getgenv().closure.UI.keybind);
    Alignment = "Left"; 
    Default = "N"; 
    Callback = function() 
        Window:Visibility();
    end;
    Flag = "ui_keybind";
});

local UI__Exit = Sections.UI:CreateButton({
    Text = "Exit";
    Alignment = "Left"; 
    Callback = function() 
        Window:Exit();
    end;
});

local uiSave = Sections.Data:CreateButton({
    Text = "Save Config",
    Callback = function()
        Library:Save();
    end,
});

uiSave:CreateSettings():CreateToggle({
    Text = "Auto Save",
    Callback = function(v)
        getgenv().closure.UI.auto_save = v;
        spawn(function()
            while getgenv().closure.UI.auto_save do
                uiSave:Fire();
                task.wait(15)
            end;
        end);
    end,
    Flag = "auto_save",
});

local AutoLoad_Toggle = Sections.Data:CreateToggle({
    Text = "Auto Load";
    Subtext = "Loads script on Teleport";
    Alignment = "Left";
    Default = false;
    Callback = function(al)
        if al then 
            task.spawn(function()
                hunters.AutoLoad()
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
            print("r");
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

local Main__AutoSpin = Sections.Main:CreateToggle({
    Text = "Auto Spin";
    Subtext = "RNG";
    Alignment = "Left";
    Default = false;
    Callback = function(spin)
        getgenv().closure.Config.Main.auto_spin = spin;

        if spin then 
            hunters.AutoSpin()
            print(type(hunters.AutoSpin))
            Library:Notify("Currently Spinning!!", 2, "Tuah")
        end;
    end;
    Flag = "auto_spin";
})

local Main__AutoSellRarity = Sections.Sell:CreateDropdown({
    Text = "Rarity";
    Subtext = "Rarity for Auto Sell";
    Alignment = "Left";
    Choices = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" };
    Multi = true;
    Default = {"Common", "Uncommon"};
    Callback = function(values)
        getgenv().closure.Config.Main.auto_sell.selected_rarity = values;
    end;
    Flag = "auto_sell_selected";
})

local Main__AutoSell = Sections.Sell:CreateToggle({
    Text = "Auto Sell";
    Subtext = "Equipment only";
    Alignment = "Left";
    Default = false;
    Callback = function(sell)
        getgenv().closure.Config.Main.auto_sell.enabled = sell

        if sell then
            task.spawn(hunters.AutoSell)
        end
    end;
    Flag = "auto_sell";
})


local Main__AutoSellMode = Sections.Main:CreateToggle({
    Text = "Set Sell mode";
    Subtext = "Sells all besides Mythic";
    Alignment = "Left";
    Default = false;
    Callback = function(sell)
        getgenv().closure.Config.Main.auto_sell_mode.enabled = sell;

        if sell then 
            hunters.AutoSell()
        end;
    end;
    Flag = "auto_sell_mode";
})

Main__AutoSell:CreateSettings():CreateToggle({
    Text = "Keep Legendary",
    Callback = function(v)
        getgenv().closure.Config.Main.auto_sell_mode.keep_legendary = v;
    end,
    Flag = "keep_legendary",
});

local Main__AutoQuest = Sections.Main:CreateToggle({
    Text = "Auto Quest";
    Subtext = "Accepts the Main Quest";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().closure.Config.Main.auto_quest = v;

        if v then 
            hunters.AutoAcceptQuest()
        end;
    end;
    Flag = "auto_quest";
})

local Main__NoRollCd = Sections.Main:CreateToggle({
    Text = "No Roll Cooldown";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().closure.Config.Main.no_roll_cd = v;

        if v then 
            hunters.NoRollCooldown()
        end;
    end;
    Flag = "no_roll_cd";
})

local Main__LobbyDungeon = Sections.Dungeon:CreateDropdown({
    Text = "Select Dungeon";
    Subtext = "";
    Alignment = "Left";
    Choices = { "DoubleDungeonD", "GoblinCave", "SpiderCavern" };
    Multi = false;
    Default = nil;
    Callback = function(v)
            getgenv().closure.Config.Main.auto_dungeon.selected_dungeon = v;
        end;
    Flag = "selected_dungeon";
})

local Main__DungeonDifficulty = Sections.Dungeon:CreateDropdown({
    Text = "Difficulty";
    Subtext = "";
    Alignment = "Left";
    Choices = { "Regular", "Hard", "Nightmare" };
    Multi = false;
    Default = nil;
    Callback = function(v)
            getgenv().closure.Config.Main.auto_dungeon.difficulty = v;
        end;
    Flag = "difficulty_dungeon";
})

local Main__AutoDungeon = Sections.Dungeon:CreateToggle({
    Text = "Auto Dungeon";
    Subtext = "Farms Dungeon Mobs";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().closure.Config.Main.auto_dungeon.enabled = v;

        if v then
            task.spawn(function()
                task.wait()
                hunters.AutoDungeon()
            end)
        end
    end;
    Flag = "auto_dungeon";
})

local Main__InstantKill = Sections.Dungeon:CreateToggle({
    Text = "Insta Kill";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().closure.Config.Main.auto_dungeon.insta_kill = v;

        if v then
            task.spawn(hunters.InstantKill)
        end
    end;
    Flag = "insta_kill";
})

local Main__AutoLeave = Sections.Dungeon:CreateToggle({
    Text = "Auto Leave";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().closure.Config.Main.auto_dungeon.auto_leave = v;
    end;
    Flag = "auto_leave_dungeon";
})

local Main__SafeHover = Sections.Dungeon:CreateToggle({
    Text = "Safe Mode",
    Subtext = "Enable Instant Kill for this",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().closure.Config.Main.safe_hover = v

        if v then
            task.spawn(hunters.SafeHover)
        end
    end;
    Flag = "safe_mode_dungeon";
})



Library:Notify("Script loaded for: \n" ..tostring(hunters.GetGame()), 5, "Tuah")
Library:Load();
