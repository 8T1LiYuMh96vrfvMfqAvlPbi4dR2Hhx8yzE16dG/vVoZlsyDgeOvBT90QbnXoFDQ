hunters = {};
getgenv().closure = {
    ["Config"] = {
        ["Main"] = {
            ["auto_spin"] = false;
            ["auto_sell"] = {
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
            };
        };
    };
    ["UI"] = {
        ["keybind"] = "N";
        ["auto_save"] = true;
    }
}

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
    local player = game:GetService("Players").LocalPlayer
    local gui = player:WaitForChild("PlayerGui"):FindFirstChild("ScreenGui")
    local waveLabel = gui and gui:FindFirstChild("Wave")
    local dungeonEndFrame = gui and gui:FindFirstChild("DungeonEnd")

    if waveLabel and waveLabel.Visible then
        print("Already in dungeon - skipping join process.")
    else
        local args = {[1] = tostring(getgenv().closure.Config.Main.auto_dungeon.selected_dungeon)}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("createLobby"):InvokeServer(unpack(args))
        print("1 - Lobby created")
        task.wait(2)
        game:GetService("ReplicatedStorage").Remotes.LobbyStart:FireServer()
        print("2 - Lobby started")
        task.wait(2)
    end

    game:GetService("ReplicatedStorage").Remotes.DungeonStart:FireServer()

    while getgenv().closure.Config.Main.auto_dungeon.enabled do
        task.wait()
        if dungeonEndFrame and dungeonEndFrame.Visible and getgenv().closure.Config.Main.auto_dungeon.auto_leave then
            print("Dungeon ended - auto leaving.")
            hunters.AutoLeave()
            break
        end

        local mobs = hunters.GetMobs()
        for _, mob in pairs(mobs) do
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                local mobPos = mob.HumanoidRootPart.Position
                local offset = Vector3.new(-5, 0, 0)
                RootPart.CFrame = CFrame.new(mobPos + offset)
                RootPart.CFrame = CFrame.lookAt(mobPos + offset, mobPos)
                hunters.AutoM1()
            end
        end
    end
end

hunters.InstantKill = function()
    while getgenv().closure.Config.Main.auto_dungeon.insta_kill do 
        task.wait()
        local mobs = hunters.GetMobs()
        for _, v in pairs(mobs) do 
            if v:FindFirstChild("Humanoid") then
                v.Humanoid.Health = 0
            end
        end
    end
end


hunters.AutoM1 = function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Combat"):FireServer()
end;

hunters.AutoLeave = function()
    if getgenv().closure.Config.Main.auto_dungeon.enabled and getgenv().closure.Config.Main.auto_dungeon.auto_leave then 
    task.wait()
    game:GetService("ReplicatedStorage").Remotes.LeaveToLobby:FireServer()
    end
end;

-- // Variables
Players = cloneref(game:GetService("Players"));
Client = cloneref(Players.LocalPlayer);
ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));
Character = Client.Character or Client.CharacterAdded:Wait();
RootPart = Character:WaitForChild("HumanoidRootPart");

--// UI
local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
local Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))() 
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))()  
local FileService = Setup:File();
local VIM = Setup:VirtualInputManager();
Setup:Basics()

Library.Paths.Folder = "\\Tuah"
Library.Paths.Secondary = "\\" .. tostring(Client.UserId)
Library.Paths.Data = "\\" .. tostring(game.PlaceId)

local Window = Library:CreateWindow({ Title = "Hunters" })
local Tabs = {
    Dashboard = Window:CreateTab({ Title = "Dashboard" }),
    Config = Window:CreateTab({ Title = "Config" })
};
local Sections = {
    Data = Tabs.Config:CreateSection({ Title = "Data", Side = "Right",}),
    UI = Tabs.Config:CreateSection({ Title = "UI", Side = "Left",}),
    Main = Tabs.Dashboard:CreateSection({ Title = "Main", Side = "Left",}),
    Dungeon = Tabs.Dashboard:CreateSection({ Title = "Dungeon", Side = "Right",}),
};

local UI__Toggle = Sections.UI:CreateKeybind({
    Text = "Toggle";
    Subtext = "Default";
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
        print("saved")
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

local Main__AutoSell = Sections.Main:CreateToggle({
    Text = "Auto Sell";
    Subtext = "Sells besides Mythic";
    Alignment = "Left";
    Default = false;
    Callback = function(sell)
        getgenv().closure.Config.Main.auto_sell.enabled = sell;

        if sell then 
            hunters.AutoSell()
        end;
    end;
    Flag = "auto_sell";
})

Main__AutoSell:CreateSettings():CreateToggle({
    Text = "Keep Legendary",
    Callback = function(v)
        getgenv().closure.Config.Main.auto_sell.keep_legendary = v;
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

        task.spawn(function()
            task.wait()
                task.wait() 
                hunters.InstantKill()
        end)
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


Library:Notify("Early ahh version of Hunters", 5, "Tuah")
Library:Load();
