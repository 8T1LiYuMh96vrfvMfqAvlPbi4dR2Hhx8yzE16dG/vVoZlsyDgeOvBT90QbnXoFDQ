-- // ENTRY
-- // v.1.21

repeat task.wait(math.floor(1, 2, 3)) until game:IsLoaded();

local Debug = setmetatable({
    Enabled = false,
    Logs = {},
    Levels = { INFO = "🟢 INFO", WARN = "🟡 WARNING", ERROR = "🔴 ERROR" }
}, {
    __index = function(self, key)
        return rawget(self, key) or function(...) return self:Log("[MISSING FUNC]: " .. key, "ERROR") end
    end
})

function Debug:Toggle(state)
    self.Enabled = state
    print(("[DEBUG] Mode: %s"):format(state and "Enabled ✅" or "Disabled ❌"))
end

function Debug:Log(msg, level)
    level = self.Levels[level] or self.Levels.INFO
    local formattedMsg = ("[%s]: %s"):format(level, msg)
    if self.Enabled then
        table.insert(self.Logs, formattedMsg)
        print(formattedMsg)
    end
end

function Debug:Clear()
    self.Logs = {}
    print("[DEBUG] Logs cleared")
end

function Debug:SaveLogs()
    local json = game:GetService("HttpService"):JSONEncode(self.Logs)
    writefile("DebugLogs.json", json)
    print("[DEBUG] Logs saved to DebugLogs.json")
end

function Debug:PrintLogs()
    print(("[DEBUG] Log History:\n%s"):format(#self.Logs > 0 and table.concat(self.Logs, "\n") or "No logs recorded"))
end

local HttpService = game:GetService("HttpService")
local Status_Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG/vVoZlsyDgeOvBT90QbnXoFDQ/refs/heads/main/b8z3Qp9lJ4x7k2mD5tnvC6hwYr/Status.lua"

local Check_ = setmetatable({
    Status = "N/A",
    Version = "N/A",
    LastUpdated = "N/A",
    Options = {
        Online = "✅ Operational",
        Testing = "⚠️ Testing Phase",
        Down = "❌ Under Maintenance",
        Beta = "Working but Early Development, Expect Bugs", BETA = "Working but Early Development, Expect Bugs"
    }
}, {
    __index = function(self, key)
        return rawget(self, key) or function(...) return Debug:Log("[MISSING FUNC]: " .. key, "ERROR") end;
    end;
})

function Check_:SetStatus(newStatus)
    if self.Options[newStatus] then
        self.Status = newStatus;
    else
        Debug:Log(("Invalid status attempted: %s"):format(tostring(newStatus)), "ERROR");
        print("[ERROR] Invalid Status: " .. tostring(newStatus));
    end;
end;

function Check_:FetchStatus()
    local success, response = pcall(function()
        return request({Url = Status_Repo, Method = "GET"});
    end)

    if success and response and response.StatusCode == 200 then
        local statusData = HttpService:JSONDecode(response.Body);
        if statusData and statusData.Status then
            self:SetStatus(statusData.Status);
            self.Version = statusData.Version or "N/A";
            self.LastUpdated = statusData.Updated_At or "N/A";

            Debug:Log(("Fetched Status: %s | Version: %s | Last Updated: %s"):format(
                self.Options[self.Status] or "Unknown Status", self.Version, self.LastUpdated
            ), "INFO")

            self:CheckStatus()
        else
            Debug:Log("Invalid Data Format", "ERROR");
            print("[ERROR] Invalid JSON format in Status.lua");
        end;
    else
        Debug:Log("Failed to fetch from GitHub", "ERROR");
        print("[ERROR] Failed to fetch Status.lua from GitHub");
    end;
end;

function Check_:CheckStatus()
    if not self.Status then
        Debug:Log("Status is nil or uninitialized", "ERROR");
        return false
    end;

    if self.Status == "Down" then
        game:GetService("Players").LocalPlayer:Kick(("[SCRIPT]: %s - Check our Discord for updates!"):format(self.Options.Down));
        return true;
    elseif self.Status == "Beta" or self.Status == string.lower("BETA") or self.Status == string.upper("beta") then
        print("Status Checked, " ..tostring(Check_.Status).. " Works but expect Bugs to happen!");
        return false;
    end;


    Debug:Log(("Current Status: %s | Version: %s | Last Updated: %s"):format(
        self.Options[self.Status] or "Unknown Status", self.Version, self.LastUpdated
    ), "INFO")
    return false
end;

local startTime = tick() 
Check_:FetchStatus();
print("[SCRIPT] Status: ((" .. tostring(Check_.Status) .. "))");
task.wait(math.random(.2,1))
print("[SCRIPT] Version: ((" .. tostring(Check_.Version) .. "))");
task.wait(math.random(.3,1))
print("[SCRIPT] Last Updated: ((" .. tostring(Check_.LastUpdated) .. "))");
task.wait(math.random(.4,1))
local elapsed = tick() - startTime 
print(("[SCRIPT]: Authenticated in %.4f seconds"):format(elapsed))

getgenv().Debug = Debug;
getgenv().StatusChecker = Check_;

function GetGame()
    local marketService = game:GetService("MarketplaceService");
    local info = marketService:GetProductInfo(game.PlaceId);
    return info.Name, game.PlaceId, game.PlaceVersion;
end;

local gameName, placeId, version_ = GetGame();
print("Game Found: " .. (gameName or "Unknown"));
print("Place ID: " .. (placeId or "Unknown"));
print("Version: " .. (version_ or "Unknown"));

local exec = getexecutorname() or "Unknown";
print("Checking Executor: " .. exec);
if exec == "Xeno" or exec == "Luna" or exec == "Solara" then
    warn("Executor " .. exec .. " is not supported");
    if Kick() ~= nil then
    LP:Kick("[Tempa]: Not Supported - Consider switching Executors!")
    end
    return;
end;


-- // Discord Logging - Not added until needed for Whitelist purposes and Data
local User_Logs = nil;

-- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

LP = game:GetService("Players").LocalPlayer;
local PLRS = game:GetService("Players");
local TS_S = game:GetService("TeleportService");
local UIS = game:GetService("UserInputService");
local CHAR = LP.Character or LP.CharacterAdded:Wait();
local HRP = CHAR:WaitForChild("HumanoidRootPart");
local TS = game:GetService("TweenService");
local RS = game:GetService("ReplicatedStorage");
local RUN_S = game:GetService("RunService");
local HTTP = game:GetService("HttpService");
local HUMANOID = CHAR:WaitForChild("Humanoid");
local VIM = game:GetService("VirtualInputManager")
local TPSERV = game:GetService("TeleportService")
local WORK = workspace;
DELAY = math.random(5,10);
ENV = (getgenv and getgenv() or shared);
LOAD = (loadstring or load)
TICK = tick;
SSUB = string.sub;
MATH_F = math.floor;
CF = CFrame.new;
V3 = Vector3.new;
TS_SP = task.spawn;
OS = os.clock;
s_l = string.lower;
s_u = string.upper;
s_gsub = string.gsub;
s_byte = string.byte; 
s_char = string.char;
s_rep = string.rep;
s_find = string.find; 
s_match = string.match;
t_con = table.concat;
succ = "Works!";
err = "Error!";
saveeeed = "Saved Config!!"

local FindFootball = (function()
    local Football = WORK:FindFirstChild("Football") or WORK:WaitForChild("Football", 1);

    if not Football then
        for _, playerModel in ipairs(WORK:GetChildren()) do
            if playerModel:IsA("Model") and playerModel:FindFirstChild("Football") then
                Football = playerModel:FindFirstChild("Football");
                break;
            end
        end
    end

    return Football;
end)

-- // Ingame
local Football = FindFootball();
BallHitbox = workspace:WaitForChild("Football"):WaitForChild("Hitbox", 1);
local PlayerStats = cloneref(LP:WaitForChild("PlayerStats"));
local InFlow = cloneref(PlayerStats:WaitForChild("InFlow"));
local GameScored = cloneref(RS:WaitForChild("GameValues"):WaitForChild("Scored"));
local Flow = cloneref(PlayerStats:WaitForChild("Flow"));
local RunService = cloneref(game:GetService("RunService"));
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));
local Packages = cloneref(ReplicatedStorage:WaitForChild("Packages"));
local Controllers = cloneref(ReplicatedStorage:WaitForChild("Controllers"));
local Knit = cloneref(Packages:WaitForChild("Knit"));
local Services = cloneref(Knit:WaitForChild("Services"));
local StaminaService = cloneref(Services:WaitForChild("StaminaService"));
local StaminaRE = cloneref(StaminaService:WaitForChild("RE"));
local DecreaseStamina = cloneref(StaminaRE:WaitForChild("DecreaseStamina"));
local AbilityController = require(Controllers:WaitForChild("AbilityController")); 
local ballControllerModule = require(ReplicatedStorage.Controllers.BallController);
local IsRagdoll = cloneref(CHAR:WaitForChild("IsRagdoll")) 

local default_config = {
    ["UI"] = {
        ["AutoLoad"] = false;
        ["Debug"] = false;
        ["ToggleKey"] = nil;
        ["Discord"] = {
            ["Invite1_Week"] = "https://discord.gg/vcPWM2vB";
            ["Invite2_Forever"] = "https://discord.gg/rqmwc6MydQ"
        };
        ["Save"] = false;
    };
    ["ESP"] = {
        ["Name_Esp"] = false;
        ["Name_Size"] = 16;
        ["Name_Toggle"] = "K" or nil;
        ["Flow_Esp"] = false;
        ["Flow_Size"] = 16;
        ["Style_Esp"] = false;
        ["Style_Size"] = 16;
        ["Ball_Tracer"] = {
            ["Enabled"] = false;
            ["Thickness"] = 2;
            ["Color"] = Color3.new(0.823529, 0.592156, 1);
        };
        ["Ball_Highlight"] = false;
    };
    ["Misc"] = {
        ["Skill_No_Cd"] = false;
        ["Infinite_Stam"] = false;
        ["Infinite_Stam2"] = false;
        ["Anti_Rag"] = false;
        ["Temp_Flow"] = nil;
        ["Ball_Return"] = false;
        ["AutoFlow"] = false;
        ["AutoAwaken"] = false;
        ["Lock_Ball"] = { 
            ["Camera"] = false;
            ["Character"] = false;
        }; 
        ["WalkSpeed"] = {
            ["WS_Enabled"] = false;
            ["WS_Value"] = false;
            ["WS_Cleanup"] = {};
        };
        ["Auto_Steal"] = {
            ["Steal_Enabled"] = false;
            ["Steal_Value"] = 5;
        };    
        ["Auto_Dribble"] = {
            ["Dribble_Enabled"] = false;
            ["Dribble_Value"] = 5;
        };  
        ["Auto_Abilities"] = {
            ["Ability_B"] = false;
            ["Ability_C"] = false;
            ["Ability_V"] = false;
        };
        ["InfiniteJump"] = false;
    };
    ["Dashboard"] = {
        ["AutoFarm"] = false;
        ["AutoFarm_Config"] = {
            ["Shot_Delay"] = .2;
            ["Teleport_Height"] = 0;
            ["Possesion_Wait"] = .1;
            ["Ball_Pickup"] = .1;
        };
        ["AutoFarm_InstantGoal"] = {
            ["Enabled"] = false;
            ["Delay"] = .5;
        };
        ["Spinning"] = {
            ["FlowSpin_Enabled"] = false, 
            ["StyleSpin_Enabled"] = false, 
            ["LuckySpin_Flow"] = false, 
            ["LuckySpin_Style"] = false, 
        };
    };
    ["Auto Quest"] = {
        ["ClaimDaily"] = false;
    };
    ["Other"] = {
        ["Cursor"] = {
            ["Enabled"] = false;
            ["Thickness"] = 2;
            ["Radius"] = 5;
            ["Color"] = Color3.new(1, 1, 1);
        };
        ["Connection"] = nil;
        ["RagdollConnection"] = nil;
        ["Shooting"] = false;
        ["Revert"] = {
            ["BreakEverything"] = false;
        };
        ["CameraConnection"] = nil;
    };
    ["Cache__"] = {...}
}
local AutoLoad = (function()
    if default_config.UI.AutoLoad == true and identifyexecutor() then 
        pcall(function()
            print("AutoLoad, is on REALOMGWOWOOAS")
            queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG/vVoZlsyDgeOvBT90QbnXoFDQ/refs/heads/main/b8z3Qp9lJ4x7k2mD5tnvC6hwYr/BLR.lua"))()]])
        end)
    else
        print(err)
        Debug:Log("Auto Load issue", "WARN") Debug:SaveLogs()
    end
end);
local Noclip = (function(state)
    for _, v in pairs(workspace.Goals:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = not state; 
        end;
    end;
    for _, v in pairs(workspace.SmallSquare:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = not state; 
        end;
    end;
end)
randomJoinTeam = (function()
    local player = game:GetService("Players").LocalPlayer;
    local currentTeam = player.Team;
    local teamChoice;
    if currentTeam and (currentTeam.Name == "Home" or currentTeam.Name == "Away") then
        teamChoice = currentTeam.Name == "Home" and "Away" or "Home"
    else
        teamChoice = math.random(1, 2) == 1 and "Home" or "Away"
        teamChoice = teamChoice == "Home" and "Away" or "Home" 
    end
    local positions = {"CF", "CM", "LW", "RW", "GK"};
    local gameStateValue = game:GetService("ReplicatedStorage").GameValues:WaitForChild("State");
    pcall(function()
        local teamService = game:GetService("ReplicatedStorage").Packages.Knit.Services.TeamService.RE;
        if gameStateValue.Value == "Playing" then
        for _, position in ipairs(positions) do
            teamService.Select:FireServer(teamChoice, position) ;
            task.wait(0.2);
            local currentPlayer = game:GetService("Players").LocalPlayer;
            local newTeam = currentPlayer.Team;

            if newTeam and newTeam.Name == teamChoice then
                print("[SCRIPT] Successfully joined " .. teamChoice .. " as " .. position);
                break
            end;
        end;
    else 
        print(err);
        Debug:Log("Random Team Join issue", "WARN"); Debug:SaveLogs();
        end;
    end);
end);
local previousPosition = nil;
local teleportToFootball = function()
    local Football = workspace:FindFirstChild("Football") 
    
    if not Football and LP.Character then
        for _, v in ipairs(LP.Character:GetChildren()) do
            if v:IsA("MeshPart") and v.Name == "Football" then
                Football = v
                break
            end
        end
    end

    if Football then
        local currentPos = Football.Position;
        if previousPosition and (currentPos - previousPosition).Magnitude > 2 then
            HRP.CFrame = CFrame.new(currentPos);
            previousPosition = currentPos;  
        elseif not previousPosition then
            HRP.CFrame = CFrame.new(currentPos);
            previousPosition = currentPos;  
        else
            print("Football position hasn't moved significantly");
        end;
        elseif not Football then 
        local Football_Check = Football or game:GetService("Workspace"):WaitForChild("Football");
    elseif Football:IsDescendantOf(PLRS) then
        HRP.CFrame = CFrame.new(Football.Position);
        previousPosition = Football.Position;
    else
        print("Football not found or not in workspace or a player's model");
        Debug:Log("Teleport to Football Issue - Character or Ball not found", "WARN");
        Debug:SaveLogs();
    end;
end;
local enableInfiniteStamina = (function()
    local stats = game.Players.LocalPlayer:WaitForChild("PlayerStats")
    local staminaService = game:GetService("ReplicatedStorage").Packages.Knit.Services:FindFirstChild("StaminaService")

        if staminaService then
            local decreaseStamina = staminaService.RE.DecreaseStamina
            decreaseStamina:FireServer(math.sqrt(-1)) 
            task.wait()
        else
           print("error")
        end
        stats.Stamina.Value = 100
end);
local monitorRagdoll = (function()
    local IsRagdoll = cloneref(CHAR:WaitForChild("IsRagdoll")) 
    if default_config.Other.RagdollConnection then
        default_config.Other.RagdollConnection:Disconnect(); 
    end
    default_config.Other.RagdollConnection = IsRagdoll:GetPropertyChangedSignal("Value"):Connect(function()
        if ENV.AntiRagdoll and IsRagdoll.Value == true then
            if IsRagdoll.Value == true then
                IsRagdoll.Value = false;
            end;
        end;
    end);
end);
local disableRagdoll = (function()
    if IsRagdoll.Value == true then
        IsRagdoll.Value = false
    end;
end);
local enableAntiRagdoll = (function()
    monitorRagdoll();
    disableRagdoll();

    LP.CharacterAdded:Connect(function(newCharacter)
        CHAR = newCharacter
        IsRagdoll = cloneref(newCharacter:WaitForChild("IsRagdoll"))
        monitorRagdoll();
        disableRagdoll();
    end);
end);
local disableAntiRagdoll = (function()
    if default_config.Other.RagdollConnection then
        default_config.Other.RagdollConnection:Disconnect()
        default_config.Other.RagdollConnection = nil
    end;
end);
local Lock_OnBall = function()
    task.spawn(function()
        while default_config.Misc.Lock_Ball and (default_config.Misc.Lock_Ball.Character or default_config.Misc.Lock_Ball.Camera) do
            if Football and CHAR and HRP then
                local dist = (Football.Position - HRP.Position).Magnitude

                if default_config.Misc.Lock_Ball.Character and dist <= 200 then
                    local LV = (Football.Position - HRP.Position).Unit
                    local currentCFrame = HRP.CFrame
                    local targetCFrame = CFrame.new(HRP.Position, HRP.Position + LV)
                    
                    local smoothingFactor = 0.1
                    HRP.CFrame = currentCFrame:Lerp(targetCFrame, smoothingFactor)
                end;

                if default_config.Misc.Lock_Ball.Camera then
                    if not default_config.Other.CameraConnection then
                        default_config.Other.CameraConnection = RUN_S.Heartbeat:Connect(function()
                            local c = workspace.CurrentCamera
                            c.CFrame = CFrame.new(c.CFrame.Position, Football.Position)
                            task.wait()
                        end);
                    end;
                else
                    if default_config.Other.CameraConnection then
                        default_config.Other.CameraConnection:Disconnect()
                        default_config.Other.CameraConnection = nil
                    end;
                end;
            else
                warn("Football or HRP not found - Issue Lock on Ball Camera", type(Football))
                Debug:Log("Seems like Football or HRP Issue =; not found", "WARN")
            end;
            
            task.wait(0.01)
        end;

        if default_config.Other.CameraConnection then
            default_config.Other.CameraConnection:Disconnect();
            default_config.Other.CameraConnection = nil;
        end;
    end);
end;
local AutoSteal = (function()
    pcall(function()
        while default_config.Misc.Auto_Steal.Steal_Enabled do
            if not Football then
                task.wait(.5);
                return;
            end

            for _, playerInstance in ipairs(game:GetService("Players"):GetPlayers()) do
                if playerInstance ~= game.Players.LocalPlayer then
                    local enemyCharacter = playerInstance.Character
                    if enemyCharacter and enemyCharacter:FindFirstChild("HumanoidRootPart") then
                        local enemyRootPart = enemyCharacter.HumanoidRootPart

                        if Football:IsDescendantOf(enemyCharacter) then
                            local distance = (enemyRootPart.Position - HRP.Position).Magnitude

                            if distance <= default_config.Misc.Auto_Steal.Steal_Value then
                                local lookVector = (enemyRootPart.Position - HRP.Position).Unit
                                HRP.CFrame = CFrame.new(HRP.Position, HRP.Position + lookVector)

                                VIM:SendKeyEvent(true, "E", false, game)
                                task.wait(0.1)
                                VIM:SendKeyEvent(false, "E", false, game)
                                task.wait(0.3)
                            end;
                        end;
                    end;
                end;
            end;

            if Football.Parent == workspace then
                local distanceToBall = (Football.Position - HRP.Position).Magnitude
                if distanceToBall <= default_config.Misc.Auto_Steal.Steal_Value then
                    HRP.CFrame = CFrame.new(Football.Position)

                    VIM:SendKeyEvent(true, "E", false, game)
                    task.wait(0.1)
                    VIM:SendKeyEvent(false, "E", false, game)
                    task.wait(0.3)
                end;
            end;
            task.wait();
        end;
    end);
end);
local AutoDribble = (function()
    pcall(function()
        while default_config.Misc.Auto_Dribble.Dribble_Enabled do
            if Football:IsDescendantOf(CHAR) then
                for _, playerInstance in ipairs(PLRS:GetPlayers()) do
                    if playerInstance ~= LP then
                        local enemyCharacter = playerInstance.Character
                        if enemyCharacter and enemyCharacter:FindFirstChild("HumanoidRootPart") then
                            local enemyRootPart = enemyCharacter:WaitForChild("HumanoidRootPart")
                            local distance = (enemyRootPart.Position - HRP.Position).Magnitude

                            if distance <= default_config.Misc.Auto_Dribble.Dribble_Value then 
                                print("tried to dribble!!")   

                                VIM:SendKeyEvent(true, "Q", false, game)
                                task.wait(0.1)
                                VIM:SendKeyEvent(false, "Q", false, game)
                                task.wait(0.3)
                            end;
                        end;
                    end;
                end;
            end;
            task.wait();
        end;
    end);
    return;
end);
local AutoAbility = (function(key)
    pcall(function()
        while default_config.Misc.Auto_Abilities["Ability_" ..key] == true do
            VIM:SendKeyEvent(true, key, false, game)
            task.wait(0.1)
            VIM:SendKeyEvent(false, key, false, game)
            task.wait(1) 
        end;
    end);
end);
local j_connect 
local infiniteJump = function()
    if default_config.Misc.InfiniteJump then
        j_connect = RunService.Heartbeat:Connect(function()
            local humanoid = LP.Character and LP.Character:FindFirstChildOfClass('Humanoid');
            local rootPart = LP.Character and LP.Character.PrimaryPart;

            if humanoid and rootPart and UIS:IsKeyDown(Enum.KeyCode.Space) then
                local velocity = rootPart.Velocity;
                rootPart.Velocity = Vector3.new(velocity.X, 50, velocity.Z);
            end;
        end);
    end;
end;
--[[local infiniteStamina = function()
    local stats = game.Players.LocalPlayer:WaitForChild("PlayerStats")
    local staminaService = RS:FindFirstChild("StaminaService")
    local decreaseStamina = staminaService.RE.DecreaseStamina
    local last = tick();
    RunService.Stepped:Connect(function()
        if (tick()-last <= 0.1) then return; end;
        last = tick();

        decreaseStamina:FireServer(-1000);
        stats.Stamina.Value = 100
    end)
end]]
local DailyQuest = (function()
    local service = game:GetService("ReplicatedStorage").Packages.Knit.Services.QuestsService.RE.Quest;
    if default_config["Auto Quest"].ClaimDaily then 
        -- // Daily
        game:GetService("ReplicatedStorage").Packages.Knit.Services.DailyRewardsService.RF.Redeem:InvokeServer();

        if service ~= nil then
            for i = 1, 3 do 
                service:FireServer("Quest" ..i);
                task.wait(DELAY);
            end;
        end;
    end;
end);
local returnBall = (function()
    if Football ~= nil then
        local direction = (HRP.Position - Football.Position).Unit;
        local speed = 110;
        Football.AssemblyLinearVelocity = direction * speed + Vector3.new(0,2,0);
        task.wait(0.005);
    end;
end);
local serv_hop = (function()
    local TeleportService = game:GetService("TeleportService");
    local PlaceId = game.PlaceId;
    local ServersUrl = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100";

    local succ, resp = pcall(function()
        return HTTP:JSONDecode(game:HttpGet(ServersUrl));
    end);

    if succ and resp and resp.data then
        for _, server in ipairs(resp.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LP);
                return;
            end
        end
    end

    warn("No servers found ;/");
end);
local join_lowest = (function()
    local PlaceId = game.PlaceId;
    local ServersUrl = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100";

    local succ, resp = pcall(function()
        return HTTP:JSONDecode(game:HttpGet(ServersUrl));
    end);

    if succ and resp and resp.data then
        local lowest_server;
        local lowest_players = math.huge;

        for _, server in ipairs(resp.data) do
            if server.playing < lowest_players and server.id ~= game.JobId then
                lowest_server = server.id;
                lowest_players = server.playing;
            end
        end

        if lowest_server then
            TPSERV:TeleportToPlaceInstance(PlaceId, lowest_server, LP);
            return;
        end
    end

    warn("No available low Servers servers found ;/");
end);
local rejoin = (function()
    TPSERV:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP);
end);


-- // UI
local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG"
local Library = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/aSbQ28Y1UMk1"))() 
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))() 
local FileService = Setup:File();
Setup:Basics()

Library.Paths.Folder = "..\\ "..LP.UserId .. "" .. "_Tuah"
Library.Paths.Data = "\\ " .. LP.DisplayName .. "_Data"
Library.Paths.Themes = "\\Themes"
local uiAutoSave = false;

local Window = Library:CreateWindow({
    Title = "Tuah";
    Icon = { "rbxassetid://97083803604594", UDim2.new(0.27, 0, 0.22, 0) },
})

local Dashboard_Tab = Window:CreateTab({
    Title = "Dashboard";
    Icon = "rbxassetid://130289250570665";
});
local Misc_Tab = Window:CreateTab({
    Title = "Miscellaneous";
    Icon = "rbxassetid://130819053773683";
});
local ESP_Tab = Window:CreateTab({
    Title = "Esp";
    Icon = "rbxassetid://138343944779037";
});
local Spin_Tab = Window:CreateTab({
    Title = "Spin";
    Icon = "rbxassetid://96951878795398";
});
local Quest_Tab__ = Window:CreateTab({
    Title = "Auto Quest";
    Icon = "rbxassetid://100106290165177";
});
local Config_Tab = Window:CreateTab({
    Title = "Config";
    Icon = "rbxassetid://95750721918044";
});

local Section_Config = Config_Tab:CreateSection({
    Title = "Other";
    Side = "Left"; 
});

local SectionSpin = Spin_Tab:CreateSection({
    Title = "Options";
    Side = "Left"; 
});
local SectionSpin2 = Spin_Tab:CreateSection({
    Title = "Options";
    Side = "Right"; 
});

local Section2_Config = Config_Tab:CreateSection({
    Title = "Cursor Settings";
    Side = "Right"; 
});

local Section3_Info = Config_Tab:CreateSection({
    Title = "Information";
    Side = "Left"; 
});

local Section_Dashboard = Dashboard_Tab:CreateSection({
    Title = "Farming";
    Side = "Left"; 
});
local Section_Dashboard_Quick = Dashboard_Tab:CreateSection({
    Title = "Quick Farm";
    Side = "Right"; 
});
local Section_ESP = ESP_Tab:CreateSection({
    Title = "Player ESP";
    Side = "Left"; 
});
local Section_ESP_Flow = ESP_Tab:CreateSection({
    Title = "Flow ESP";
    Side = "Right"; 
});
local Section_ESP_Style = ESP_Tab:CreateSection({
    Title = "Style ESP";
    Side = "Right"; 
});
local Section_ESP_Ball = ESP_Tab:CreateSection({
    Title = "Ball ESP";
    Side = "Left"; 
});
local Section_BallConfig = Dashboard_Tab:CreateSection({
    Title = "Ball Control";
    Side = "Right"; 
});

local Section_Full = Misc_Tab:CreateSection({
    Title = "Full-Unlocks",
    Side = "Right"
})

local Section_Other = Misc_Tab:CreateSection({
    Title = "Utilities",
    Side = "Left"
})
local Section_Auto = Misc_Tab:CreateSection({
    Title = "Automatic",
    Side = "Right"
})
local Section_Character = Misc_Tab:CreateSection({
    Title = "Character",
    Side = "Left"
})

local Section_Quest__ = Quest_Tab__:CreateSection({
    Title = "Claim",
    Side = "Left"
})

local Section_Troll = Misc_Tab:CreateSection({
    Title = "Troll",
    Side = "Right"
})

local Server_Control = Config_Tab:CreateSection({
    Title = "Server Control",
    Side = "Right"
})

local gameStateValue = game:GetService("ReplicatedStorage").GameValues:WaitForChild("State")

local function isGamePlaying()
    return gameStateValue.Value == "Playing"
end

gameStateValue:GetPropertyChangedSignal("Value"):Connect(function()
    if not isGamePlaying() and default_config.Dashboard.AutoFarm then
        print("Game ended, stopping AutoFarm.")
        default_config.Dashboard.AutoFarm = false
    end
end)

GameScored:GetPropertyChangedSignal("Value"):Connect(function()
    if GameScored.Value and default_config.Dashboard.AutoFarm then
        default_config.Dashboard.AutoFarm = false
        task.wait(4.5)
        default_config.Dashboard.AutoFarm = true
        task.spawn(startAutoFarm)
    end
end)

 function startAutoFarm()
    task.spawn(function()
        while default_config.Dashboard.AutoFarm do
            task.wait(0.1)

            if not isGamePlaying() then
                print("Game ended, stopping AutoFarm.")
                default_config.Dashboard.AutoFarm = false
                break
            end

            local team = LP.Team and LP.Team.Name or nil
            local goalpos
            local BallService = ReplicatedStorage.Packages.Knit.Services.BallService.RE

            if team == "Home" then
                goalpos = Vector3.new(-241, 11 + default_config.Dashboard.AutoFarm_Config.Teleport_Height, -44) 
            elseif team == "Away" then
                goalpos = Vector3.new(318, 11 + default_config.Dashboard.AutoFarm_Config.Teleport_Height, -48) 
            else
                print("Not on a valid team vro")
                task.wait(1)
                continue
            end

            local Football = workspace:FindFirstChild("Football")
            if not Football and LP.Character then
                for _, v in ipairs(LP.Character:GetChildren()) do
                    if v:IsA("MeshPart") and v.Name == "Football" then
                        Football = v
                        break
                    end
                end
            end

            if Football then
                local possession = false
                local maxAttempts = 20
                local attempts = 0
                
                while not Football:IsDescendantOf(LP.Character) and attempts < maxAttempts do
                    HRP.CFrame = Football.CFrame
                    task.wait(default_config.Dashboard.AutoFarm_Config.Ball_Pickup)
                    attempts += 1
                end

                if Football:IsDescendantOf(LP.Character) then
                    possession = true
                    print("Ball in Possesion")
                end

                if possession then
                    HRP.CFrame = CFrame.new(goalpos)
                    task.wait(default_config.Dashboard.AutoFarm_Config.Shot_Delay) 

                    BallService.Shoot:FireServer(110, nil, nil, Vector3.new(0, 0, 0))
                else
                    print("Max Attempts reached")
                end
            else
                print("Football not found")
            end
        end
    end)
end

local AutoFarm_Toggle = Section_Dashboard:CreateToggle({
    Text = "Auto Farm",
    Subtext = "Scores on Enemy Goal",
    Alignment = "Left",
    Default = default_config.Dashboard.AutoFarm,
    Callback = function(a)
        default_config.Dashboard.AutoFarm = a

        if a then
            task.spawn(startAutoFarm)
        end
    end
})

local Teleport_Height_Slider = Section_Dashboard:CreateSlider({
    Text = "Teleport Height",
    Alignment = "Left",
    Default = default_config.Dashboard.AutoFarm_Config.Teleport_Height,
    Callback = function(value)
        default_config.Dashboard.AutoFarm_Config.Teleport_Height = value
    end,
    Floats = 1,
    Limits = {0, 10},
    Increment = 0.1
})

local Ball_Pickup_Slider = Section_Dashboard:CreateSlider({
    Text = "Ball Pickup Delay",
    Alignment = "Left",
    Default = default_config.Dashboard.AutoFarm_Config.Ball_Pickup,
    Callback = function(value)
        default_config.Dashboard.AutoFarm_Config.Ball_Pickup = value
    end,
    Floats = 2,
    Limits = {0.2, 2},
    Increment = 0.05
})

local Shot_Delay_Slider = Section_Dashboard:CreateSlider({
    Text = "Shoot Delay",
    Alignment = "Left",
    Default = default_config.Dashboard.AutoFarm_Config.Shot_Delay,
    Callback = function(value)
        default_config.Dashboard.AutoFarm_Config.Shot_Delay = value
    end,
    Floats = 2,
    Limits = {0.1, 3},
    Increment = 0.1
})

local NoClip_Toggle = Section_Dashboard:CreateToggle({
    Text = "No Clip",
    Subtext = "Must Enable for Autofarm!",
    Alignment = "Left",
    Default = false,
    Callback = function(val)
        default_config.Dashboard.AutoFarm_Config.NoClip = val;

        task.spawn(function()
            while default_config.Dashboard.AutoFarm_Config.NoClip do
                Noclip(true); 
                task.wait(0.5);
            end;

            Noclip(false);
        end);
    end;
});

local Toggle_RandomTeam = Section_Dashboard:CreateToggle({
    Text = "Auto Join Match",
    Subtext = "Joins a random team",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        default_config.Dashboard.AutoFarm_Config.AutoJoinTeam = Value;

        if default_config.Dashboard.AutoFarm_Config.AutoJoinTeam == true then 
            randomJoinTeam();
        end

        while default_config.Dashboard.AutoFarm_Config.AutoJoinTeam do task.wait(1);
            task.spawn(function()
                local gameStateValue = game:GetService("ReplicatedStorage").GameValues:WaitForChild("State");

                gameStateValue:GetPropertyChangedSignal("Value"):Connect(function()
                    if gameStateValue.Value == "Playing" then 
                        randomJoinTeam();
                    else
                        print(err, "Game is not playing or State not found");
                    end;
                end);
            end);
        end;
    end;
});

local EntryLog = Section_Dashboard:CreateLog({
    Default = { };
});

function addAutofarmLog(entryText)
    EntryLog:AddEntry(entryText);
end;

local InstantGoal_Toggle = Section_Dashboard_Quick:CreateToggle({
    Text = "Instant Goal",
    Subtext = "Instantly Score Goals!",
    Alignment = "Left",
    Default = false,
    Callback = function(a)
        default_config.Dashboard.AutoFarm_InstantGoal.Enabled = a

        task.spawn(function()
            while default_config.Dashboard.AutoFarm_InstantGoal.Enabled do
                local BallService = ReplicatedStorage.Packages.Knit.Services.BallService.RE
                local Football = workspace:FindFirstChild("Football") 
                local currentTeam = LP.Team and LP.Team.Name or nil
                local goalPosition

                if currentTeam == "Home" then
                    goalPosition = Vector3.new(-241, 11, -44) 
                elseif currentTeam == "Away" then
                    goalPosition = Vector3.new(318, 11, -48) 
                else
                    print("You're not on a valid team, skipping goal.")
                    task.wait(1)
                    continue
                end

                if not Football and LP.Character then
                    for _, v in ipairs(LP.Character:GetChildren()) do
                        if v:IsA("MeshPart") and v.Name == "Football" then
                            Football = v
                            break
                        end
                    end
                end

                if Football then
                    BallService.Shoot:FireServer(110, nil, nil, Vector3.new(0, 0, 0))
                    task.wait(0.1)
                    if Football.Parent then
                        Football.CFrame = CFrame.new(goalPosition) 
                    else
                        print("Failed to teleport ball: No parent found.")
                    end
                else
                    print("Football not found in Workspace or Character!")
                end

                task.wait(default_config.Dashboard.AutoFarm_InstantGoal.Delay)
            end
        end)
    end
})

local Slider_InstantGoalDelay = Section_Dashboard_Quick:CreateSlider({
    Text = "Delay";
    Alignment = "Left";
    Default = .5;
    Callback = function(v)
        default_config.Dashboard.AutoFarm_InstantGoal.Delay = v
    end;
    Flag = "InstantGoalDelay";
    Floats = 0; 
    Limits = { .1, 10 };
    Increment = 0.1;
})

local Button_FlingBall = Section_BallConfig:CreateButton({
    Text = "Fling Ball";
    Alignment = "Left"; 
    Callback = function()
        task.spawn(function()
            task.wait();
            local gameStateValue = game:GetService("ReplicatedStorage").GameValues:WaitForChild("State");
            if gameStateValue.Value == "Playing" then 
            game:GetService("Workspace").Football.Velocity = Vector3.new(500, 200, 1000);
            end;
        end);
    end;
});

local Button_VoidBall = Section_BallConfig:CreateButton({
    Text = "Void Ball";
    Alignment = "Left"; 
    Callback = function()
    task.spawn(function()
        local gameStateValue = game:GetService("ReplicatedStorage").GameValues:WaitForChild("State");
        if gameStateValue.Value == "Playing" then 
            -- Football:Destroy()
            Library:Notify("Removed!", 3, "Alert"); 
        else 
            print("Not in Match");
            end;
        end);
    end;
});

local Button_TakeBall = Section_BallConfig:CreateButton({
    Text = "Bring Ball";
    Alignment = "Left"; 
    Callback = function()
        task.spawn(function()
            local gameStateValue = RS.GameValues:WaitForChild("State");
            if gameStateValue.Value == "Playing" then 
                Football.Position = HRP.Position + Vector3.new(0,3,0);
            else 
                print("Not in Match");
            end;
        end);
    end;
});

local Button_TpTOBall = Section_BallConfig:CreateButton({
    Text = "Tp to Ball";
    Alignment = "Left"; 
    Callback = function() 
        task.spawn(function()
            local gameStateValue = RS.GameValues:WaitForChild("State");
            if gameStateValue.Value == "Playing" then 
                teleportToFootball();
            else 
                print("Not in Match");
            end;
        end);
    end;
});

local UI_ToggleKeybind = Section_Config:CreateKeybind({
    Text = "Toggle UI";
    Subtext = "Default [N] to Toggle";
    Alignment = "Left"; 
    Default = "N"; 
    Callback = function(v) 
        Window:Visibility();
    end;
});

local AutoLoad_Toggle = Section_Config:CreateToggle({
    Text = "Auto Load";
    Subtext = "Loads script on Teleport";
    Alignment = "Left";
    Default = false;
    Callback = function(val)
        default_config.UI.AutoLoad = val;

        if default_config.UI.AutoLoad then 
            task.spawn(function()
                AutoLoad();
            end);
        end;
    end;
});

local Debug_Toggle = Section_Config:CreateToggle({
    Text = "Debug Mode";
    Subtext = "For Debugging Purposes";
    Alignment = "Left"; 
    Default = false;
    Callback = function(value) 
        Debug:Toggle(value);
    end;
});

local last_t = tick()
local last_fps = 0

RUN_S.RenderStepped:Connect(function()
    local current_t = tick()
    last_fps = math.floor(1 / (current_t - last_t))
    last_t = current_t
end)
local FPS_NoCapButton = Section_Config:CreateButton({
    Text = "Unlock Fps";
    Alignment = "Left"; 
    Callback = function() 
        if not setfpscap then print(err); return; end;

        setfpscap(math.max(60, 9999));
        print(succ, "FPS: " ..last_fps);
    end;
});

local Server_HopBtn = Server_Control:CreateButton({
    Text = "Server Hop";
    Alignment = "Left"; 
    Callback = function() 
        if not serv_hop then print(err); return; end;

        task.delay(5, function()
            task.spawn(function()
                serv_hop();
                print(succ);
            end)
        end)
    end;
});

local Server_LowestBtn = Server_Control:CreateButton({
    Text = "Join Lowest Server";
    Alignment = "Left"; 
    Callback = function() 
        if not join_lowest() then print(err); return; end;

        task.delay(5, function()
            task.spawn(function()
                join_lowest();
                print(succ);
            end)
        end)
    end;
});

local Server_RejoinBtn = Server_Control:CreateButton({
    Text = "Rejoin";
    Alignment = "Left"; 
    Callback = function() 
        if not rejoin() then print(err); return; end;

        task.delay(5, function()
            task.spawn(function()
                rejoin();
                print(succ);
            end)
        end)
    end;
});

local Button_Exit = Section_Config:CreateButton({
    Text = "Exit UI";
    Alignment = "Left"; 
    Callback = function() 
    Window:Exit();
    end;
});

local Cursor
local Connection
local Dropdown_Cursor = Section2_Config:CreateDropdown({
    Text = "Choose Variant";
    Subtext = "Multiple Shapes";
    Alignment = "Left";
    Choices = { "Circle", "Square" };  
    Multi = false;
    Default = nil;
    Callback = function(Value)
        if Cursor then
            Cursor:Remove();
            Cursor = nil;
        end

        if ENV.ShowCursor then
            Cursor = Drawing.new(Value);  
            Cursor.Visible = true;
            Cursor.Color = default_config.Other.Cursor.Color;
            Cursor.Thickness = default_config.Other.Cursor.Thickness;

            if Value == "Circle" then
                Cursor.Radius = default_config.Other.Cursor.Radius;
            elseif Value == "Square" then
                Cursor.Size = Vector2.new(default_config.Other.Cursor.Radius, default_config.Other.Cursor.Radius);
            end

            Connection = RUN_S.RenderStepped:Connect(function()
                local mousePosition = UIS:GetMouseLocation();
                if Cursor then 
                Cursor.Position = Vector2.new(mousePosition.X, mousePosition.Y);
                end;
            end);
        end;
    end;
    Flag = "cursorDrop";
})

local Cursor_Toggle = Section2_Config:CreateToggle({
    Text = "Enable Cursor";
    Subtext = "Shows a Custom Cursor";
    Alignment = "Left";
    Default = default_config.Other.Cursor.Enabled;
    Callback = function(v)
        ENV.ShowCursor = v;

        if ENV.ShowCursor then
            Dropdown_Cursor:Fire()

            Connection = RUN_S.RenderStepped:Connect(function()
                local mousePosition = UIS:GetMouseLocation();
                if Cursor then
                    Cursor.Position = Vector2.new(mousePosition.X, mousePosition.Y);
                end;
            end);
        else
            if Cursor then
                Cursor:Remove();
                Cursor = nil;
            end
            if Connection then
                Connection:Disconnect();
                Connection = nil;
            end;
        end;
    end;
})

local Slider_Thick = Section2_Config:CreateSlider({
    Text = "Thickness";
    Subtext = "Change the Cursor Thickness";
    Alignment = "Left";
    Default = default_config.Other.Cursor.Thickness;
    Floats = 1;
    Limits = { 1, 20 };
    Callback = function(Value)
        if Cursor then
            Cursor.Thickness = Value;
            default_config.Other.Cursor.Thickness = Value;
        end
    end;
});

local Slider_Rad = Section2_Config:CreateSlider({
    Text = "Radius";
    Subtext = "Change the Cursor Radius";
    Alignment = "Left";
    Default = default_config.Other.Cursor.Radius;
    Floats = 1;
    Limits = { 0, 20 };
    Callback = function(Value)
        if Cursor then
            if Dropdown_Cursor.Value == "Circle" then
                Cursor.Radius = Value;
            elseif Dropdown_Cursor.Value == "Square" then
                Cursor.Size = Vector2.new(Value, Value);
            end;
            default_config.Other.Cursor.Radius = Value;
        end;
    end;
});

function Update_ele()
    RUN_S.Heartbeat:Connect(function()
        local EXEC = "Executor: " .. getexecutorname();
        local PING = "Ping: " .. (game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString();
        local FPS =  "FPS: " .. (WORK:GetRealPhysicsFPS());
        local DATE_TIME = (os.date("%Y-%m-%d %H:%M:%S"))
                
        Ping_Label:ChangeText(PING);
        FPS_Label:ChangeText(FPS);
        Exec_Label:ChangeText(EXEC)
        Timer_Label:ChangeText(DATE_TIME)
    end)
end

Exec_Label = Section3_Info:CreateLabel({
    Text = "N/A";
    Alignment = "Left"; 
})

Ping_Label = Section3_Info:CreateLabel({
    Text = "N/A";
    Alignment = "Left"; 
})

FPS_Label = Section3_Info:CreateLabel({
    Text = "N/A";
    Alignment = "Left"; 
})

Timer_Label = Section3_Info:CreateLabel({
    Text = "N/A";
    Alignment = "Left"; 
})

Update_ele();
local currentIndex = 1  
local discord_invites = {
    default_config.UI.Discord.Invite1_Week,
    default_config.UI.Discord.Invite2_Forever
}
local Discord_Label = Section3_Info:CreateLabel({
    Text = discord_invites[currentIndex], 
    Alignment = "Left"; 
})

local Button_DiscordInv = Section3_Info:CreateButton({
    Text = "New Invite";
    Alignment = "Center";
    Callback = function() 
        currentIndex = currentIndex + 1
        if currentIndex > #discord_invites then
            currentIndex = 1  
        end

        Discord_Label:ChangeText(discord_invites[currentIndex])
    end;
})

local ESP = {};
ESP.Enabled = false;
ESP.Cache = {};
ESP.Settings = {
    NameESP = false;
    ShowFlows = false;
    ShowStyles = false;
    ShowSkeleton = false;
    NameSize = 15;
    FlowSize = 14;
    StyleSize = 14
}

function ESP:CreateDrawing(Type, Properties)
    local DrawingObj = Drawing.new(Type);
    for Property, Value in pairs(Properties) do
        DrawingObj[Property] = Value;
    end;
    return DrawingObj;
end;

function ESP:Toggle(State)
    self.Enabled = State;
    if not State then
        for _, Objects in pairs(self.Cache) do
            for _, DrawingObj in pairs(Objects) do
                if typeof(DrawingObj) == "table" then
                    for _, Obj in pairs(DrawingObj) do
                        Obj.Visible = false;
                    end;
                else
                    DrawingObj.Visible = false;
                end;
            end;
        end;
        self.Cache = {};
    end;
end;

function ESP:ClearCacheForPlayer(Player)
    if self.Cache[Player] then
        for _, DrawingObj in pairs(self.Cache[Player]) do
            if typeof(DrawingObj) == "table" then
                for _, Obj in pairs(DrawingObj) do
                    Obj:Remove();
                end;
            else
                DrawingObj:Remove();
            end;
        end;
        self.Cache[Player] = nil;
    end;
end;

function ESP:Update()
    if not self.Enabled then return; end;

    self.Settings.NameESP = default_config.ESP.Name_Esp;
    self.Settings.ShowFlows = default_config.ESP.Flow_Esp;
    self.Settings.ShowStyles = default_config.ESP.Style_Esp;
    self.Settings.NameSize = default_config.ESP.Name_Size;
    self.Settings.FlowSize = default_config.ESP.Flow_Size;
    self.Settings.StyleSize = default_config.ESP.Style_Size;

    for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
        if Player ~= game.Players.LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Character = Player.Character;
            local RootPart = Character:FindFirstChild("HumanoidRootPart");
            local ScreenPos, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position);

            local PlayerStats = Player:FindFirstChild("PlayerStats");
            if not PlayerStats then continue; end;
            local Style = PlayerStats:FindFirstChild("Style") and PlayerStats.Style.Value or "Unknown";
            local Flow = PlayerStats:FindFirstChild("Flow") and PlayerStats.Flow.Value or "Unknown";

            if OnScreen then
                if not self.Cache[Player] then
                    self.Cache[Player] = {
                        NameTag = self:CreateDrawing("Text", {
                            Text = Player.Name,
                            Size = self.Settings.NameSize,
                            Color = Color3.fromRGB(255, 255, 255),
                            Center = true,
                            Outline = true,
                        }),
                        FlowTag = self:CreateDrawing("Text", {
                            Text = "Flow: " .. tostring(Flow),
                            Size = self.Settings.FlowSize,
                            Color = Color3.fromRGB(255, 255, 255),
                            Center = true,
                            Outline = true,
                        }),
                        StyleTag = self:CreateDrawing("Text", {
                            Text = "Style: " .. tostring(Style),
                            Size = self.Settings.StyleSize,
                            Color = Color3.fromRGB(255, 101, 178),
                            Center = true,
                            Outline = true,
                        }),
                        Skeleton = {}, -- Not added yet
                    }
                end;

                local Cache = self.Cache[Player];

                if self.Settings.NameESP and Cache.NameTag then
                    Cache.NameTag.Size = self.Settings.NameSize;
                    Cache.NameTag.Visible = true;
                    Cache.NameTag.Position = Vector2.new(ScreenPos.X, ScreenPos.Y - 20);
                else
                    Cache.NameTag.Visible = false;
                end;

                if self.Settings.ShowFlows and Cache.FlowTag then
                    Cache.FlowTag.Size = self.Settings.FlowSize;
                    Cache.FlowTag.Text = "Flow: " .. tostring(Flow);
                    Cache.FlowTag.Visible = true;
                    Cache.FlowTag.Position = Vector2.new(ScreenPos.X, ScreenPos.Y);
                else
                    Cache.FlowTag.Visible = false;
                end;
                
                if self.Settings.ShowStyles and Cache.StyleTag then
                    Cache.StyleTag.Size = self.Settings.StyleSize;
                    Cache.StyleTag.Text = "Style: " .. tostring(Style);
                    Cache.StyleTag.Visible = true;
                    Cache.StyleTag.Position = Vector2.new(ScreenPos.X, ScreenPos.Y + 20);
                else
                    Cache.StyleTag.Visible = false;
                end;
                
            else
                if self.Cache[Player] then
                    for _, DrawingObj in pairs(self.Cache[Player]) do
                        if typeof(DrawingObj) == "table" then
                            for _, Obj in pairs(DrawingObj) do
                                Obj.Visible = false;
                            end;
                        else
                            DrawingObj.Visible = false;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

game:GetService("Players").PlayerRemoving:Connect(function(Player)
    ESP:ClearCacheForPlayer(Player);
end);

game:GetService("RunService").RenderStepped:Connect(function()
    ESP:Update();
end);

local NameESP_Toggle = Section_ESP:CreateToggle({
    Text = "Show Names",
    Subtext = "Shows their Username",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        default_config.ESP.Name_Esp = Value;
    end,
})

local FlowESP_Toggle = Section_ESP_Flow:CreateToggle({
    Text = "Show Flows",
    Subtext = "Shows player's Flow",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        default_config.ESP.Flow_Esp = Value;
    end,
})

local StyleESP_Toggle = Section_ESP_Style:CreateToggle({
    Text = "Show Styles",
    Subtext = "Shows player's Style",
    Alignment = "Left",
    Default = false,
    Callback = function(Value)
        default_config.ESP.Style_Esp = Value;
    end,
})

local NameSlider = Section_ESP:CreateSlider({
    Text = "Name ESP Size",
    Alignment = "Left",
    Default = 15,
    Callback = function(Value)
        default_config.ESP.Name_Size = Value;
    end,
    Flag = "nameEspSizeSlider",
    Floats = 0,
    Limits = { 10, 50 },
    Increment = 1,
})

local FlowSlider = Section_ESP_Flow:CreateSlider({
    Text = "Flow ESP Size",
    Alignment = "Left",
    Default = 14, 
    Callback = function(Value)
        default_config.ESP.Flow_Size = Value;
    end,
    Flag = "flowEspSizeSlider",
    Floats = 0,
    Limits = { 10, 50 },
    Increment = 1,
})

local StyleSlider = Section_ESP_Style:CreateSlider({
    Text = "Style ESP Size",
    Alignment = "Left",
    Default = 14, 
    Callback = function(Value)
        default_config.ESP.Style_Size = Value;
    end,
    Flag = "styleEspSizeSlider",
    Floats = 0,
    Limits = { 10, 50 },
    Increment = 1,
})

local Keybind = Section_ESP:CreateKeybind({
    Text = "Enable ESP",
    Subtext = "Use a keybind to toggle ESP",
    Alignment = "Left",
    Default = "K",
    Callback = function()
        ESP:Toggle(not ESP.Enabled);
        print("ESP is now " .. (ESP.Enabled and "Enabled" or "Disabled"));
    end,
})

local BallHighlight = nil
local Ball_Toggle = Section_ESP_Ball:CreateToggle({
    Text = "Show Ball",
    Subtext = "Highlights the ball",
    Alignment = "Left",
    Default = default_config.ESP.Ball_Highlight,
    Callback = function(Value)
        default_config.ESP.Ball_Highlight = Value;

        if not Football then return; end;

        if Value then
            if not BallHighlight then
                BallHighlight = Instance.new("Highlight");
                BallHighlight.Name = "BallESP";
                BallHighlight.Adornee = Football;
                BallHighlight.FillColor = Color3.new(0.823529, 0.592156, 1);
                BallHighlight.FillTransparency = 0.5;
                BallHighlight.OutlineColor = Color3.new(1, 1, 1);
                BallHighlight.OutlineTransparency = 0.1;
            end;
            BallHighlight.Parent = Football;
        else
            if BallHighlight then
                BallHighlight:Destroy();
                BallHighlight = nil;
            end;
        end;
    end;
})

local BallTracer = nil;
Tracer_Toggle = Section_ESP_Ball:CreateToggle({
    Text = "Show Ball Tracer",
    Subtext = "Line to ball",
    Alignment = "Left",
    Default = false,
    Callback = function(v)
        default_config.ESP.Ball_Tracer.Enabled = v;

        if not Football then return; end;

        if v then
            if not BallTracer then
                BallTracer = Drawing.new("Line");
                BallTracer.Color = Color3.new(0.823529, 0.592156, 1);
                BallTracer.Thickness = default_config.ESP.Ball_Tracer.Thickness;
            end

            game:GetService("RunService").RenderStepped:Connect(function()
                if not default_config.ESP.Ball_Tracer.Enabled or not Football or not Football.Parent then
                    if BallTracer then BallTracer.Visible = false end;
                    return;
                end;

                local character = LP.Character;
                local hrp = character and character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head");
                if hrp then
                    local startPos = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position);
                    local endPos = workspace.CurrentCamera:WorldToViewportPoint(Football.Position);

                    BallTracer.From = Vector2.new(startPos.X, startPos.Y);
                    BallTracer.To = Vector2.new(endPos.X, endPos.Y);
                    BallTracer.Visible = true;
                    BallTracer.Thickness = default_config.ESP.Ball_Tracer.Thickness;
                else
                    BallTracer.Visible = false;
                end;
            end);
        else
            if BallTracer then BallTracer.Visible = false end;
        end;
    end;
})

local Slider_TracerThickness = Section_ESP_Ball:CreateSlider({
    Text = "Thickness";
    Alignment = "Left";
    Default = 2;
    Callback = function(v) 
        default_config.ESP.Ball_Tracer.Thickness = v
     end;
    Flag = "ballTracerThickness";
    Floats = 0;
    Limits = { 0, 100 };
    Increment = 1;
})

-- // PATCHED

--[[local Temp_FlowBox = Section_Flow:CreateInput({
    Text = "Enter desired Flow";
    Subtext = "Patched ;(";
    Alignment = "Left"; 
    Default = ""; 
    Placeholder = "";
    Callback = function(Value)
    default_config.Misc.Temp_Flow = Value

    InFlow:GetPropertyChangedSignal("Value"):Connect(function()
        if InFlow.Value then return end 
        task.wait()
        InFlow.Value = true
    end)
    InFlow.Value = true
    
    Flow:GetPropertyChangedSignal("Value"):Connect(function()
        if Flow.Value == default_config.Misc.Temp_Flow then return end;
        task.wait()
        Flow.Value = default_config.Misc.Temp_Flow
    end)
    Flow.Value = default_config.Misc.Temp_Flow

    end;
})]]

--[[local Toggle_NoCd = Section_Other:CreateToggle({
    Text = "Skills no Cooldown",
    Subtext = "Patched ;(",
    Alignment = "Left", 
    Default = false,
    Callback = function(Value)
        -- default_config.Misc.Skill_No_Cd = Value;
    end
})

RunService.Heartbeat:Connect(function(fn)
    if not AbilityController.AbilityOne then return; end;
    if default_config.Misc.Skill_No_Cd then
        fn *= 1.5;
        AbilityController.AbilityOne -= fn;
        AbilityController.AbilityTwo -= fn;
        AbilityController.AbilityThree -= fn;
        -- AbilityController.AbilityFour -= fn;
        -- AbilityController.AbilityFive -= fn;
    end;
end);]]

local Toggle_InfStamina = Section_Other:CreateToggle({
    Text = "Infinite Stamina";
    Subtext = "No Stamina loss";
    Alignment = "Left"; 
    Default = false;
    Callback = function(Value)
        default_config.Misc.Infinite_Stam = Value;

        task.spawn(function()
            while default_config.Misc.Infinite_Stam do
                task.wait();
                enableInfiniteStamina();
            end;
        end);
    end;
});

local Toggle_AntiRag = Section_Other:CreateToggle({
    Text = "Anti Ragdoll";
    Subtext = "Move while Ragdoll";
    Alignment = "Left"; 
    Default = false;
    Callback = function(Value)
        default_config.Misc.Anti_Rag = Value;

        task.spawn(function()
            if default_config.Misc.Anti_Rag then
                enableAntiRagdoll();
            else
                disableAntiRagdoll();
            end;
        end);
    end;
})
local exclude = {
    ["OUTDATED"] = true,
    ["LOBBY"] = true,
    ["CODES"] = true,
    ["REDEEM"] = true,
    ["TYPOS"] = true
}
local get_C = function()
    local response = request({
        Url = "https://www.destructoid.com/blue-lock-rivals-codes/", 
        Method = "GET",
        Headers = {
            ["User-Agent"] = "Awp"
        }
    })
    
    if response.StatusCode == 200 then
        local currentT = tick();
        Codes = {};

        for code in string.gmatch(response.Body, '<li>.-<strong>(%w+)</strong>.-</li>') do
            local upperCode = string.upper(code)
            if not exclude[upperCode] then
                table.insert(Codes, code)
            end
        end

        if #Codes > 0 then
            lastT = tick() - currentT
            print("Fetched Codes: ", table.concat(Codes, ", "))
            Library:Notify("[CHECK] <font color='#39FF14'><i>[ SUCCESS ]</i></font> Received Codes!\nTook: " .. string.format("%.2f", lastT) .. " sec", 4, "Info!")
        else
            print("No valid codes found") 
            Library:Notify("[CHECK] <font color='#FF0000'><i>[ FAILED ]</i></font> to Recieve Codes!\nTook: " .. string.format("%.2f", lastT) .. " sec", 4, "Info!")
        end
    else
        print("Failed to Access: ", response.StatusCode)
    end
end
local redeemCodes = function()
    for _, code in ipairs(Codes) do
        pcall(function()
            game:GetService("ReplicatedStorage").Packages.Knit.Services.CodesService.RF.Redeem:InvokeServer(code);
            task.wait(1);
            print("Redeemed Code: " .. code);
            Library:Notify("[CHECK] <font color='#39FF14'><i>[ SUCCESS ]</i></font>\nRedeemed: " ..code, 3, "Notification");
        end);
    end;
end;
local Button_RedeemAllCodes = Section_Quest__:CreateButton({
    Text = "Redeem All Codes";
    Alignment = "Left"; 
    Callback = function() 
        get_C() 
        task.wait(DELAY)
        if #Codes == 0 then
            print("No codes to redeem!")
            return
        end
        task.spawn(function()
            redeemCodes();
        end)
        
        print("Redeemed all codes successfully!")
        Debug:Log("Redeeming Codes Successful", "INFO")
        Debug:SaveLogs()
    end;
})

local Toggle_BallAlwaysReturn = Section_Troll:CreateToggle({
    Text = "Ball Return";
    Subtext = "Will return the Ball when in Possesion";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        default_config.Misc.Ball_Return = v;

        task.spawn(function()
            while default_config.Misc.Ball_Return do task.wait();
                returnBall();
            end;
        end);
    end;
    Flag = "ballreturn";
})

local Toggle_AutoFlow = Section_Auto:CreateToggle({
    Text = "Auto Flow";
    Subtext = "Activates flow when possible";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        default_config.Misc.AutoFlow = v 
        local SV_F = game:GetService("ReplicatedStorage").Packages.Knit.Services.FlowService.RE.Activate;

        if SV_F then 
            task.spawn(function()
                while default_config.Misc.AutoFlow do task.wait(DELAY)
                    SV_F:FireServer();
                end;
            end);
        else
            print(err, type(SV_F), "Seems like Service/Remote is not Available");
            Debug:Log("Auto Flow Error, Service or Remote not found", "WARN");
        end;
    end;
    Flag = "autoFlow";
})

local Toggle_AutoAwaken = Section_Auto:CreateToggle({
    Text = "Auto Awaken";
    Subtext = "Activates Awaken when possible";
    Alignment = "Left";
    Default = false;
    Callback = function(v) 
        default_config.Misc.AutoAwaken = v 
        local SV_A = game:GetService("ReplicatedStorage").Packages.Knit.Services.AwakeningService.RE.StartAwakening;

        if SV_A then 
            task.spawn(function()
                while default_config.Misc.AutoAwaken do task.wait(DELAY);
                    pcall(function()
                        SV_A:FireServer();
                    end);
                end;
            end);
        else
            print(err, type(SV_A), "Seems like Service/Remote is not Available");
            Debug:Log("Auto Awaken Error, Service or Remote not found", "WARN");
        end;
    end;
    Flag = "autoAwaken";
})

local Lock__Dropdown__Options = Section_Character:CreateDropdown({ 
    Text = "Lock Options",
    Subtext = "Choose Lock Option",
    Alignment = "Left",
    Choices = {"Lock Character", "Lock Camera", "Lock Both"},
    Multi = false,
    Default = "None",
    Callback = function(choice)
        if choice == "Lock Character" then
            default_config.Misc.Lock_Ball.Character = true;
            default_config.Misc.Lock_Ball.Camera = false;
        elseif choice == "Lock Camera" then
            default_config.Misc.Lock_Ball.Character = false;
            default_config.Misc.Lock_Ball.Camera = true;
        elseif choice == "Lock Both" then
            default_config.Misc.Lock_Ball.Character = true;
            default_config.Misc.Lock_Ball.Camera = true;
        else
            default_config.Misc.Lock_Ball.Character = false;
            default_config.Misc.Lock_Ball.Camera = false;
        end;
    end;
    Flag = "LockBallDrop"
})

local Toggle_LockOnBall = Section_Character:CreateToggle({
    Text = "Lock Ball",
    Subtext = "Locks Character to Football and Camera",
    Alignment = "Left",
    Default = false,
    Callback = function(e) 
        if e then
            Lock_OnBall();
        else
            default_config.Misc.Lock_Ball.Character = false;
            default_config.Misc.Lock_Ball.Camera = false;
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;

            if default_config.Other.CameraConnection then
                default_config.Other.CameraConnection:Disconnect();
                default_config.Other.CameraConnection = nil;
            end;
        end;
    end,
    Flag = "lockBall"
})

local Slider_AutoSteal = Section_Auto:CreateSlider({
    Text = "Steal Value";
    Alignment = "Left";
    Default = default_config.Misc.Auto_Steal.Steal_Value;
    Callback = function(d)
         default_config.Misc.Auto_Steal.Steal_Value = d;
    end;
    Flag = "sliderSteal";
    Floats = 0; 
    Limits = { 1, 20 }; 
    Increment = 1;
})

local Toggle_AutoSteal = Section_Auto:CreateToggle({
    Text = "Auto Steal",
    Subtext = "Steals the ball from the Enemy",
    Alignment = "Left",
    Default = false,
    Callback = function(e) 
        default_config.Misc.Auto_Steal.Steal_Enabled = e;

        if e then
            task.spawn(function()
                AutoSteal();
            end)
        end;
    end;
    Flag = "stealBall"
})

local Toggle_AutoDribble = Section_Auto:CreateSlider({
    Text = "Dribble Value";
    Alignment = "Left";
    Default =  default_config.Misc.Auto_Dribble.Dribble_Value;
    Callback = function(d)
         default_config.Misc.Auto_Dribble.Dribble_Value = d
    end;
    Flag = "sliderDribble";
    Floats = 0; 
    Limits = { 1, 20 }; 
    Increment = 1;
})

local Toggle_AutoDribble = Section_Auto:CreateToggle({
    Text = "Auto Dribble",
    Subtext = "Dribble the ball from the Enemy",
    Alignment = "Left",
    Default = false,
    Callback = function(e) 
        default_config.Misc.Auto_Dribble.Dribble_Enabled = e
        
        if e then
            task.spawn(function()
                AutoDribble();
            end)
        end
    end,
    Flag = "dribbleBall"
})

local selectedABs = {};
local abilities = {};
table.insert(abilities, "B");
table.insert(abilities, "C");
table.insert(abilities, "V");

Dropdown_Abilities = Section_Auto:CreateDropdown({
    Text = "Select Abilities",
    Subtext = "Auto uses Abilities",
    Alignment = "Left",
    Choices = abilities, 
    Multi = true, 
    Default = nil,
    Callback = function(choices)
        selectedABs = choices
        if selectedABs ~= nil then
        print("Selected Abilities: " .. table.concat(selectedABs, ", "));
        end;
        
        Dropdown_Abilities:SetValue(selectedABs);
    end,
    Flag = "abilityDropdown"
})

local Toggle_Ability = Section_Auto:CreateToggle({
    Text = "Auto Ability",
    Subtext = "Enable the Feature",
    Alignment = "Left",
    Default = false,
    Callback = function(enabled)        
        if enabled then
            if #selectedABs > 0 then
                for _, ability in pairs(selectedABs) do
                    default_config.Misc.Auto_Abilities["Ability_" .. ability] = true;
                    AutoAbility(ability);
                end;
            end;
        else
            for key, _ in pairs(default_config.Misc.Auto_Abilities) do
                default_config.Misc.Auto_Abilities[key] = false
            end;
        end;
    end;
    Flag = "autoAbility"
})

local SaveConfig = Section_Config:CreateButton({
    Text = "Save Config",
    Callback = function()
        Library:Save();
        print(string.lower(saveeeed));
    end,
});

SaveConfig:CreateSettings():CreateToggle({
    Text = "Auto Save",
    Callback = function(v)
        uiAutoSave = v; 

        task.spawn(function()
            while uiAutoSave do
                Library:Save();
                task.wait(15); 
            end;
        end);
    end,
    Flag = "UI_AutoSave",
});

local Dropdown_UnlocksDrop = Section_Full:CreateDropdown({
    Text = "Select Card";
    Subtext = "Cards";
    Alignment = "Left";
    Choices = { };
    Multi = false;
    Default = nil;
    Callback = function(selectedCard) 
        local args = {
            [1] = "Cards",
            [2] = selectedCard
        }
        game:GetService("ReplicatedStorage")
            .Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
     end;
    Flag = "unlockDrop_Cards";
})

local Cards = game:GetService("ReplicatedStorage").Assets.Customization.Cards
for _, card in ipairs(Cards:GetChildren()) do
    Dropdown_UnlocksDrop:AddOption(card.Name, card.Name)
end

local Dropdown_UnlocksAccessoryDrop = Section_Full:CreateDropdown({
    Text = "Select Accessory";
    Subtext = "Accessories";
    Alignment = "Left";
    Choices = { };
    Multi = false;
    Default = nil;
    Callback = function(selectedAccessory) 
        local args = {
            [1] = "Cosmetics",
            [2] = selectedAccessory
        }
        game:GetService("ReplicatedStorage")
            .Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
     end;
    Flag = "unlockDrop_Accessory";
})

local Accessories = game:GetService("ReplicatedStorage").Assets.Cosmetics
for _, accessory in ipairs(Accessories:GetChildren()) do
    Dropdown_UnlocksAccessoryDrop:AddOption(accessory.Name, accessory.Name)
end

local Dropdown_UnlocksGoalDrop = Section_Full:CreateDropdown({
    Text = "Select Goal VFX";
    Subtext = "Goal Effects";
    Alignment = "Left";
    Choices = { };
    Multi = false;
    Default = nil;
    Callback = function(selectedGoalEffect) 
        local args = {
            [1] = "GoalEffects",
            [2] = selectedGoalEffect
        }
        game:GetService("ReplicatedStorage")
            .Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
     end;
    Flag = "unlockDrop_VFX";
})

local GoalEffects = game:GetService("ReplicatedStorage").Assets.GoalEffects
for _, effect in ipairs(GoalEffects:GetChildren()) do
    Dropdown_UnlocksGoalDrop:AddOption(effect.Name, effect.Name)
end

local ToggleInfJumping = Section_Other:CreateToggle({
    Text = "Infinite Jump";
    Subtext = "Uhh";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        default_config.Misc.InfiniteJump = v;

        if default_config.Misc.InfiniteJump then task.wait();
            task.spawn(function()
                infiniteJump()  ;
            end)
        else
            if j_connect then
                j_connect:Disconnect();
                j_connect = nil;  
            end
        end
    end;
    Flag = "infJ";
})

--[[local Toggle_InfStam = Section_Other:CreateToggle({
    Text = "Infinite Stamina v2";
    Subtext = "Another version ig";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        default_config.Misc.Infinite_Stam2 = v 

        if default_config.Misc.Infinite_Stam2 then task.wait()
        task.spawn(function()
            infiniteStamina();
        end)
        end
    end;
    Flag = "infStam";
})]]

local Toggle_ClaimDaily = Section_Quest__:CreateToggle({
    Text = "Auto Claim Daily";
    Subtext = "Claims Daily Quest";
    Alignment = "Left";
    Default = false;
    Callback = function(v)
        default_config["Auto Quest"].ClaimDaily = v

        if default_config["Auto Quest"].ClaimDaily then task.wait();
        task.spawn(function()
            DailyQuest();
            end)
        end
    end;
    Flag = "RedeemQuests";
})

local function stop_speedwahahahhaha()
    if default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv then
        default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv:Destroy();
        default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv = nil;
    end;
end;

local function speed()
    if default_config.Misc.WalkSpeed.WS_Enabled then
        stop_speedwahahahhaha();

        default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv = Instance.new("BodyVelocity");
        default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv.MaxForce = Vector3.new(100000, 0, 100000);

        RunService.Heartbeat:Connect(function()
            local character = LP.Character;
            if not character then return; end;

            local humanoid = character:FindFirstChildOfClass("Humanoid");
            local head = character:FindFirstChild("Head");
            if not humanoid or not head then return; end;

            default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv.Parent = head;
            default_config.Misc.WalkSpeed.WS_Cleanup.speedHackBv.Velocity = humanoid.MoveDirection * default_config.Misc.WalkSpeed.WS_Value;
        end)
    else
        stop_speedwahahahhaha();
    end
end

local Slider_WS = Section_Character:CreateSlider({
    Text = "Walkspeed Value",
    Alignment = "Left",
    Default = 16, 
    Callback = function(w)
        default_config.Misc.WalkSpeed.WS_Value = w;
    end,
    Floats = 0, 
    Limits = {16, 89}, 
    Increment = 1
})

local Toggle_WS = Section_Character:CreateToggle({
    Text = "Walkspeed Enabled",
    Subtext = "Uhh yea",
    Alignment = "Left",
    Default = false,
    Callback = function(w)
        default_config.Misc.WalkSpeed.WS_Enabled = w;
        speed();
    end
})

local FlowChoices = {
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
}
local StyleChoices = {
    "Shidou",
    "Aiku",
    "Yukimiya",
    "Sae",
    "Rin",
    "King",
    "Nagi",
    "Reo",
    "Karasu",
    "Bachira",
    "Otoya",
    "Hiori",
    "Gagamaru",
    "Isagi",
    "Chigiri",
}
local selectedFlows = {};
local selectedStyles = {};

local spinFlow = (function()
    while default_config.Dashboard.Spinning.FlowSpin_Enabled do
        task.wait(5); 
        local currentFlow = game:GetService("Players").LocalPlayer.PlayerStats.Flow.Value;

        for _, flow in ipairs(selectedFlows) do
            if currentFlow == flow then
                default_config.Dashboard.Spinning.FlowSpin_Enabled = false
                return
            end;
        end;        
        local args = {
            [1] = default_config.Dashboard.Spinning.LuckySpin_Flow 
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("FlowService"):WaitForChild("RE"):WaitForChild("Spin"):FireServer(unpack(args))
    end;
end);
local spinStyle = (function()
    while default_config.Dashboard.Spinning.StyleSpin_Enabled do
        task.wait(5); 
        local currentStyle = game:GetService("Players").LocalPlayer.PlayerStats.Style.Value;

        for _, style in ipairs(selectedStyles) do
            if currentStyle == style then
                default_config.Dashboard.Spinning.StyleSpin_Enabled = false 
                return
            end;
        end;

        local args = {
            [1] = default_config.Dashboard.Spinning.LuckySpin_Style 
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StyleService"):WaitForChild("RE"):WaitForChild("Spin"):FireServer(unpack(args))
    end;
end);

local Dropdown_SpinningFlow = SectionSpin:CreateDropdown({
    Text = "Flow Choices",
    Subtext = "",
    Alignment = "Left",
    Choices = FlowChoices,
    Multi = true,
    Default = nil,
    Callback = function(Values)
        selectedFlows = Values 
    end,
    Flag = "FlowChoices",
})

local Dropdown_SpinningStyle = SectionSpin2:CreateDropdown({
    Text = "Style Choices",
    Subtext = "",
    Alignment = "Left",
    Choices = StyleChoices,
    Multi = true,
    Default = nil,
    Callback = function(Values)
        selectedStyles = Values 
    end,
    Flag = "StyleChoices",
})

local Toggle_FlowSpin = SectionSpin:CreateToggle({
    Text = "Spin Flow",
    Subtext = "",
    Alignment = "Left",
    Default = default_config.Dashboard.Spinning.FlowSpin_Enabled,
    Callback = function(v)
        default_config.Dashboard.Spinning.FlowSpin_Enabled = v 
        if default_config.Dashboard.Spinning.FlowSpin_Enabled then
            task.spawn(spinFlow) 
        end
    end,
    Flag = "FlowSpin",
})

local Toggle_StyleSpin = SectionSpin2:CreateToggle({
    Text = "Spin Style",
    Subtext = "",
    Alignment = "Left",
    Default = default_config.Dashboard.Spinning.StyleSpin_Enabled,
    Callback = function(v)
        default_config.Dashboard.Spinning.StyleSpin_Enabled = v 
        if default_config.Dashboard.Spinning.StyleSpin_Enabled then
            task.spawn(spinStyle) 
        end
    end,
    Flag = "StyleSpin",
})

local Toggle_LuckySpinFlow = SectionSpin:CreateToggle({
    Text = "Lucky Spin (Flow)",
    Subtext = "",
    Alignment = "Left",
    Default = default_config.Dashboard.Spinning.LuckySpin_Flow,
    Callback = function(v)
        default_config.Dashboard.Spinning.LuckySpin_Flow = v
    end,
    Flag = "LuckySpin_Flow",
})

local Toggle_LuckySpinStyle = SectionSpin2:CreateToggle({
    Text = "Lucky Spin (Style)",
    Subtext = "",
    Alignment = "Left",
    Default = default_config.Dashboard.Spinning.LuckySpin_Style,
    Callback = function(v)
        default_config.Dashboard.Spinning.LuckySpin_Style = v
    end,
    Flag = "LuckySpin_Style",
})

Debug:Toggle(false);  
Debug:SaveLogs();
Library:Notify("Whitelisted!\nScript is in early Development\nCurrent Status: " .. tostring(Check_.Status), 5, "Info!");
Library:Load();
