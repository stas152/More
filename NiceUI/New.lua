Предупреждение: данный скрипт разработан для использования в современных
программных средах исполнения (инжекторах) с поддержкой функций файловой системы
(readfile, writefile, makefolder, isfile) и генерации локальных ресурсов
(getcustomasset). Если ваше программное обеспечение не поддерживает данные
функции или имеет ограничения на запись файлов, шрифты и конфигурации не смогут
загрузиться, а интерфейс может отображаться некорректно. Любые метаметоды или
хуки, затрагивающие вызовы внутренних UI-компонентов игры, должны использовать
проверку self.Name вместо прямых ссылок во избежание сбоев в работе потока
рендеринга.

local c = cloneref or function(o) return o end
local u = c(game:GetService("UserInputService"))
local p = c(game:GetService("Players"))
local w = c(game:GetService("Workspace"))
local r = c(game:GetService("ReplicatedStorage"))
local h = c(game:GetService("HttpService"))
local g = c(game:GetService("GuiService"))
local l = c(game:GetService("Lighting"))
local rn = c(game:GetService("RunService"))
local s = c(game:GetService("Stats"))
local cg = (gethui and gethui()) or c(game:GetService("CoreGui"))
local db = c(game:GetService("Debris"))
local tw = c(game:GetService("TweenService"))
local ss = c(game:GetService("SoundService"))

local v2 = Vector2.new
local v3 = Vector3.new
local d2 = UDim2.new
local dm = UDim.new 
local rc = Rect.new
local cf = CFrame.new
local ecf = cf()
local pos = ecf.PointToObjectSpace
local an = CFrame.Angles
local dof = UDim2.fromOffset

local col = Color3.new
local rgb = Color3.fromRGB
local hex = Color3.fromHex
local hsv = Color3.fromHSV
local rgbseq = ColorSequence.new
local rgbkey = ColorSequenceKeypoint.new
local numseq = NumberSequence.new
local numkey = NumberSequenceKeypoint.new

local cam = w.CurrentCamera
local lp = p.LocalPlayer 
local ms = lp:GetMouse() 
local goff = g:GetGuiInset().Y

local mx = math.max 
local fl = math.floor 
local mn = math.min 
local ab = math.abs 
local ns = math.noise
local rd = math.rad 
local rnd = math.random 
local pw = math.pow 
local sn = math.sin 
local pi = math.pi 
local tn = math.tan 
local at2 = math.atan2 
local cl = math.clamp 

local ins = table.insert 
local fd = table.find 
local rm = table.remove
local ct = table.concat

getgenv().library = {
    directory = "milenium",
    folders = {
        "/fonts",
        "/configs",
    },
    flags = {},
    config_flags = {},
    connections = {},   
    notifications = {notifs = {}},
    current_open = nil, 
}

local th = {
    preset = {
        accent = rgb(155, 150, 219),
    }, 
    utility = {
        accent = {
            BackgroundColor3 = {}, 	
            TextColor3 = {}, 
            ImageColor3 = {}, 
            ScrollBarImageColor3 = {} 
        },
    }
}

local ky = {
    [Enum.KeyCode.LeftShift] = "LS",
    [Enum.KeyCode.RightShift] = "RS",
    [Enum.KeyCode.LeftControl] = "LC",
    [Enum.KeyCode.RightControl] = "RC",
    [Enum.KeyCode.Insert] = "INS",
    [Enum.KeyCode.Backspace] = "BS",
    [Enum.KeyCode.Return] = "Ent",
    [Enum.KeyCode.LeftAlt] = "LA",
    [Enum.KeyCode.RightAlt] = "RA",
    [Enum.KeyCode.CapsLock] = "CAPS",
    [Enum.KeyCode.One] = "1",
    [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4",
    [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7",
    [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.KeypadOne] = "Num1",
    [Enum.KeyCode.KeypadTwo] = "Num2",
    [Enum.KeyCode.KeypadThree] = "Num3",
    [Enum.KeyCode.KeypadFour] = "Num4",
    [Enum.KeyCode.KeypadFive] = "Num5",
    [Enum.KeyCode.KeypadSix] = "Num6",
    [Enum.KeyCode.KeypadSeven] = "Num7",
    [Enum.KeyCode.KeypadEight] = "Num8",
    [Enum.KeyCode.KeypadNine] = "Num9",
    [Enum.KeyCode.KeypadZero] = "Num0",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.LeftBracket] = "[",
    [Enum.KeyCode.RightBracket] = "]",
    [Enum.KeyCode.RightParenthesis] = ")",
    [Enum.KeyCode.LeftParenthesis] = "(",
    [Enum.KeyCode.Semicolon] = ",",
    [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.BackSlash] = "\\",
    [Enum.KeyCode.Comma] = ",",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/",
    [Enum.KeyCode.Asterisk] = "*",
    [Enum.KeyCode.Plus] = "+",
    [Enum.KeyCode.Backquote] = "`",
    [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2",
    [Enum.UserInputType.MouseButton3] = "MB3",
    [Enum.KeyCode.Escape] = "ESC",
    [Enum.KeyCode.Space] = "SPC",
}
    
library.__index = library

if not isfolder(library.directory) then
    makefolder(library.directory)
end

for _, path in next, library.folders do 
    local f_p = library.directory .. path
    if not isfolder(f_p) then
        makefolder(f_p)
    end
end

local flg = library.flags 
local cfg_flg = library.config_flags
local ntfs = library.notifications 

local fnt = {}; do
    function Register_Font(n, w, s, a)
        local f_id = library.directory .. "/fonts/" .. a.Id
        if not isfile(f_id) then
            writefile(f_id, a.Font)
        end
        local f_path = library.directory .. "/fonts/" .. n .. ".font"
        if isfile(f_path) then
            delfile(f_path)
        end
        local d = {
            name = n,
            faces = {
                {
                    name = "Normal",
                    weight = w,
                    style = s,
                    assetId = getcustomasset(f_id),
                },
            },
        }
        writefile(f_path, h:JSONEncode(d))
        return getcustomasset(f_path);
    end
    
    local med = Register_Font("Medium", 200, "Normal", {
        Id = "Medium.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-Medium.ttf"),
    })

    local sbold = Register_Font("SemiBold", 200, "Normal", {
        Id = "SemiBold.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-SemiBold.ttf"),
    })

    fnt = {
        small = Font.new(med, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        font = Font.new(sbold, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    }
end

function library:tween(obj, prop, est, t) 
    local tween = tw:Create(obj, TweenInfo.new(t or 0.25, est or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), prop)
    tween:Play()
    return tween
end

function library:resizify(fr) 
    local Frame = Instance.new("TextButton")
    Frame.Position = d2(1, -10, 1, -10)
    Frame.BorderColor3 = rgb(0, 0, 0)
    Frame.Size = d2(0, 10, 0, 10)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = rgb(255, 255, 255)
    Frame.Parent = fr
    Frame.BackgroundTransparency = 1 
    Frame.Text = ""

    local resizing = false 
    local s_sz 
    local start 
    local og_sz = fr.Size  

    Frame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            start = inp.Position
            s_sz = fr.Size
        end
    end)

    Frame.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)

    library:connection(u.InputChanged, function(inp) 
        if resizing and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local v_x = cam.ViewportSize.X
            local v_y = cam.ViewportSize.Y
            local cur_sz = d2(
                s_sz.X.Scale,
                cl(s_sz.X.Offset + (inp.Position.X - start.X), og_sz.X.Offset, v_x),
                s_sz.Y.Scale,
                cl(s_sz.Y.Offset + (inp.Position.Y - start.Y), og_sz.Y.Offset, v_y)
            )
            library:tween(fr, {Size = cur_sz}, Enum.EasingStyle.Linear, 0.05)
        end
    end)
end 

function fag(tbl)
    local sz = 0
    for _ in tbl do
        sz = sz + 1
    end
    return sz
end

function library:next_flag()
    local idx = fag(library.flags) + 1;
    return string.format("flagnumber%s", idx);
end 

function library:mouse_in_frame(ui)
    local y_c = ui.AbsolutePosition.Y <= ms.Y and ms.Y <= ui.AbsolutePosition.Y + ui.AbsoluteSize.Y
    local x_c = ui.AbsolutePosition.X <= ms.X and ms.X <= ui.AbsolutePosition.X + ui.AbsoluteSize.X
    return (y_c and x_c)
end

function library:draggify(fr)
    local dragging = false 
    local s_pos = fr.Position
    local start 

    fr.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            start = inp.Position
            s_pos = fr.Position
        end
    end)

    fr.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    library:connection(u.InputChanged, function(inp) 
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local v_x = cam.ViewportSize.X
            local v_y = cam.ViewportSize.Y
            local cur_pos = d2(
                0,
                cl(s_pos.X.Offset + (inp.Position.X - start.X), 0, v_x - fr.Size.X.Offset),
                0,
                cl(s_pos.Y.Offset + (inp.Position.Y - start.Y), 0, v_y - fr.Size.Y.Offset)
            )
            library:tween(fr, {Position = cur_pos}, Enum.EasingStyle.Linear, 0.05)
            library:close_element()
        end
    end)
end 

function library:convert(str)
    local val = {}
    for v in string.gmatch(str, "[^,]+") do
        ins(val, tonumber(v))
    end
    if #val == 4 then              
        return unpack(val)
    end
end

function library:convert_enum(enum)
    local parts = {}
    for p in string.gmatch(enum, "[%w_]+") do
        ins(parts, p)
    end
    local en_tbl = Enum
    for i = 2, #parts do
        en_tbl = en_tbl[parts[i]]
    end
    return en_tbl
end

local cfg_hld;
function library:update_config_list() 
    if not cfg_hld then 
        return 
    end
    local lst = {}
    local path = library.directory .. "/configs"
    if isfolder(path) then
        for _, file in listfiles(path) do
            local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
            lst[#lst + 1] = name
        end
    end
    cfg_hld.refresh_options(lst)
end 

function library:get_config()
    local Config = {}
    for k, v in next, flg do
        if type(v) == "table" and v.key then
            Config[k] = {active = v.active, mode = v.mode, key = tostring(v.key)}
        elseif type(v) == "table" and v["Transparency"] and v["Color"] then
            Config[k] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
        else
            Config[k] = v
        end
    end 
    return h:JSONEncode(Config)
end

function library:load_config(cfg_json) 
    local config = h:JSONDecode(cfg_json)
    for k, v in config do 
        local func = library.config_flags[k]
        if k == "config_name_list" then 
            continue 
        end
        if func then 
            if type(v) == "table" and v["Transparency"] and v["Color"] then
                func(hex(v["Color"]), v["Transparency"])
            elseif type(v) == "table" and v["active"] then 
                func(v)
            else
                func(v)
            end
        end 
    end 
end 

function library:round(num, float) 
    local mult = 1 / (float or 1)
    return fl(num * mult + 0.5) / mult
end 

function library:apply_theme(inst, theme, prop) 
    ins(th.utility[theme][prop], inst)
end

function library:update_theme(theme, color)
    for _, prop in th.utility[theme] do 
        for _, obj in prop do 
            if obj[_] == th.preset[theme] then 
                obj[_] = color 
            end 
        end 
    end 
    th.preset[theme] = color 
end 

function library:connection(sig, cb)
    local conn = sig:Connect(cb)
    ins(library.connections, conn)
    return conn 
end

function library:close_element(new) 
    local open = library.current_open
    if open and new ~= open then
        open.set_visible(false)
        open.open = false;
    end 
    if new ~= open then 
        library.current_open = new or nil;
    end
end 

function library:create(inst, opt)
    local obj = Instance.new(inst) 
    for p, v in opt do 
        obj[p] = v
    end
    return obj 
end

function library:unload_menu() 
    if library["items"] then 
        library["items"]:Destroy()
    end
    if library["other"] then 
        library["other"]:Destroy()
    end 
    for _, conn in library.connections do 
        if conn then
            conn:Disconnect() 
        end
    end
    library.connections = {}
    library = nil 
end 

function library:window(prop)
    local cfg = { 
        suffix = prop.suffix or "tech",
        name = prop.name or "nebula",
        game_name = prop.gameInfo or "Milenium for Roblox",
        size = prop.size or d2(0, 700, 0, 565),
        selected_tab = nil,
        items = {},
        tween = nil,
    }
    
    library["items"] = library:create("ScreenGui", {
        Parent = cg,
        Name = "\0",
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        IgnoreGuiInset = true,
    });
    
    library["other"] = library:create("ScreenGui", {
        Parent = cg,
        Name = "\0",
        Enabled = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
    }); 

    local items = cfg.items; do
        items["main"] = library:create("Frame", {
            Parent = library["items"],
            Size = cfg.size,
            Name = "\0",
            Position = d2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(14, 14, 16)
        }); items["main"].Position = d2(0, items["main"].AbsolutePosition.X, 0, items["main"].AbsolutePosition.Y)
        
        library:create("UICorner", {
            Parent = items["main"],
            CornerRadius = dm(0, 10)
        });
        
        library:create("UIStroke", {
            Color = rgb(23, 23, 29),
            Parent = items["main"],
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        });
        
        items["side_frame"] = library:create("Frame", {
            Parent = items["main"],
            BackgroundTransparency = 1,
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 196, 1, -25),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(14, 14, 16)
        });
        
        library:create("Frame", {
            AnchorPoint = v2(1, 0),
            Parent = items["side_frame"],
            Position = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(21, 21, 23)
        });
        
        items["button_holder"] = library:create("Frame", {
            Parent = items["side_frame"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 0, 0, 60),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 1, -60),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }); cfg.button_holder = items["button_holder"];
        
        library:create("UIListLayout", {
            Parent = items["button_holder"],
            Padding = dm(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UIPadding", {
            PaddingTop = dm(0, 16),
            PaddingBottom = dm(0, 36),
            Parent = items["button_holder"],
            PaddingRight = dm(0, 11),
            PaddingLeft = dm(0, 10)
        });

        items["title"] = library:create("TextLabel", {
            FontFace = fnt.font,
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["side_frame"],
            Name = "\0",
            Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix),
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 70),
            TextColor3 = th.preset.accent,
            BorderSizePixel = 0,
            RichText = true,
            TextSize = 30,
            BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items["title"], "accent", "TextColor3");
        
        items["multi_holder"] = library:create("Frame", {
            Parent = items["main"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 196, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -196, 0, 56),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }); cfg.multi_holder = items["multi_holder"];
        
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = items["multi_holder"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(21, 21, 23)
        });
        
        items["shadow"] = library:create("ImageLabel", {
            ImageColor3 = rgb(0, 0, 0),
            ScaleType = Enum.ScaleType.Slice,
            Parent = items["main"],
            BorderColor3 = rgb(0, 0, 0),
            Name = "\0",
            BackgroundColor3 = rgb(255, 255, 255),
            Size = d2(1, 75, 1, 75),
            AnchorPoint = v2(0.5, 0.5),
            Image = "rbxassetid://112971167999062",
            BackgroundTransparency = 1,
            Position = d2(0.5, 0, 0.5, 0),
            SliceScale = 0.75,
            ZIndex = -100,
            BorderSizePixel = 0,
            SliceCenter = rc(v2(112, 112), v2(147, 147))
        });
        
        items["global_fade"] = library:create("Frame", {
            Parent = items["main"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 196, 0, 56),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -196, 1, -81),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(14, 14, 16),
            ZIndex = 2,
        });                

        library:create("UICorner", {
            Parent = items["shadow"],
            CornerRadius = dm(0, 5)
        });
        
        items["info"] = library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = items["main"],
            Name = "\0",
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 25),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(23, 23, 25)
        });
        
        library:create("UICorner", {
            Parent = items["info"],
            CornerRadius = dm(0, 10)
        });
        
        items["grey_fill"] = library:create("Frame", {
            Name = "\0",
            Parent = items["info"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 6),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(23, 23, 25)
        });
        
        items["game"] = library:create("TextLabel", {
            FontFace = fnt.font,
            Parent = items["info"],
            TextColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.game_name,
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            AnchorPoint = v2(0, 0.5),
            Position = d2(0, 10, 0.5, -1),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        }); 
        
        items["other_info"] = library:create("TextLabel", {
            Parent = items["info"],
            RichText = true,
            Name = "\0",
            TextColor3 = th.preset.accent,
            BorderColor3 = rgb(0, 0, 0),
            Text = '<font color="rgb(72, 72, 73)">Active, </font>' .. cfg.name .. cfg.suffix,
            Size = d2(1, 0, 0, 0),
            Position = d2(0, -10, 0.5, -1),
            AnchorPoint = v2(0, 0.5),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Right,
            AutomaticSize = Enum.AutomaticSize.XY,
            FontFace = fnt.font,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items["other_info"], "accent", "TextColor3");        
    end 

    do 
        library:draggify(items["main"])
        library:resizify(items["main"])
    end 

    function cfg.toggle_menu(bool) 
        library["items"].Enabled = bool
    end 
        
    return setmetatable(cfg, library)
end 

function library:tab(prop)
    local cfg = {
        name = prop.name or "visuals", 
        icon = prop.icon or "http://www.roblox.com/asset/?id=6034767608",
        tabs = prop.tabs or {"Main", "Misc.", "Settings"},
        pages = {}, 
        current_multi = nil, 
        items = {},
    } 

    local items = cfg.items; do 
        items["tab_holder"] = library:create("Frame", {
            Parent = library.cache,
            Name = "\0",
            Visible = false,
            BackgroundTransparency = 1,
            Position = d2(0, 196, 0, 56),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -216, 1, -101),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["button"] = library:create("TextButton", {
            FontFace = fnt.font,
            TextColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["button_holder"],
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Name = "\0",
            Size = d2(1, 0, 0, 35),
            BorderSizePixel = 0,
            TextSize = 16,
            BackgroundColor3 = rgb(29, 29, 29)
        });
        
        items["icon"] = library:create("ImageLabel", {
            ImageColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["button"],
            AnchorPoint = v2(0, 0.5),
            Image = "http://www.roblox.com/asset/?id=6034767608",
            BackgroundTransparency = 1,
            Position = d2(0, 10, 0.5, 0),
            Name = "\0",
            Size = d2(0, 22, 0, 22),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items["icon"], "accent", "ImageColor3");
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["button"],
            Name = "\0",
            Size = d2(0, 0, 1, 0),
            Position = d2(0, 40, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        library:create("UICorner", {
            Parent = items["button"],
            CornerRadius = dm(0, 7)
        });
        
        library:create("UIStroke", {
            Color = rgb(23, 23, 29),
            Parent = items["button"],
            Enabled = false,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        });

        items["multi_section_button_holder"] = library:create("Frame", {
            Parent = library.cache,
            BackgroundTransparency = 1,
            Name = "\0",
            Visible = false,
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["multi_section_button_holder"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal
        });
        
        library:create("UIPadding", {
            PaddingTop = dm(0, 8),
            PaddingBottom = dm(0, 7),
            Parent = items["multi_section_button_holder"],
            PaddingRight = dm(0, 7),
            PaddingLeft = dm(0, 7)
        });                        

        for _, section in cfg.tabs do
            local data = {items = {}} 
            local multi_items = data.items; do 
                multi_items["button"] = library:create("TextButton", {
                    FontFace = fnt.font,
                    TextColor3 = rgb(255, 255, 255),
                    BorderColor3 = rgb(0, 0, 0),
                    AutoButtonColor = false,
                    Text = "",
                    Parent = items["multi_section_button_holder"],
                    Name = "\0",
                    Size = d2(0, 0, 0, 39),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 16,
                    BackgroundColor3 = rgb(25, 25, 29)
                });
                
                multi_items["name"] = library:create("TextLabel", {
                    FontFace = fnt.font,
                    TextColor3 = rgb(62, 62, 63),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = section,
                    Parent = multi_items["button"],
                    Name = "\0",
                    Size = d2(0, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 16,
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIPadding", {
                    Parent = multi_items["name"],
                    PaddingRight = dm(0, 5),
                    PaddingLeft = dm(0, 5)
                });
                
                multi_items["accent"] = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0),
                    AnchorPoint = v2(0, 1),
                    Parent = multi_items["button"],
                    BackgroundTransparency = 1,
                    Position = d2(0, 10, 1, 4),
                    Name = "\0",
                    Size = d2(1, -20, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = th.preset.accent
                }); library:apply_theme(multi_items["accent"], "accent", "BackgroundColor3");
                
                library:create("UICorner", {
                    Parent = multi_items["accent"],
                    CornerRadius = dm(0, 999)
                });
                
                library:create("UIPadding", {
                    Parent = multi_items["button"],
                    PaddingRight = dm(0, 10),
                    PaddingLeft = dm(0, 10)
                });
                
                library:create("UICorner", {
                    Parent = multi_items["button"],
                    CornerRadius = dm(0, 7)
                }); 

                multi_items["tab"] = library:create("Frame", {
                    Parent = library.cache,
                    BackgroundTransparency = 1,
                    Name = "\0",
                    BorderColor3 = rgb(0, 0, 0),
                    Size = d2(1, -20, 1, -20),
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Parent = multi_items["tab"],
                    Padding = dm(0, 7),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                library:create("UIPadding", {
                    PaddingTop = dm(0, 7),
                    PaddingBottom = dm(0, 7),
                    Parent = multi_items["tab"],
                    PaddingRight = dm(0, 7),
                    PaddingLeft = dm(0, 7)
                });
            end

            data.text = multi_items["name"]
            data.accent = multi_items["accent"]
            data.button = multi_items["button"]
            data.page = multi_items["tab"]
            data.parent = setmetatable(data, library):sub_tab({}).items["tab_parent"]
            
            function data.open_page()
                local page = cfg.current_multi; 
                if page and page.text ~= data.text then 
                    self.items["global_fade"].BackgroundTransparency = 0
                    library:tween(self.items["global_fade"], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                    local o_sz = page.page.Size
                    page.page.Size = d2(1, -20, 1, -20)
                end

                if page then
                    library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                    library:tween(page.accent, {BackgroundTransparency = 1})
                    library:tween(page.button, {BackgroundTransparency = 1})
                    page.page.Visible = false
                    page.page.Parent = library["cache"] 
                end 
                
                library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                library:tween(data.accent, {BackgroundTransparency = 0})
                library:tween(data.button, {BackgroundTransparency = 0})
                library:tween(data.page, {Size = d2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                data.page.Visible = true
                data.page.Parent = items["tab_holder"]
                cfg.current_multi = data
                library:close_element()
            end

            multi_items["button"].MouseButton1Down:Connect(function()
                data.open_page() 
            end)

            cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
        end 

        cfg.pages[1].open_page()
    end 

    function cfg.open_tab() 
        local sel = self.selected_tab
        if sel then 
            if sel[4] ~= items["tab_holder"] then 
                self.items["global_fade"].BackgroundTransparency = 0
                library:tween(self.items["global_fade"], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                sel[4].Size = d2(1, -216, 1, -101)
            end

            library:tween(sel[1], {BackgroundTransparency = 1})
            library:tween(sel[2], {ImageColor3 = rgb(72, 72, 73)})
            library:tween(sel[3], {TextColor3 = rgb(72, 72, 73)})

            sel[4].Visible = false
            sel[4].Parent = library["cache"]
            sel[5].Visible = false
            sel[5].Parent = library["cache"]
        end

        library:tween(items["button"], {BackgroundTransparency = 0})
        library:tween(items["icon"], {ImageColor3 = th.preset.accent})
        library:tween(items["name"], {TextColor3 = rgb(255, 255, 255)})
        library:tween(items["tab_holder"], {Size = d2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
        
        items["tab_holder"].Visible = true 
        items["tab_holder"].Parent = self.items["main"]
        items["multi_section_button_holder"].Visible = true 
        items["multi_section_button_holder"].Parent = self.items["multi_holder"]

        self.selected_tab = {
            items["button"],
            items["icon"],
            items["name"],
            items["tab_holder"],
            items["multi_section_button_holder"],
        }

        library:close_element()
    end

    items["button"].MouseButton1Down:Connect(function()
        cfg.open_tab()
    end)
    
    if not self.selected_tab then 
        cfg.open_tab(true) 
    end

    return unpack(cfg.pages)
end

function library:seperator(prop)
    local cfg = {items = {}, name = prop.Name or "General"}
    local items = cfg.items do 
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = self.items["button_holder"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            Position = d2(0, 40, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0, 
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });                
    end;    
    return setmetatable(cfg, library)
end 

function library:column(prop) 
    local cfg = {items = {}, size = prop.size or 1}
    local items = cfg.items; do     
        items["column"] = library:create("Frame", {
            Parent = self["parent"] or self.items["tab_parent"],
            BackgroundTransparency = 1,
            Name = "\0",
            Size = d2(0, 0, cfg.size, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 10),
            Parent = items["column"]
        });
        
        library:create("UIListLayout", {
            Parent = items["column"],
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = dm(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        });
    end 
    return setmetatable(cfg, library)
end 

function library:sub_tab(prop) 
    local cfg = {items = {}, order = prop.order or 0, size = prop.size or 1}
    local items = cfg.items; do 
        items["tab_parent"] = library:create("Frame", {
            Parent = self.items["tab"],
            BackgroundTransparency = 1,
            Name = "\0",
            Size = d2(0,0,cfg.size,0),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            Visible = true,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            VerticalFlex = Enum.UIFlexAlignment.Fill,
            Parent = items["tab_parent"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder,
        });
    end
    return setmetatable(cfg, library)
end 

function library:section(prop)
    local cfg = {
        name = prop.name or "section", 
        side = prop.side or "left",
        default = prop.default or false,
        size = prop.size or self.size or 0.5, 
        icon = prop.icon or "http://www.roblox.com/asset/?id=6022668898",
        fading_toggle = prop.fading or false,
        items = {},
    };
    
    local items = cfg.items; do 
        items["outline"] = library:create("Frame", {
            Name = "\0",
            Parent = self.items["column"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, cfg.size, -3),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(25, 25, 29)
        });

        library:create("UICorner", {
            Parent = items["outline"],
            CornerRadius = dm(0, 7)
        });
        
        items["inline"] = library:create("Frame", {
            Parent = items["outline"],
            Name = "\0",
            Position = d2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create("UICorner", {
            Parent = items["inline"],
            CornerRadius = dm(0, 7)
        });
        
        items["scrolling"] = library:create("ScrollingFrame", {
            ScrollBarImageColor3 = rgb(44, 44, 46),
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 2,
            Parent = items["inline"],
            Name = "\0",
            Size = d2(1, 0, 1, -40),
            BackgroundTransparency = 1,
            Position = d2(0, 0, 0, 35),
            BackgroundColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            CanvasSize = d2(0, 0, 0, 0)
        });
        
        items["elements"] = library:create("Frame", {
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["scrolling"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 10, 0, 10),
            Size = d2(1, -20, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["elements"],
            Padding = dm(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 15),
            Parent = items["elements"]
        });
        
        items["button"] = library:create("TextButton", {
            FontFace = fnt.font,
            TextColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            Parent = items["outline"],
            Name = "\0",
            Position = d2(0, 1, 0, 1),
            Size = d2(1, -2, 0, 35),
            BorderSizePixel = 0,
            TextSize = 16,
            BackgroundColor3 = rgb(19, 19, 21)
        });
        
        library:create("UIStroke", {
            Color = rgb(23, 23, 29),
            Parent = items["button"],
            Enabled = false,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        });
        
        library:create("UICorner", {
            Parent = items["button"],
            CornerRadius = dm(0, 7)
        });
        
        items["Icon"] = library:create("ImageLabel", {
            ImageColor3 = th.preset.accent,
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["button"],
            AnchorPoint = v2(0, 0.5),
            Image = cfg.icon,
            BackgroundTransparency = 1,
            Position = d2(0, 10, 0.5, 0),
            Name = "\0",
            Size = d2(0, 22, 0, 22),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items["Icon"], "accent", "ImageColor3");
        
        items["section_title"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["button"],
            Name = "\0",
            Size = d2(0, 0, 1, 0),
            Position = d2(0, 40, 0, -1),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = items["button"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(36, 36, 37)
        });
        
        if cfg.fading_toggle then 
            items["toggle"] = library:create("TextButton", {
                FontFace = fnt.small,
                TextColor3 = rgb(0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                AutoButtonColor = false,
                Text = "",
                AnchorPoint = v2(1, 0.5),
                Parent = items["button"],
                Name = "\0",
                Position = d2(1, -9, 0.5, 0),
                Size = d2(0, 36, 0, 18),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = rgb(58, 58, 62)
            });  library:apply_theme(items["toggle"], "accent", "BackgroundColor3");
            
            library:create("UICorner", {
                Parent = items["toggle"],
                CornerRadius = dm(0, 999)
            });
            
            items["toggle_outline"] = library:create("Frame", {
                Parent = items["toggle"],
                Size = d2(1, -2, 1, -2),
                Name = "\0",
                BorderMode = Enum.BorderMode.Inset,
                BorderColor3 = rgb(0, 0, 0),
                Position = d2(0, 1, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(50, 50, 50)
            });  library:apply_theme(items["toggle_outline"], "accent", "BackgroundColor3");
            
            library:create("UICorner", {
                Parent = items["toggle_outline"],
                CornerRadius = dm(0, 999)
            });
            
            library:create("UIGradient", {
                Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))},
                Parent = items["toggle_outline"]
            });
            
            items["toggle_circle"] = library:create("Frame", {
                Parent = items["toggle_outline"],
                Name = "\0",
                Position = d2(0, 2, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = d2(0, 12, 0, 12),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(86, 86, 88)
            });
            
            library:create("UICorner", {
                Parent = items["toggle_circle"],
                CornerRadius = dm(0, 999)
            });
            
            library:create("UICorner", {
                Parent = items["outline"],
                CornerRadius = dm(0, 7)
            });
        
            items["fade"] = library:create("Frame", {
                Parent = items["outline"],
                BackgroundTransparency = 0.8,
                Name = "\0",
                BorderColor3 = rgb(0, 0, 0),
                Size = d2(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(0, 0, 0)
            });
            
            library:create("UICorner", {
                Parent = items["fade"],
                CornerRadius = dm(0, 7)
            });
        end 
    end;

    if cfg.fading_toggle then
        items["button"].MouseButton1Click:Connect(function()
            cfg.default = not cfg.default 
            cfg.toggle_section(cfg.default) 
        end)

        function cfg.toggle_section(bool)
            library:tween(items["toggle"], {BackgroundColor3 = bool and th.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
            library:tween(items["toggle_outline"], {BackgroundColor3 = bool and th.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
            library:tween(items["toggle_circle"], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and d2(1, -14, 0, 2) or d2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
            library:tween(items["fade"], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
        end 
    end 

    return setmetatable(cfg, library)
end  

function library:toggle(opt) 
    local rand = rnd(1, 2) 
    local cfg = {
        enabled = opt.enabled or nil,
        name = opt.name or "Toggle",
        info = opt.info or nil,
        flag = opt.flag or library:next_flag(),
        type = opt.type and string.lower(opt.type) or rand == 1 and "toggle" or "checkbox", 
        default = opt.default or false,
        folding = opt.folding or false, 
        callback = opt.callback or function() end,
        items = {},
        seperator = opt.seperator or false,
    }

    flg[cfg.flag] = cfg.default

    local items = cfg.items; do
        items["toggle"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["toggle"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });

        if cfg.info then 
            items["info"] = library:create("TextLabel", {
                FontFace = fnt.small,
                TextColor3 = rgb(130, 130, 130),
                BorderColor3 = rgb(0, 0, 0),
                TextWrapped = true,
                Text = cfg.info,
                Parent = items["toggle"],
                Name = "\0",
                Position = d2(0, 5, 0, 17),
                Size = d2(1, -10, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 16,
                BackgroundColor3 = rgb(255, 255, 255)
            });
        end 
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["toggle"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Parent = items["right_components"],
            Padding = dm(0, 9),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        if cfg.type == "checkbox" then 
            items["toggle_button"] = library:create("TextButton", {
                FontFace = fnt.small,
                TextColor3 = rgb(0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                LayoutOrder = 2,
                AutoButtonColor = false,
                AnchorPoint = v2(1, 0),
                Parent = items["right_components"],
                Name = "\0",
                Position = d2(1, 0, 0, 0),
                Size = d2(0, 16, 0, 16),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = rgb(67, 67, 68)
            }); library:apply_theme(items["toggle_button"], "accent", "BackgroundColor3");
            
            library:create("UICorner", {
                Parent = items["toggle_button"],
                CornerRadius = dm(0, 4)
            });
            
            items["outline"] = library:create("Frame", {
                Parent = items["toggle_button"],
                Size = d2(1, -2, 1, -2),
                Name = "\0",
                BorderMode = Enum.BorderMode.Inset,
                BorderColor3 = rgb(0, 0, 0),
                Position = d2(0, 1, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(22, 22, 24)
            }); library:apply_theme(items["outline"], "accent", "BackgroundColor3");
            
            items["tick"] = library:create("ImageLabel", {
                ImageTransparency = 1,
                BorderColor3 = rgb(0, 0, 0),
                Image = "rbxassetid://111862698467575",
                BackgroundTransparency = 1,
                Position = d2(0, -1, 0, 0),
                Parent = items["outline"],
                Size = d2(1, 2, 1, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255),
                ZIndex = 1,
            });

            library:create("UICorner", {
                Parent = items["outline"],
                CornerRadius = dm(0, 4)
            });
            
            library:create("UIGradient", {
                Enabled = false,
                Parent = items["outline"],
                Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}
            });  
        else 
            items["toggle_button"] = library:create("TextButton", {
                FontFace = fnt.font,
                TextColor3 = rgb(0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                LayoutOrder = 2,
                AnchorPoint = v2(1, 0.5),
                Parent = items["right_components"],
                Name = "\0",
                Position = d2(1, -9, 0.5, 0),
                Size = d2(0, 36, 0, 18),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = th.preset.accent
            }); library:apply_theme(items["toggle_button"], "accent", "BackgroundColor3");
            
            library:create("UICorner", {
                Parent = items["toggle_button"],
                CornerRadius = dm(0, 999)
            });
            
            items["inline"] = library:create("Frame", {
                Parent = items["toggle_button"],
                Size = d2(1, -2, 1, -2),
                Name = "\0",
                BorderMode = Enum.BorderMode.Inset,
                BorderColor3 = rgb(0, 0, 0),
                Position = d2(0, 1, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = th.preset.accent
            }); library:apply_theme(items["inline"], "accent", "BackgroundColor3");
            
            library:create("UICorner", {
                Parent = items["inline"],
                CornerRadius = dm(0, 999)
            });
            
            library:create("UIGradient", {
                Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))},
                Parent = items["inline"]
            });
            
            items["circle"] = library:create("Frame", {
                Parent = items["inline"],
                Name = "\0",
                Position = d2(1, -14, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = d2(0, 12, 0, 12),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            });
            
            library:create("UICorner", {
                Parent = items["circle"],
                CornerRadius = dm(0, 999)
            });                        
        end 
    end;
    
    function cfg.set(bool)
        if cfg.type == "checkbox" then 
            library:tween(items["tick"], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
            library:tween(items["toggle_button"], {BackgroundColor3 = bool and th.preset.accent or rgb(67, 67, 68)})
            library:tween(items["outline"], {BackgroundColor3 = bool and th.preset.accent or rgb(22, 22, 24)})
        else
            library:tween(items["toggle_button"], {BackgroundColor3 = bool and th.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
            library:tween(items["inline"], {BackgroundColor3 = bool and th.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
            library:tween(items["circle"], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and d2(1, -14, 0, 2) or d2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
        end

        cfg.callback(bool)

        if cfg.folding then 
            elements.Visible = bool
        end

        flg[cfg.flag] = bool
    end 
    
    items["toggle"].MouseButton1Click:Connect(function()
        cfg.enabled = not cfg.enabled 
        cfg.set(cfg.enabled)
    end)

    items["toggle_button"].MouseButton1Click:Connect(function()
        cfg.enabled = not cfg.enabled 
        cfg.set(cfg.enabled)
    end)
    
    if cfg.seperator then 
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = self.items["elements"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 1, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(36, 36, 37)
        });
    end

    cfg.set(cfg.default)
    cfg_flg[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:slider(opt) 
    local cfg = {
        name = opt.name or nil,
        suffix = opt.suffix or "",
        flag = opt.flag or library:next_flag(),
        callback = opt.callback or function() end, 
        info = opt.info or nil, 
        min = opt.min or opt.minimum or 0,
        max = opt.max or opt.maximum or 100,
        intervals = opt.interval or opt.decimal or 1,
        default = opt.default or 10,
        value = opt.default or 10, 
        seperator = opt.seperator or true,
        dragging = false,
        items = {}
    } 

    flg[cfg.flag] = cfg.default

    local items = cfg.items; do
        items["slider_object"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["slider_object"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        if cfg.info then 
            items["info"] = library:create("TextLabel", {
                FontFace = fnt.small,
                TextColor3 = rgb(130, 130, 130),
                BorderColor3 = rgb(0, 0, 0),
                TextWrapped = true,
                Text = cfg.info,
                Parent = items["slider_object"],
                Name = "\0",
                Position = d2(0, 5, 0, 37),
                Size = d2(1, -10, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 16,
                BackgroundColor3 = rgb(255, 255, 255)
            });
        end 

        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["slider_object"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 4, 0, 23),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 12),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["right_components"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal
        });
        
        items["slider"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = v2(1, 0),
            Parent = items["right_components"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            Size = d2(1, -4, 0, 4),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create("UICorner", {
            Parent = items["slider"],
            CornerRadius = dm(0, 999)
        });
        
        items["fill"] = library:create("Frame", {
            Name = "\0",
            Parent = items["slider"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0.5, 0, 0, 4),
            BorderSizePixel = 0,
            BackgroundColor3 = th.preset.accent
        });  library:apply_theme(items["fill"], "accent", "BackgroundColor3");
        
        library:create("UICorner", {
            Parent = items["fill"],
            CornerRadius = dm(0, 999)
        });
        
        items["circle"] = library:create("Frame", {
            AnchorPoint = v2(0.5, 0.5),
            Parent = items["fill"],
            Name = "\0",
            Position = d2(1, 0, 0.5, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 12, 0, 12),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(244, 244, 244)
        });
        
        library:create("UICorner", {
            Parent = items["circle"],
            CornerRadius = dm(0, 999)
        });
        
        library:create("UIPadding", {
            Parent = items["right_components"],
            PaddingTop = dm(0, 4)
        });
        
        items["value"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Text = "50%",
            Parent = items["slider_object"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            Position = d2(0, 6, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Right,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["value"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });                
    end 

    function cfg.set(value)
        cfg.value = cl(library:round(value, cfg.intervals), cfg.min, cfg.max)
        library:tween(items["fill"], {Size = d2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
        items["value"].Text = tostring(cfg.value) .. cfg.suffix
        flg[cfg.flag] = cfg.value
        cfg.callback(flg[cfg.flag])
    end

    items["slider"].MouseButton1Down:Connect(function()
        cfg.dragging = true 
        library:tween(items["value"], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
    end)

    library:connection(u.InputChanged, function(inp)
        if cfg.dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then 
            local size_x = (inp.Position.X - items["slider"].AbsolutePosition.X) / items["slider"].AbsoluteSize.X
            local value = ((cfg.max - cfg.min) * size_x) + cfg.min
            cfg.set(value)
        end
    end)

    library:connection(u.InputEnded, function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            cfg.dragging = false
            library:tween(items["value"], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2) 
        end 
    end)

    if cfg.seperator then 
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = self.items["elements"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 1, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    cfg.set(cfg.default)
    cfg_flg[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:dropdown(opt) 
    local cfg = {
        name = opt.name or nil,
        info = opt.info or nil,
        flag = opt.flag or library:next_flag(),
        options = opt.items or {""},
        callback = opt.callback or function() end,
        multi = opt.multi or false,
        scrolling = opt.scrolling or false,
        width = opt.width or 130,
        open = false,
        option_instances = {},
        multi_items = {},
        ignore = opt.ignore or false,
        items = {},
        y_size = nil,
        seperator = opt.seperator or true,
    }   

    cfg.default = opt.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"
    flg[cfg.flag] = cfg.default

    local items = cfg.items; do 
        items["dropdown_object"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = "Dropdown",
            Parent = items["dropdown_object"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        if cfg.info then 
            items["info"] = library:create("TextLabel", {
                FontFace = fnt.small,
                TextColor3 = rgb(130, 130, 130),
                BorderColor3 = rgb(0, 0, 0),
                TextWrapped = true,
                Text = cfg.info,
                Parent = items["dropdown_object"],
                Name = "\0",
                Position = d2(0, 5, 0, 17),
                Size = d2(1, -10, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 16,
                BackgroundColor3 = rgb(255, 255, 255)
            });
        end 

        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["dropdown_object"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Parent = items["right_components"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        items["dropdown"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = v2(1, 0),
            Parent = items["right_components"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            Size = d2(0, cfg.width, 0, 16),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create("UICorner", {
            Parent = items["dropdown"],
            CornerRadius = dm(0, 4)
        });
        
        items["sub_text"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(86, 86, 87),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = items["dropdown"],
            Name = "\0",
            Size = d2(1, -12, 0, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["sub_text"],
            PaddingTop = dm(0, 1),
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["indicator"] = library:create("ImageLabel", {
            ImageColor3 = rgb(86, 86, 87),
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["dropdown"],
            AnchorPoint = v2(1, 0.5),
            Image = "rbxassetid://101025591575185",
            BackgroundTransparency = 1,
            Position = d2(1, -5, 0.5, 0),
            Name = "\0",
            Size = d2(0, 12, 0, 12),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });

        items["dropdown_holder"] = library:create("Frame", {
            BorderColor3 = rgb(0, 0, 0),
            Parent = library["items"],
            Name = "\0",
            Visible = true,
            BackgroundTransparency = 1,
            Size = d2(0, 0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(0, 0, 0),
            ZIndex = 10,
        });
        
        items["outline"] = library:create("Frame", {
            Parent = items["dropdown_holder"],
            Size = d2(1, 0, 1, 0),
            ClipsDescendants = true,
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(33, 33, 35),
            ZIndex = 10,
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 6),
            PaddingTop = dm(0, 3),
            PaddingLeft = dm(0, 3),
            Parent = items["outline"]
        });
        
        library:create("UIListLayout", {
            Parent = items["outline"],
            Padding = dm(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UICorner", {
            Parent = items["outline"],
            CornerRadius = dm(0, 4)
        });
    end;

    function cfg.render_option(text)
        local button = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(72, 72, 73),
            BorderColor3 = rgb(0, 0, 0),
            Text = text,
            Parent = items["outline"],
            Name = "\0",
            Size = d2(1, -12, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255),
            ZIndex = 10,
        }); library:apply_theme(button, "accent", "TextColor3");
        
        library:create("UIPadding", {
            Parent = button,
            PaddingTop = dm(0, 1),
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        return button
    end
    
    function cfg.set_visible(bool)
        local a = bool and cfg.y_size or 0
        library:tween(items["dropdown_holder"], {Size = dof(items["dropdown"].AbsoluteSize.X, a)})
        items["dropdown_holder"].Position = d2(0, items["dropdown"].AbsolutePosition.X, 0, items["dropdown"].AbsolutePosition.Y + 80)
        if not (self.sanity and library.current_open == self) then 
            library:close_element(cfg)
        end
    end
    
    function cfg.set(value)
        local selected = {}
        local isTable = type(value) == "table"

        for _, option in cfg.option_instances do 
            if option.Text == value or (isTable and fd(value, option.Text)) then 
                ins(selected, option.Text)
                cfg.multi_items = selected
                option.TextColor3 = th.preset.accent
            else
                option.TextColor3 = rgb(72, 72, 73)
            end
        end

        items["sub_text"].Text = isTable and ct(selected, ", ") or selected[1] or ""
        flg[cfg.flag] = isTable and selected or selected[1]
        cfg.callback(flg[cfg.flag]) 
    end
    
    function cfg.refresh_options(list) 
        cfg.y_size = 0
        for _, option in cfg.option_instances do 
            option:Destroy() 
        end
        cfg.option_instances = {} 

        for _, option in list do 
            local button = cfg.render_option(option)
            cfg.y_size = cfg.y_size + button.AbsoluteSize.Y + 6 
            ins(cfg.option_instances, button)
            
            button.MouseButton1Down:Connect(function()
                if cfg.multi then 
                    local sel_idx = fd(cfg.multi_items, button.Text)
                    if sel_idx then 
                        rm(cfg.multi_items, sel_idx)
                    else
                        ins(cfg.multi_items, button.Text)
                    end
                    cfg.set(cfg.multi_items) 				
                else 
                    cfg.set_visible(false)
                    cfg.open = false 
                    cfg.set(button.Text)
                end
            end)
        end
    end

    items["dropdown"].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)
    end)

    if cfg.seperator then 
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = self.items["elements"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 1, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    flg[cfg.flag] = {} 
    cfg_flg[cfg.flag] = cfg.set
    
    cfg.refresh_options(cfg.options)
    cfg.set(cfg.default)
        
    return setmetatable(cfg, library)
end

function library:label(opt)
    local cfg = {
        enabled = opt.enabled or nil,
        name = opt.name or "Toggle",
        seperator = opt.seperator or false,
        info = opt.info or nil, 
        items = {},
    }

    local items = cfg.items; do 
        items["label"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["label"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });

        if cfg.info then 
            items["info"] = library:create("TextLabel", {
                FontFace = fnt.small,
                TextColor3 = rgb(130, 130, 130),
                BorderColor3 = rgb(0, 0, 0),
                TextWrapped = true,
                Text = cfg.info,
                Parent = items["label"],
                Name = "\0",
                Position = d2(0, 5, 0, 17),
                Size = d2(1, -10, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 16,
                BackgroundColor3 = rgb(255, 255, 255)
            });
        end 
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["label"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Parent = items["right_components"],
            Padding = dm(0, 9),
            SortOrder = Enum.SortOrder.LayoutOrder
        });                
    end 

    if cfg.seperator then 
        library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = self.items["elements"],
            Position = d2(0, 0, 1, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 1, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    return setmetatable(cfg, library)
end 
    
function library:colorpicker(opt) 
    local cfg = {
        name = opt.name or "Color", 
        flag = opt.flag or library:next_flag(),
        color = opt.color or col(1, 1, 1), 
        alpha = opt.alpha and 1 - opt.alpha or 0,
        open = false, 
        callback = opt.callback or function() end,
        items = {},
        seperator = opt.seperator or false,
    }

    local drag_sat = false 
    local drag_hue = false 
    local drag_alpha = false 

    local h, s, v = cfg.color:ToHSV() 
    local a = cfg.alpha 

    flg[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

    local label; 
    if not self.items.right_components then 
        label = self:label({name = cfg.name, seperator = cfg.seperator})
    end

    local items = cfg.items; do 
        items["colorpicker"] = library:create("TextButton", {
            FontFace = fnt.small,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = v2(1, 0),
            Parent = label and label.items.right_components or self.items["right_components"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            Size = d2(0, 16, 0, 16),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = rgb(54, 31, 184)
        });
        
        library:create("UICorner", {
            Parent = items["colorpicker"],
            CornerRadius = dm(0, 4)
        });
        
        items["colorpicker_inline"] = library:create("Frame", {
            Parent = items["colorpicker"],
            Size = d2(1, -2, 1, -2),
            Name = "\0",
            BorderMode = Enum.BorderMode.Inset,
            BorderColor3 = rgb(0, 0, 0),
            Position = d2(0, 1, 0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(54, 31, 184)
        });
        
        library:create("UICorner", {
            Parent = items["colorpicker_inline"],
            CornerRadius = dm(0, 4)
        });
        
        library:create("UIGradient", {
            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))},
            Parent = items["colorpicker_inline"]
        });         

        items["colorpicker_holder"] = library:create("Frame", {
            Parent = library["other"],
            Name = "\0",
            Position = d2(0.2, 20, 0.297, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 166, 0, 197),
            BorderSizePixel = 0,
            Visible = true,
            BackgroundColor3 = rgb(25, 25, 29)
        });

        items["colorpicker_fade"] = library:create("Frame", {
            Parent = items["colorpicker_holder"],
            Name = "\0",
            BackgroundTransparency = 0,
            Position = d2(0, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 1, 0),
            BorderSizePixel = 0,
            ZIndex = 100,
            BackgroundColor3 = rgb(25, 25, 29)
        });
        
        items["colorpicker_components"] = library:create("Frame", {
            Parent = items["colorpicker_holder"],
            Name = "\0",
            Position = d2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create("UICorner", {
            Parent = items["colorpicker_components"],
            CornerRadius = dm(0, 6)
        });
        
        items["saturation_holder"] = library:create("Frame", {
            Parent = items["colorpicker_components"],
            Name = "\0",
            Position = d2(0, 7, 0, 7),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -14, 1, -80),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 39, 39)
        });
        
        items["sat"] = library:create("TextButton", {
            Parent = items["saturation_holder"],
            Name = "\0",
            Size = d2(1, 0, 1, 0),
            Text = "",
            AutoButtonColor = false,
            BorderColor3 = rgb(0, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UICorner", {
            Parent = items["sat"],
            CornerRadius = dm(0, 4)
        });
        
        library:create("UIGradient", {
            Rotation = 270;
            Transparency = numseq{numkey(0, 0), numkey(1, 1)},
            Parent = items["sat"],
            Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
        });
        
        items["val"] = library:create("Frame", {
            Name = "\0",
            Parent = items["saturation_holder"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIGradient", {
            Parent = items["val"],
            Transparency = numseq{numkey(0, 0), numkey(1, 1)}
        });
        
        library:create("UICorner", {
            Parent = items["val"],
            CornerRadius = dm(0, 4)
        });
        
        library:create("UICorner", {
            Parent = items["saturation_holder"],
            CornerRadius = dm(0, 4)
        });
        
        items["satvalpicker"] = library:create("TextButton", {
            BorderColor3 = rgb(0, 0, 0),
            AutoButtonColor = false,
            Text = "",
            AnchorPoint = v2(0, 1),
            Parent = items["saturation_holder"],
            Name = "\0",
            Position = d2(0, 0, 4, 0),
            Size = d2(0, 8, 0, 8),
            ZIndex = 5,
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create("UICorner", {
            Parent = items["satvalpicker"],
            CornerRadius = dm(0, 9999)
        });
        
        library:create("UIStroke", {
            Color = rgb(255, 255, 255),
            Parent = items["satvalpicker"],
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        });
        
        items["hue_gradient"] = library:create("TextButton", {
            Parent = items["colorpicker_components"],
            Name = "\0",
            Position = d2(0, 10, 1, -64),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -20, 0, 8),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255),
            AutoButtonColor = false,
            Text = "",
        });
        
        library:create("UIGradient", {
            Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))},
            Parent = items["hue_gradient"]
        });
        
        library:create("UICorner", {
            Parent = items["hue_gradient"],
            CornerRadius = dm(0, 6)
        });
        
        items["hue_picker"] = library:create("TextButton", {
            BorderColor3 = rgb(0, 0, 0),
            AutoButtonColor = false,
            Text = "",
            AnchorPoint = v2(0, 0.5),
            Parent = items["hue_gradient"],
            Name = "\0",
            Position = d2(0, 0, 0.5, 0),
            Size = d2(0, 8, 0, 8),
            ZIndex = 5,
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create("UICorner", {
            Parent = items["hue_picker"],
            CornerRadius = dm(0, 9999)
        });
        
        library:create("UIStroke", {
            Color = rgb(255, 255, 255),
            Parent = items["hue_picker"],
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        });
        
        items["alpha_gradient"] = library:create("TextButton", {
            Parent = items["colorpicker_components"],
            Name = "\0",
            Position = d2(0, 10, 1, -46),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -20, 0, 8),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(25, 25, 29),
            AutoButtonColor = false,
            Text = "",
        });
        
        library:create("UICorner", {
            Parent = items["alpha_gradient"],
            CornerRadius = dm(0, 6)
        });
        
        items["alpha_picker"] = library:create("TextButton", {
            BorderColor3 = rgb(0, 0, 0),
            AutoButtonColor = false,
            Text = "",
            AnchorPoint = v2(0, 0.5),
            Parent = items["alpha_gradient"],
            Name = "\0",
            Position = d2(1, 0, 0.5, 0),
            Size = d2(0, 8, 0, 8),
            ZIndex = 5,
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create("UICorner", {
            Parent = items["alpha_picker"],
            CornerRadius = dm(0, 9999)
        });
        
        library:create("UIStroke", {
            Color = rgb(255, 255, 255),
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Parent = items["alpha_picker"]
        });
        
        library:create("UIGradient", {
            Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))},
            Parent = items["alpha_gradient"]
        });
        
        items["alpha_indicator"] = library:create("ImageLabel", {
            ScaleType = Enum.ScaleType.Tile,
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["alpha_gradient"],
            Image = "rbxassetid://18274452449",
            BackgroundTransparency = 1,
            Name = "\0",
            Size = d2(1, 0, 1, 0),
            TileSize = d2(0, 6, 0, 6),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(0, 0, 0)
        });
        
        library:create("UIGradient", {
            Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))},
            Transparency = numseq{numkey(0, 0.806), numkey(1, 0)},
            Parent = items["alpha_indicator"]
        });
        
        library:create("UICorner", {
            Parent = items["alpha_indicator"],
            CornerRadius = dm(0, 6)
        });
        
        library:create("UIGradient", {
            Rotation = 90,
            Parent = items["colorpicker_components"],
            Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))}
        });

        items["input"] = library:create("TextBox", {
            FontFace = fnt.font,
            AnchorPoint = v2(1, 1),
            Text = "",
            Parent = items["colorpicker_components"],
            Name = "\0",
            TextTruncate = Enum.TextTruncate.AtEnd,
            BorderSizePixel = 0,
            PlaceholderColor3 = rgb(255, 255, 255),
            CursorPosition = -1,
            ClearTextOnFocus = false,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255),
            TextColor3 = rgb(72, 72, 72),
            BorderColor3 = rgb(0, 0, 0),
            Position = d2(1, -8, 1, -11),
            Size = d2(1, -16, 0, 18),
            BackgroundColor3 = rgb(33, 33, 35)
        }); 
        
        library:create("UICorner", {
            Parent = items["input"],
            CornerRadius = dm(0, 3)
        });
        
        items["UICorenr"] = library:create("UICorner", { 
            Parent = items["colorpicker_holder"],
            Name = "\0",
            CornerRadius = dm(0, 4)
        });
    end;

    function cfg.set_visible(bool)
        items["colorpicker_fade"].BackgroundTransparency = 0
        items["colorpicker_holder"].Parent = bool and library["items"] or library["other"]
        items["colorpicker_holder"].Position = dof(items["colorpicker"].AbsolutePosition.X, items["colorpicker"].AbsolutePosition.Y + items["colorpicker"].AbsoluteSize.Y + 45)
        library:tween(items["colorpicker_fade"], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
        library:tween(items["colorpicker_holder"], {Position = items["colorpicker_holder"].Position + dof(0, 20)}) 
        if not (self.sanity and library.current_open == self and self.open) then 
            library:close_element(cfg)
        end
    end

    function cfg.set(color, alpha)
        if type(color) == "boolean" then 
            return
        end 
        if color then 
            h, s, v = color:ToHSV()
        end
        if alpha then 
            a = alpha
        end 
        
        local Color = hsv(h, s, v)
        library:tween(items["hue_picker"], {Position = d2(0, (items["hue_gradient"].AbsoluteSize.X - items["hue_picker"].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        library:tween(items["alpha_picker"], {Position = d2(0, (items["alpha_gradient"].AbsoluteSize.X - items["alpha_picker"].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        library:tween(items["satvalpicker"], {Position = d2(0, s * (items["saturation_holder"].AbsoluteSize.X - items["satvalpicker"].AbsoluteSize.X), 1, 1 - v * (items["saturation_holder"].AbsoluteSize.Y - items["satvalpicker"].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

        items["alpha_indicator"]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))}; 
        
        items["colorpicker"].BackgroundColor3 = Color
        items["colorpicker_inline"].BackgroundColor3 = Color
        items["saturation_holder"].BackgroundColor3 = hsv(h, 1, 1)
        items["hue_picker"].BackgroundColor3 = hsv(h, 1, 1)
        items["alpha_picker"].BackgroundColor3 = hsv(h, 1, 1 - a)
        items["satvalpicker"].BackgroundColor3 = hsv(h, s, v)

        flg[cfg.flag] = {
            Color = Color,
            Transparency = a 
        }
        
        local col_val = items["colorpicker"].BackgroundColor3
        items["input"].Text = string.format("%s, %s, %s, ", library:round(col_val.R * 255), library:round(col_val.G * 255), library:round(col_val.B * 255))
        items["input"].Text = items["input"].Text .. library:round(1 - a, 0.01)
        cfg.callback(Color, a)
    end
    
    function cfg.update_color() 
        local m_pos = u:GetMouseLocation() 
        local offset = v2(m_pos.X, m_pos.Y - goff) 

        if drag_sat then	
            s = cl((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
            v = 1 - cl((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
        elseif drag_hue then
            h = cl((offset - items["hue_gradient"].AbsolutePosition).X / items["hue_gradient"].AbsoluteSize.X, 0, 1)
        elseif drag_alpha then
            a = 1 - cl((offset - items["alpha_gradient"].AbsolutePosition).X / items["alpha_gradient"].AbsoluteSize.X, 0, 1)
        end
        cfg.set()
    end

    items["colorpicker"].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)            
    end)

    u.InputChanged:Connect(function(inp)
        if (drag_sat or drag_hue or drag_alpha) and inp.UserInputType == Enum.UserInputType.MouseMovement then
            cfg.update_color() 
        end
    end)

    library:connection(u.InputEnded, function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag_sat = false
            drag_hue = false
            drag_alpha = false
        end
    end)    

    items["alpha_gradient"].MouseButton1Down:Connect(function()
        drag_alpha = true 
    end)
    
    items["hue_gradient"].MouseButton1Down:Connect(function()
        drag_hue = true 
    end)
    
    items["sat"].MouseButton1Down:Connect(function()
        drag_sat = true  
    end)

    items["input"].FocusLost:Connect(function()
        local text = items["input"].Text
        local r_val, g_val, b_val, a_val = library:convert(text)
        if r_val and g_val and b_val and a_val then 
            cfg.set(rgb(r_val, g_val, b_val), 1 - a_val)
        end 
    end)

    items["input"].Focused:Connect(function()
        library:tween(items["input"], {TextColor3 = rgb(245, 245, 245)})
    end)

    items["input"].FocusLost:Connect(function()
        library:tween(items["input"], {TextColor3 = rgb(72, 72, 72)})
    end)
    
    cfg.set(cfg.color, cfg.alpha)
    cfg_flg[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:textbox(opt) 
    local cfg = {
        name = opt.name or "TextBox",
        placeholder = opt.placeholder or "type here...",
        default = opt.default or "",
        flag = opt.flag or library:next_flag(),
        callback = opt.callback or function() end,
        visible = opt.visible or true,
        items = {},
    }

    flg[cfg.flag] = cfg.default

    local items = cfg.items; do 
        items["textbox"] = library:create("TextButton", {
            LayoutOrder = -1,
            FontFace = fnt.font,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["textbox"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["textbox"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 4, 0, 19),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, 0, 0, 12),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["right_components"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal
        });
        
        items["input"] = library:create("TextBox", {
            FontFace = fnt.font,
            Text = "",
            Parent = items["right_components"],
            Name = "\0",
            TextTruncate = Enum.TextTruncate.AtEnd,
            BorderSizePixel = 0,
            PlaceholderColor3 = rgb(255, 255, 255),
            CursorPosition = -1,
            ClearTextOnFocus = false,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255),
            TextColor3 = rgb(72, 72, 72),
            BorderColor3 = rgb(0, 0, 0),
            Position = d2(1, 0, 0, 0),
            Size = d2(1, -4, 0, 30),
            BackgroundColor3 = rgb(33, 33, 35)
        }); 

        library:create("UICorner", {
            Parent = items["input"],
            CornerRadius = dm(0, 3)
        });                
        
        library:create("UIPadding", {
            Parent = items["right_components"],
            PaddingTop = dm(0, 4),
            PaddingRight = dm(0, 4)
        });
    end 
    
    function cfg.set(text) 
        flg[cfg.flag] = text
        items["input"].Text = text
        cfg.callback(text)
    end 
    
    items["input"]:GetPropertyChangedSignal("Text"):Connect(function()
        cfg.set(items["input"].Text) 
    end)

    items["input"].Focused:Connect(function()
        library:tween(items["input"], {TextColor3 = rgb(245, 245, 245)})
    end)

    items["input"].FocusLost:Connect(function()
        library:tween(items["input"], {TextColor3 = rgb(72, 72, 72)})
    end)
        
    if cfg.default then 
        cfg.set(cfg.default) 
    end

    cfg_flg[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end

function library:keybind(opt) 
    local cfg = {
        flag = opt.flag or library:next_flag(),
        callback = opt.callback or function() end,
        name = opt.name or nil, 
        ignore_key = opt.ignore or false, 
        key = opt.key or nil, 
        mode = opt.mode or "Toggle",
        active = opt.default or false, 
        open = false,
        binding = nil, 
        hold_instances = {},
        items = {},
    }

    flg[cfg.flag] = {
        mode = cfg.mode,
        key = cfg.key, 
        active = cfg.active
    }

    local items = cfg.items; do 
        items["keybind_element"] = library:create("TextButton", {
            FontFace = fnt.font,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["keybind_element"],
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["name"],
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });
        
        items["right_components"] = library:create("Frame", {
            Parent = items["keybind_element"],
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Parent = items["right_components"],
            Padding = dm(0, 7),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        items["keybind_holder"] = library:create("TextButton", {
            FontFace = fnt.font,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            Parent = items["right_components"],
            AutoButtonColor = false,
            AnchorPoint = v2(1, 0),
            Size = d2(0, 0, 0, 16),
            Name = "\0",
            Position = d2(1, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 14,
            BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create("UICorner", {
            Parent = items["keybind_holder"],
            CornerRadius = dm(0, 4)
        });
        
        items["key"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(86, 86, 87),
            BorderColor3 = rgb(0, 0, 0),
            Text = "LSHIFT",
            Parent = items["keybind_holder"],
            Name = "\0",
            Size = d2(1, -12, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            Parent = items["key"],
            PaddingTop = dm(0, 1),
            PaddingRight = dm(0, 5),
            PaddingLeft = dm(0, 5)
        });                                  

        items["dropdown"] = library:create("Frame", {
            BorderColor3 = rgb(0, 0, 0),
            Parent = library.items,
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 0, 0, 0),
            Size = d2(0, 0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = rgb(0, 0, 0)
        });
        
        items["inline"] = library:create("Frame", {
            Parent = items["dropdown"],
            Size = d2(1, 0, 1, 0),
            Name = "\0",
            ClipsDescendants = true,
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 6),
            PaddingTop = dm(0, 3),
            PaddingLeft = dm(0, 3),
            Parent = items["inline"]
        });
        
        library:create("UIListLayout", {
            Parent = items["inline"],
            Padding = dm(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UICorner", {
            Parent = items["inline"],
            CornerRadius = dm(0, 4)
        });
        
        local options = {"Hold", "Toggle", "Always"}
        cfg.y_size = 20
        for _, option in options do                        
            local name = library:create("TextButton", {
                FontFace = fnt.font,
                TextColor3 = rgb(72, 72, 73),
                BorderColor3 = rgb(0, 0, 0),
                Text = option,
                Parent = items["inline"],
                Name = "\0",
                Size = d2(0, 0, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 14,
                BackgroundColor3 = rgb(255, 255, 255)
            }); cfg.hold_instances[option] = name
            library:apply_theme(name, "accent", "TextColor3")
            cfg.y_size = cfg.y_size + name.AbsoluteSize.Y

            library:create("UIPadding", {
                Parent = name,
                PaddingTop = dm(0, 1),
                PaddingRight = dm(0, 5),
                PaddingLeft = dm(0, 5)
            });

            name.MouseButton1Click:Connect(function()
                cfg.set(option)
                cfg.set_visible(false)
                cfg.open = false
            end)
        end
    end 
    
    function cfg.modify_mode_color(path) 
        for _, v in cfg.hold_instances do 
            v.TextColor3 = rgb(72, 72, 72)
        end 
        cfg.hold_instances[path].TextColor3 = th.preset.accent
    end

    function cfg.set_mode(mode) 
        cfg.mode = mode 
        if mode == "Always" then
            cfg.set(true)
        elseif mode == "Hold" then
            cfg.set(false)
        end
        flg[cfg.flag]["mode"] = mode
        cfg.modify_mode_color(mode)
    end 

    function cfg.set(input)
        if type(input) == "boolean" then 
            cfg.active = input
            if cfg.mode == "Always" then 
                cfg.active = true
            end
        elseif tostring(input):find("Enum") then 
            input = input.Name == "Escape" and "NONE" or input
            cfg.key = input or "NONE"	
        elseif fd({"Toggle", "Hold", "Always"}, input) then 
            if input == "Always" then 
                cfg.active = true 
            end 
            cfg.mode = input
            cfg.set_mode(cfg.mode) 
        elseif type(input) == "table" then 
            input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
            input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key
            cfg.key = input.key or "NONE"
            cfg.mode = input.mode or "Toggle"
            if input.active then
                cfg.active = input.active
            end
            cfg.set_mode(cfg.mode) 
        end 

        cfg.callback(cfg.active)
        local text = tostring(cfg.key) ~= "Enums" and (ky[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
        local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
        items["key"].Text = __text

        flg[cfg.flag] = {
            mode = cfg.mode,
            key = cfg.key, 
            active = cfg.active
        }
    end

    function cfg.set_visible(bool)
        local size = bool and cfg.y_size or 0
        library:tween(items["dropdown"], {Size = dof(items["keybind_holder"].AbsoluteSize.X, size)})
        items["dropdown"].Position = dof(items["keybind_holder"].AbsolutePosition.X, items["keybind_holder"].AbsolutePosition.Y + items["keybind_holder"].AbsoluteSize.Y + 60)
    end

    items["keybind_holder"].MouseButton1Down:Connect(function()
        task.wait()
        items["key"].Text = "..."	
        cfg.binding = library:connection(u.InputBegan, function(keycode, game_event)  
            cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
            cfg.binding:Disconnect() 
            cfg.binding = nil
        end)
    end)

    items["keybind_holder"].MouseButton2Down:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)
    end)

    library:connection(u.InputBegan, function(input, game_event) 
        if not game_event then
            local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
            if selected_key == cfg.key then 
                if cfg.mode == "Toggle" then 
                    cfg.active = not cfg.active
                    cfg.set(cfg.active)
                elseif cfg.mode == "Hold" then 
                    cfg.set(true)
                end
            end
        end
    end)    

    library:connection(u.InputEnded, function(input, game_event) 
        if game_event then 
            return 
        end 
        local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
        if selected_key == cfg.key then
            if cfg.mode == "Hold" then 
                cfg.set(false)
            end
        end
    end)
    
    cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
    cfg_flg[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end

function library:button(opt) 
    local cfg = {
        name = opt.name or "TextBox",
        callback = opt.callback or function() end,
        items = {},
    }
    
    local items = cfg.items; do 
        items["button_element"] = library:create("Frame", {
            Parent = self.items["elements"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items["button"] = library:create("TextButton", {
            FontFace = fnt.font,
            TextColor3 = rgb(0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = v2(1, 0),
            Parent = items["button_element"],
            Name = "\0",
            Position = d2(1, -4, 0, 0),
            Size = d2(1, -8, 0, 30),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create("UICorner", {
            Parent = items["button"],
            CornerRadius = dm(0, 3)
        });
        
        items["name"] = library:create("TextLabel", {
            FontFace = fnt.small,
            TextColor3 = rgb(245, 245, 245),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["button"],
            Name = "\0",
            BackgroundTransparency = 1,
            Size = d2(1, 0, 1, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items["name"], "accent", "BackgroundColor3");                            
    end 

    items["button"].MouseButton1Click:Connect(function()
        cfg.callback()
        items["name"].TextColor3 = th.preset.accent 
        library:tween(items["name"], {TextColor3 = rgb(245, 245, 245)})
    end)
    
    return setmetatable(cfg, library)
end 

function library:settings(opt)  
    local cfg = {
        open = false, 
        items = {}, 
        sanity = true,
    }

    local items = cfg.items; do 
        items["outline"] = library:create("Frame", {
            Name = "\0",
            Visible = true,
            Parent = library["items"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 0, 0),
            ClipsDescendants = true,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = rgb(25, 25, 29)
        });
        
        items["inline"] = library:create("Frame", {
            Parent = items["outline"],
            Name = "\0",
            Position = d2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create("UICorner", {
            Parent = items["inline"],
            CornerRadius = dm(0, 7)
        });
        
        items["elements"] = library:create("Frame", {
            BorderColor3 = rgb(0, 0, 0),
            Parent = items["inline"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 10, 0, 10),
            Size = d2(1, -20, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["elements"],
            Padding = dm(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 15),
            Parent = items["elements"]
        });
        
        library:create("UICorner", {
            Parent = items["outline"],
            CornerRadius = dm(0, 7)
        });
        
        library:create("UICorner", {
            Parent = items["fade"],
            CornerRadius = dm(0, 7)
        });
        
        items["tick"] = library:create("ImageButton", {
            Image = "rbxassetid://128797200442698",
            Name = "\0",
            AutoButtonColor = false,
            Parent = self.items["right_components"],
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 16, 0, 16),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });                
    end 

    function cfg.set_visible(bool)                 
        library:tween(items["outline"], {Size = dof(bool and 240 or 0, 0)})
        items["outline"].Position = dof(items["tick"].AbsolutePosition.X, items["tick"].AbsolutePosition.Y + 90)
        library:close_element(cfg)
    end
    
    items["tick"].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open
        cfg.set_visible(cfg.open)
    end)

    return setmetatable(cfg, library)
end 

function library:list(prop) 
    local cfg = {
        items = {},
        options = prop.options or {"1", "2", "3"},
        flag = prop.flag or library:next_flag(),    
        callback = prop.callback or function() end,
        data_store = {},        
        current_element = nil,
    }

    local items = cfg.items; do
        items["list"] = library:create("Frame", {
            Parent = self.items["elements"],
            BackgroundTransparency = 1,
            Name = "\0",
            Size = d2(1, 0, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIListLayout", {
            Parent = items["list"],
            Padding = dm(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        library:create("UIPadding", {
            Parent = items["list"],
            PaddingRight = dm(0, 4),
            PaddingLeft = dm(0, 4)
        });
    end 

    function cfg.refresh_options(options_to_refresh) 
        for _,option in cfg.data_store do 
            option:Destroy()
        end

        for _, option_data in options_to_refresh do 
            local button = library:create("TextButton", {
                FontFace = fnt.small,
                TextColor3 = rgb(0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = v2(1, 0),
                Parent = items["list"],
                Name = "\0",
                Position = d2(1, 0, 0, 30),
                Size = d2(1, 0, 0, 30),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = rgb(33, 33, 35)
            }); cfg.data_store[#cfg.data_store + 1] = button;

            local name = library:create("TextLabel", {
                FontFace = fnt.font,
                TextColor3 = rgb(72, 72, 73),
                BorderColor3 = rgb(0, 0, 0),
                Text = option_data,
                Parent = button,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = d2(1, 0, 1, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 14,
                BackgroundColor3 = rgb(255, 255, 255)
            });
            
            library:create("UICorner", {
                Parent = button,
                CornerRadius = dm(0, 3)
            });     

            button.MouseButton1Click:Connect(function()
                local current = cfg.current_element 
                if current and current ~= name then 
                    library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                end

                flg[cfg.flag] = option_data
                cfg.callback(option_data)
                library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                cfg.current_element = name
            end)

            name.MouseEnter:Connect(function()
                if cfg.current_element == name then 
                    return 
                end 
                library:tween(name, {TextColor3 = rgb(140, 140, 140)})
            end)

            name.MouseLeave:Connect(function()
                if cfg.current_element == name then 
                    return 
                end 
                library:tween(name, {TextColor3 = rgb(72, 72, 72)})
            end)
        end
    end

    cfg.refresh_options(cfg.options)
    return setmetatable(cfg, library)
end 

function library:init_config(win) 
    win:seperator({name = "Settings"})
    local main = win:tab({name = "Configs", tabs = {"Main"}})
    
    local column = main:column({})
    local sec = column:section({name = "Configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
    cfg_hld = sec:list({options = {"Default"}, callback = function(opt) end, flag = "config_name_list"}); library:update_config_list()
    
    local column_r = main:column({})
    local sec_r = column_r:section({name = "Settings", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
    sec_r:textbox({name = "Config name:", flag = "config_name_text"})
    sec_r:button({name = "Save", callback = function() 
        local name = (flg["config_name_text"] and flg["config_name_text"] ~= "") and flg["config_name_text"] or flg["config_name_list"]
        if name and name ~= "" then
            writefile(library.directory .. "/configs/" .. name .. ".cfg", library:get_config()) 
            library:update_config_list() 
            ntfs:create_notification({name = "Configs", info = "Saved config to:\n" .. name}) 
        end
    end}) 
    sec_r:button({name = "Load", callback = function() 
        local name = flg["config_name_list"]
        if name and name ~= "" then
            local path = library.directory .. "/configs/" .. name .. ".cfg"
            if isfile(path) then
                library:load_config(readfile(path))  
                library:update_config_list() 
                ntfs:create_notification({name = "Configs", info = "Loaded config:\n" .. name}) 
            else
                ntfs:create_notification({name = "Configs", info = "Config does not exist:\n" .. name})
            end
        end
    end})
    sec_r:button({name = "Delete", callback = function() 
        local name = flg["config_name_list"]
        if name and name ~= "" then
            local path = library.directory .. "/configs/" .. name .. ".cfg"
            if isfile(path) then
                delfile(path)  
                library:update_config_list() 
                ntfs:create_notification({name = "Configs", info = "Deleted config:\n" .. name}) 
            else
                ntfs:create_notification({name = "Configs", info = "Config does not exist:\n" .. name})
            end
        end
    end})
    sec_r:colorpicker({name = "Menu Accent", callback = function(color, alpha) library:update_theme("accent", color) end, color = th.preset.accent})
    sec_r:keybind({name = "Menu Bind", callback = function(bool) win.toggle_menu(bool) end, default = true})
end

function ntfs:refresh_notifs() 
    local offset = 50
    for _, v in ntfs.notifs do
        local Position = v2(20, offset)
        library:tween(v, {Position = dof(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
        offset = offset + (v.AbsoluteSize.Y + 10)
    end
    return offset
end

function ntfs:fade(path, is_fading)
    local fading = is_fading and 1 or 0 
    library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)

    for _, inst in path:GetDescendants() do 
        if not inst:IsA("GuiObject") then 
            if inst:IsA("UIStroke") then
                library:tween(inst, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
            end
            continue
        end 
        if inst:IsA("TextLabel") then
            library:tween(inst, {TextTransparency = fading})
        elseif inst:IsA("Frame") then
            library:tween(inst, {BackgroundTransparency = inst.Transparency and 0.6 and is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
        end
    end
end 

function ntfs:create_notification(opt)
    local cfg = {
        name = opt.name or "Notification",
        info = opt.info or "Extra info",
        lifetime = opt.lifetime or 3,
        items = {},
        outline = nil,
    }

    local items = cfg.items; do 
        items["notification"] = library:create("Frame", {
            Parent = library["items"],
            Size = d2(0, 210, 0, 53),
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            AnchorPoint = v2(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = rgb(14, 14, 16)
        });
        
        library:create("UIStroke", {
            Color = rgb(23, 23, 29),
            Parent = items["notification"],
            Transparency = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        });
        
        items["title"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Parent = items["notification"],
            Name = "\0",
            BackgroundTransparency = 1,
            Position = d2(0, 7, 0, 6),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UICorner", {
            Parent = items["notification"],
            CornerRadius = dm(0, 3)
        });
        
        items["info"] = library:create("TextLabel", {
            FontFace = fnt.font,
            TextColor3 = rgb(145, 145, 145),
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.info,
            Parent = items["notification"],
            Name = "\0",
            Position = d2(0, 9, 0, 22),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 14,
            BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create("UIPadding", {
            PaddingBottom = dm(0, 17),
            PaddingRight = dm(0, 8),
            Parent = items["info"]
        });
        
        items["bar"] = library:create("Frame", {
            AnchorPoint = v2(0, 1),
            Parent = items["notification"],
            Name = "\0",
            Position = d2(0, 8, 1, -6),
            BorderColor3 = rgb(0, 0, 0),
            Size = d2(0, 0, 0, 5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = th.preset.accent
        });
        
        library:create("UICorner", {
            Parent = items["bar"],
            CornerRadius = dm(0, 999)
        });
        
        library:create("UIPadding", {
            PaddingRight = dm(0, 8),
            Parent = items["notification"]
        });
    end
    
    local idx = #ntfs.notifs + 1
    ntfs.notifs[idx] = items["notification"]
    ntfs:fade(items["notification"], false)
    
    local offset = ntfs:refresh_notifs()
    items["notification"].Position = dof(20, offset)

    library:tween(items["notification"], {AnchorPoint = v2(0, 0)}, Enum.EasingStyle.Quad, 1)
    library:tween(items["bar"], {Size = d2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

    task.spawn(function()
        task.wait(cfg.lifetime)
        ntfs.notifs[idx] = nil
        ntfs:fade(items["notification"], true)
        library:tween(items["notification"], {AnchorPoint = v2(1, 0)}, Enum.EasingStyle.Quad, 1)
        task.wait(1)
        items["notification"]:Destroy() 
    end)
end

return library
