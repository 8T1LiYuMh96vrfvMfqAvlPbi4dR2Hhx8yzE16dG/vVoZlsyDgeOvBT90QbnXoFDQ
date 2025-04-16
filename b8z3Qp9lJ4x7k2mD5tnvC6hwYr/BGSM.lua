bubble = {}; --storing here
config = {};
manager = {};
handler = {};

replicatedstorage =     cloneref(game:GetService("ReplicatedStorage"));
players =               cloneref(game:GetService("Players"))
client =                players.LocalPlayer;
character =             client.Character or client.CharacterAdded:Wait();
root =                  character:WaitForChild("HumanoidRootPart");
run =                   cloneref(game:GetService("RunService"));

local Kaugummi = {
    Config = {
        ["Dashboard"] = {
            ["auto_bubblegum"] = false;
            ["auto_sell_bubblegum"] = false;
            ["auto_buy_next_flavor"] = false;
            ["auto_buy_next_gum"] = false;
        };
        ["Misc"] = {
            ["auto_claim_prizes"] = false;
            ["auto_claim_daily"] = false;
            ["unlock_all_islands"] = false;
            ["auto_claim_playtime"] = false;
            ["auto_coins_potion"] = false;
        };
    };
    UI = {
        ["auto_save"] = false;
    };
    Cache = {...};
}


--game stuff
local network = cloneref(replicatedstorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"));
local codesM = require(replicatedstorage.Shared.Data.Codes);
local flavorsD = require(replicatedstorage.Shared.Data.Flavors);

function bubble:GetGame()
    local m_service = game:GetService("MarketplaceService");
    local succ, m_info = pcall(m_service.GetProductInfo, m_service, game.PlaceId);
    return succ and m_info.Name or "Couldnt get GameValues"
end;

function bubble:ClaimDailyReward()
    local getRemote = network:WaitForChild("Remote"):WaitForChild("Event");
    local f;
    local all = {
        "DailyRewardClaimStars";
    };

    getRemote:FireServer(table.find(all, "DailyRewardClaimStars")); print(tostring(self));
end;

function bubble:ClaimPlaytime()
    local getRemoteJ = network:WaitForChild("Remote"):WaitForChild("Function");

    for i = 1, 9 do 
        task.wait()
        getRemoteJ:InvokeServer("ClaimPlaytime", tonumber(i))
    end;
end;

function bubble:UseAllCoinPotions()
    getRemoteK = network:WaitForChild("Remote"):WaitForChild("Event");

    local args = {
        [1] = "UsePotion",
        [2] = "Coins",
        [3] = 3
    }

    for i = 1, 5 do 
        task.wait()
        getRemoteK:FireServer("UsePotion", "Coins", tonumber(i))
    end;
end;

function bubble:GetIslands()
    for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do 
        if v:IsA("Folder") and v:FindFirstChild("Island"):FindFirstChild("UnlockHitbox") then 
            return v;
        end;
    end;
end;

function bubble:ClaimPrize()
    getRemoteI = network:WaitForChild("Remote"):WaitForChild("Event");

    for i = 1, 20 do 
        task.wait()
        getRemoteI:FireServer("ClaimPrize", tonumber(i));
    end;
end;

function bubble:BlowBubbles()
    local getRemote = network:WaitForChild("Remote"):WaitForChild("Event");
    local g;
    local arg = "BlowBubble"
    
    while (Kaugummi.Config.Dashboard.auto_bubblegum and getRemote) do task.wait()
        getRemote:FireServer(tostring(arg))
    end;
end;

function bubble:SellBubbles()
    local getRemoteH = network:WaitForChild("Remote"):WaitForChild("Event");
    local h;
    local arg1 = "SellBubble"

    while (Kaugummi.Config.Dashboard.auto_sell_bubblegum and getRemoteH) do task.wait()
        getRemoteH:FireServer(tostring(arg1))
    end;
end;

function bubble:GetAllCodes()
    local codes = {};
    for code in pairs(codesM) do
        table.insert(codes, code);
    end;
    return codes;
end;

function bubble:GetAllEggs()
    local getF = workspace.Rendered.Generic;
    local i;

    for k,v in pairs(getF:GetChildren()) do 
        if v:IsA("Model") and v:FindFirstChild("Hitbox") then 
            return v;
        end;
    end;
end;

local function GetCoins()
    local label = client:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("HUD"):WaitForChild("Left"):WaitForChild("Currency"):WaitForChild("Coins"):WaitForChild("Frame"):WaitForChild("Label")

    local rawText = label.Text:gsub(",", "");
    return tonumber(rawText) or 0;
end;

local function GetSortedFlavors()
    local flavors = {};
    for name, data in pairs(flavorsD) do
        local cost = type(data.Cost) == "table" and data.Cost.Amount or 0
        table.insert(flavors, {
            Name = name,
            Cost = cost
        })
    end;
    table.sort(flavors, function(a, b)
        return a.Cost < b.Cost;
    end)
    return flavors;
end;

local flavorData = require(replicatedstorage.Shared.Data.Flavors)

function bubble:AutoBuyNextFlavor()
    local coins = GetCoins()
    local remote = network:WaitForChild("Remote"):WaitForChild("Event")

    local flavors = {}
    for name, data in pairs(flavorData) do
        local costData = data.Cost
        local cost = type(costData) == "table" and costData.Currency == "Coins" and costData.Amount or 0
        table.insert(flavors, { Name = name, Cost = cost })
    end

    table.sort(flavors, function(a, b)
        return a.Cost < b.Cost
    end)

    for _, flavor in ipairs(flavors) do
        if coins >= flavor.Cost then
            remote:FireServer("GumShopPurchase", flavor.Name)
            task.wait(1)
        else
            break
        end
    end
end



local gumData = require(replicatedstorage.Shared.Data.Gum)

function bubble:AutoBuyNextGum()
    local coins = GetCoins()
    local remote = network:WaitForChild("Remote"):WaitForChild("Event")

    local gums = {}
    for name, data in pairs(gumData) do
        local costData = data.Cost
        local cost = type(costData) == "table" and costData.Currency == "Coins" and costData.Amount or 0
        table.insert(gums, { Name = name, Cost = cost })
    end

    table.sort(gums, function(a, b)
        return a.Cost < b.Cost
    end)

    for _, gum in ipairs(gums) do
        if coins >= gum.Cost then
            remote:FireServer("GumShopPurchase", gum.Name)
            task.wait(1)
        else
            break
        end
    end
end

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
    Misc = Window:CreateTab({ Title = "Misc", Icon = "rbxassetid://87313080232273" }),
    Config = Window:CreateTab({ Title = "Config", Icon = "rbxassetid://120211262975365"})
};
local Sections = {
    Data = Tabs.Config:CreateSection({ Title = "Data", Side = "Right",}),
    UI = Tabs.Config:CreateSection({ Title = "UI", Side = "Left",}),
    Main = Tabs.Dashboard:CreateSection({ Title = "Main", Side = "Left",}),
    Shop = Tabs.Dashboard:CreateSection({ Title = "Shop", Side = "Right",}),
    Misc = Tabs.Misc:CreateSection({ Title = "Misc", Side = "Left",}),
    Themes = Tabs.Config:CreateSection({ Title = "Themes", Side = "Left",}),
    Teleport = Tabs.Misc:CreateSection({ Title = "Teleport", Side = "Right",}),
    Potions = Tabs.Misc:CreateSection({ Title = "Potion", Side = "Left",}),
};

local Dashboard__AutoBlow = Sections.Main:CreateToggle({
    Text = "Auto Blow";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_bubblegum = v;

        if Kaugummi.Config.Dashboard.auto_bubblegum then 
            task.spawn(function()
                bubble:BlowBubbles()       
            end)
        end;
    end;
    Flag = "auto_blow";
})

local Dashboard__AutoSell = Sections.Main:CreateToggle({
    Text = "Auto Sell";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_sell_bubblegum = v;

        if Kaugummi.Config.Dashboard.auto_sell_bubblegum then 
            task.spawn(function()
                bubble:SellBubbles()       
            end)
        end;
    end;
    Flag = "auto_sell";
})

local Dashboard__AutoBuyNextFlavor = Sections.Shop:CreateToggle({
    Text = "Auto buy next Flavor";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_buy_next_flavor = v;

        while Kaugummi.Config.Dashboard.auto_buy_next_flavor do 
            task.wait();
            task.spawn(function()
                bubble:AutoBuyNextFlavor()       
            end)
        end;
    end;
    Flag = "auto_buy_next_flavor";
})

local Dashboard__AutoBuyNextGum = Sections.Shop:CreateToggle({
    Text = "Auto buy next Gum";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_buy_next_gum = v;

        while Kaugummi.Config.Dashboard.auto_buy_next_gum do 
            task.wait();
            task.spawn(function()
                bubble:AutoBuyNextGum()       
            end)
        end;
    end;
    Flag = "auto_buy_next_gum";
})

local Misc__AutoClaimPrize = Sections.Misc:CreateToggle({
    Text = "Auto Claim Prizes";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_claim_prizes = v;

        while Kaugummi.Config.Misc.auto_claim_prizes do
            task.wait(1);
            task.spawn(function()
                bubble:ClaimPrize()       
            end)
        end;
    end;
    Flag = "auto_claim_prizes";
})

local Misc__AutoClaimDaily = Sections.Misc:CreateToggle({
    Text = "Auto Claim Daily";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_claim_daily = v;

        while Kaugummi.Config.Misc.auto_claim_daily do
            task.wait(1);
            task.spawn(function()
                bubble:ClaimDailyReward()       
            end)
        end;
    end;
    Flag = "auto_claim_daily";
})

local Misc__AutoClaimPlaytime = Sections.Misc:CreateToggle({
    Text = "Auto Claim Playtime";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_claim_playtime = v;

        while Kaugummi.Config.Misc.auto_claim_playtime do
            task.wait(1);
            task.spawn(function()
                bubble:ClaimPlaytime()       
            end)
        end;
    end;
    Flag = "auto_claim_playtime";
})

local Misc__UseAllCoinsPotion = Sections.Potions:CreateToggle({
    Text = "Auto use Coins Potion";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_coins_potion = v;

        while Kaugummi.Config.Misc.auto_coins_potion do
            task.wait(1);
            task.spawn(function()
                bubble:UseAllCoinPotions()       
            end)
        end;
    end;
    Flag = "auto_coins_potion";
})

local Misc__UnlockAllIslands; Misc__UnlockAllIslands = Sections.Teleport:CreateButton({
    Text = "Unlock all Islands";
    Alignment = "Left";
    Callback = function()
        local islandsFolder = workspace.Worlds["The Overworld"]:FindFirstChild("Islands")
        if (not islandsFolder) then
            warn("folder not found, weird")
            return;
        end;
        local islands = islandsFolder:GetChildren()

        table.sort(islands, function(a, b)
            local aHitbox = a:FindFirstChild("Island") and a.Island:FindFirstChild("UnlockHitbox")
            local bHitbox = b:FindFirstChild("Island") and b.Island:FindFirstChild("UnlockHitbox")
            if aHitbox and bHitbox then
                return aHitbox.Position.Y < bHitbox.Position.Y;
            end;
            return false;
        end)

        for i, island in ipairs(islands) do
            local islandModel = island:FindFirstChild("Island")
            local hitbox = islandModel and islandModel:FindFirstChild("UnlockHitbox")
            if hitbox and hitbox:IsA("BasePart") then
                local name = island.Name or ("Island " .. tostring(i))
                Misc__UnlockAllIslands:ChangeText("Unlocking: " .. name)
                root.CFrame = hitbox.CFrame + Vector3.new(0, 2, 0)
                task.wait(1);
            end;
        end;

        Misc__UnlockAllIslands:ChangeText("✅ All Islands Unlocked!");
        task.wait(math.random(2,3));
        Misc__UnlockAllIslands:ChangeText("Unlock all Islands");
    end;
})


local UI__Toggle = Sections.UI:CreateKeybind({
    Text = "Toggle UI";
    Subtext = "Default is N" ;
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
        Kaugummi.UI.auto_save = v;
        spawn(function()
            while Kaugummi.UI.auto_save do
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
run.RenderStepped:Connect(function()
    local current_t = tick();
    last_fps = math.floor(1 / (current_t - last_t));
    last_t = current_t;
end)

local Config__FpsU = Sections.Data:CreateButton({
    Text = "Unlock Fps";
    Alignment = "Left"; 
    Callback = function() 
        if (not setfpscap) then print("Executor not supported"); return; end;

        setfpscap(math.max(60, 9999));
        print("FPS: " ..tostring(last_fps));
    end;
});

getgenv().theme_set = nil;

local Config__ThemeSet = Sections.Themes:CreateInput({
    Text = "Theme Name";
    Subtext = "Desired Theme here";
    Alignment = "Left";
    Default = "";
    Placeholder = "";
    Callback = function(v)
        getgenv().theme_set = v;
    end;
    Flag = "theme_selected";
})

local Config__DarkTheme = Sections.Themes:CreateToggle({
    Text = "Set Theme";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        if v and getgenv().theme_set ~= nil then
            Library.Theme = tostring(getgenv().theme_set);
        else
            Library.Theme = "Default";
        end;
    end;
    Flag = "theme_set";
})

local Config__AvailableThemes = Sections.Themes:CreateLog({
    Default = { "Dark", "Light", "Midnight", "Bloom", "Minecraft", "Windows 11", "Lotus Dark", "Default" };
})

Library:Notify("Script loaded for: \n" ..tostring(bubble:GetGame()), 5, "Tuah")
Library:Load();
