bubble = {}; --storing here 
config = {};
handler = {
    ["__"] = {Version = 1.11}
}; print("Checking " ..tostring(handler.__.Version), tostring(os.date()))

-- Auto Hatch Throwback egg Event
-- Auto Equip Best Pet
-- Auto Sell using 250x new Rift


local Kaugummi = {
    Config = {
        ["Dashboard"] = {
            ["Information"] = {
                {...};
            };
            ["Farm"] = {
                ["auto_bubble"] = false;
                ["auto_sell"] = false;
                ["auto_sell_ifmax"] = false;
                ["auto_sell_custom"] = false;
                ["auto_sell_custom_value"] = nil;
                ["collect_loot"] = false;
                ["Unlocks"] = {
                    ["auto_claim_prizes"] = false;
                    ["auto_claim_daily"] = false;
                    ["auto_claim_playtime"] = false;
                    ["auto_spin_wheel"] = false;
                    ["auto_win_doggy_game"] = false;
                    ["auto_claim_season"] = false;
                };
            };
            ["Shop"] = {
                ["auto_buy_next_flavor"] = false;
                ["auto_buy_next_gum"] = false;
                ["auto_use_potion"] = false;  
                ["potion_type"] = "Lucky"; 
                ["potion_count"] = 6;  
                ["auto_use_potion_limit"] = 3;
                ["auto_black_market"] = false;
                ["auto_black_marketselected"] = nil;
            };
            ["Pets"] = {
                ["selected_egg"] = nil;
                ["auto_hatch"] = false;
                ["event_selected_egg"] = nil;
                ["event_hatch"] = false;
            }
        };
        ["Misc"] = {
            ["selected_zone"] = nil;
        };
    };
    Ui = {
        ["auto_save"] = false;
    };
    Game = {
        ["Zones"] = {
            "Floating Island", "Outer Space", "Twilight", "The Void", "Zen", "Event";
        };
    };
    Cache = {...};
    Logs = {
        ["discord"] = {
            ["invite"] = "discord.gg/tuahhub";
            ["webhook"] = "https://discord.com/api/webhooks/1364674289621667880/brUcaz2Vy5aoYVp2KULO4OsEEJIcpNdJyhdjdEoTtWN7BhZmINX_nKwTOLlgFHKSW6W1";
        };
    };
}

replicatedstorage =     cloneref(game:GetService("ReplicatedStorage"));
players =               cloneref(game:GetService("Players"))
client =                players.LocalPlayer;
character =             client.Character or client.CharacterAdded:Wait();
root =                  character:WaitForChild("HumanoidRootPart");
run =                   cloneref(game:GetService("RunService"));
tween_serv =            cloneref(game:GetService("TweenService"));

local network =         cloneref(replicatedstorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"));
local event = network.Remote.Event;
local codesM =          require(replicatedstorage.Shared.Data.Codes);
local flavorsD =        require(replicatedstorage.Shared.Data.Flavors);
local v36 =             require(replicatedstorage.Shared.Utils.Chunker);
local flavorData =      require(replicatedstorage.Shared.Data.Flavors)
local gumData =         require(replicatedstorage.Shared.Data.Gum)
local hatching =        require(game:GetService("ReplicatedStorage").Client.Effects.HatchEgg)

local remotes =         replicatedstorage:WaitForChild("Remotes");
local pickups =         remotes.Pickups;
local collect =         pickups.CollectPickup;
local v_u_255 =         v36.new(128, 2);
local rendered =        Workspace:WaitForChild("Rendered");
local coins =           rendered:GetChildren()[14];
local buffs =           client.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("Buffs");


function bubble:GetGame()
    local m_service = game:GetService("MarketplaceService");
    local succ, m_info = pcall(m_service.GetProductInfo, m_service, game.PlaceId);
    return succ and m_info.Name or "Couldnt get required Values"
end;

function bubble:BlowBubbles()
    local getRemoteA = network:WaitForChild("Remote"):WaitForChild("Event");
    local a;
    while (Kaugummi.Config.Dashboard.Farm.auto_bubble and getRemoteA) do task.wait(math.random(1,1.1))
        task.spawn(function()
            getRemoteA:FireServer("BlowBubble");
        end)
    end;
end;

function bubble:SellBubbles()
    local getRemoteB = network:WaitForChild("Remote"):WaitForChild("Event");
    local b;
    while (Kaugummi.Config.Dashboard.Farm.auto_sell and getRemoteB) do task.wait(math.random(2,3))
        local ohString1 = "Teleport"
        local ohString2 = "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"

        network.Remote.Event:FireServer(ohString1, ohString2)
        task.wait()
        getRemoteB:FireServer("SellBubble");
    end;
end;

function bubble:SellBubblesCustom()
    local getRemoteH = network:WaitForChild("Remote"):WaitForChild("Event");
    local bubble = client.PlayerGui.ScreenGui.HUD.Left.Currency.Bubble.Frame.Label;

    if not bubble then warn("ts shit pmo") return; end;

    while (Kaugummi.Config.Dashboard.Farm.auto_sell_custom and getRemoteH) do
        if bubble then
            local text = bubble.ContentText or "";
            local current = text:match("([%d,]+)");
            if current then
                current = current:gsub(",", ""):gsub("%s", "");
                local currentNum = tonumber(current);
                local customTarget = tonumber(Kaugummi.Config.Dashboard.Farm.auto_sell_custom_value);

                if currentNum and customTarget and currentNum >= customTarget then
                    local ohString1 = "Teleport"
                    local ohString2 = "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"
            
                    network.Remote.Event:FireServer(ohString1, ohString2)
                    task.wait()
                    getRemoteH:FireServer("SellBubble");
                end;
            end;
        end;
        task.wait();
    end;
end;

function bubble:SellBubblesMax()
    local getRemoteBB = network:WaitForChild("Remote"):WaitForChild("Event")

    while Kaugummi.Config.Dashboard.Farm.auto_sell_ifmax do
        local get_bubble = client.PlayerGui.ScreenGui.HUD.Left.Currency.Bubble.Frame.Label

        if get_bubble then
            local text = get_bubble.ContentText or ""
            local current, max = text:match("([%d,]+)%s*/%s*([%d,]+)")

            if current and max then
                current = current:gsub(",", ""):gsub("%s", "")
                max = max:gsub(",", ""):gsub("%s", "")
                local currentNum = tonumber(current)
                local maxNum = tonumber(max)

                if currentNum and maxNum and currentNum >= maxNum then
                    Misc__ZoneToTeleport:SetValue("Twilight");
                    Misc__TeleportZone:Fire();
                    task.wait()
                    getRemoteBB:FireServer("SellBubble")
                end
            end
        end

        task.wait()
    end
end

function bubble:ClaimDailyReward()
    local getRemoteC = network:WaitForChild("Remote"):WaitForChild("Event");
    local c;
    getRemoteC:FireServer("DailyRewardClaimStars");
end;

function bubble:ClaimWheelSpin()
    local getRemoteK = network:WaitForChild("Remote"):WaitForChild("Function");
    local k;
    getRemoteK:InvokeServer("WheelSpin");
end;

function bubble:ClaimPlaytime()
    local getRemoteJ = network:WaitForChild("Remote"):WaitForChild("Function");
    for i = 1, 9 do task.wait()
        getRemoteJ:InvokeServer("ClaimPlaytime", tonumber(i))
    end;
end;

function bubble:ClaimPrize()
    local getRemoteI = network:WaitForChild("Remote"):WaitForChild("Event");
    for i = 1, 20 do task.wait()
        getRemoteI:FireServer("ClaimPrize", tonumber(i));
    end;
end;

function bubble:ClaimSeason()
    local getRemoteJ = network.Remote.Event;
    local j;
    getRemoteJ:FireServer("ClaimSeason")
end;

function bubble:stripRichText(str)
    return str:gsub("<[^>]->", ""):gsub("^%s*(.-)%s*$", "%1")
end;

blackmarket_products = {"Coins Evolved", "Coins V", "Lucky Evolved", "Lucky V", "Mythic Evolved", "Mythic V", "Speed Evolved", "Speed V"};
function bubble:BuyBlackmarket()
    local selected = Kaugummi.Config.Dashboard.Shop.auto_black_marketselected;
    if not selected or typeof(selected) ~= "table" then
        return;
    end;
    local remote = network.Remote.Event;
    local itemsFrame = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ItemShop.Frame.Main.ScrollingFrame;

    for i = 1, 3 do
        local item = itemsFrame:FindFirstChild("Item" .. i)
        if item then
            local labelInstance = item:FindFirstChild("Frame") and item.Frame:FindFirstChild("ItemFrame") and item.Frame.ItemFrame:FindFirstChild("Button") and item.Frame.ItemFrame.Button:FindFirstChild("Inner") and item.Frame.ItemFrame.Button.Inner:FindFirstChild("Label")

            local itemName = labelInstance and bubble:stripRichText(labelInstance.Text)
            if itemName and table.find(selected, itemName) then
                remote:FireServer("BuyShopItem", "shard-shop", i);
            end;
        end;
    end;
end;

function bubble:DetectRifts()
    local requesting = http and http.request or request;
    local rifts = workspace.Rendered.Rifts;
    local webhook = Kaugummi.Logs.discord.webhook;

    if (not requesting) then
        warn("executor doesnt support requests_")
        return;
    elseif (not rifts) then 
        warn("rifts dependency not found_")
        return;
    end;

    local pool_ = {
        ["Rifts"] = {
            ["nightmare-egg"] = true;
            ["void-egg"] = true;
            ["bunny-egg"] = true; -- event
            ["pastel-egg"] = true; -- event
            ["royal-chest"] = true;
            ["rainbow-egg"] = true;
        };
        ["Color"] = {
            ["nightmare-egg"] = 0xFF0000;
            ["void-egg"] = 0x000000;
            ["bunny-egg"] = 0xFFA500;
            ["pastel-egg"] = 0xFFA500;
            ["royal-chest"] = 0xFF69B4;
            ["rainbow-egg"] = 0x0000FF;
        };
    };

    local function send(name, type_)
        local get_rift = rifts:FindFirstChild(name);
        local timer = "N/A";
        local luck = "N/A";
        local p = #players:GetPlayers()   

        if get_rift then
            local gui = get_rift:FindFirstChild("Display");
            if gui then
                local surface = gui:FindFirstChild("SurfaceGui");
                if surface then
                    local t = surface:FindFirstChild("Timer");
                    local icon = surface:FindFirstChild("Icon");
                    local l = icon and icon:FindFirstChild("Luck");
                    if t and t:IsA("TextLabel") then timer = t.Text; end;
                    if l and l:IsA("TextLabel") then luck = l.Text; end;
                end;
            end;
        end;

        local embed = {
            ["embeds"] = { {
                ["title"] = "A Rift spawned in recently!";
                ["color"] = pool_["Color"][name] or 0xFFFFFF;
                ["fields"] = {
                    {
                        ["name"] = "🎯 Name";
                        ["value"] = "" .. name .. "";
                        ["inline"] = false;
                    };
                    {
                        ["name"] = "📦 Type";
                        ["value"] = "" .. type_ .. "";
                        ["inline"] = false;
                    };
                    {
                        ["name"] = "⏳ Timer";
                        ["value"] = "" .. timer .. "";
                        ["inline"] = false;
                    };
                    {
                        ["name"] = "🍀 Luck";
                        ["value"] = "" .. luck .. "";
                        ["inline"] = false;
                    };
                    {
                        ["name"] = "👤 Players";
                        ["value"] = "" .. tostring(p) .. "";
                        ["inline"] = false;
                    };
                    {
                        ["name"] = "Teleport Script";
                        ["value"] = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "', game.Players.LocalPlayer)\n```";
                        ["inline"] = false;
                    };                    
                };
                ["footer"] = {
                    ["text"] = "discord.gg/tuahhub";
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/1285020918397145159/1363255330749808750/Group_53.png?ex=68055df6&is=68040c76&hm=a6ad96c8210bc9e60aff4a963db85e0fb668bd514e5a7ff3aa14f0f4b14fc310&";
                };
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ");
            }};
        };       
        requesting({
            Url = webhook; Method = "POST"; Headers = {["Content-Type"] = "application/json";}; 
            Body = game:GetService("HttpService"):JSONEncode(embed);
        });
    end;

    local function find(type_)
        for _, v in pairs(rifts:GetChildren()) do
            if v:IsA("Model") and pool_["Rifts"][v.Name] then 
                send(v.Name, type_);
                return;
            end;
        end;
    end;
    find("Initial");

    rifts.ChildAdded:Connect(function(child)
        task.wait();
        if child:IsA("Model") and pool_["Rifts"][child.Name] then
            send(child.Name, "Live");
        end;
    end);
end;
bubble:DetectRifts();

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

function bubble:ZoneTeleport()
    trim = "Workspace.Worlds.The Overworld.Islands.".. tostring(Kaugummi.Config.Misc.selected_zone) ..".Island.Portal.Spawn";
    network:WaitForChild("Remote"):WaitForChild("Event"):FireServer("Teleport", trim)
end;

function bubble:GetIslands()
    for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do 
        if v:IsA("Folder") and v:FindFirstChild("Island"):FindFirstChild("UnlockHitbox") then 
            return v;
        end;
    end;
end;

function bubble:CollectCoins()
    repeat task.wait() until #coins:GetChildren() > 0;

    if Kaugummi.Config.Dashboard.Farm.collect_loot then
    for _, v in pairs(coins:GetChildren()) do
        collect:FireServer(v.Name);
        v:Destroy();
        v_u_255:Remove(v:GetPivot().Position, v);
    end;
end;
end;

function bubble:AutoWinDoggyGame()
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
    local codes = self:GetAllCodes();
    local getRemote = network:WaitForChild("Remote"):WaitForChild("Function");

    for _, code in ipairs(codes) do
        local args = { "RedeemCode", code }
        local success, result = pcall(function()
            return getRemote:InvokeServer(unpack(args))
        end)
        if success then Library:Notify("Redeemed Code: " ..tostring(string.upper(code)), 5, "Tuah")
        else warn("Failed to redeem code:", code, result) end;
        task.wait();
    end;
end;
    
function bubble:GetCoins()
    local label = client:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("HUD"):WaitForChild("Left"):WaitForChild("Currency"):WaitForChild("Coins"):WaitForChild("Frame"):WaitForChild("Label");
    local rawText = label.Text:gsub(",", "");
    return tonumber(rawText) or 0;
end;

function bubble:GetSortedFlavors()
    local flavors = {};
    for name, data in pairs(flavorsD) do
        local cost = type(data.Cost) == "table" and data.Cost.Amount or 0;
        table.insert(flavors, {Name = name, Cost = cost})
    end;
    table.sort(flavors, function(a, b)
        return a.Cost < b.Cost;
    end)
    return flavors;
end;

function bubble:AutoBuyNextFlavor()
    local coins = bubble:GetCoins();
    local remote = network:WaitForChild("Remote"):WaitForChild("Event");
    local flavors = {};

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
            task.wait();
        else
            break;
        end;
    end;
end;

function bubble:AutoBuyNextGum()
    local coins = bubble:GetCoins();
    local remote = network:WaitForChild("Remote"):WaitForChild("Event");
    local gums = {};

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
            task.wait();
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

function bubble:ReturnPotions(potion, count)
    pool = {"Lucky", "Mythic", "Speed", "Coins"};
    shit, other = {};

    for _, next in pool do 
        potion = table.sort(pool)
        return potion;
    end;

    for i = 1, 6 do 
        count = tonumber(i);
        return count
    end;
end;

function Protect()
    return tostring("https://discord.com/api/webhooks/1364674289621667880/brUcaz2Vy5aoYVp2KULO4OsEEJIcpNdJyhdjdEoTtWN7BhZmINX_nKwTOLlgFHKSW6W1")
end;

bubble.Potions = { "Lucky", "Mythic", "Speed", "Coins" };
bubble.Connection = nil;
bubble.BuffWatcher = nil;
bubble.UsedCount = 0;
function bubble:StartBuffWatcher()
    if self.BuffWatcher then
        self.BuffWatcher:Disconnect()
    end;

    self.BuffWatcher = buffs.ChildRemoved:Connect(function(child)
        local config = Kaugummi.Config.Dashboard.Shop

        for _, potion in ipairs(config.potion_multi or {}) do
            if child.Name == potion then
                if config.auto_use_potion then
                    event:FireServer("UsePotion", potion, config.potion_count)
                    bubble.UsedCount = bubble.UsedCount + 1
                end;
            end;
        end;
    end)
end;

function bubble:AutoPotionHandler()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil;
    end;

    bubble.UsedCount = 0;
    self:StartBuffWatcher()

    self.Connection = run.Heartbeat:Connect(function()
        local config = Kaugummi.Config.Dashboard.Shop;
        local now = os.time();

        if config.auto_use_potion then
            for _, potion in ipairs(config.potion_multi or {}) do
                if not buffs:FindFirstChild(potion) then
                    event:FireServer("UsePotion", potion, config.potion_count)
                    bubble.UsedCount = bubble.UsedCount + 1;
                    task.wait(1);
                end;
            end;
        elseif config.auto_use_potioninterval then
            if now - (bubble.LastPotionTime or 0) >= bubble.PotionInterval then
                bubble.LastPotionTime = now
                for _, potion in ipairs(config.potion_multi or {}) do
                    event:FireServer("UsePotion", potion, config.potion_count)
                    bubble.UsedCount = bubble.UsedCount + 1
                    task.wait(1);
                end;
            end;
        end;
    end)
end;

local oldH; local hooked = false;
function bubble:NoHatchAnim(cc)
    cc = cc or false;
    if cc then
        if not hooked then
            oldH = hookfunction(hatching.Play, function(...)
                return;
            end);
            hooked = true;
        end;
    else
        if hooked and oldH then
            hookfunction(hatching.Play, oldH);
            hooked = false;
        end;
    end;
end;

local teleport_table = {
    bunny_egg = Vector3.new(-404.91217041015625, 12012.033203125, -56.928504943847656);
    pastel_egg = Vector3.new(-389.7406921386719, 12011.533203125, -55.226104736328125);
} local tweeninfo = TweenInfo.new(6.5,Enum.EasingStyle.Linear)

function bubble:bypass_teleport(v)
    if client.Character and 
    client.Character:FindFirstChild('HumanoidRootPart') then
        local cf = CFrame.new(v)
        local a = tween_serv:Create(client.Character.HumanoidRootPart,tweeninfo,{CFrame=cf})
        a:Play()
    end;
end;

--// UI
local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))() 
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))()  
local FileService = Setup:File();
local VIM = Setup:VirtualInputManager();
Setup:Basics()

Library.Paths.Folder = "Tuah"
Library.Paths.Secondary = "/" .. tostring(client.UserId)
Library.Paths.Data = "/" .. tostring(game.PlaceId)

local Window = Library:CreateWindow({ Title = "Hunters" })
local Tabs = {
    Information = Window:CreateTab({ Title = "Info", Icon = "rbxassetid://118584452301773" }),
    Dashboard = Window:CreateTab({ Title = "Dashboard", Icon = "rbxassetid://114287454825054" }),
    Misc = Window:CreateTab({ Title = "Misc", Icon = "rbxassetid://87313080232273" }),
    Config = Window:CreateTab({ Title = "Config", Icon = "rbxassetid://120211262975365"})
};
local Sections = {
    Info = {
        Logs = Tabs.Information:CreateSection({ Title = "Updates", Side = "Full",});
        Premium = Tabs.Information:CreateSection({ Title = "Premium", Side = "Full",})
    };
    Dashboard = {
        Farm = Tabs.Dashboard:CreateSection({ Title = "Farming", Side = "Left",});
        Automatic = Tabs.Dashboard:CreateSection({ Title = "Automatic", Side = "Right",});
        Shop = Tabs.Dashboard:CreateSection({ Title = "Shop", Side = "Left",});
        Potion = Tabs.Dashboard:CreateSection({ Title = "Potion", Side = "Left",});
        Event = Tabs.Dashboard:CreateSection({ Title = "Event", Side = "Right",});
    };
    Misc = {
        Misc = Tabs.Misc:CreateSection({ Title = "Additional", Side = "Left",});
        Teleport = Tabs.Misc:CreateSection({ Title = "Teleport", Side = "Right",});
        Pets = Tabs.Misc:CreateSection({ Title = "Pets", Side = "Left",});
    };
    Config = {
        Ui = Tabs.Config:CreateSection({ Title = "UI", Side = "Left",});
        Performance = Tabs.Config:CreateSection({ Title = "Performance", Side = "Right",});
        Theme = Tabs.Config:CreateSection({ Title = "Theme", Side = "Right",});
    };
};

local WelcomeMsg = Sections.Info.Logs:CreateLabel({
    Text = "Welcome, " ..client.DisplayName.. " consider joining our Discord!";
    Alignment = "Left"; 
})

local UpdateLogs = Sections.Info.Logs:CreateLog({
    Default = { "[+] Rewriten Script!", "[+] Added Collect Loot", "[+] Version ".. tostring(handler.__.Version) };
})


local PremiumMsg = Sections.Info.Premium:CreateLabel({
    Text = "Tired of the Key System?";
    Alignment = "Left"; 
})

local PremiumMsg = Sections.Info.Premium:CreateLabel({
    Text = "Get Premium and skip the whole Key System & more";
    Alignment = "Left"; 
})

local DiscordInv; DiscordInv = Sections.Info.Premium:CreateButton({
    Text = "Join our Discord";
    Alignment = "Center"; 
    Callback = function()
        local get_invite = Kaugummi.Logs.discord.invite;

        if get_invite then 
        setclipboard(get_invite)
        DiscordInv:ChangeText("Copied Invite!")
        end;

        task.wait(1);
        DiscordInv:ChangeText("Join our Discord")
    end;
})

local Dashboard__AutoBlow = Sections.Dashboard.Farm:CreateToggle({
    Text = "Auto Blow";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(auto)
        Kaugummi.Config.Dashboard.Farm.auto_bubble = auto;

        if Kaugummi.Config.Dashboard.Farm.auto_bubble then 
            task.spawn(pcall, function()
                bubble:BlowBubbles();
            end);
        end;
    end;
    Flag = "auto_blow";
})

local Dashboard__AutoSell = Sections.Dashboard.Farm:CreateToggle({
    Text = "Auto Sell";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.auto_sell = v;

        if Kaugummi.Config.Dashboard.Farm.auto_sell then 
            task.spawn(function()
                bubble:SellBubbles();
            end);
        end;
    end;
    Flag = "auto_sell";
})

local Dashboard__AutoSell = Sections.Dashboard.Farm:CreateToggle({
    Text = "Auto Sell (Max)";
    Subtext = "Sells only if Max Bubbles";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.auto_sell_ifmax = v;

        if Kaugummi.Config.Dashboard.Farm.auto_sell_ifmax then 
            task.spawn(function()
                bubble:SellBubblesMax();
            end)
        end;
    end;
    Flag = "auto_sell_max";
})

local Dashboard__AutoSellCustom = Sections.Dashboard.Farm:CreateInput({
    Text = "Sell Value";
    Subtext = "Sells whatever amount you input";
    Alignment = "Left";
    Default = "";
    Placeholder = "Enter bubble amount";
    Callback = function(y) 
        Kaugummi.Config.Dashboard.Farm.auto_sell_custom_value = tonumber(y)
    end;
    Flag = "auto_sell_custom_value";
})

local Dashboard__AutoSellCustom = Sections.Dashboard.Farm:CreateToggle({
    Text = "Auto Sell Amount";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.auto_sell_custom = v;

        if Kaugummi.Config.Dashboard.Farm.auto_sell_custom then 
            task.spawn(function()
                bubble:SellBubblesCustom()
            end)
        end;
    end;
    Flag = "auto_sell_custom";
})

local Dashboard__AutoBuyNextFlavor = Sections.Dashboard.Shop:CreateToggle({
    Text = "Auto buy Flavor";
    Subtext = "Detects the next flavor to buy";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.auto_buy_next_flavor = v;

        while Kaugummi.Config.Dashboard.Shop.auto_buy_next_flavor do task.wait();
            task.spawn(function()
                bubble:AutoBuyNextFlavor()       
            end)
        end;
    end;
    Flag = "auto_buy_next_flavor";
})

local Dashboard__AutoBuyNextGum = Sections.Dashboard.Shop:CreateToggle({
    Text = "Auto buy Gum";
    Subtext = "Detects the next gum to buy";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.auto_buy_next_gum = v;

        while Kaugummi.Config.Dashboard.Shop.auto_buy_next_gum do task.wait();
            task.spawn(function()
                bubble:AutoBuyNextGum()       
            end)
        end;
    end;
    Flag = "auto_buy_next_gum";
})

local Dashboard__ClaimPrizes = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Claim Prizes";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_prizes = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_prizes do task.wait();
            task.spawn(function()
                bubble:ClaimPrize()       
            end)
        end;
    end;
    Flag = "auto_claim_prizes";
})

local Dashboard__ClaimDaily = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Claim Daily";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_daily = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_daily do task.wait();
            task.spawn(function()
                bubble:ClaimDailyReward()       
            end)
        end;
    end;
    Flag = "auto_claim_daily";
})

local Dashboard__ClaimPlaytime = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Claim Playtime";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_playtime = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_playtime do task.wait();
            task.spawn(function()
                bubble:ClaimPlaytime()       
            end)
        end;
    end;
    Flag = "auto_claim_playtime";
})

local Dashboard__ClaimWheel = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Spin Wheel";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_spin_wheel = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_spin_wheel do task.wait();
            task.spawn(function()
                bubble:ClaimWheelSpin()       
            end)
        end;
    end;
    Flag = "auto_claim_wheel_spin";
})

local Dashboard__WinDoggyGame = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Win Doggy";
    Subtext = "Wins the Game at max Score";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_win_doggy_game = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_win_doggy_game do task.wait();
            task.spawn(function()
                bubble:AutoWinDoggyGame()       
            end)
        end;
    end;
    Flag = "auto_win_doggy_game";
})

local Dashboard__ClaimSeason = Sections.Dashboard.Automatic:CreateToggle({
    Text = "Auto Claim Season";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_season = v;

        while Kaugummi.Config.Dashboard.Farm.Unlocks.auto_claim_season do task.wait();
            task.spawn(function()
                bubble:ClaimSeason()       
            end)
        end;
    end;
    Flag = "auto_claim_season";
})

local Dashboard__CollectCoins = Sections.Dashboard.Farm:CreateToggle({
    Text = "Auto Collect Coins";
    Subtext = "";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Farm.collect_loot = v;

        while Kaugummi.Config.Dashboard.Farm.collect_loot do task.wait();
            task.spawn(function()
                bubble:CollectCoins()       
            end)
        end;
    end;
    Flag = "collect_coins";
})

local Dashboard__PotionSelected = Sections.Dashboard.Potion:CreateDropdown({
    Text = "Potions";
    Subtext = "Choose a Potion";
    Alignment = "Left";
    Choices = bubble.Potions;
    Multi = true;
    Default = Kaugummi.Config.Dashboard.Shop.potion_type;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.potion_type = v;
    end;
    Flag = "potion_type";
})

local Dashboard__PotionCount = Sections.Dashboard.Potion:CreateSlider({
    Text = "Potion Type";
    SubText = "1-Low 6-Highest";
    Alignment = "Left";
    Default = Kaugummi.Config.Dashboard.Shop.potion_count;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.potion_count = v;
    end;
    Flag = "potion_count";
    Floats = 0;
    Limits = { 1, 6 };
    Increment = 1;
})

local Dashboard__PotionLimit = Sections.Dashboard.Potion:CreateSlider({
    Text = "Potion Count";
    Subtext = "Max times to use potion before stopping";
    Alignment = "Left";
    Default = Kaugummi.Config.Dashboard.Shop.auto_use_potion_limit;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.auto_use_potion_limit = v;
    end;
    Flag = "auto_use_potion_limit";
    Floats = 0;
    Limits = { 1, 100 };
    Increment = 1;
})

local Dashboard__AutoPotion = Sections.Dashboard.Potion:CreateToggle({
    Text = "Auto use Potion";
    Subtext = "";
    Alignment = "Left";
    Default = Kaugummi.Config.Dashboard.Shop.auto_use_potion;
    Callback = function(v)
        Kaugummi.Config.Dashboard.Shop.auto_use_potion = v;
        bubble:AutoPotionHandler()
    end;
    Flag = "auto_use_potion";
})

local Dashboard__AutoPotionSettings = Dashboard__AutoPotion:CreateSettings();
Dashboard__AutoPotionSettings:CreateToggle({
    Text = "Auto Use every 30 minutes",
    Callback = function(v)
        if v then Dashboard__AutoPotion:Fire(); end;
    end,
    Flag = "auto_use_potioninterval",
});

local Misc__RedeemAllCodes = Sections.Misc.Misc:CreateButton({
    Text = "Redeem All Codes";
    Alignment = "Left";
    Callback = function()
        task.spawn(function()
            bubble:RedeemAllCodes()
        end)
    end;
})

Misc__ZoneToTeleport = Sections.Misc.Teleport:CreateDropdown({
    Text = "Select Zone";
    Subtext = "";
    Alignment = "Left";
    Choices = Kaugummi.Game.Zones;
    Multi = false;
    Default = nil;
    Callback = function(v) 
        Kaugummi.Config.Misc.selected_zone = v;
     end;
    Flag = "selected_zone";
})

Misc__TeleportZone = Sections.Misc.Teleport:CreateButton({
    Text = "Teleport";
    Alignment = "Left"; 
    Callback = function() 
        bubble:ZoneTeleport();

        if Kaugummi.Config.Misc.selected_zone == "Event" then 
            Dashboard__EventEggTP:Fire()
        end;
     end;
})

local Misc__UnlockAllIslands; Misc__UnlockAllIslands = Sections.Misc.Teleport:CreateButton({
    Text = "Unlock all Islands";
    Alignment = "Left";
    Callback = function()
        local islandsFolder = workspace.Worlds["The Overworld"]:FindFirstChild("Islands");

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

local UI__Toggle = Sections.Config.Ui:CreateKeybind({
    Text = "Toggle UI";
    Subtext = "Default is N" ;
    Alignment = "Left"; 
    Default = "N"; 
    Callback = function() 
        Window:Visibility();
    end;
    Flag = "ui_keybind";
});

local UI__Exit = Sections.Config.Ui:CreateButton({
    Text = "Exit";
    Alignment = "Center"; 
    Callback = function() 
        Window:Exit();
    end;
});

local uiSave = Sections.Config.Ui:CreateButton({
    Text = "Save Config",
    Callback = function()
        Library:Save();
    end,
});

uiSave:CreateSettings():CreateToggle({
    Text = "Auto Save",
    Callback = function(v)
        Kaugummi.Ui.auto_save = v;
        spawn(function()
            while Kaugummi.Ui.auto_save do
                uiSave:Fire();
                task.wait(15)
            end;
        end);
    end,
    Flag = "auto_save",
});

local AutoLoad_Toggle = Sections.Config.Ui:CreateToggle({
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

local Debug_Toggle = Sections.Config.Ui:CreateToggle({
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

local Config__FpsU = Sections.Config.Performance:CreateButton({
    Text = "Unlock Fps";
    Alignment = "Left"; 
    Callback = function() 
        if (not setfpscap) then print("Executor not supported"); return; end;

        setfpscap(math.max(60, 9999));
        print("FPS: " ..tostring(last_fps));
    end;
});

getgenv().theme_set = nil;
local Config__ThemeSet = Sections.Config.Theme:CreateInput({
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

local Config__DarkTheme = Sections.Config.Theme:CreateToggle({
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

local Config__AvailableThemes = Sections.Config.Theme:CreateLog({
    Default = { "Dark", "Light", "Midnight", "Bloom", "Minecraft", "Windows 11", "Lotus Dark", "Default" };
})

local Misc__HatchableEggs = Sections.Misc.Pets:CreateDropdown({
    Text = "Choose Egg";
    Subtext = "";
    Alignment = "Left";
    Choices = bubble:GetAllEggs();  
    Multi = false;
    Default = nil;
    Callback = function(v) 
        Kaugummi.Config.Dashboard.Pets.selected_egg = v
    end;
    Flag = "choosen_egg";
})

local Misc__HatchEgg; Misc__HatchEgg = Sections.Misc.Pets:CreateToggle({
    Text = "Auto Open";
    Subtext = "Hatches the egg for you";
    Alignment = "Left";
    Default = false;
    Callback = function(enabled) 
        Kaugummi.Config.Dashboard.Pets.hatch_egg = enabled;

        while Kaugummi.Config.Dashboard.Pets.hatch_egg do task.wait()
            task.spawn(function()
                local ohString1 = "HatchEgg"
                local ohString2 = tostring(Kaugummi.Config.Dashboard.Pets.selected_egg)
                local ohNumber3 = 6
                
                network.Remote.Event:FireServer(ohString1, ohString2, ohNumber3)
            end)
        end
    end;
    Flag = "auto_hatch";
})

local Misc__HatchEggAnim; Misc__HatchEggAnim = Sections.Misc.Pets:CreateToggle({
    Text = "Disable Animation";
    Subtext = "Rejoin to undo";
    Alignment = "Left";
    Default = false;
    Callback = function(enabled) 
        bubble:NoHatchAnim(enabled)
    end;
    Flag = "auto_hatch_disableanim";
})


local Misc__Refresh = Sections.Misc.Pets:CreateButton({
    Text = "Refresh Eggs";
    Callback = function()
        local reEggs = bubble:GetAllEggs();

        task.wait(1)
        Misc__HatchEgg:SetOptions(reEggs);
    end;
})

local Config__AntiAfk = Sections.Config.Performance:CreateToggle({
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

local Dashboard__BlackMarketProducts = Sections.Dashboard.Shop:CreateDropdown({
    Text = "Market Products";
    Subtext = "";
    Alignment = "Left";
    Choices = blackmarket_products;
    Multi = true;
    Default = nil;
    Callback = function(Value)
         Kaugummi.Config.Dashboard.Shop.auto_black_marketselected = Value;
        end;
    Flag = "black_market_products";
})

Dashboard__AutoBlackMarket = Sections.Dashboard.Shop:CreateToggle({
    Text = "Auto Buy Blackmarket",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(enabled)
        Kaugummi.Config.Dashboard.Shop.auto_black_market = enabled
        if enabled then
            task.spawn(function()
                while Kaugummi.Config.Dashboard.Shop.auto_black_market do
                    bubble:BuyBlackmarket()
                    task.wait(5)
                end
            end)
        end
    end,
    Flag = "black_market_autobuy"
})

local Dashboard__EventEggSelected = Sections.Dashboard.Event:CreateDropdown({
    Text = "Select Egg";
    Subtext = "";
    Alignment = "Left";
    Choices = {"Bunny Egg", "Pastel Egg"};
    Multi = false;
    Default = nil;
    Callback = function(Value)
         Kaugummi.Config.Dashboard.Pets.selected_egg = Value;
        end;
    Flag = "event_hatch_selected";
})

local Dashboard__EventEgg = Sections.Dashboard.Event:CreateToggle({
    Text = "Auto Hatch",
    Subtext = "",
    Alignment = "Left",
    Default = false,
    Callback = function(enabled)
        Kaugummi.Config.Dashboard.Pets.hatch_egg = enabled

        if enabled then
            task.spawn(function()
                Dashboard__EventEggTP:Fire()
                task.wait(2)
    
             if Kaugummi.Config.Dashboard.Pets.selected_egg == "Bunny Egg" then 
                bubble:bypass_teleport(teleport_table.bunny_egg)
             elseif Kaugummi.Config.Dashboard.Pets.selected_egg == "Pastel Egg" then 
                bubble:bypass_teleport(teleport_table.pastel_egg)
             end;
    
                while Kaugummi.Config.Dashboard.Pets.hatch_egg do
                    task.wait(1.2);
                    network.Remote.Event:FireServer("HatchEgg", tostring(Kaugummi.Config.Dashboard.Pets.selected_egg), 6)
                end;
            end)
        end;
    end,
    Flag = "event_hatch"
})

Dashboard__EventEggTP = Sections.Dashboard.Event:CreateButton({
    Text = "Teleport to Event";
    Alignment = "Left";
    Callback = function()
    local ohString1 = "Teleport"
    local ohString2 = "Workspace.Event.Portal.Spawn"
    network.Remote.Event:FireServer(ohString1, ohString2)
    end;
})

Library:Notify("Script loaded for: \n" ..tostring(bubble:GetGame()), 5, "Tuah")
Library:Load();
