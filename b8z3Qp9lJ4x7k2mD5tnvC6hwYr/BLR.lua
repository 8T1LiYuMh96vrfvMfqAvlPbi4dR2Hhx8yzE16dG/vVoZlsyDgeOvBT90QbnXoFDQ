Rivals_Keeper = {};
print(os.date()); GetVersion = tostring(Version);

local env = {}
env[1] = {
    ["Build"] = "Public",
    ["Version"] = "1.0.2",
    ["UpdateCheckURL"] = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG/vVoZlsyDgeOvBT90QbnXoFDQ/refs/heads/main/b8z3Qp9lJ4x7k2mD5tnvC6hwYr/version.lua",
    ["ScriptURL"] = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG/vVoZlsyDgeOvBT90QbnXoFDQ/refs/heads/main/b8z3Qp9lJ4x7k2mD5tnvC6hwYr/BLR.lua"
}
env[2] = {
    ["Shutdown"] = function(reason)
        print("[!] Script is shutting down: " .. reason)
        task.wait(1) 
        Client:Kick("[Tuah] - " .. reason)
    end;
}
env[3] = {
    ["CheckForUpdates"] = function()
        local success, response = pcall(function()
            return game:HttpGet(env[1]["UpdateCheckURL"])
        end)

        if success and response then
            local versionData = loadstring(response)()
            
            if versionData then
                if versionData.Force_Update == true then
                    env[2]["Shutdown"]("Force update enabled by the developer")
                end;

                local serverVersion = tostring(versionData.Version)
                if serverVersion and serverVersion ~= tostring(env[1]["Version"]) then
                    print("[!] New update detected: " .. serverVersion)
                    env[2]["Shutdown"]("New version available")
                end;
            else
                print("[!] Failed to parse version data");
            end;
        else
            print("[!] Failed to check for updates, Running in offline mode");
        end;
    end;
}
env[4] = {
    ["VerifyIntegrity"] = function()
        local success, response = pcall(function()
            return game:HttpGet(env[1]["ScriptURL"])
        end)

        if success and response then
            local localScript = game:HttpGet(env[1]["ScriptURL"])

            if localScript ~= response then
                env[2]["Shutdown"]("Script modification detected!")
            else
                print("[✓] Script integrity verified.")
            end
        else
            print("[!] Failed to verify integrity.")
        end
    end
}
task.spawn(env[3]["CheckForUpdates"])
task.spawn(env[4]["VerifyIntegrity"])
print("[✓] Script Loaded Successfully")

getgenv().closure = {
    ["Main"] = {
        ["Auto_Dribble"] = {
            ["Enabled"] = false;
            ["Distance"] = 6;
            ["Threshold"] = 6;
        },
        ["AutoClaimQuests"] = false;
        ["AutoClaimDaily"] = false;
        ["Auto_Steal"] = {
            ["Enabled"] = false;
            ["Distance"] = 6;
        },
        ["InfiniteStamina"] = false;
        ["AutoFlow"] = false;
        ["AutoAwaken"] = false;
        ["Speed"] = {
            ["Enabled"] = false;
        },
        ["AntiRagdoll"] = false;
        ["SkillsNoCd"] = false;
        ["Goalkeeper"] = {
            ["Enabled"] = false;
            ["Range"] = 10;
        }
    },
    ["Spin"] = {
        ["Flow"] = {
            ["Enabled"] = false;
            ["Choosen_Flow"] = nil;
            ["UseLucky_Spins"] = false;
        },
        ["Style"] = {
            ["Enabled"] = false;
            ["Choosen_Style"] = nil;
            ["UseLucky_Spins"] = false;
        },
    },
    ["UI"] = {
        ["Keybind"] = "N";
    },
}

Rivals_Keeper.GetGame = function()
    local m_service = game:GetService("MarketplaceService");
    local succ, m_info = pcall(m_service.GetProductInfo, m_service, game.PlaceId);
    return succ and m_info.Name or "Couldnt get GameValues"
end;

local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
local Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))()
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))()  
local FileService = Setup:File();
local VIM = Setup:VirtualInputManager();
Setup:Basics()

Library.Paths.Folder = "\\Tuah";
Library.Paths.Secondary = "\\" .. tostring(Client.UserId);
Library.Paths.Data = "\\" .. tostring(PlaceId);

local Window = Library:CreateWindow({ Title = "Tuah - Blue Lock: Rivals" });
local Tabs = {
    Dashboard = Window:CreateTab({ Title = "Dashboard" }),
    Misc = Window:CreateTab({ Title = "Misc" }),
    Spin = Window:CreateTab({ Title = "Spin" }),
    Config = Window:CreateTab({ Title = "Config" })
};
local Sections = {
    Data = Tabs.Config:CreateSection({ Title = "Data", Side = "Right",}),
    UI = Tabs.Config:CreateSection({ Title = "UI", Side = "Left",}),
    Performance = Tabs.Config:CreateSection({ Title = "Performance", Side = "Right",}),
    Discord = Tabs.Config:CreateSection({ Title = "Discord", Side = "Right",}),
    Main = Tabs.Dashboard:CreateSection({ Title = "Main Settings", Side = "Left",}),
    Ball = Tabs.Dashboard:CreateSection({ Title = "Ball Control", Side = "Right",}),
    Misc_Config = Tabs.Misc:CreateSection({ Title = "Misc Settings", Side = "Left",}),
    Target = Tabs.Misc:CreateSection({ Title = "Target", Side = "Right",}),
    Client = Tabs.Misc:CreateSection({ Title = "Client", Side = "Left",}),
    GoalKeeper = Tabs.Dashboard:CreateSection({ Title = "Goalkeeper", Side = "Right",}),
    Flow = Tabs.Spin:CreateSection({ Title = "Flow", Side = "Right",}),
    Style = Tabs.Spin:CreateSection({ Title = "Style", Side = "Left",})
};

local UI__Toggle = Sections.UI:CreateKeybind({
    Text = "Toggle";
    Subtext = "Default [" .. tostring(getgenv().closure.UI.Keybind) .. "] to Toggle UI";
    Alignment = "Left"; 
    Default = getgenv().closure.UI.Keybind; 
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
    Callback = function(Value)
        uiAutoSave = Value;
        spawn(function()
            while uiAutoSave do
                uiSave:Fire();
                task.wait(15)
            end;
        end);
    end,
    Flag = "uiAutoSave",
});

local Main__DribbleDistance = Sections.Main:CreateSlider({
    Text = "Distance";
    Subtext = "Only adjust if you know what your doing";
    Alignment = "Left";
    Default = getgenv().closure.Main.Auto_Dribble.Distance; 
    Floats = 1; 
    Limits = { 1, 15 }; 
    Callback = function(v)
        getgenv().closure.Main.Auto_Dribble.Distance = v;
    end;
    Flag = "auto_dribble_distance";
});

local Main__DribbleThreshold = Sections.Main:CreateSlider({
    Text = "Slide Threshold";
    Subtext = "Only adjust if you know what your doing";
    Alignment = "Left";
    Default = getgenv().closure.Main.Auto_Dribble.Threshold; 
    Floats = 1; 
    Limits = { 1, 15 }; 
    Callback = function(v)
        getgenv().closure.Main.Auto_Dribble.Threshold = v;
    end;
    Flag = "auto_dribble_threshold";
});

local Main__Dribble = Sections.Main:CreateToggle({
    Text = "Auto Dribble",
    Subtext = "Default Config is 6-6",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.Auto_Dribble.Enabled = v
        
        task.spawn(function()
            while getgenv().closure.Main.Auto_Dribble.Enabled do task.wait()
                Rivals_Keeper.AutoDribble(true)
            end;
        end)
    end;
    Flag = "auto_dribble";
})

local Main__StealDistance = Sections.Main:CreateSlider({
    Text = "Distance";
    Subtext = "Only adjust if you know what your doing";
    Alignment = "Left";
    Default = getgenv().closure.Main.Auto_Steal.Distance; 
    Floats = 1; 
    Limits = { 1, 15 }; 
    Callback = function(v)
        getgenv().closure.Main.Auto_Steal.Distance = v;
    end;
    Flag = "auto_steal_distance";
});

local Main__AutoSteal = Sections.Main:CreateToggle({
    Text = "Auto Steal",
    Subtext = "Default Config is 6",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.Auto_Steal.Enabled = v

        task.spawn(function()
            while getgenv().closure.Main.Auto_Steal.Enabled  do task.wait()
                Rivals_Keeper.AutoSteal(true)
            end;
        end)
    end;
    Flag = "auto_steal";
})

local Main__AutoFlow = Sections.Main:CreateToggle({
    Text = "Auto Flow",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.AutoFlow = v

        task.spawn(function()
            while getgenv().closure.Main.AutoFlow do task.wait()
                Rivals_Keeper.AutoFlow()
            end;
        end)
    end;
    Flag = "auto_flow";
})

local Main__AutoAwaken = Sections.Main:CreateToggle({
    Text = "Auto Awaken",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.AutoAwaken = v

        task.spawn(function()
            while getgenv().closure.Main.AutoAwaken do task.wait()
                Rivals_Keeper.AutoAwaken()
            end;
        end)
    end;
    Flag = "auto_awaken";
})

local Ball__TeleportToBall = Sections.Ball:CreateButton({
    Text = "Teleport to Ball";
    Alignment = "Left"; 
    Callback = function() 
        task.spawn(function()
            RootPart.CFrame = Rivals_Keeper.GetBall().CFrame;
        end)
    end;
});

local Ball__FlingBall = Sections.Ball:CreateButton({
    Text = "Fling Ball";
    Alignment = "Left"; 
    Callback = function() 
        getB = Rivals_Keeper.GetBall();
        task.spawn(function()
            getB.AssemblyLinearVelocity = Vector3.new(math.sin(math.random()) * 9999, math.sin(math.random()) * 9999, math.sin(math.random()) * 9999)
        end)
    end;
});

local Misc__AutoClaimQuests = Sections.Misc_Config:CreateToggle({
    Text = "Auto Claim Quests",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.AutoClaimQuests = v

        task.spawn(function()
            while getgenv().closure.Main.AutoClaimQuests do task.wait()
                Rivals_Keeper.AutoClaimQuests(true)
            end;
        end)
    end;
    Flag = "auto_claim_quests";
})

local Misc__AutoClaimDaily = Sections.Misc_Config:CreateToggle({
    Text = "Auto Claim Daily",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.AutoClaimDaily = v

        task.spawn(function()
            while getgenv().closure.Main.AutoClaimDaily do task.wait()
                Rivals_Keeper.AutoClaimDaily(true)
            end;
        end)
    end;
    Flag = "auto_claim_daily";
})

local Misc__InfiniteStam = Sections.Misc_Config:CreateToggle({
    Text = "Infinite Stamina",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.InfiniteStamina = v

        task.spawn(function()
            while getgenv().closure.Main.InfiniteStamina do task.wait()
                Rivals_Keeper.InfiniteStamina(true)
            end;
        end)
    end;
    Flag = "infinite_stamina";
})

local Misc__NoCooldown = Sections.Misc_Config:CreateToggle({
    Text = "Skills no Cooldown",
    Subtext = "",
    Default = false,
    Callback = function(v)
        getgenv().closure.Main.SkillsNoCd = v

        task.spawn(function()
            if v then
            Rivals_Keeper.SkillsNoCd();
            end
        end)
    end;
    Flag = "skills_no_cooldown";
})

local Misc__RedeemAllCodes = Sections.Misc_Config:CreateButton({
    Text = "Redeem All Codes";
    Alignment = "Left"; 
    Callback = function()
        local html = Rivals_Keeper.RedeemAllCodes({ Action = "Fetch" })
        if not html then
            Rivals_Keeper.LastRedeemStatus = "Failed to Fetch Codes"
            return
        end

        local codes = Rivals_Keeper.RedeemAllCodes({ Action = "Extract", Data = html })
        if #codes == 0 then
            Rivals_Keeper.LastRedeemStatus = "No Codes Found"
            return
        end

        local redeemed = Rivals_Keeper.RedeemAllCodes({ Action = "Redeem", Data = codes })
        if redeemed > 0 then
            Rivals_Keeper.LastRedeemStatus = "Redeemed " .. redeemed .. " Codes!"
        else
            Rivals_Keeper.LastRedeemStatus = "Failed to redeem codes."
        end
    end;
})

local targetPlayerName = "";
local Misc__Target = Sections.Target:CreateInput({
    Text = "Username";
    Subtext = "Enter the player's username";
    Alignment = "Left"; 
    Default = ""; 
    Placeholder = "Target";
    Callback = function(v)
        targetPlayerName = v;
    end;
});

local Misc__TargetAlwaysSteal = Sections.Target:CreateToggle({
    Text = "Always Steal";
    Subtext = "";
    Alignment = "Left"; 
    Default = false;
    Callback = function(v)
        getgenv().closure.Main.TargetAlwaysSteal = v

        if v then
            task.spawn(function()
                Rivals_Keeper.TargetAlwaysSteal(true) 
            end)
        end;
    end;
    Flag = "target_always_steal";
});

local Main__SpeedChanger = Sections.Client:CreateSlider({
    Text = "Speed";
    Subtext = "Boosts your Speed";
    Alignment = "Left"; 
    Default = 4; 
    Floats = 1; 
    Limits = { 4, 50 }; 
    Callback = function(v)
        if getgenv().closure.Main.Speed.Enabled then 
            Rivals_Keeper.Speed(v);
        end
    end;
    Flag = "speed_value";
});

local Main__SpeedChangerEnabled = Sections.Client:CreateToggle({
    Text = "Enable Speed";
    Subtext = "";
    Alignment = "Left"; 
    Default = false;
    Callback = function(v)
        getgenv().closure.Main.Speed.Enabled = v;
    end;
    Flag = "speed_enabled";
});

Rivals_Keeper.Cursor = function(enabled, size, shape)
    getgenv().cursorEnabled = enabled
    getgenv().cursorSize = size or 20
    getgenv().cursorShape = shape or "Circle"

    if getgenv().cursor then
        getgenv().cursor:Remove()
        getgenv().cursor = nil
    end

    if not getgenv().cursorEnabled then return end

    if getgenv().cursorShape == "Square" then
        getgenv().cursor = Drawing.new("Square")
        getgenv().cursor.Size = Vector2.new(getgenv().cursorSize, getgenv().cursorSize)
    elseif getgenv().cursorShape == "Triangle" then
        getgenv().cursor = Drawing.new("Triangle")
        getgenv().cursor.PointA = Vector2.new(0, 0)
        getgenv().cursor.PointB = Vector2.new(getgenv().cursorSize, 0)
        getgenv().cursor.PointC = Vector2.new(getgenv().cursorSize / 2, getgenv().cursorSize)
    else
        getgenv().cursor = Drawing.new("Circle")
        getgenv().cursor.Radius = getgenv().cursorSize / 2
    end

    getgenv().cursor.Color = Color3.fromRGB(255, 255, 255)
    getgenv().cursor.Transparency = 1
    getgenv().cursor.Filled = true
    getgenv().cursor.Visible = true

    task.spawn(function()
        while getgenv().cursorEnabled and getgenv().cursor do
            local mousePos = UserInputService:GetMouseLocation()

            if getgenv().cursorShape == "Square" then
                getgenv().cursor.Position = Vector2.new(mousePos.X - getgenv().cursorSize / 2, mousePos.Y - getgenv().cursorSize / 2)
            elseif getgenv().cursorShape == "Triangle" then
                getgenv().cursor.PointA = Vector2.new(mousePos.X, mousePos.Y)
                getgenv().cursor.PointB = Vector2.new(mousePos.X + getgenv().cursorSize, mousePos.Y)
                getgenv().cursor.PointC = Vector2.new(mousePos.X + getgenv().cursorSize / 2, mousePos.Y + getgenv().cursorSize)
            else
                getgenv().cursor.Position = Vector2.new(mousePos.X, mousePos.Y)
            end

            RunService.RenderStepped:Wait()
        end

        if getgenv().cursor then
            getgenv().cursor.Visible = false
            getgenv().cursor:Remove()
        end
    end)
end

local Main__CursorShape = Sections.UI:CreateDropdown({
    Text = "Shape";
    Subtext = "Choose your Shape";
    Alignment = "Left"; 
    Choices = {"Circle", "Square", "Triangle"}; 
    Multi = false; 
    Default = nil;
    Callback = function(v)
        getgenv().cursorShape = v
        Rivals_Keeper.Cursor(getgenv().cursorEnabled, getgenv().cursorSize, getgenv().cursorShape)
     end;
     Flag = "cursor_shape"
});

local Main__CursorSize = Sections.UI:CreateSlider({
    Text = "Size";
    Subtext = "Choose your Cursor Size";
    Alignment = "Left";
    Default = 10; 
    Floats = 1; 
    Limits = { 1, 20 };
    Callback = function(v)
    getgenv().cursorSize = v;
    Rivals_Keeper.Cursor(getgenv().cursorEnabled, getgenv().cursorSize, getgenv().cursorShape)
    end;
    Flag = "cursor_size"
});

local UI__CursorEnabled = Sections.UI:CreateToggle({
    Text = "Enable Cursor";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        getgenv().cursorEnabled = v
        Rivals_Keeper.Cursor(getgenv().cursorEnabled, getgenv().cursorSize, getgenv().cursorShape)
    end;
    Flag = "cursor_enabled"
});

local Performance__BoostFps = Sections.Performance:CreateToggle({
    Text = "Boost Fps";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        if v and (setfpscap) then 
            setfpscap(math.max(60, 9999));
            ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SettingsService"):WaitForChild("RE"):WaitForChild("Setting"):FireServer("Shadows", true)
        else
            ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SettingsService"):WaitForChild("RE"):WaitForChild("Setting"):FireServer("Shadows", false)
        end;
    end;
    Flag = "boost_fps";
});

local FRAME_COUNT = 0;
local LAST_UPD = tick()
local LAST_FPS = 0;
local Performance__CFpS = Sections.Performance:CreateLabel({
    Text = "N/A";
    Alignment = "Left"; 
})
RunService.RenderStepped:Connect(function()
    FRAME_COUNT = FRAME_COUNT + 1
end)

task.spawn(function()
    while true do
        task.wait(1) 
        LAST_FPS = FRAME_COUNT;
        FRAME_COUNT = 0;
        Performance__CFpS:ChangeText("FPS: " .. tostring(LAST_FPS))
    end;
end)

local UI__DiscordInvite = Sections.Discord:CreateLabel({
    Text = "Fetching invite...";
    Alignment = "Center"; 
})

local UI__DiscordInviteGet = Sections.Discord:CreateButton({
    Text = "Copy Invite";
    Alignment = "Center"; 
    Callback = function()
        if Rivals_Keeper.InviteLink then
            setclipboard(Rivals_Keeper.InviteLink)
            print("Invite copied: " .. Rivals_Keeper.InviteLink)
        else
            print("No invite available to copy.")
        end
    end;
})

local UI__DiscordUpdates = Sections.Discord:CreateLog({
    Default = { };
})

local Main__ReactionSpeed = Sections.GoalKeeper:CreateSlider({
    Text = "Range";
    Alignment = "Left";
    Default = getgenv().closure.Main.Goalkeeper.Range;
    Callback = function(v) 
        getgenv().closure.Main.Goalkeeper.Range = v
    end;
    Flag = "goalkeeper_range";
    Floats = 0; 
    Limits = { 1, 20 };
    Increment = 1;
})


local Main__AutoGoalKeeper = Sections.GoalKeeper:CreateToggle({
    Text = "Auto Catch";
    Subtext = "Auto defends the Ball";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        getgenv().closure.Main.Goalkeeper.Enabled = v

        if getgenv().closure.Main.Goalkeeper.Enabled then 
            Rivals_Keeper.AutoGoalkeeper();
        end;
    end;
    Flag = "goalkeeper_enabled";
})

local FlowChoices = {
    "Emperor",
    "Soul Harvester",
    "Awakened Genius",
    "Snake",
    "Dribbler",
    "Prodigy",
    "Wild Card",
    "Crow",
    "Trap",
    "Ice",
    "Chameleon",
    "Demon Wings",
    "Monster",
    "Gale Burst",
    "Genius",
    "King's Instinct",
    "Lightning",
    "Puzzle",
    "Buddha's Blessing"
}
local StyleChoices = {
    "Sae",
    "Kaiser",
    "NEL Isagi",
    "Don Lorenzo",
    "Shidou",
    "Kunigami",
    "Aiku",
    "Yukimiya",
    "Rin",
    "King",
    "Nagi",
    "Reo",
    "Karasu",
    "Bachira",
    "Otoya",
    "Hiori",
    "Kurona",
    "Gagamaru",
    "Isagi",
    "Chigiri",
    "Igaguri",
}
local selectedFlows = {};
local selectedStyles = {};

local Spin__StyleChoose = Sections.Style:CreateDropdown({
    Text = "Choose Style",
    Subtext = "To spin for",
    Alignment = "Left",
    Choices = StyleChoices,
    Multi = true,
    Default = nil,
    Callback = function(Value)
        getgenv().closure.Spin.Style.Choosen_Style = Value
    end,
    Flag = "auto_spin_style_choosen_style"
})

local Spin__FlowChoose = Sections.Flow:CreateDropdown({
    Text = "Choose Flow",
    Subtext = "To spin for",
    Alignment = "Left",
    Choices = FlowChoices,
    Multi = true,
    Default = nil,
    Callback = function(Value)
        getgenv().closure.Spin.Flow.Choosen_Flow = Value
    end,
    Flag = "auto_spin_flow_choosen_flow"
})

local Spin__StyleSpin = Sections.Style:CreateToggle({
    Text = "Auto Spin",
    Subtext = "Style only",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().closure.Spin.Style.Enabled = v

        task.spawn(function()
            if getgenv().closure.Spin.Style.Enabled then 
                Rivals_Keeper.AutoSpinStyle();
            end
        end)
    end,
    Flag = "auto_spin_style_enabled"
})

local Spin__FlowSpin = Sections.Flow:CreateToggle({
    Text = "Auto Spin",
    Subtext = "Flow only",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        getgenv().closure.Spin.Flow.Enabled = v

        task.spawn(function()
            if getgenv().closure.Spin.Flow.Enabled then 
                Rivals_Keeper.AutoSpinFlow();
            end
        end)
    end,
    Flag = "auto_spin_flow_enabled"
})

local Spin__StyleUseLucky = Sections.Style:CreateToggle({
    Text = "Use Lucky Spins",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        getgenv().closure.Spin.Style.UseLucky_Spins = Value
    end,
    Flag = "auto_spin_style_luckyspins"
})

local Spin__FlowUseLucky = Sections.Flow:CreateToggle({
    Text = "Use Lucky Spins",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        getgenv().closure.Spin.Flow.UseLucky_Spins = Value
    end,
    Flag = "auto_spin_flow_luckyspins"
})

-- (( Vars )) 

Players = game:GetService("Players");
Client = Players.LocalPlayer;
PlaceId = game.PlaceId;
Character = Client.Character or Client.CharacterAdded:Wait();
RootPart = Character:FindFirstChild("HumanoidRootPart");
ReplicatedStorage = game:GetService("ReplicatedStorage");
RunService = game:GetService("RunService");
UserInputService = game:GetService("UserInputService");

Rivals_Keeper.GetBall = function()
    for _, v in pairs(workspace:GetDescendants()) do 
        if v:IsA("MeshPart") and v.Name == "Football" then
            --print("Football found:", v)
            return v;
        end;
    end;
    return nil;
end;

Rivals_Keeper.IsThreatNearby = function()
    local players = game:GetService("Players"):GetPlayers()
    local myPosition = Character.PrimaryPart.Position
    local threatDistance = getgenv().closure.Main.Auto_Dribble.Distance or 7
    local slidingThreshold = getgenv().closure.Main.Auto_Dribble.Threshold or 7
    local myTeam = Rivals_Keeper.GetTeam()

    for _, player in pairs(players) do
        if player ~= Client and player.Character then
            local enemyChar = player.Character
            local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
            
            local enemyTeam = nil
            for _, slot in pairs(ReplicatedStorage.Teams.HomeTeam:GetChildren()) do
                if slot:IsA("ObjectValue") and slot.Value == player then
                    enemyTeam = "Home"
                    break
                end
            end
            for _, slot in pairs(ReplicatedStorage.Teams.AwayTeam:GetChildren()) do
                if slot:IsA("ObjectValue") and slot.Value == player then
                    enemyTeam = "Away"
                    break
                end
            end
            
            if myTeam and enemyTeam and myTeam == enemyTeam then
                continue
            end

            if enemyRoot then
                local distance = (enemyRoot.Position - myPosition).Magnitude
                local velocity = enemyRoot.Velocity

                if distance < threatDistance and velocity.Magnitude > slidingThreshold then
                    return true
                end
            end
        end
    end
    return false
end

Rivals_Keeper.AutoDribble = function(check)
    check = check or false
    local rB = Rivals_Keeper.GetBall()
    local cName = Character.Name
    local bCheck = Character.Values.HasBall

    while getgenv().closure.Main.Auto_Dribble.Enabled and check do
        task.wait()
        if rB and rB.Parent == Character or (bCheck and bCheck.Value == true) then
            if Rivals_Keeper.IsThreatNearby() then
                VIM:Press("Q")
            end
        end
    end
end

Rivals_Keeper.GetTeam = function()
    local teams = ReplicatedStorage:WaitForChild("Teams")
    local homeTeam = teams:FindFirstChild("HomeTeam")
    local awayTeam = teams:FindFirstChild("AwayTeam")

    if homeTeam and awayTeam then
        for _, playerSlot in pairs(homeTeam:GetChildren()) do
            if playerSlot:IsA("ObjectValue") and playerSlot.Value == Client then
                return "Home";
            end;
        end;
        for _, playerSlot in pairs(awayTeam:GetChildren()) do
            if playerSlot:IsA("ObjectValue") and playerSlot.Value == Client then
                return "Away";
            end;
        end;
    end;
    return nil;  
end;

Rivals_Keeper.AutoSteal = function(check)
    check = check or false;

    while getgenv().closure.Main.Auto_Steal.Enabled and check do
        task.wait()
        local myTeam = Rivals_Keeper.GetTeam()

        local players = Players:GetPlayers()
        for _, player in pairs(players) do
            if player ~= Client and player.Character then
                local enemyChar = player.Character
                local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                local hasBall = enemyChar:FindFirstChild("Values") and enemyChar.Values:FindFirstChild("HasBall")

                local enemyTeam = nil
                for _, slot in pairs(ReplicatedStorage.Teams.HomeTeam:GetChildren()) do
                    if slot:IsA("ObjectValue") and slot.Value == player then
                        enemyTeam = "Home";
                        break;
                    end;
                end;
                for _, slot in pairs(ReplicatedStorage.Teams.AwayTeam:GetChildren()) do
                    if slot:IsA("ObjectValue") and slot.Value == player then
                        enemyTeam = "Away";
                        break;
                    end;
                end;

                if myTeam and enemyTeam and myTeam ~= enemyTeam then
                    if enemyRoot and hasBall and hasBall.Value then
                        local dist = (enemyRoot.Position - Character.PrimaryPart.Position).Magnitude

                        if dist <= (getgenv().closure.Main.Auto_Steal.Distance or 6) then
                            Character:SetPrimaryPartCFrame(CFrame.lookAt(Character.PrimaryPart.Position, enemyRoot.Position))
                            VIM:Press("E")
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

Rivals_Keeper.AutoClaimQuests = function(check)
    remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("QuestsService"):WaitForChild("RE"):WaitForChild("Quest");
    check = check or false;

    while getgenv().closure.Main.AutoClaimQuests and check do task.wait()
        for i = 1, 3 do
            task.wait(math.random(2.1,3))
            remote:FireServer("Quest" ..i);
        end;
    end;
end;

Rivals_Keeper.AutoClaimDaily = function(check)
    remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("DailyRewardsService"):WaitForChild("RF"):WaitForChild("Redeem");
    check = check or false;

    while getgenv().closure.Main.AutoClaimDaily and check do task.wait()
            task.wait(math.random(2.1,3))
        remote:InvokeServer();
    end;
end;

Rivals_Keeper.RedeemAllCodes = function(args)
    if args.Action == "Fetch" then
        local response = request({
            Url = "https://beebom.com/blue-lock-rivals-codes/",
            Method = "GET"
        })
        if response.Success then
            return response.Body
        else
            return nil
        end
    end

    if args.Action == "Extract" then
        local html = args.Data
        local codes = {}
        for code in html:gmatch("<strong>(%w+)</strong>") do
            table.insert(codes, code)
        end
        return codes
    end

    if args.Action == "Redeem" then
        local codes = args.Data
        local remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CodesService"):WaitForChild("RF"):WaitForChild("Redeem")
        local redeemedCount = 0

        for _, code in ipairs(codes) do
            local success, result = pcall(function()
                return remote:InvokeServer(code)
            end)

            if success then
                if result == true then
                    print("Redeemed:", code)
                    redeemedCount = redeemedCount + 1
                else
                    print("Failed to redeem:", code, "| Response:", result)
                end
            else
                print("Error invoking server for code:", code)
            end
        end

        return redeemedCount
    end
end

local old;
local hooked = false;
Rivals_Keeper.InfiniteStamina = function(check)
    check = check or false;
    local remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):FindFirstChild("StaminaService");
    local stat = Players.LocalPlayer.PlayerStats.Stamina;

    if check and not hooked then 
        hooked = true
        local service = remote.RE.DecreaseStamina
        old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = { ... }

            if method == "FireServer" and self.Name == "DecreaseStamina" then
                args[1] = 0/0
                return old(self, unpack(args))
            end

            return old(self, ...)
        end))

        task.spawn(function()
            while hooked do
                stat.Value = 100;
                task.wait();
            end;
        end)

    elseif not check and hooked then
        hookmetamethod(game, "__namecall", old) 
        hooked = false
    end;

    if not check then
        stat.Value = 100;
    end;
end;

Rivals_Keeper.TargetAlwaysSteal = function(check)
    check = check or false;
    
    while getgenv().closure.Main.TargetAlwaysSteal and check do
        task.wait()
        if targetPlayerName == "" then continue end 
        
        local targetPlayer = Players:FindFirstChild(targetPlayerName)
        
        if targetPlayer and targetPlayer.Character then
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local hasBall = targetPlayer.Character:FindFirstChild("Values") and targetPlayer.Character.Values:FindFirstChild("HasBall")

            if targetRoot and hasBall and hasBall.Value then
                Character:SetPrimaryPartCFrame(CFrame.new(targetRoot.Position + Vector3.new(0, 0, 1))) 
                VIM:Press("E")
            end;
        end;
    end;
end;

Rivals_Keeper.AutoFlow = function()
    while getgenv().closure.Main.AutoFlow do task.wait(math.random(1.5,2.1))
    if VIM then
        VIM:Press("T");
    else
        ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("FlowService"):WaitForChild("RE"):WaitForChild("Activate"):FireServer();
    end;
end;
end;

Rivals_Keeper.AutoAwaken = function()
    while getgenv().closure.Main.AutoAwaken do task.wait(math.random(1.5,2.1))
    if VIM then
        VIM:Press("G");
    else
        ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("AwakeningService"):WaitForChild("RE"):WaitForChild("StartAwakening"):FireServer()
    end;
end;
end;

Rivals_Keeper.Speed = newcclosure(function(val)
    val = tonumber(val) or 25

    if getgenv().closure.Main.Speed.Enabled and typeof(val) == "number" and val > 1 then
        for i, v in next, debug.getregistry() do
            if type(v) == "table" then
                if rawget(v, "SpeedBoost2") then
                    v.SpeedBoost2 = val
                end
            end
        end
    elseif (val <= 1) or not table.find(getgenv().closure.Main.Speed, tostring(val)) then
        print("Something unexpected happened", type(Rivals_Keeper.Speed))
    end
end)

Rivals_Keeper.Discord = function()
    local invites = {
        ["Lifetime"] = "https://discord.gg/HPa9UwxssG",
        ["7Days"] = "https://discord.gg/HDaa6Kcw"
    }

    return invites["Lifetime"] or invites["7Days"]
end

Rivals_Keeper.InviteLink = Rivals_Keeper.Discord()
if Rivals_Keeper.InviteLink then
    UI__DiscordInvite:ChangeText(Rivals_Keeper.InviteLink)
else
    UI__DiscordInvite:ChangeText("No invite available.")
end

Rivals_Keeper.UpdateLogger = function()
    local updates = {
        "Released Script!",
    }

    for _, update in ipairs(updates) do
        UI__DiscordUpdates:AddEntry(update)
    end
end
Rivals_Keeper.UpdateLogger()

local originalAttributes = {};
Rivals_Keeper.SkillsNoCd = function()
    local path = ReplicatedStorage.AbilityCooldowns

    if getgenv().closure.Main.SkillsNoCd then
        for attributeName, attributeValue in pairs(path:GetAttributes()) do
            originalAttributes[attributeName] = attributeValue  
            path:SetAttribute(attributeName, 1) 
        end;
    else
        for attributeName, originalValue in pairs(originalAttributes) do
            path:SetAttribute(attributeName, originalValue) 
        end;
    end;
end;

local AutoGK = function()
    task.spawn(function()
        while task.wait(0.05) do
            if default_config["Misc"]["AutoGoalkeeper"] then
                local Ball = BallModule.GetBall()
                if Ball then
                    local Character = game.Players.LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                    if HumanoidRootPart then
                        local distance = (Ball.Position - HumanoidRootPart.Position).magnitude
                        if distance <= default_config["Misc"]["Goalkeeper_Range"] then
                            local direction = (Ball.Position - HumanoidRootPart.Position).unit
                            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + direction)
                            
                            task.defer(dash)
                        elseif Ball:IsDescendantOf(LP.Character) then 
                            repeat
                                task.wait(1)
                            until not Ball.Parent == LP.Character or not Ball:IsDescendantOf(LP.Character) or default_config.Misc.AutoGoalkeeper == false;
                            -- continue;
                        end
                    end
                end
            end
        end
    end)
end

Rivals_Keeper.AutoGoalkeeper = function()
    while task.wait() do
        if getgenv().closure.Main.Goalkeeper.Enabled then 
            local ball = Rivals_Keeper.GetBall();
            local hasBall = Character.Values.HasBall;

            if ball and HumanoidRootPart then
                local distance = (ball.Position - HumanoidRootPart.Position).magnitude
                if distance <= getgenv().closure.Main.Goalkeeper.Range then 
                    local direction = (ball.Position - HumanoidRootPart.Position).unit
                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + direction)
                    VIM:Press("Q");
                    task.wait(0.05)

                elseif hasBall and hasBall.Value == true then 
                    continue;
                end;
            end
        end
    end
end;

Rivals_Keeper.AutoSpinFlow = function()
    while getgenv().closure.Spin.Flow.Enabled do
        task.wait(5); 
        local currentFlow = Client.PlayerStats.Flow.Value;

        for _, flow in ipairs(selectedFlows) do
            if currentFlow == flow then
                getgenv().closure.Spin.Flow.Enabled = false
                return
            end;
        end;        
        ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("FlowService"):WaitForChild("RE"):WaitForChild("Spin"):FireServer(getgenv().closure.Spin.Flow.UseLucky_Spins)
    end;
end;

Rivals_Keeper.AutoSpinStyle = function()
    while getgenv().closure.Spin.Style.Enabled do
        task.wait(5); 
        local currentStyle = Client.PlayerStats.Style.Value;

        for _, style in ipairs(selectedStyles) do
            if currentStyle == style then
                getgenv().closure.Spin.Style.Enabled = false 
                return
            end;
        end;
        ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StyleService"):WaitForChild("RE"):WaitForChild("Spin"):FireServer(getgenv().closure.Spin.Style.UseLucky_Spins)
    end;
end;

Library:Notify("Tuah - has been loaded for\n" ..Rivals_Keeper.GetGame(), 4, "Information") 
--Library:Notify("Status: Online 🟢\nBuild: " ..env[1].Build.. "\nVersion " .. env[1].Version, 5, "Information") 
Library:Load();
