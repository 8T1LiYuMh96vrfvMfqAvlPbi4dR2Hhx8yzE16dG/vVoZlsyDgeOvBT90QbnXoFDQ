-- UI Remake

local Repo = "https://raw.githubusercontent.com/8T1LiYuMh96vrfvMfqAvlPbi4dR2Hhx8yzE16dG";
local Setup = loadstring(game:HttpGet(Repo .. "/vVoZlsyDgeOvBT90QbnXoFDQ/main/HsUTSb1JpEQZ"))();
local InputService = Setup:InputRecorder();
local FileService = Setup:File();
Setup:Basics();

local RGB = Color3.fromRGB;
local Library = {
    Cache = {},
    Created = {
        Tabs = {},
        Sections = {},

        Toggles = {},
        Binds = {},

        Flags = {}
    },

    Theme = "Default",
    Themes = {
        ["Default"] = {
            ["Title"] = RGB(255, 255, 255),

            ["Background"] = RGB(9, 9, 13),
            ["Background2"] = RGB(10, 10, 15),
            ["Tone"] = RGB(23, 22, 32),

            ["Accent1"] = RGB(19, 19, 23),
            ["Highlight"] = RGB(121, 115, 234),
            ["Hover"] = RGB(77, 75, 116),
            ["Selected"] = RGB(117, 113, 175),

            ["Text"] = RGB(199, 199, 199),
            ["Subtext"] = RGB(95, 95, 95),
            ["Icons"] = RGB(199, 199, 199),

            ["Font"] = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
            ["NotiFont"] = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold,
                Enum.FontStyle.Normal)
        },
        ["Dark"] = {
            ["Title"] = RGB(255, 255, 255),

            ["Background"] = RGB(33, 33, 33),
            ["Background2"] = RGB(23, 23, 23),
            ["Tone"] = RGB(29, 29, 29),

            ["Accent1"] = RGB(46, 46, 46),
            ["Highlight"] = RGB(58, 64, 80),
            ["Hover"] = RGB(85, 87, 98),
            ["Selected"] = RGB(101, 103, 117),

            ["Text"] = RGB(230, 230, 230),
            ["Subtext"] = RGB(170, 170, 170),
            ["Icons"] = RGB(230, 230, 230),

            ["Font"] = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
            ["NotiFont"] = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold,
                Enum.FontStyle.Normal)
        },
    },

    Black = RGB(0, 0, 0),
    White = RGB(255, 255, 255),

    Paths = {
        ["Folder"] = "\\TEMPUI",
        ["Secondary"] = nil,
        ["Data"] = "\\Data",
        ["Themes"] = "\\Themes",
    },
};

do -- Save / Load
    function Library:Save()
        local Paths = Library.Paths;
        local Folder, Secondary = Paths["Folder"], Paths["Secondary"];
        FileService:CreateFolder(Folder);
        if Secondary then
            Folder = (Folder .. Secondary); FileService:CreateFolder(Folder);
        end;

        local Path = Folder .. Library.Paths["Data"] .. ".json";

        local SaveData = {};
        for i, v in pairs(self.Created.Flags) do
            if v.Value then
                SaveData[i] = v.Value;
            end;
        end;

        FileService:Write(Path, HttpService:JSONEncode(SaveData))
    end;

    function Library:Load()
        local Paths = Library.Paths;
        local Folder, Secondary = Paths["Folder"], Paths["Secondary"];
        FileService:CreateFolder(Folder);
        if Secondary then
            Folder = (Folder .. Secondary); FileService:CreateFolder(Folder);
        end;

        local Path = Folder .. Library.Paths["Data"] .. ".json";

        local LoadData = FileService:Read(Path);
        if not LoadData then return; end;

        LoadData = HttpService:JSONDecode(LoadData);
        for i, v in pairs(LoadData) do
            if Library.Created.Flags[i] then
                Library.Created.Flags[i]:Load(v);
            end;
        end;
    end;

    function Library:SaveExternal(File, Data)
        if not File then return; end;

        local Paths = Library.Paths;
        local Folder, Secondary = Paths["Folder"], "\\External";
        FileService:CreateFolder(Folder);
        Folder = (Folder .. Secondary); FileService:CreateFolder(Folder);

        local Path = Folder .. tostring(File) .. ".json";
        FileService:Write(Path, HttpService:JSONEncode(Data));
    end;

    function Library:LoadExternal(File)
        if not File then return; end;

        local Paths = Library.Paths;
        local Folder, Secondary = Paths["Folder"], "\\External";
        FileService:CreateFolder(Folder);
        Folder = (Folder .. Secondary); FileService:CreateFolder(Folder);

        local Path = Folder .. tostring(File) .. ".json";
        local LoadData = FileService:Read(Path);
        if not LoadData then return; end;
        return HttpService:JSONDecode(LoadData);
    end;
end;

do -- Colorize
    function Library:Register(Obj, Properties, Tween)
        if (not Obj) or (not Properties) then return; end;

        if self.Cache[Obj] then
            for i, v in pairs(self.Cache[Obj].Properties) do
                if not Properties[i] then
                    Properties[i] = v;
                end;
            end;
        end;

        local Data = {
            Instance = Obj,
            Properties = Properties,
            Tween = Tween,
        };

        self.Cache[Obj] = Data;
    end;

    function Library:Unregister(Obj)
        if not Obj then return; end;
        self.Cache[Obj] = nil;
    end;

    function UpdateColors()
        local Theme = Library.Theme;
        local Themes = Library.Themes;
        local CTheme = Themes[Theme];

        if not CTheme then return; end;

        for _, v in pairs(Library.Cache) do
            local Obj = v.Instance;
            local Properties = v.Properties;
            local isTween = v.Tween;

            for idx, val in next, (Properties) do
                if CTheme[val] then
                    if isTween then
                        pcall(function()
                            TweenService:Create(Obj,
                                TweenInfo.new((typeof(isTween) == "number" and isTween) or .05, Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.InOut), { [idx] = CTheme[val] }):Play();
                        end);

                        continue;
                    end
                    Obj[idx] = CTheme[val];
                elseif Library[val] then
                    if isTween then
                        pcall(function()
                            TweenService:Create(Obj,
                                TweenInfo.new((typeof(isTween) == "number" and isTween) or .05, Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.InOut), { [idx] = Library[val] }):Play();
                        end);

                        continue;
                    end

                    Obj[idx] = Library[val];
                end;
            end;
        end;
    end;

    RunService.Heartbeat:Connect(UpdateColors);
end;

do -- Creation
    function Library.Create(Class, Properties, Reg)
        local _Instance = Class;

        if type(Class) == 'string' then
            _Instance = Instance.new(Class);
        end;

        for Property, Value in next, Properties do
            _Instance[Property] = Value;
        end;

        pcall(function()
            _Instance.BorderSizePixel = 0;
        end);

        if Reg then
            Library:Register(_Instance, Reg);
        end;

        return _Instance;
    end;

    function Library:ApplyRatio(Obj, Ratio, Axis, Type)
        if not Obj then return; end;
        local Ratio = Ratio or 1;
        local Axis = Axis or "Height";

        local AspectRatio = Library.Create("UIAspectRatioConstraint", {
            Parent = Obj,
            AspectType = (not Type and Enum.AspectType.ScaleWithParentSize) or Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis[Axis],
            AspectRatio = Ratio,
        });

        return AspectRatio;
    end;

    function Library:ApplyStroke(Obj, Reg, Thickness, Type, Border)
        if not Obj then return; end;

        Thickness = Thickness or 1;
        Type = Type or "Miter";

        local Stroke = Library.Create("UIStroke", {
            Parent = Obj,
            LineJoinMode = Enum.LineJoinMode[Type],
            ApplyStrokeMode = (Border and Enum.ApplyStrokeMode.Border) or Enum.ApplyStrokeMode.Contextual,
            Thickness = Thickness,
        }, { Color = Reg });

        return Stroke;
    end;

    function Library:ApplyPadding(Obj, Pixels)
        if not Obj then return; end;

        local UIPadding = Library.Create("UIPadding", {
            Parent = Obj,
            PaddingBottom = UDim.new(0, Pixels),
            PaddingLeft = UDim.new(0, Pixels),
            PaddingRight = UDim.new(0, Pixels),
            PaddingTop = UDim.new(0, Pixels)
        })

        return UIPadding;
    end;

    function Library:ApplyCorner(Obj, Pixels)
        if not Obj then return; end;

        local UICorner = Library.Create("UICorner", {
            Parent = Obj,
            CornerRadius = UDim.new(0, Pixels or 6),
        })

        return UICorner;
    end;

    function Library:ApplyTextSize(Obj, Size)
        if not Obj then return; end;

        Obj.TextScaled = true;
        local TextSizeConstraint = Library.Create("UITextSizeConstraint", {
            Parent = Obj,
            MaxTextSize = Size or 18,
        });

        return TextSizeConstraint;
    end;

    function Library:ApplyClick(Obj)
        if not Obj then return; end;

        local ClickButton = Library.Create("TextButton", {
            Parent = Obj,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            TextTransparency = 1,
            Text = "",
        });

        return ClickButton;
    end;

    function Library:ApplyShadow(Obj)
        if not Obj then return; end;

        local Shadow = Library.Create("ImageLabel", {
            Parent = Obj,
            AnchorPoint = Vector2.new(.5, .5),
            Position = UDim2.new(.5, 0, .5, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://6014261993",
            ZIndex = -99999999
        }, { ImageColor3 = "Black" });

        return Shadow;
    end;
end;

local function MouseInBounds(Position, Size)
    if (not Position) or (not Size) then return; end;
    local x, y = Mouse.X, Mouse.Y;
    local px, py = Position.X, Position.Y;
    local sx, sy = Size.X, Size.Y;

    return (x > px and x < px + sx and y > py and y < py + sy);
end;

local function BuildConnection(func, ...)
    local args = { ... };
    local function newFunc()
        func(unpack(args));
    end;

    return newFunc;
end;

local SubFunctions; SubFunctions = {
    CreateLabel = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Label";
        nself.Alignment = nself.Alignment or "Center";

        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 15) or 25),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Label = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = nself.Text,
            TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or
                Enum.TextXAlignment.Center,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Label, (isSetting and 14) or 18);

        local function Update()
            Label.Text = nself.Text or "";
            Label.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Center;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        return nself;
    end,

    CreateButton = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Button";
        nself.Alignment = nself.Alignment or "Center";
        nself.Callback = nself.Callback or function(...) end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 15) or 25),
        }, { BackgroundColor3 = "Background2" });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Stroke = Library:ApplyStroke(Background, "Accent1", 1, "Round");
        Library:ApplyCorner(Background, 4);

        local Label = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Label, (isSetting and 11) or 15);
        Library.Create("UIPadding", {
            Parent = Label,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        -- Functions
        local function Update()
            Label.Text = nself.Text or "";
            Label.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Center;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        nself.Fire = function(self) task.spawn(self.Callback); end;
        Update();

        local SettingsUI = nil;
        function nself:CreateSettings(Size)
            if SettingsUI then return; end;
            local Settings = { isSetting = true };

            Settings.UI = Library.Create("ScrollingFrame", {
                Parent = Library.ScreenUI,
                Size = Size or UDim2.new(0, 150, 0, 100),
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                Visible = false,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 1,
                ZIndex = 999
            }, { BackgroundColor3 = "Background2" });

            Library:ApplyCorner(Settings.UI, 4);
            Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
            Library:ApplyPadding(Settings.UI, 7);
            Library.Create("UIListLayout", {
                Parent = Settings.UI,
                Padding = UDim.new(0, 5),
            });

            SettingsUI = Settings.UI;
            InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                SettingsUI.Visible = (n and SettingsUI.Visible) or false;
            end, false, true);

            SettingsUI.ChildAdded:Connect(function(child)
                pcall(function()
                    child.ZIndex = 999;
                end);
                task.wait();
                for _, v in pairs(child:GetDescendants()) do
                    pcall(function()
                        v.ZIndex = 999;
                    end);
                end;
            end);

            setmetatable(Settings, { __index = SubFunctions })
            return Settings;
        end;

        -- Mouse Actions
        local Click = Library:ApplyClick(Background);

        Click.MouseEnter:Connect(function()
            Library:Register(Background, { BackgroundColor3 = "Background" }, true);
            Library:Register(Stroke, { Color = "Hover" }, true);
        end);

        Click.MouseLeave:Connect(function()
            Library:Register(Background, { BackgroundColor3 = "Background2" }, true);
            Library:Register(Stroke, { Color = "Accent1" }, true);
        end);

        Click.MouseButton1Down:Connect(function()
            Library:Register(Background, { BackgroundColor3 = "Background" }, true);
            Library:Register(Stroke, { Color = "Selected" }, true);
        end);

        Click.MouseButton1Up:Connect(function()
            nself:Fire();
            Library:Register(Background, { BackgroundColor3 = "Background" }, true);
            Library:Register(Stroke, { Color = "Hover" }, true);
        end);

        Click.MouseButton2Up:Connect(function()
            if SettingsUI then
                SettingsUI.Visible = true;
                SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
            end;
        end);

        return nself;
    end,

    CreateToggle = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Toggle";
        nself.Subtext = nself.Subtext or "";
        nself.Alignment = nself.Alignment or "Left";
        nself.Default = nself.Default or false;
        nself.Callback = nself.Callback or function(...) end;
        nself.Flag = nself.Flag or nil;

        nself.Value = nself.Default or false;
        table.insert(Library.Created.Toggles, nself);

        if nself.Flag then
            Library.Created.Flags[nself.Flag] = nself;
        end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 20) or 30),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Title = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(.75, 0, (nself.Subtext == "" and 1) or .5, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Title, (isSetting and 12) or 16);
        Library.Create("UIPadding", {
            Parent = Title,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Description = Library.Create("TextLabel", {
            Parent = Background,
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(.75, 0, .5, 0),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Subtext" });

        Library:ApplyTextSize(Description, (isSetting and 10) or 14);
        Library.Create("UIPadding", {
            Parent = Description,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        -- Visuals
        local Slider = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(1, .5),
            Position = UDim2.new(1, 0, .5, 0),
            Size = UDim2.new(1, 0, .66, 0),
        }, { BackgroundColor3 = "Background2" });

        Library:ApplyRatio(Slider, 2, "Height");
        Library:ApplyCorner(Slider, 10);
        Library:ApplyStroke(Slider, "Accent1", 1, "Round");

        local Circle = Library.Create("Frame", {
            Parent = Slider,
            AnchorPoint = Vector2.new(0, .5),
            Position = UDim2.new(.1, 0, .5, 0),
            Size = UDim2.new(.4, 0, .8, 0),
        }, { BackgroundColor3 = "Text" });

        Library:ApplyCorner(Circle, 10);

        -- Functions
        local function Update()
            local TweenInfo = TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            local Color, Position = (nself.Value and "Highlight") or "Background2",
                UDim2.new((nself.Value and .55) or .1, 0, .5, 0);

            TweenService:Create(Circle, TweenInfo, { Position = Position }):Play();
            Library:Register(Slider, { BackgroundColor3 = Color }, true);

            Title.Text = nself.Text;
            Title.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Left;
            Description.Text = nself.Subtext;
            Description.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or
                Enum.TextXAlignment.Left;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        function nself:SetValue(nv)
            nself.Value = nv or false;
            nself:Fire();
            Update();
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:ChangeSubtext(nv)
            nself.Subtext = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        local SettingsUI = nil;
        function nself:CreateSettings(Size)
            if SettingsUI then return; end;
            local Settings = { isSetting = true };

            Settings.UI = Library.Create("ScrollingFrame", {
                Parent = Library.ScreenUI,
                Size = Size or UDim2.new(0, 150, 0, 100),
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                Visible = false,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 1,
                ZIndex = 999
            }, { BackgroundColor3 = "Background2" });

            Library:ApplyCorner(Settings.UI, 4);
            Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
            Library:ApplyPadding(Settings.UI, 7);
            Library.Create("UIListLayout", {
                Parent = Settings.UI,
                Padding = UDim.new(0, 5),
            });

            SettingsUI = Settings.UI;
            InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                SettingsUI.Visible = (n and SettingsUI.Visible) or false;
            end, false, true);

            SettingsUI.ChildAdded:Connect(function(child)
                pcall(function()
                    child.ZIndex = 999;
                end);
                task.wait();
                for _, v in pairs(child:GetDescendants()) do
                    pcall(function()
                        v.ZIndex = 999;
                    end);
                end;
            end);

            setmetatable(Settings, { __index = SubFunctions })
            return Settings;
        end;

        nself.Switch = function(self) task.spawn(self.SetValue, self, not self.Value); end;
        nself.Unload = function(self) task.spawn(self.SetValue, self); end;
        nself.Fire = function(self) task.spawn(self.Callback, self.Value); end;
        nself.Load = nself.SetValue;
        nself:Fire();
        Update();

        local Click = Library:ApplyClick(Background);
        Click.MouseButton1Up:Connect(BuildConnection(nself.Switch, nself));
        Click.MouseButton2Up:Connect(function()
            if SettingsUI then
                SettingsUI.Visible = true;
                SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
            end;
        end);

        return nself;
    end,

    CreateKeybind = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Keybind";
        nself.Subtext = nself.Subtext or ""
        nself.Alignment = nself.Alignment or "Left";
        nself.Default = nself.Default or nil;
        nself.Callback = nself.Callback or function(...) end;
        nself.Flag = nself.Flag or nil;

        nself.Value = nself.Default or nil;
        table.insert(Library.Created.Binds, nself);

        if nself.Flag then
            Library.Created.Flags[nself.Flag] = nself;
        end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 20) or 30),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Title = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(.75, 0, (nself.Subtext == "" and 1) or .5, 0),
            BackgroundTransparency = 1,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Title, (isSetting and 12) or 16);
        Library.Create("UIPadding", {
            Parent = Title,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Description = Library.Create("TextLabel", {
            Parent = Background,
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(.75, 0, .5, 0),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Subtext" });

        Library:ApplyTextSize(Description, (isSetting and 10) or 14);
        Library.Create("UIPadding", {
            Parent = Description,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Subframe = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(1, .5),
            Position = UDim2.new(1, 0, .5, 0),
            Size = UDim2.new(.1, 0, .75, 0),
            AutomaticSize = Enum.AutomaticSize.X,
        }, { BackgroundColor3 = "Background2" });

        Library:ApplyCorner(Subframe, 4);
        Library:ApplyStroke(Subframe, "Accent1", 1, "Round");
        Library:ApplyPadding(Subframe, 5);

        local ValueLabel = Library.Create("TextLabel", {
            Parent = Subframe,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            TextSize = (isSetting and 10) or 14,
            Text = nself.Value or "",
            AutomaticSize = Enum.AutomaticSize.X,
            RichText = true,
        }, { FontFace = "Font", TextColor3 = "Text" });

        -- Functions
        local function Update()
            ValueLabel.Text = nself.Value or "";
            Title.Text = nself.Text;
            Title.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Left;
            Description.Text = nself.Subtext;
            Description.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or
                Enum.TextXAlignment.Left;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        local Old;
        function nself:SetKey(Key)
            nself.Value = Key;
            Update();

            if Old then Old:Disconnect(); end; Old = nil;
            if not Key then return; end;

            Old = InputService:Bind(Key, BuildConnection(nself.Fire, nself));
        end;

        local Doing = false;
        function nself.Start()
            if Doing then return; end;
            Doing = true;
            local Found = false;
            local function Recieved(Key)
                nself:SetKey(Key);
                Found = true;
                Doing = false;
            end;

            InputService:Record(false, {
                Type = "KeyCode",
                Break = true,

                Callback = Recieved,
            });

            task.spawn(function()
                while not Found do
                    for i = 1, 3 do
                        if Found then break; end;
                        if i == 1 then
                            ValueLabel.Text = ". "; task.wait(.5); continue;
                        end;

                        ValueLabel.Text = ValueLabel.Text .. ". ";

                        task.wait(.5);
                    end;
                end;
            end);
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:ChangeSubtext(nv)
            nself.Subtext = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        local SettingsUI = nil;
        function nself:CreateSettings(Size)
            if SettingsUI then return; end;
            local Settings = { isSetting = true };

            Settings.UI = Library.Create("ScrollingFrame", {
                Parent = Library.ScreenUI,
                Size = Size or UDim2.new(0, 150, 0, 100),
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                Visible = false,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 1,
                ZIndex = 999
            }, { BackgroundColor3 = "Background2" });

            Library:ApplyCorner(Settings.UI, 4);
            Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
            Library:ApplyPadding(Settings.UI, 7);
            Library.Create("UIListLayout", {
                Parent = Settings.UI,
                Padding = UDim.new(0, 5),
            });

            SettingsUI = Settings.UI;
            InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                SettingsUI.Visible = (n and SettingsUI.Visible) or false;
            end, false, true);

            SettingsUI.ChildAdded:Connect(function(child)
                pcall(function()
                    child.ZIndex = 999;
                end);
                task.wait();
                for _, v in pairs(child:GetDescendants()) do
                    pcall(function()
                        v.ZIndex = 999;
                    end);
                end;
            end);

            setmetatable(Settings, { __index = SubFunctions })
            return Settings;
        end;

        nself.Unload = function(self) task.spawn(self.SetKey, self); end;
        nself.Fire = function(self) task.spawn(self.Callback); end;
        nself.Load = nself.SetKey;
        nself:SetKey(nself.Default);

        local Click = Library:ApplyClick(Background);
        Click.MouseButton1Up:Connect(nself.Start);
        Click.MouseButton2Up:Connect(function()
            if SettingsUI then
                SettingsUI.Visible = true;
                SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
            end;
        end);

        return nself;
    end,

    CreateSlider = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Slider";
        nself.Alignment = nself.Alignment or "Left";
        nself.Callback = nself.Callback or function(...) end;
        nself.Flag = nself.Flag or nil;

        nself.Floats = nself.Floats or 0;
        nself.Default = nself.Default or 0;
        nself.Limits = nself.Limits or { 0, 100 }; -- Min / Max
        nself.Limits[1] = nself.Limits[1] or 0;
        nself.Limits[2] = nself.Limits[2] or 100;
        nself.Increment = nself.Increment or 1;

        nself.Value = math.clamp(nself.Default, unpack(nself.Limits)) or 0;

        if nself.Flag then
            Library.Created.Flags[nself.Flag] = nself;
        end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 20) or 30),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Title = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(.75, 0, (nself.Subtext == "" and 1) or .5, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Title, (isSetting and 12) or 16);
        Library.Create("UIPadding", {
            Parent = Title,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Subframe = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(.2, 0, .5, 0),
        }, { BackgroundColor3 = "Background2" });

        Library:ApplyCorner(Subframe, 4);
        Library:ApplyStroke(Subframe, "Accent1", 1, "Round");

        local ValueBox = Library.Create("TextBox", {
            Parent = Subframe,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = tostring(nself.Value),
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(ValueBox, 14);

        local Slider_Back = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(.5, 1),
            Position = UDim2.new(.5, 0, 1, 0),
            Size = UDim2.new(1, 0, .185, 0),

        }, { BackgroundColor3 = "Tone" });

        Library:ApplyCorner(Slider_Back, 10);
        Library:ApplyStroke(Slider_Back, "Accent1", 1, "Round");

        local Slider_Fill = Library.Create("Frame", {
            Parent = Slider_Back,
            Size = UDim2.new(0, 0, 1, 0),
        }, { BackgroundColor3 = "Highlight" });

        Library:ApplyCorner(Slider_Fill, 10);

        local SliderCircle = Library.Create("Frame", {
            Parent = Slider_Fill,
            AnchorPoint = Vector2.new(1, .5),
            Size = UDim2.new(1, 0, 1.85, 0),
            Position = UDim2.new(1, 0, .5, 0),
        }, { BackgroundColor3 = "Text" });

        Library:ApplyCorner(SliderCircle, 10);
        Library:ApplyRatio(SliderCircle, 1, "Height", true);

        local Click = Library:ApplyClick(Slider_Back);
        Click.ZIndex = 2;
        local isSliding = false;

        local function Update()
            nself.Value = math.clamp(nself.Value, unpack(nself.Limits));
            local Value = nself.Value;
            local Percent = ((nself.Value - nself.Limits[1]) / (nself.Limits[2] - nself.Limits[1]));
            local TweenInfo = TweenInfo.new(.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            TweenService:Create(Slider_Fill, TweenInfo, { Size = UDim2.new(Percent, 0, 1, 0) }):Play();

            local Converted = string.format("%." .. tostring(nself.Floats) .. "f", Value);
            ValueBox.Text = (tonumber(Converted) % 1 == 0 and tostring(math.floor(Value))) or Converted;
            Title.Text = nself.Text;
            Title.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Left;

            nself:Fire();
            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        local function Start()
            isSliding = true;

            while isSliding do
                local absPX, absSX = Slider_Back.AbsolutePosition.X, Slider_Back.AbsoluteSize.X;
                local x = Mouse.X;

                local Percent = (x - absPX) / absSX;
                Percent = math.clamp(Percent, 0, 1);
                local Value = ((nself.Limits[2] - nself.Limits[1]) * Percent) + nself.Limits[1];

                local increment = tonumber(nself.Increment) or 1
                Value = math.floor((Value / increment) + 0.5) * increment

                nself.Value = Value;
                Update();

                RunService.Heartbeat:Wait();
            end
        end;

        local function End()
            isSliding = false;
        end;

        function nself:SetValue(nv)
            nself.Value = nv or -math.huge;
            Update();
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        nself.Fire = function(self) task.spawn(self.Callback, self.Value); end;
        nself.Load = nself.SetValue;
        Update();

        local SettingsUI = nil;
        function nself:CreateSettings(Size)
            if SettingsUI then return; end;
            local Settings = { isSetting = true };

            Settings.UI = Library.Create("ScrollingFrame", {
                Parent = Library.ScreenUI,
                Size = Size or UDim2.new(0, 150, 0, 100),
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                Visible = false,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 1,
                ZIndex = 999
            }, { BackgroundColor3 = "Background2" });

            Library:ApplyCorner(Settings.UI, 4);
            Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
            Library:ApplyPadding(Settings.UI, 7);
            Library.Create("UIListLayout", {
                Parent = Settings.UI,
                Padding = UDim.new(0, 5),
            });

            SettingsUI = Settings.UI;
            InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                SettingsUI.Visible = (n and SettingsUI.Visible) or false;
            end, false, true);

            SettingsUI.ChildAdded:Connect(function(child)
                pcall(function()
                    child.ZIndex = 999;
                end);
                task.wait();
                for _, v in pairs(child:GetDescendants()) do
                    pcall(function()
                        v.ZIndex = 999;
                    end);
                end;
            end);

            setmetatable(Settings, { __index = SubFunctions })
            return Settings;
        end;

        ValueBox.FocusLost:Connect(function()
            local BoxVal = tonumber(ValueBox.Text);
            nself:SetValue(BoxVal);
        end);

        Click.MouseButton1Down:Connect(Start);
        Click.MouseButton2Up:Connect(function()
            if SettingsUI then
                SettingsUI.Visible = true;
                SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
            end;
        end);
        InputService:Bind("MouseButton1", End, true, true);

        return nself;
    end,

    CreateInput = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Input Box";
        nself.Subtext = nself.Subtext or ""
        nself.Alignment = nself.Alignment or "Left";
        nself.Default = nself.Default or "";
        nself.Placeholder = nself.Placeholder or "";
        nself.Callback = nself.Callback or function(...) end;
        nself.Flag = nself.Flag or nil;

        nself.Value = nself.Default or "";

        if nself.Flag then
            Library.Created.Flags[nself.Flag] = nself;
        end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 20) or 30),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Title = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(.75, 0, (nself.Subtext == "" and 1) or .5, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Title, (isSetting and 12) or 16);
        Library.Create("UIPadding", {
            Parent = Title,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Description = Library.Create("TextLabel", {
            Parent = Background,
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(.75, 0, .5, 0),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Subtext" });

        Library:ApplyTextSize(Description, (isSetting and 10) or 14);
        Library.Create("UIPadding", {
            Parent = Description,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Subframe = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(1, .5),
            Position = UDim2.new(1, 0, .5, 0),
            Size = UDim2.new(.25, 0, .75, 0),
            ClipsDescendants = true,
        }, { BackgroundColor3 = "Background2" });

        Library:ApplyCorner(Subframe, 4);
        Library:ApplyStroke(Subframe, "Accent1", 1, "Round");
        Library:ApplyPadding(Subframe, 5);

        local ValueBox = Library.Create("TextBox", {
            Parent = Subframe,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            TextSize = 14,
            Text = nself.Value or "",
            PlaceholderText = nself.Placeholder,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
            RichText = true,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library.Create("UIPadding", {
            Parent = ValueBox,
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
        });

        local function Update()
            ValueBox.Text = nself.Value or "";
            Title.Text = nself.Text;
            Title.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Left;
            Description.Text = nself.Subtext;
            Description.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or
                Enum.TextXAlignment.Left;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        function nself:SetValue(nv)
            nself.Value = nv;
            nself:Fire();
            Update();
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:ChangeSubtext(nv)
            nself.Subtext = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        nself.Fire = function(self) task.spawn(self.Callback, self.Value); end;
        nself.Load = nself.SetValue;
        nself:Fire();
        Update();

        ValueBox.Focused:Connect(function()
            local Info = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

            TweenService:Create(Title, TweenInfo.new(.1), { TextTransparency = 1 }):Play();
            TweenService:Create(Description, TweenInfo.new(.1), { TextTransparency = 1 }):Play();
            TweenService:Create(Subframe, Info, { Size = UDim2.new(1, 0, .75, 0) }):Play();
        end);

        ValueBox.FocusLost:Connect(function()
            local Info = TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

            TweenService:Create(Title, TweenInfo.new(.2), { TextTransparency = 0 }):Play();
            TweenService:Create(Description, TweenInfo.new(.2), { TextTransparency = 0 }):Play();
            TweenService:Create(Subframe, Info, { Size = UDim2.new(.25, 0, .75, 0) }):Play();

            nself:SetValue(ValueBox.Text);
        end);

        return nself;
    end,

    CreateDropdown = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Text = nself.Text or "Dropdown";
        nself.Subtext = nself.Subtext or ""
        nself.Alignment = nself.Alignment or "Left";
        nself.Choices = nself.Choices or {};
        nself.Multi = nself.Multi or false;
        nself.Default = nself.Default or nil;
        nself.Callback = nself.Callback or function(...) end;
        nself.Flag = nself.Flag or nil;

        nself.Value = nself.Default or nil;

        if nself.Flag then
            Library.Created.Flags[nself.Flag] = nself;
        end;

        -- UI
        local Background = Library.Create("Frame", {
            Parent = ParentUI,
            Size = UDim2.new(1, 0, 0, (isSetting and 20) or 30),
            BackgroundTransparency = 1,
        });

        local i1, i2; if not isSetting then
            i1, i2 = self:AddContent(nself.Text, nil, Background),
                self:AddContent(nself.Subtext, nil, Background);
        end;

        local Title = Library.Create("TextLabel", {
            Parent = Background,
            Size = UDim2.new(.75, 0, (nself.Subtext == "" and 1) or .5, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(Title, (isSetting and 12) or 16);
        Library.Create("UIPadding", {
            Parent = Title,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Description = Library.Create("TextLabel", {
            Parent = Background,
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(.75, 0, .5, 0),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,

        }, { FontFace = "Font", TextColor3 = "Subtext" });

        Library:ApplyTextSize(Description, (isSetting and 10) or 14);
        Library.Create("UIPadding", {
            Parent = Description,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Subframe = Library.Create("Frame", {
            Parent = Background,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(.4, 0, 1, 0),
        }, { BackgroundColor3 = "Background2" });

        Library:ApplyCorner(Subframe, 6);
        Library:ApplyStroke(Subframe, "Accent1", 1, "Round");
        Library.Create("UIPadding", {
            Parent = Subframe,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local Visuals = Library.Create("Frame", {
            Parent = Subframe,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30),
        });

        local Circle = Library.Create("Frame", {
            Parent = Visuals,
            AnchorPoint = Vector2.new(1, .5),
            Position = UDim2.new(1, -2, .5, 0),
            Size = UDim2.new(0, 5, 0, 5),
        }, { BackgroundColor3 = "Text" });

        Library:ApplyCorner(Circle, 100);

        local ValueLabel = Library.Create("TextLabel", {
            Parent = Visuals,
            BackgroundTransparency = 1,
            Size = UDim2.new(.8, 0, 1, 0),
            TextSize = 11,
            Text = "None",
            TextXAlignment = Enum.TextXAlignment.Left,
            ClipsDescendants = true,
        }, { FontFace = "Font", TextColor3 = "Text" });

        local SearchBox = Library.Create("TextBox", {
            Parent = Visuals,
            BackgroundTransparency = 1,
            Size = UDim2.new(.8, 0, 1, 0),
            TextSize = 11,
            Text = "",
            PlaceholderText = "Search: ",
            TextXAlignment = Enum.TextXAlignment.Left,
            ClipsDescendants = true,
            Visible = false,
            ZIndex = 10,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library.Create("UIPadding", {
            Parent = SearchBox,
            PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7),
        });

        local ItemHolder = Library.Create("ScrollingFrame", {
            Parent = Subframe,
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(1, 0, 0, 75),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 1,
            Visible = false,
        }, { ScrollBarImageColor3 = "Highlight" });

        Library:ApplyPadding(ItemHolder, 5);
        Library.Create("UIListLayout", {
            Parent = ItemHolder,
            Padding = UDim.new(0, 5),
        });

        local Options = {};
        local function Update()
            for i, v in pairs(Options) do
                if (nself.Value == i) or (typeof(nself.Value) == "table" and table.find(nself.Value, i)) then
                    Library:Register(v[2], { Color = "Selected" }, true);
                else
                    Library:Register(v[2], { Color = "Accent1" }, true);
                end;
            end;

            if typeof(nself.Value) == "table" then
                local Concated = table.concat(nself.Value, ", ");
                ValueLabel.Text = (Concated ~= "" and Concated) or "None";
            else
                ValueLabel.Text = nself.Value or "None";
            end;

            Title.Text = nself.Text;
            Title.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or Enum.TextXAlignment
                .Left;
            Description.Text = nself.Subtext;
            Description.TextXAlignment = (nself.Alignment and Enum.TextXAlignment[nself.Alignment]) or
                Enum.TextXAlignment.Left;

            if not isSetting then
                self:AddContent(nself.Text, i1, Background); self:AddContent(nself.Subtext, i2, Background);
            end;
        end;

        local function ToggleOption(Option)
            if nself.Multi then
                nself.Value = nself.Value or {};

                local Found = table.find(nself.Value, Option);
                if Found then
                    table.remove(nself.Value, Found);
                else
                    table.insert(nself.Value, Option);
                end;
            else
                if nself.Value ~= Option then
                    nself.Value = Option;
                else
                    nself.Value = nil;
                end;
            end;

            nself:Fire();
            Update();
        end;

        function nself:ChangeText(nv)
            nself.Text = nv;
            Update();
        end;

        function nself:ChangeSubtext(nv)
            nself.Subtext = nv;
            Update();
        end;

        function nself:SetAlignment(nv)
            nself.Alignment = nv;
            Update();
        end;

        function nself:SetOptions(New)
            for idx, _ in pairs(Options) do
                nself:RemoveOption(idx);
            end;

            for _, nv in ipairs(New) do
                nself:AddOption(nv);
            end;

            nself:SetValue();
            nself:Fire();
            Update();
        end;

        function nself:AddOption(Option)
            if not Option then return; end;
            Option = tostring(Option);

            local OptionFrame = Library.Create("Frame", {
                Parent = ItemHolder,
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                ZIndex = 11
            });

            Library:ApplyCorner(OptionFrame, 4);
            Library:ApplyTextSize(Library.Create("TextLabel", {
                Parent = OptionFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = Option,
                ZIndex = 11
            }, { FontFace = "Font", TextColor3 = "Text" }), 10);

            Options[Option] = { OptionFrame, Library:ApplyStroke(OptionFrame, "Accent1", 1, "Round") };

            local OptionClick = Library:ApplyClick(OptionFrame);
            OptionClick.ZIndex = 12;
            OptionClick.MouseButton1Up:Connect(function()
                ToggleOption(Option);
            end);
        end;

        function nself:RemoveOption(Option)
            if Option and Options[Option] then
                Options[Option][1]:Destroy();
                Options[Option] = nil;
            end;
        end;

        for _, v in pairs(nself.Choices) do
            nself:AddOption(v);
        end;

        function nself:SetValue(Value)
            if nself.Multi and typeof(Value) ~= "table" then
                Value = { Value };
            elseif not nself.Multi and typeof(Value) == "table" then
                Value = unpack(Value);
            end;

            nself.Value = Value;
            nself:Fire();
            Update();
        end;

        nself.ClearDropdown = nself.SetOptions;
        nself.Fire = function(self) task.spawn(self.Callback, self.Value); end;
        nself.Load = nself.SetValue;
        nself:Fire();
        Update();

        local SettingsUI = nil;
        function nself:CreateSettings(Size)
            if SettingsUI then return; end;
            local Settings = { isSetting = true };

            Settings.UI = Library.Create("ScrollingFrame", {
                Parent = Library.ScreenUI,
                Size = Size or UDim2.new(0, 150, 0, 100),
                Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                Visible = false,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ClipsDescendants = true,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 1,
                ZIndex = 999
            }, { BackgroundColor3 = "Background2" });

            Library:ApplyCorner(Settings.UI, 4);
            Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
            Library:ApplyPadding(Settings.UI, 7);
            Library.Create("UIListLayout", {
                Parent = Settings.UI,
                Padding = UDim.new(0, 5),
            });

            SettingsUI = Settings.UI;
            InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                SettingsUI.Visible = (n and SettingsUI.Visible) or false;
            end, false, true);

            SettingsUI.ChildAdded:Connect(function(child)
                pcall(function()
                    child.ZIndex = 999;
                end);
                task.wait();
                for _, v in pairs(child:GetDescendants()) do
                    pcall(function()
                        v.ZIndex = 999;
                    end);
                end;
            end);

            setmetatable(Settings, { __index = SubFunctions })
            return Settings;
        end;

        local Click = Library:ApplyClick(Background);

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            for Contents, Objects in pairs(Options) do
                local l1, l2 = string.lower(SearchBox.Text), string.lower(Contents);

                Objects[1].Visible = string.match(l2, l1);
            end;
        end);

        local function Show()
            Subframe.ZIndex = 10;
            Circle.ZIndex = 10;
            ValueLabel.ZIndex = 10;
            ItemHolder.ZIndex = 10;

            SearchBox.Visible = true;
            ValueLabel.Visible = false;
            local Tween = TweenService:Create(Subframe,
                TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                { Size = UDim2.new(1, 0, 1, 75) });
            Tween:Play();
            Tween.Completed:Wait();
            ItemHolder.Visible = true;
        end;

        local function Hide()
            Subframe.ZIndex = 1;
            Circle.ZIndex = 1;
            ValueLabel.ZIndex = 1;
            ItemHolder.ZIndex = 1;

            ItemHolder.Visible = false;
            SearchBox.Visible = false;
            local Tween = TweenService:Create(Subframe,
                TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                { Size = UDim2.new(.4, 0, 1, 0) });
            Tween:Play();
            Tween.Completed:Wait();
            ValueLabel.Visible = true;
        end;

        local Listing = false;
        Click.MouseButton1Up:Connect(function()
            Listing = not Listing;
            if Listing then
                Show();
            else
                Hide();
            end;
        end);

        Click.MouseButton2Up:Connect(function()
            if SettingsUI then
                SettingsUI.Visible = true;
                SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
            end;
        end);

        InputService:Bind("MouseButton1", function()
            if not MouseInBounds(Subframe.AbsolutePosition, Subframe.AbsoluteSize) then
                Hide();
            end;
        end, true, true)

        return nself;
    end,

    CreateLog = function(self, INFO)
        local ParentUI, isSetting = self.UI, self.isSetting;
        if not ParentUI then return; end;

        local nself = INFO or {};
        nself.Default = nself.Default or {}; -- { "Log1", "Log2", "Log3" }
        nself.Size = nself.Size or 60;
        nself.Max = nself.Max or 99;
        nself.Logs = {};

        local Background = Library.Create("ScrollingFrame", {
            Parent = ParentUI,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, (isSetting and ((nself.Size / 2) or 30)) or (nself.Size or (60))),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 1,
            CanvasSize = UDim2.new(0, 0, 0, 0),
        });

        Library:ApplyStroke(Background, "Accent1", 1, "Round");
        Library:ApplyCorner(Background, 5);
        Library:ApplyPadding(Background, 5);
        Library.Create("UIListLayout", {
            Parent = Background,
            SortOrder = Enum.SortOrder.LayoutOrder,
        });

        Library.Create("Frame", {
            Parent = Background,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, (isSetting and .2) or .3, 0),
            LayoutOrder = 999999,
        });

        function nself:AddEntry(Contents)
            local EF = Library.Create("Frame", {
                Parent = Background,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, (isSetting and .2) or .3, 0),
            });

            local SettingsUI;
            local Fake = {
                Destroy = function(self)
                    EF:Destroy();
                    if SettingsUI then
                        SettingsUI:Destroy();
                    end;
                end,
            };
            
            local LogContent = { Contents or "", Fake };
            table.insert(nself.Logs, LogContent);
            if #nself.Logs > nself.Max then self:RemoveEntry(1); end;

            local EF_Desc = Library.Create("TextLabel", {
                Parent = EF,
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                Text = Contents or "",
            }, { FontFace = "Font", TextColor3 = "Text" });

            Library:ApplyTextSize(EF_Desc, 16);
            Library.Create("UIPadding", {
                Parent = EF_Desc,
                PaddingLeft = UDim.new(.1, 0),
                PaddingRight = UDim.new(.1, 0),
            });

            local Number = Library.Create("TextLabel", {
                Parent = EF,
                AnchorPoint = Vector2.new(0, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(.1, 0, 1, 0),
                TextSize = 16,
                Text = tostring(#nself.Logs) .. "." or "",
            }, { FontFace = "Font", TextColor3 = "Text" });

            local f; f = Background.ChildRemoved:Connect(function(Child)
                if Child == EF then
                    f:Disconnect();
                else
                    Number.Text = table.find(nself.Logs, LogContent);
                end;
            end);

            local Click = Library:ApplyClick(EF);

            Click.MouseButton2Up:Connect(function()
                if SettingsUI then
                    SettingsUI.Visible = true;
                    SettingsUI.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
                end;
            end);

            return {
                CreateSettings = function(self, Size)
                    if SettingsUI then return; end;
                    local Settings = { isSetting = true };

                    Settings.UI = Library.Create("ScrollingFrame", {
                        Parent = Library.ScreenUI,
                        Size = Size or UDim2.new(0, 150, 0, 100),
                        Position = UDim2.new(0, Mouse.X, 0, Mouse.Y),
                        Visible = false,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ClipsDescendants = true,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        ScrollBarThickness = 1,
                        ZIndex = 999
                    }, { BackgroundColor3 = "Background2" });

                    Library:ApplyCorner(Settings.UI, 4);
                    Library:ApplyStroke(Settings.UI, "Accent1", 1, "Round");
                    Library:ApplyPadding(Settings.UI, 7);
                    Library.Create("UIListLayout", {
                        Parent = Settings.UI,
                        Padding = UDim.new(0, 5),
                    });

                    SettingsUI = Settings.UI;
                    InputService:Bind({ "MouseButton1", "MouseButton2" }, function()
                        local n = MouseInBounds(SettingsUI.AbsolutePosition, SettingsUI.AbsoluteSize);
                        SettingsUI.Visible = (n and SettingsUI.Visible) or false;
                    end, false, true);

                    SettingsUI.ChildAdded:Connect(function(child)
                        pcall(function()
                            child.ZIndex = 999;
                        end);
                        task.wait();
                        for _, v in pairs(child:GetDescendants()) do
                            pcall(function()
                                v.ZIndex = 999;
                            end);
                        end;
                    end);

                    setmetatable(Settings, { __index = SubFunctions })
                    return Settings;
                end,
            };
        end;

        function nself:RemoveEntry(Entry)
            if typeof(Entry) == "number" then
                local _, Thing = unpack(nself.Logs[Entry]);
                table.remove(nself.Logs, Entry);

                if Thing then
                    Thing:Destroy();
                end;
            else
                for i, v in pairs(nself.Logs) do
                    local Contents, Thing = unpack(v);
                    if Contents == Entry then
                        Thing:Destroy();
                        table.remove(nself.Logs, i);
                        break;
                    end;
                end;
            end;
        end;

        function nself:Clear()
            for _, v in pairs(nself.Logs) do
                nself:RemoveEntry(v);
            end;
        end;

        for _, v in next, (nself.Default) do
            nself:AddEntry(v);
        end;

        return nself;
    end,
};

function Library:Notify(Message, Duration, Title)
    if (not Message) or (not Library.ScreenUI) then return; end;

    Duration = Duration or 7.5;
    Title = Title or "Notificaiton!";

    local NotiUI;
    if not getgenv().NotiUI then
        NotiUI = Library.Create("Frame", {
            Parent = Library.ScreenUI,
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 250, 1, 0),
        });

        Library:ApplyPadding(NotiUI, 5);
        Library.Create("UIListLayout", {
            Parent = NotiUI,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, 5),
        });
    else
        NotiUI = getgenv().NotiUI;
    end;

    local Fake = Library.Create("Frame", {
        Parent = NotiUI,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50),
        AutomaticSize = Enum.AutomaticSize.Y,
    });

    local NotiBack = Library.Create("Frame", {
        Parent = Fake,
        Position = UDim2.new(2, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 50),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, { BackgroundColor3 = "Background" });

    Library:ApplyCorner(NotiBack, 5);
    Library:ApplyPadding(NotiBack, 5);
    Library:ApplyStroke(NotiBack, "Highlight", 1, "Round");

    local TitleLabel = Library.Create("TextLabel", {
        Parent = NotiBack,
        AnchorPoint = Vector2.new(0, .75),
        BackgroundTransparency = 1,
        Size = UDim2.new(.5, 0, 0, 20),
        TextSize = 20,
        RichText = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = tostring(Title),
    }, { TextColor3 = "Text", FontFace = "NotiFont" });

    Library:ApplyStroke(TitleLabel, "Highlight", 1, "Round");

    local Description = Library.Create("Frame", {
        Parent = NotiBack,
        AnchorPoint = Vector2.new(.5, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(.5, 0, 0, 10),
        Size = UDim2.new(.9, 0, 0, 50),
        AutomaticSize = Enum.AutomaticSize.Y,
    });

    Library.Create("UIPadding", {
        Parent = Description,
        PaddingBottom = UDim.new(0, 20),
    });

    Library.Create("TextLabel", {
        Parent = Description,
        BackgroundTransparency = 1,
        Size = UDim2.new(.9, 0, 0, 50),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextSize = 12,
        RichText = true,
        Text = tostring(Message),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }, { TextColor3 = "Text", FontFace = "Font" });

    local DurationBar = Library.Create("Frame", {
        Parent = NotiBack,
        AnchorPoint = Vector2.new(.5, 1),
        Position = UDim2.new(.5, 0, 1, -2),
        Size = UDim2.new(.9, 0, 0, 5),
    }, { BackgroundColor3 = "Background2" });

    Library:ApplyCorner(DurationBar, 100);
    Library:ApplyStroke(DurationBar, "Highlight", 1, "Round");

    local Fill = Library.Create("Frame", {
        Parent = DurationBar,
        Size = UDim2.new(1, 0, 1, 0)
    }, { BackgroundColor3 = "Highlight" });

    Library:ApplyCorner(Fill, 100);

    local Click = Library:ApplyClick(NotiBack);
    local Tween;

    task.spawn(function()
        TweenService:Create(NotiBack, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Position = UDim2.new(0, 0, 0, 0) }):Play();

        Tween = TweenService:Create(Fill, TweenInfo.new(Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Size = UDim2.new(0, 0, 1, 0) });
        Tween:Play();
        Tween.Completed:Wait();

        TweenService:Create(NotiBack, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Position = UDim2.new(2, 0, 0, 0) }):Play();
    end);

    Click.MouseButton1Up:Connect(function()
        if Tween then Tween:Cancel(); end;
    end);

    getgenv().NotiUI = NotiUI;
end;

local MinSize, MaxSize = UDim2.new(0, 750, 0, 50), UDim2.new(0, 750, 0, 500);
function Library:CreateWindow(WINFO)
    local Window = WINFO or {};
    Window.Title = Window.Title or "Window";
    Window.Icon = {};
    -- Window.Icon = { Image, Size } ; ImageID, UDim2 | Having a image will replace the title

    local ScreenUI = Library.Create("ScreenGui", {
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
    });

    Library.ScreenUI = ScreenUI;
    Library.Window = Window;
    getgenv().UIUIUI = Library;

    local Background = Library.Create("Frame", {
        Parent = ScreenUI,
        Position = UDim2.new(0, 0, .1, 0),
        Size = MaxSize,
    }, { BackgroundColor3 = "Background" });

    local DragUI = Library.Create("Frame", {
        Parent = Background,
        Size = UDim2.new(1, 0, .11, 0),
        BackgroundTransparency = 1,
    });

    do -- Drag
        -- off roblox devforum
        local dragging;
        local dragInput;
        local dragStart;
        local startPos;

        local function Update(input)
            local delta = input.Position - dragStart
            Background.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end;

        DragUI.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Background.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        DragUI.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                Update(input)
            end
        end)
    end;

    Library:ApplyShadow(Background);
    Library:ApplyCorner(Background, 6);

    Library.Create("Frame", {
        Parent = Background,
        AnchorPoint = Vector2.new(0, .5),
        Position = UDim2.new(.27, 0, .5, 0),
        Size = UDim2.new(0, 1, 1, 0),
    }, { BackgroundColor3 = "Accent1" }); -- Vertical Line

    local HoriLine = Library.Create("Frame", {
        Parent = Background,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, .11, 0),
        Size = UDim2.new(.73, 0, 0, 1),
    }, { BackgroundColor3 = "Accent1" }); -- Horizontal Line

    local Left = Library.Create("Frame", {
        Parent = Background,
        BackgroundTransparency = 1,
        Size = UDim2.new(.27, 0, 1, 0),
    });

    local LeftTop = Library.Create("Frame", {
        Parent = Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, .22, 0),
    });

    local LeftBottom = Library.Create("Frame", {
        Parent = Left,
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, .78, 0),
    });

    local TabsHolder = Library.Create("ScrollingFrame", {
        Parent = LeftBottom,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
    });

    Library.Create("UIPadding", {
        Parent = TabsHolder,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 4),
    });

    Library.Create("UIListLayout", {
        Parent = TabsHolder,
        Padding = UDim.new(0, 5),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    });

    local SearchFrame = Library.Create("Frame", {
        Parent = LeftBottom,
        AnchorPoint = Vector2.new(.5, 1),
        Position = UDim2.new(.5, 0, 1, -10),
        Size = UDim2.new(.8, 0, .1, 0)

    }, { BackgroundColor3 = "Background" });

    Library:ApplyCorner(SearchFrame, 4);
    Library:ApplyStroke(SearchFrame, "Accent1", 1, "Round");

    Library:ApplyRatio(Library.Create("ImageLabel", {
        Parent = SearchFrame,
        AnchorPoint = Vector2.new(1, .5),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -5, .5, 0),
        Size = UDim2.new(.12, 0, .5, 0),
        Image = "rbxassetid://117458905054064"
    }, { ImageColor3 = "Highlight" }));

    local SearchBox = Library.Create("TextBox", {
        Parent = SearchFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(.8, 0, 1, 0),
        Text = "",
        PlaceholderText = "Search",
        TextXAlignment = Enum.TextXAlignment.Left,
    }, { FontFace = "Font", TextColor3 = "Text" })

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        for _, v in pairs(Library.Created.Sections) do
            v:Search(SearchBox.Text)
        end
    end);

    Library.Create("UIPadding", {
        Parent = SearchBox,
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
    })

    Library:ApplyTextSize(SearchBox, 12);

    local Right = Library.Create("Frame", {
        Parent = Background,
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(.73, 0, 1, 0),
    });

    local RightTop = Library.Create("Frame", {
        Parent = Right,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, .11, 0),
    });

    local NavButtons = Library.Create("Frame", {
        Parent = RightTop,
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(.2, 0, 1, 0),
    });

    Library.Create("UIListLayout", {
        Parent = NavButtons,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
    })

    Library.Create("UIPadding", {
        Parent = NavButtons,
        PaddingRight = UDim.new(0, 10)
    });

    local NavClose = Library.Create("ImageButton", {
        Parent = NavButtons,
        AnchorPoint = Vector2.new(0, .5),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.new(0, 16, 0, 16),
        Image = "rbxassetid://80084831701712",
    }, { ImageColor3 = "Icons" });

    local NavMini = Library.Create("ImageButton", {
        Parent = NavButtons,
        AnchorPoint = Vector2.new(0, .5),
        BackgroundTransparency = 1,
        LayoutOrder = 0,
        Size = UDim2.new(0, 16, 0, 16),
        Image = "rbxassetid://73066567788933",
    }, { ImageColor3 = "Icons" });

    local RightBottom = Library.Create("Frame", {
        Parent = Right,
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, .89, 0),
    });

    Library:ApplyPadding(RightBottom, 10);

    function Window:Visibility(Value)
        Value = (Value ~= nil and Value) or not ScreenUI.Enabled;
        ScreenUI.Enabled = Value;
    end;

    local Minimized, MiniDB = false, false;
    NavClose.MouseButton1Up:Connect(BuildConnection(Window.Visibility, Window));
    NavMini.MouseButton1Up:Connect(function()
        if MiniDB then return; end;
        MiniDB = true;
        Minimized = not Minimized;
        local TweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

        if Minimized then
            NavMini.Image = "rbxassetid://116599003372689"; -- Restore icon
            LeftBottom.Visible = false;
            RightBottom.Visible = false;
            HoriLine.Visible = false;

            DragUI.Size = UDim2.new(1, 0, 1, 0);
            TweenService:Create(LeftTop, TweenInfo, { Size = UDim2.new(1, 0, 0, MinSize.Y.Offset) }):Play();
            TweenService:Create(RightTop, TweenInfo, { Size = UDim2.new(1, 0, 0, MinSize.Y.Offset) }):Play();
            TweenService:Create(Background, TweenInfo, { Size = MinSize }):Play();
        else
            NavMini.Image = "rbxassetid://73066567788933"; -- Mini icon

            HoriLine.Visible = true;
            DragUI.Size = UDim2.new(1, 0, .11, 0);
            TweenService:Create(LeftTop, TweenInfo, { Size = UDim2.new(1, 0, 0.22, 0) }):Play();
            TweenService:Create(RightTop, TweenInfo, { Size = UDim2.new(1, 0, 0.11, 0) }):Play();
            local Tween = TweenService:Create(Background, TweenInfo, { Size = MaxSize });
            Tween:Play();
            Tween.Completed:Wait();

            LeftBottom.Visible = true;
            RightBottom.Visible = true;
        end;

        task.wait(.1);
        MiniDB = false;
    end);

    function Window:Exit()
        ScreenUI:Destroy();

        for _, n in pairs(Library.Created) do
            for __, v in pairs(n) do
                if v.Unload then
                    v:Unload();
                end;
            end;
        end;
    end;

    if Window.Icon then
        local Image, Size = unpack(Window.Icon);

        Library.Create("ImageLabel", {
            Parent = LeftTop,
            AnchorPoint = Vector2.new(.5, .5),
            BackgroundTransparency = 1,
            Position = UDim2.new(.5, 0, .5, 0),
            Size = Size or UDim2.new(1, 0, 1, 0),
            Image = Image or "rbxassetid://122142349354490",
        }, { ImageColor3 = "Title" });
    else
        Library:ApplyStroke(Library.Create("TextLabel", {
            Parent = LeftTop,
            AnchorPoint = Vector2.new(.5, .5),
            BackgroundTransparency = 1,
            Position = UDim2.new(.5, 0, .5, 0),
            Size = UDim2.new(.7, 0, .5, 0),
            Text = Window.Title or "Window",
            TextScaled = true,
        }, { FontFace = "Font", TextColor3 = "Title" }));
    end;

    function Window:CreateTab(TINFO)
        local Tab = TINFO or {};
        Tab.Title = Tab.Title or "Tab";
        Tab.Icon = Tab.Icon or nil;

        local TB_Frame = Library.Create("Frame", {
            Parent = TabsHolder,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 35),
        }, { BackgroundColor3 = "Background2" });

        local TB_Stroke = Library:ApplyStroke(TB_Frame, "Accent1", 1, "Round");
        TB_Stroke.Enabled = false;

        Library:ApplyCorner(TB_Frame, 4);
        Library.Create("UIPadding", {
            Parent = TB_Frame,
            PaddingLeft = UDim.new(0, 10),
        });

        local TB_Holder = Library.Create("Frame", {
            Parent = TB_Frame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
        });

        Library.Create("UIListLayout", {
            Parent = TB_Holder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 10),
        });

        local TB_Icon = Library.Create("ImageLabel", {
            Parent = TB_Holder,
            BackgroundTransparency = 1,
            LayoutOrder = -1,
            Size = UDim2.new(0, 20, .5, 0),
            Image = Tab.Icon,
            Visible = (Tab.Icon ~= nil),
        }, { ImageColor3 = "Text" });

        local TB_Title = Library.Create("TextLabel", {
            Parent = TB_Holder,
            BackgroundTransparency = 1,
            Size = UDim2.new(.77, 0, 1, 0),
            Text = Tab.Title or "Tab",
            TextXAlignment = Enum.TextXAlignment.Left,
        }, { FontFace = "Font", TextColor3 = "Text" });

        Library:ApplyTextSize(TB_Title);

        local TabFrame = Library.Create("Frame", {
            Parent = RightBottom,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            ClipsDescendants = true,
        });

        local LeftTab = Library.Create("ScrollingFrame", {
            Parent = TabFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(.5, 0, 1, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            ClipsDescendants = false,
        });

        Library.Create("UIListLayout", {
            Parent = LeftTab,
            Padding = UDim.new(0, 10),
        });

        Library:ApplyPadding(LeftTab, 5);

        local RightTab = Library.Create("ScrollingFrame", {
            Parent = TabFrame,
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(.5, 0, 1, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            ClipsDescendants = false,
        });

        Library.Create("UIListLayout", {
            Parent = RightTab,
            Padding = UDim.new(0, 10),
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
        });

        Library:ApplyPadding(RightTab, 5);

        table.insert(Library.Created.Tabs, Tab);

        function Tab.Unfocus()
            local TweenInfo = TweenInfo.new(.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

            Tab.Focused = false;
            TweenService:Create(TB_Frame, TweenInfo, { BackgroundTransparency = 1 }):Play();
            Library:Register(TB_Icon, { ImageColor3 = "Text" }, true);
            Library:Register(TB_Title, { TextColor3 = "Text" }, true);
            TB_Stroke.Enabled = false;
            TabFrame.Visible = false;
        end;

        function Tab.Focus(c)
            local TweenInfo = TweenInfo.new(.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            c = c or false;

            TweenService:Create(TB_Frame, TweenInfo, { BackgroundTransparency = 0 }):Play();
            TB_Stroke.Enabled = true;

            Library:Register(TB_Icon, { ImageColor3 = "Highlight" }, not c);
            Library:Register(TB_Title, { TextColor3 = "Highlight", FontFace = "Font" }, not c);
            Tab.Focused = true;
            TabFrame.Visible = true;

            for _, v in pairs(Library.Created.Tabs) do
                if v == Tab then continue; end;
                v.Unfocus();
            end;
        end;

        if #Library.Created.Tabs == 1 then
            Tab.Focus(true);
        end;

        local TB_Click = Library:ApplyClick(TB_Frame);
        TB_Click.MouseEnter:Connect(function()
            if Tab.Focused then return; end;
            Library:Register(TB_Icon, { ImageColor3 = "Hover" }, true);
            Library:Register(TB_Title, { TextColor3 = "Hover" }, true);
        end);

        TB_Click.MouseLeave:Connect(function()
            if Tab.Focused then return; end;
            Library:Register(TB_Icon, { ImageColor3 = "Text" }, true);
            Library:Register(TB_Title, { TextColor3 = "Text" }, true);
        end);

        TB_Click.MouseButton1Down:Connect(function()
            Library:Register(TB_Icon, { ImageColor3 = "Selected" }, true);
            Library:Register(TB_Title, { TextColor3 = "Selected" }, true);
        end);

        TB_Click.MouseButton1Up:Connect(Tab.Focus);

        function Tab:CreateSection(SINFO)
            local Section = SINFO or {};
            Section.Title = Section.Title or "Section";
            Section.Side = Section.Side or "Left";

            local Sides = { ["Left"] = LeftTab, ["Right"] = RightTab };

            local isFull;
            if Section.Side == "Full" then
                Section.Side = "Left";
                isFull = true;
            end;

            table.insert(Library.Created.Sections, Section);

            local SF = Library.Create("Frame", {
                Parent = (Section.Side and Sides[Section.Side]) or LeftTab,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new((isFull and 2) or 1, (isFull and 10) or 0, 0, 0),
                BackgroundTransparency = 1,
            });

            if isFull then
                task.spawn(function()
                    local filler = Library.Create("Frame", {
                        Parent = RightTab,
                        Size = UDim2.new((isFull and 2) or 1, (isFull and 5) or 0, 0, 0),
                        BackgroundTransparency = 1,
                    });

                    while filler and task.wait() do
                        filler.Size = UDim2.new(filler.Size.X.Scale, filler.Size.X.Offset, 0, SF.AbsoluteSize.Y)
                    end;
                end);
            end;

            Library:ApplyTextSize(Library.Create("TextLabel", {
                Parent = SF,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 25),
                LayoutOrder = -1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = Section.Title,
            }, { FontFace = "Font", TextColor3 = "Text" }));

            Library.Create("UIListLayout", {
                Parent = SF,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
            });

            local SectionMain = Library.Create("Frame", {
                Parent = SF,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, { BackgroundColor3 = "Background2" });

            Section.UI = SectionMain;
            Library:ApplyStroke(SectionMain, "Accent1", 1, "Round");
            Library:ApplyCorner(SectionMain, 6);

            Library.Create("UIPadding", {
                Parent = SectionMain,
                PaddingLeft = UDim.new(0, 14),
                PaddingRight = UDim.new(0, 14),
                PaddingTop = UDim.new(0, 7),
                PaddingBottom = UDim.new(0, 7),
            });

            Library.Create("UIListLayout", {
                Parent = SectionMain,
                Padding = UDim.new(0, 12),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
            });

            function Section:Search(s)
                SF.Visible = false;
                for _, v in pairs(self.Contents) do
                    local Value, Object = unpack(v);

                    if (string.match(string.lower(Value), string.lower(s))) or (s == "") then
                        if Object then
                            Object.Visible = true;
                            SF.Visible = true;
                        end;
                    else
                        if Object then
                            Object.Visible = false;
                        end;
                    end;
                end
            end;

            Section.Contents = { { Section.Title, SF } };
            function Section:AddContent(Value, Index, Object)
                if (not Value) or (not Object) then return; end;
                if not Index then
                    table.insert(self.Contents, { Value, Object });
                    return #Section.Contents;
                else
                    self.Contents[Index] = { Value, Object };
                end;
            end;

            function Section:Visibility(Value)
                SF.Visible = Value or false;
            end;

            setmetatable(Section, { __index = SubFunctions })

            return Section;
        end;

        return Tab;
    end;

    return Window;
end;

return Library;
