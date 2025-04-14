-- Functions

local Setup, Called = {}, {};

Setup["Basics"] = function(self)
    if Called["Basics"] then return; end;
    Called["Basics"] = true; 

    Players = game:GetService("Players");
    ReplicatedStorage = game:GetService("ReplicatedStorage"); Replicated = ReplicatedStorage;
    TweenService = game:GetService("TweenService"); TS = TweenService;
    UserInputService = game:GetService("UserInputService"); UIS = UserInputService;
    RunService = game:GetService("RunService"); RSV = RunService; rsv = RunService;
    CoreGui = game:GetService("CoreGui");
    HttpService = game:GetService("HttpService");

    Client = Players.LocalPlayer; client = Client; LocalPlayer = Client; LP = Client;
    Camera = workspace.CurrentCamera; CC = Camera; cc = Camera;
    Mouse = LP:GetMouse(); mouse = Mouse;

    PlayerGui = LP:WaitForChild("PlayerGui");
    Backpack = LP:WaitForChild("Backpack");

    task.spawn(function()
        Character = LP.Character or LP.CharacterAdded:Wait(); Char = Character; char = Character;
        Humanoid = Char:WaitForChild("Humanoid"); Hum = Humanoid; hum = Humanoid;
        HumanoidRootPart = Char:WaitForChild("HumanoidRootPart") or Char.PrimaryPart; HRP = HumanoidRootPart; hrp =
            HumanoidRootPart;

        LP.CharacterAdded:Connect(function()
            Character = LP.Character; Char = Character; char = Character;
            Humanoid = Char:WaitForChild("Humanoid"); Hum = Humanoid; hum = Humanoid;
            HumanoidRootPart = Char:WaitForChild("HumanoidRootPart") or Char.PrimaryPart; HRP = HumanoidRootPart; hrp =
                HumanoidRootPart;
        end);
    end);
end;

Setup["ClientController"] = function(self)
    local Manager = {};
    if Called["ClientController"] then return Called["ClientController"]; end;
    Called["ClientController"] = Manager;

    self:Basics();

    function Manager:Reset()
        if char then
            char:BreakJoints();
        end;
    end;

    function Manager:Goto(cf)
        if typeof(cf) == 'Vector3' then cf = CFrame.new(cf) end;
        if typeof(cf) ~= 'CFrame' then return; end;

        if hrp then
            hrp.CFrame = cf;
        end;
    end;

    local Recorder = self:InputRecorder();
    local walkspeed, jumppower;
    Manager['Movement'] = {
        -- TP Walk
        TWX = nil,

        WS = function(Speed)
            walkspeed = Speed;
        end,

        TW = function(self, Toggle)
            if self.TWX then
                self.TWX:Disconnect();
            end;

            if Toggle then
                self.TWX = rsv.RenderStepped:Connect(function()
                    if hum.MoveDirection.Magnitude > 0 then
                        walkspeed = walkspeed or 1;
                        char:TranslateBy(hum.MoveDirection * walkspeed)
                    end;
                end);
            end;
        end,

        -- Jump
        IJX = nil,
        IJX2 = nil,

        JP = function(Power)
            jumppower = Power;
        end,

        IJ = function(self, Toggle)
            if self.IJX then
                self.IJX:Disconnect();
                self.IJX2:Disconnect();
            end;

            if Toggle then
                local Pressing = false;

                local function jump()
                    local Power = jumppower or hum.JumpPower or 50;
                    hrp.Velocity = Vector3.new(hrp.Velocity.X, Power, hrp.Velocity.Z);
                end;

                local function on()
                    Pressing = true;

                    while Pressing do
                        jump();
                        task.wait(.1);
                    end;
                end;

                local function off()
                    Pressing = false;
                end;

                self.IJX = Recorder:Bind("Space", on);
                self.IJX = Recorder:Bind("Space", off, true);
            end;
        end,
    };

    return Manager;
end;

Setup["HttpService"] = function(self)
    local Manager = {};
    if Called["HttpService"] then return Called["HttpService"]; end;
    Called["HttpService"] = Manager;

    self:Basics();

    function Manager:Webhook(weblink, title, fields)
        if not weblink then return; end;
        local data = {
            ["embeds"] = {
                {
                    ["title"] = title or "",
                    ["type"] = "rich",
                    ["color"] = tonumber(0x8383AA),
                    ["fields"] = fields
                },
            },
        };

        local newdata = HttpService:JSONEncode(data)

        request = http_request or request or HttpPost or syn.request;
        request({ Url = weblink, Body = newdata, Method = "POST", Headers = { ["content-type"] = "application/json" } });
    end;

    return Manager;
end;

Setup["File"] = function(self)
    local Manager, Allowed = {};
    if Called["File"] then return Called["File"]; end;
    Called["File"] = Manager;

    self:Basics();


    if readfile and writefile and isfolder and isfile and makefolder and delfolder then
        Allowed = true;
    end;

    function Manager:Read(path)
        if not Allowed then return; end;
        if typeof(path) ~= "string" then return; end;
        local contents;

        if isfile(path) then
            contents = readfile(path);
        elseif isfolder(path) then
            if listfiles then
                contents = listfiles(path);
            end;
        end;

        return contents;
    end;

    function Manager:Write(path, contents)
        if not Allowed then return; end;
        if typeof(path) ~= 'string' then return; end;

        local contents = contents or "";

        writefile(path, tostring(contents));
    end;

    function Manager:CreateFolder(path)
        if not Allowed then return; end;
        if typeof(path) ~= 'string' then return; end;

        if not isfolder(path) then
            makefolder(path);
        end;
    end;

    function Manager:DeleteFolder(path)
        if not Allowed then return; end;
        if typeof(path) ~= 'string' then return; end;
        if isfolder(path) then
            delfolder(path);
        end;
    end;

    function Manager:Execute(path)
        if not Allowed then return; end;
        if typeof(path) ~= 'string' then return; end;

        if isfile(path) then
            if runfile then
                runfile(path);
            else
                loadstring(readfile(path));
            end
        end;
    end;

    return Manager;
end;

Setup["Tween"] = function(self)
    local Manager, Storage = {}, {};
    if Called["Tween"] then return Called["Tween"]; end;
    Called["Tween"] = Manager;

    self:Basics();

    function Manager:Create(pos, speed, nofall, extra, delayY)
        if (typeof(pos) ~= "CFrame") or (not hrp) then
            if Storage['CurrentTween'] then Storage['CurrentTween']:Pause(); end; return;
        end;

        if (not char) or (not hrp) then return; end;

        local isClose = false;
        local cf, vec3 = pos, pos.Position;

        if delayY then
            cf = CFrame.new(pos.X, hrp.Position.Y, pos.Z);
            vec3 = cf.Position;
        end;

        local speed = speed or 5;
        local distance = (hrp.Position - vec3).magnitude;

        if nofall then
            if Storage["No Fall INS"] then
                Storage["No Fall INS"]:Destroy();
            end;

            Storage["No Fall INS"] = Instance.new('BodyVelocity');
            Storage["No Fall INS"].MaxForce = Vector3.new(math.huge, math.huge, math.huge);
            Storage["No Fall INS"].Velocity = Vector3.new(0, 0, 0);
            Storage["No Fall INS"].Parent = hrp;
        end;

        if distance <= speed / 5 then
            isClose = true;
            hrp.CFrame = pos;
        end;

        if typeof(extra) == "function" then
            task.spawn(extra, isClose);
        end;

        local Time = distance / speed;
        Storage['CurrentTween'] = TweenService:Create(hrp,
            TweenInfo.new(Time, Enum.EasingStyle.Linear), { CFrame = cf });
        Storage['CurrentTween']:Play();


        return isClose;
    end;

    function Manager:Cancel()
        if Storage["No Fall INS"] then Storage["No Fall INS"]:Destroy(); end;
        if Storage['CurrentTween'] then Storage['CurrentTween']:Pause(); end;
    end;

    return Manager;
end;

Setup["VirtualInputManager"] = function(self)
    local Manager, VIM = {}, game:GetService("VirtualInputManager");
    if Called["VirtualInputManager"] then return Called["VirtualInputManager"]; end;
    Called["VirtualInputManager"] = Manager;

    function Manager:Press(Key)
        if typeof(Key) == 'string' then
            local EnumKey;

            pcall(function() EnumKey = Enum.KeyCode[Key] end);

            if not EnumKey then return; end;

            VIM:SendKeyEvent(true, EnumKey, false, game);
            task.wait()
            VIM:SendKeyEvent(false, EnumKey, false, game);
        end;
    end;

    function Manager:Click(mb)
        if typeof(MB) == 'number' then
            mb = math.clamp(mb, 0, 2);

            VIM:SendMouseButtonEvent(0, 0, mb, true, game);
            task.wait();
            VIM:SendMouseButtonEvent(0, 0, mb, false, game);
        end;
    end;

    function Manager:Hold(Key)
        if typeof(Key) == 'string' then
            local EnumKey;
            pcall(function() EnumKey = Enum.KeyCode[Key] end);
            if not EnumKey then return; end;

            VIM:SendKeyEvent(true, EnumKey, false, game);
        end;
    end;

    function Manager:Release(Key)
        if typeof(Key) == 'string' then
            local EnumKey;
            pcall(function() EnumKey = Enum.KeyCode[Key] end);
            if not EnumKey then return; end;

            VIM:SendKeyEvent(false, EnumKey, false, game);
        end;
    end;

    function Manager:Move(x, y)
        if (not x) or (not y) then return; end;
        VIM:SendMouseMoveEvent(x, y, game)
    end;

    return Manager;
end;

Setup["InputRecorder"] = function(self)
    local Manager = {};
    if Called["InputRecorder"] then return Called["InputRecorder"]; end;
    Called["InputRecorder"] = Manager;

    self:Basics();

    Manager.Pressed = {};
    function Manager:Record(OnUP, Settings)
        if not Settings then return; end;
        local Callback = Settings['Callback'];
        local Valid = Settings['Inputs'];
        local Type = Settings['Type'];
        local Break = Settings['Break'];
        local CancelKeys = Settings['CancelKeys'] or { "Escape", "Backspace" };
        local IgnoreProc = Settings['IgnoreProc'];
        local Recorder;

        if not Callback then return; end;

        local function OnResponse(Input, isTyping)
            if (not Input) or (isTyping and not IgnoreProc) then return; end;

            local Keycode = Input['KeyCode'];
            local UserInputType = Input['UserInputType'];
            if not Keycode then return; end;
            local KeyName = Keycode.Name;

            if KeyName == "Unknown" then
                if Type == "KeyCode" then return; end;

                KeyName = UserInputType.Name;
            end;

            if table.find(CancelKeys, KeyName) then
                if Recorder then
                    Recorder:Disconnect();
                    Callback();
                    return;
                end;
            end;

            if Valid then
                if table.find(Valid, KeyName) then
                    Callback(KeyName);
                else
                    for i, v in next, (Valid) do
                        if string.lower(v) == string.lower(KeyName) then
                            Callback(KeyName);
                        end;
                    end;
                end;
            else
                Callback(KeyName);
            end;

            if Break and Recorder then
                Recorder:Disconnect();
            end;
        end;

        if OnUP then
            Recorder = UserInputService.InputEnded:Connect(OnResponse);
        else
            Recorder = UserInputService.InputBegan:Connect(OnResponse);
        end;

        return Recorder;
    end;

    function Manager:Bind(Key, Callback, OnUP, IgnoreProc)
        if (not Key) or (not Callback) then return; end;

        return Manager:Record(OnUP, {
            Inputs = (typeof(Key) == "table" and Key) or { Key },
            CancelKeys = {},
            IgnoreProc = IgnoreProc,

            Callback = Callback,
        });
    end;

    UserInputService.InputBegan:Connect(function(Input, proc)
        if not proc then
            local Keycode = Input['KeyCode'];
            local UserInputType = Input['UserInputType'];
            if not Keycode then return; end;
            local KeyName = Keycode.Name;

            if KeyName == "Unknown" then
                if Type == "KeyCode" then return; end;

                KeyName = UserInputType.Name;
            end;
        end;
    end);

    UserInputService.InputEnded:Connect(function(Input, proc)
        if not proc then
            local Keycode = Input['KeyCode'];
            local UserInputType = Input['UserInputType'];
            if not Keycode then return; end;
            local KeyName = Keycode.Name;

            if KeyName == "Unknown" then
                if Type == "KeyCode" then return; end;

                KeyName = UserInputType.Name;
            end;
        end;
    end);

    return Manager;
end;

return Setup;
