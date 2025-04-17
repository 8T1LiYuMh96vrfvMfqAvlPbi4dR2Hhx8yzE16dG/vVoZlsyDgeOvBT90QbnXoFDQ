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
            ["auto_sell_max"] = false;
            ["auto_buy_next_flavor"] = false;
            ["auto_buy_next_gum"] = false;
            ["auto_sell_custom"] = nil;
            ["auto_sell_custom_enabled"] = false;
            ["auto_win_dog_game"] = false;
            ["auto_chest_farm"] = false;
        };
        ["Misc"] = {
            ["auto_claim_prizes"] = false;
            ["auto_claim_daily"] = false;
            ["unlock_all_islands"] = false;
            ["auto_claim_playtime"] = false;
            ["auto_claim_wheel_spin"] = false;
            ["auto_coins_potion"] = false;
            ["auto_speed_potion"] = false;
            ["auto_mythic_potion"] = false;
            ["auto_lucky_potion"] = false;
            ["auto_hatch"] = false;
            ["choosen_egg"] = nil;
            ["auto_collect_coins"] = false;
            ["auto_gift"] = {
                ["enabled"] = false;
                ["open_value"] = 10;
            };
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
    getRemote:FireServer(table.find(all, "DailyRewardClaimStars"));
end;

function bubble:ClaimWheelSpin()
    local getRemoteK = network:WaitForChild("Remote"):WaitForChild("Function");
    local k;
    getRemoteK:InvokeServer("WheelSpin");
end;

function bubble:ClaimPlaytime()
    local getRemoteJ = network:WaitForChild("Remote"):WaitForChild("Function");
    for i = 1, 9 do 
        task.wait()
        getRemoteJ:InvokeServer("ClaimPlaytime", tonumber(i))
    end;
end;

function bubble:AutoGift()
    local getRemoteM = network:WaitForChild("Remote"):WaitForChild("Event")
    local openCount = tonumber(Kaugummi.Config.Misc.auto_gift.open_value) or 5 
    local NetworkFolder = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote")
    getRemoteM:FireServer("UseGift", "Mystery Box", openCount)
    task.wait(.5)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    for i = 1, openCount do
        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
        print("Clicked gift #" .. i)
        task.wait(0.15)
    end;
end;

function bubble:UseAllCoinPotions()
    getRemoteK = network:WaitForChild("Remote"):WaitForChild("Event");
    for i = 1, 6 do 
        task.wait()
        getRemoteK:FireServer("UsePotion", "Coins", tonumber(i))
    end;
end;

function bubble:UseAllLuckyPotions()
    getRemoteK = network:WaitForChild("Remote"):WaitForChild("Event");
    for i = 1, 6 do 
        task.wait()
        getRemoteK:FireServer("UsePotion", "Lucky", tonumber(i))
    end;
end;

function bubble:UseAllSpeedPotions()
    getRemoteK = network:WaitForChild("Remote"):WaitForChild("Event");
    for i = 1, 6 do 
        task.wait()
        getRemoteK:FireServer("UsePotion", "Speed", tonumber(i))
    end;
end;

function bubble:UseAllMythicPotions()
    getRemoteK = network:WaitForChild("Remote"):WaitForChild("Event");
    for i = 1, 6 do 
        task.wait()
        getRemoteK:FireServer("UsePotion", "Mythic", tonumber(i))
    end;
end;

function bubble:GetAllEggs()
    local getNga = replicatedstorage.Assets.Eggs;
    local eggs = {};
    for _, v in pairs(getNga:GetChildren()) do 
        if v:IsA("Model") then
            table.insert(eggs, v.Name);
        end;
    end;
    return eggs;
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

function bubble:CollectCoins()
    for i, v in pairs(workspace.Rendered:GetChildren()[12]:GetChildren()) do
        if v:IsA("Model") then
            local id = v.Name
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(id)
            task.wait()
        end;
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

function bubble:SellBubblesCustom()
    local getRemoteH = network:WaitForChild("Remote"):WaitForChild("Event");
    local arg1 = "SellBubble"
    while (Kaugummi.Config.Dashboard.auto_sell_custom and getRemoteH) do
        local bubbleLabel = client.PlayerGui.ScreenGui.HUD.Left.Currency.Bubble.Frame.Label
        if bubbleLabel then
            local text = bubbleLabel.ContentText or ""
            local current = text:match("([%d,]+)")
            if current then
                current = current:gsub(",", ""):gsub("%s", "")
                local currentNum = tonumber(current)
                local customTarget = tonumber(Kaugummi.Config.Dashboard.custom_sell_value)

                if currentNum and customTarget and currentNum >= customTarget then
                    getRemoteH:FireServer(tostring(arg1))
                end;
            end;
        end;
        task.wait(1);
    end;
end;

function bubble:AutoWinDogGame()
    local getRemoteL = network:WaitForChild("Remote"):WaitForChild("Event");

    while (Kaugummi.Config.Dashboard.auto_win_dog_game and getRemoteL) do task.wait()
        getRemoteL:FireServer("DoggyJumpWin", tonumber("3"))
    end;
end;

function bubble:GetAllCodes()
    local codes = {};
    for code in pairs(codesM) do
        table.insert(codes, code);
    end;
    return codes;
end;

function bubble:RedeemAllCodes()
    local codes = self:GetAllCodes()
    local getRemote = network:WaitForChild("Remote"):WaitForChild("Function");
    for _, code in ipairs(codes) do
        local args = { "RedeemCode", code }
        local success, result = pcall(function()
            return getRemote:InvokeServer(unpack(args))
        end)
        if success then print("Redeemed Code:", code)
        else warn("Failed to redeem code:", code, result) end
        task.wait(.5);
    end;
end;

function bubble:AntiAfk()
    local vu = game:GetService("VirtualUser");
    
    Client.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end;
    
local function GetCoins()
    local label = client:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("HUD"):WaitForChild("Left"):WaitForChild("Currency"):WaitForChild("Coins"):WaitForChild("Frame"):WaitForChild("Label");
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
    local remote = network:WaitForChild("Remote"):WaitForChild("Event");

    local flavors = {}
    for name, data in pairs(flavorData) do
        local costData = data.Cost;
        local cost = type(costData) == "table" and costData.Currency == "Coins" and costData.Amount or 0;
        table.insert(flavors, { Name = name, Cost = cost });
    end;

    table.sort(flavors, function(a, b)
        return a.Cost < b.Cost;
    end)

    for _, flavor in ipairs(flavors) do
        if coins >= flavor.Cost then
            remote:FireServer("GumShopPurchase", flavor.Name)
            task.wait(1);
        else
            break;
        end;
    end;
end;

function bubble:AutoLoad()
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

local gumData = require(replicatedstorage.Shared.Data.Gum)
function bubble:AutoBuyNextGum()
    local coins = GetCoins()
    local remote = network:WaitForChild("Remote"):WaitForChild("Event");

    local gums = {}
    for name, data in pairs(gumData) do
        local costData = data.Cost
        local cost = type(costData) == "table" and costData.Currency == "Coins" and costData.Amount or 0
        table.insert(gums, { Name = name, Cost = cost })
    end;

    table.sort(gums, function(a, b)
        return a.Cost < b.Cost;
    end)

    for _, gum in ipairs(gums) do
        if coins >= gum.Cost then
            remote:FireServer("GumShopPurchase", gum.Name)
            task.wait(1);
        else
            break;
        end;
    end;
end;

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
    Opening = Tabs.Misc:CreateSection({ Title = "Opening", Side = "Right",}),
    Potions = Tabs.Misc:CreateSection({ Title = "Potion", Side = "Left",}),
    Hatch = Tabs.Misc:CreateSection({ Title = "Hatch", Side = "Left",}),
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

local Dashboard__AutoSell = Sections.Main:CreateToggle({
    Text = "Auto Sell on MAX";
    Subtext = "Sells only if Max Bubbles";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_sell_max = v;

        if v then 
            task.spawn(function()
                while Kaugummi.Config.Dashboard.auto_sell_max do
                    local bubbleLabel = client.PlayerGui.ScreenGui.HUD.Left.Currency.Bubble.Frame.Label
                    if bubbleLabel then
                        local text = bubbleLabel.ContentText or ""
                        local current, max = text:match("([%d,]+)%s*/%s*([%d,]+)")
                        if current and max then
                            current = current:gsub(",", ""):gsub("%s", "")
                            max = max:gsub(",", ""):gsub("%s", "")
                            local currentNum = tonumber(current)
                            local maxNum = tonumber(max)
                            if currentNum and maxNum and currentNum >= maxNum then
                                local args = {
                                    [1] = "SellBubble"
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                            end;
                        end;
                    end;
                    task.wait(1);
                end
            end)
        end;
    end;
    Flag = "auto_sell_max";
})

local Dashboard__AutoSellCustomToggle = Sections.Main:CreateToggle({
    Text = "Auto Sell Custom";
    Subtext = "Sells custom bubbles Value";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.auto_sell_custom = v;

        if v then 
            task.spawn(function()
                bubble:SellBubblesCustom()
            end)
        end;
    end;
    Flag = "auto_sell_custom";
})

local Dashboard__AutoSellCustomInput = Sections.Main:CreateInput({
    Text = "Set Custom Sell Value";
    Subtext = "Example: 1000";
    Alignment = "Left";
    Default = "";
    Placeholder = "Enter bubble amount";
    Callback = function(Value) 
        Kaugummi.Config.Dashboard.custom_sell_value = tonumber(Value)
        print("Custom Sell Value set to: " .. tostring(Value)) 
    end;
    Flag = "custom_sell_value";
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

local Misc__AutoClaimWheel = Sections.Misc:CreateToggle({
    Text = "Auto Spin Wheel";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_claim_wheel_spin = v;

        while Kaugummi.Config.Misc.auto_claim_wheel_spin do
            task.wait(1);
            task.spawn(function()
                bubble:ClaimWheelSpin()       
            end)
        end;
    end;
    Flag = "auto_claim_wheel_spin";
})

local Misc__AutoCollectCoins = Sections.Misc:CreateToggle({
    Text = "Auto Collect Coins";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_collect_coins = v;

        while Kaugummi.Config.Misc.auto_collect_coins do
            task.wait(1);
            task.spawn(function()
                bubble:CollectCoins()       
            end)
        end;
    end;
    Flag = "auto_collect_coins";
})

local Misc__AutoWinDogGame = Sections.Misc:CreateToggle({
    Text = "Auto Win Dog";
    Subtext = "Wins the Dog game!";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_win_dog_game = v;

        while Kaugummi.Config.Misc.auto_win_dog_game do
            task.wait(1);
            task.spawn(function()
                bubble:AutoWinDogGame()       
            end)
        end;
    end;
    Flag = "auto_win_dog_game";
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

local Misc__UseAllSpeedPotion = Sections.Potions:CreateToggle({
    Text = "Auto use Speed Potion";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_speed_potion = v;

        while Kaugummi.Config.Misc.auto_speed_potion do
            task.wait(1);
            task.spawn(function()
                bubble:UseAllSpeedPotions()       
            end)
        end;
    end;
    Flag = "auto_speed_potion";
})

local Misc__UseAllLuckyPotion = Sections.Potions:CreateToggle({
    Text = "Auto use Lucky Potion";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_lucky_potion = v;

        while Kaugummi.Config.Misc.auto_lucky_potion do
            task.wait(1);
            task.spawn(function()
                bubble:UseAllLuckyPotions()       
            end)
        end;
    end;
    Flag = "auto_lucky_potion";
})

local Misc__UseAllMythicPotion = Sections.Potions:CreateToggle({
    Text = "Auto use Mythic Potion";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_mythic_potion = v;

        while Kaugummi.Config.Misc.auto_mythic_potion do
            task.wait(1);
            task.spawn(function()
                bubble:UseAllMythicPotions()       
            end)
        end;
    end;
    Flag = "auto_mythic_potion";
})

local Misc__AutoGiftValue = Sections.Opening:CreateSlider({
    Text = "Gifts to open";
    Alignment = "Left";
    Default = 10;
    Callback = function(v)
         Kaugummi.Config.Misc.auto_gift.open_value = v;
        end;
    Flag = "auto_gift_value";
    Floats = 0; 
    Limits = { 1, 10 }; 
    Increment = 1;
})

local Misc__AutoGift = Sections.Opening:CreateToggle({
    Text = "Auto Gift";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Misc.auto_gift.enabled = v;

        while Kaugummi.Config.Misc.auto_gift.enabled do
            task.wait(1);
            task.spawn(function()
                bubble:AutoGift()       
            end)
        end;
    end;
    Flag = "auto_gift";
})

local Misc__RedeemAllCodes = Sections.Misc:CreateButton({
    Text = "Redeem All Codes";
    Alignment = "Left";
    Callback = function()
        task.spawn(function()
            bubble:RedeemAllCodes()
        end)
    end;
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
                bubble:AutoLoad();
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


local Misc__HatchableEggs = Sections.Hatch:CreateDropdown({
    Text = "Choose Egg";
    Subtext = "";
    Alignment = "Left";
    Choices = bubble:GetAllEggs();  
    Multi = false;
    Default = nil;
    Callback = function(v) 
        Kaugummi.Config.Misc.choosen_egg = v
    end;
    Flag = "choosen_egg";
})

local Misc__HatchEgg; Misc__HatchEgg = Sections.Hatch:CreateToggle({
    Text = "Auto Open";
    Subtext = "Hatches the egg for you";
    Alignment = "Left";
    Default = false;
    Callback = function(enabled) 
        Kaugummi.Config.Misc.auto_hatch = enabled

        task.spawn(function()
            while Kaugummi.Config.Misc.auto_hatch do
                task.wait(1)
                if Kaugummi.Config.Misc.choosen_egg then
                    local args = {
                        [1] = "HatchEgg",
                        [2] = tostring(Kaugummi.Config.Misc.choosen_egg),
                        [3] = 2
                    }
                network:WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                else
                    warn("No egg selected")
                end
            end
        end)
    end;
    Flag = "auto_hatch";
})

local Misc__Refresh = Sections.Hatch:CreateButton({
    Text = "Refresh Eggs";
    Callback = function()
        local reEggs = bubble:GetAllEggs();

        task.wait(1)
        Misc__HatchEgg:SetOptions(reEggs);
    end;
})

local Config__AntiAfk = Sections.Data:CreateToggle({
    Text = "Anti Afk";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(a)
        if a then 
            task.spawn(function()
                bubble:AntiAfk();
            end)
        end;
    end;
    Flag = "anti_afk";
})

Library:Notify("Script loaded for: \n" ..tostring(bubble:GetGame()), 5, "Tuah")
Library:Load();
