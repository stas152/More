
local Ts=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local Hs=game:GetService("HttpService")

local Lib={}
local Sig={}
Sig.__index=Sig
function Sig.new(v)
	local s=setmetatable({},Sig)
	s.V=v
	s.C={}
	return s
end
function Sig:g()
	return self.V
end
function Sig:s(v)
	if self.V==v then return end
	self.V=v
	self:_f()
end
function Sig:c(f)
	local id=#self.C+1
	self.C[id]=f
	return function() self.C[id]=nil end
end
function Sig:oc(f)
	f(self.V)
	return self:c(f)
end
function Sig:_f()
	for i=1,#self.C do
		local cb=self.C[i]
		if cb then task.spawn(cb,self.V) end
	end
end

local function U(c,p)
	local i=Instance.new(c)
	for k,v in pairs(p or {}) do i[k]=v end
	if p and p.Parent then end
	if p and p._P then i.Parent=p._P end
	return i
end
local function UC(p,r)
	return U("UICorner",{CornerRadius=UDim.new(0,r or 4)},p)
end
local function US(p,t,c,tr)
	return U("UIStroke",{Thickness=t or 1,Color=c or Color3.new(1,1,1),Transparency=tr or 0.9},p)
end
local function UL(p,d,pad,ha,va)
	local l=U("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=d or Enum.FillDirection.Vertical,Padding=UDim.new(0,pad or 0),HorizontalAlignment=ha or Enum.HorizontalAlignment.Left,VerticalAlignment=va or Enum.VerticalAlignment.Top},p)
	return l
end
local function CT(s)
	local r,g,b=s:match("#(..)(..)(..)")
	if r then return Color3.fromRGB(tonumber(r,16),tonumber(g,16),tonumber(b,16)) end
	local r3,g3,b3=s:match("#(.)(.)(.)")
	if r3 then return Color3.fromRGB(tonumber(r3..r3,16),tonumber(g3..g3,16),tonumber(b3..b3,16)) end
	return Color3.new(1,1,1)
end
local function CC(c)
	return string.format("#%02X%02X%02X",math.floor(c.R*255+0.5),math.floor(c.G*255+0.5),math.floor(c.B*255+0.5))
end
local function DC(t)
	local c={}
	for k,v in pairs(t) do
		if type(v)=="table" then c[k]=DC(v) else c[k]=v end
	end
	return c
end
local function GI() return Hs:GenerateGUID(false):gsub("-","") end
local function CL(s)
	return s:gsub("Key",""):gsub("Digit",""):gsub("Mouse0","M1"):gsub("Mouse1","M2"):gsub("Mouse2","M3"):gsub("Mouse3","M4"):gsub("Mouse4","M5")
end
local function SP(s,d)
	local r,pat={},"(.-)"..d.."()"
	local lp=1
	for p,pos in s:gmatch(pat) do r[#r+1]=p;lp=pos end
	r[#r+1]=s:sub(lp)
	return r
end
local function CLMP(v,mn,mx) return math.max(mn,math.min(mx,v)) end

local function TW(i,p,d,es,ed)
	local ti=TweenInfo.new(d or 0.2,es or Enum.EasingStyle.Quad,ed or Enum.EasingDirection.Out)
	local t=Ts:Create(i,ti,p)
	t:Play()
	return t
end
local function AI(g,p,d,cb)
	g.Visible=true
	local t=TW(g,p or {BackgroundTransparency=0},d or 0.15)
	if cb then t.Completed:Connect(cb) end
	return t
end
local function AO(g,p,d,cb)
	local t=TW(g,p or {BackgroundTransparency=1},d or 0.12)
	t.Completed:Connect(function() g:Destroy() if cb then cb() end end)
	return t
end

local Th={}
Th.Blue={Id="blue",P=Color3.fromRGB(0,240,255),S=Color3.fromRGB(0,114,255),SL=Color3.fromRGB(0,240,255)}
Th.Sapphire={Id="sapphire",P=Color3.fromRGB(0,210,255),S=Color3.fromRGB(0,82,204),SL=Color3.fromRGB(0,210,255)}
Th.Green={Id="green",P=Color3.fromRGB(0,255,135),S=Color3.fromRGB(0,163,92),SL=Color3.fromRGB(0,255,135)}
Th.Mint={Id="mint",P=Color3.fromRGB(0,255,210),S=Color3.fromRGB(0,158,128),SL=Color3.fromRGB(0,255,210)}
Th.Yellow={Id="yellow",P=Color3.fromRGB(255,234,0),S=Color3.fromRGB(255,141,0),SL=Color3.fromRGB(255,234,0)}
Th.Orange={Id="orange",P=Color3.fromRGB(255,122,0),S=Color3.fromRGB(179,75,0),SL=Color3.fromRGB(255,122,0)}
Th.Red={Id="red",P=Color3.fromRGB(255,51,102),S=Color3.fromRGB(179,0,45),SL=Color3.fromRGB(255,51,102)}
Th.Pink={Id="pink",P=Color3.fromRGB(255,91,192),S=Color3.fromRGB(179,30,120),SL=Color3.fromRGB(255,91,192)}
Th.Purple={Id="purple",P=Color3.fromRGB(174,0,255),S=Color3.fromRGB(110,0,179),SL=Color3.fromRGB(174,0,255)}
Th.White={Id="white",P=Color3.new(1,1,1),S=Color3.fromRGB(143,161,179),SL=Color3.new(1,1,1)}

local Nav={{C="MAIN",I={{I="combat",L="Combat"},{I="visuals",L="Visuals"},{I="movement",L="Movement"},{I="exploit",L="Exploit"},{I="configs",L="Config"}}}}

local Dflt={Antiaim={Movement={AutoJump=true,AutoJumpMode="Normal",AutoJumpOnKey=false,AutoStrafe=false,AutoStrafeSmoothness=50,QuickStop=true,StrafeAssist=false,AutoPeek=false,EdgeJump=false,InfinityDuck=true,Blockbot=false},Other={AntiUntrusted=true,FilterAds=false,FilterConsole=true,UnlockCvars=false,FastReload=false,FastWeaponSwitch=true,FakePing=0,EventLog={"Damage"},Windows="Binds List, Water",ClanTag="",ThirdPersonKey="None",MenuColor="#00f0ff",ShowHUD=true,HudPosition="Top-Right"}},Rage={Enable=false,Fov=180,SilentAim=false,AutoFire=false,AutoScope=false,AutoWall=false,MinDamage=10,HitChance=50,TargetPriority="Highest Damage",Hitbox="Head",MultiPoint=false,MultiPointScale=50,Resolver=false,SafePoint=false,ForceBaim=false},Legit={Enable=true,Smooth=5,Rcs=true,Triggerbot=false},Players={EnableESP=true,BoxEsp=true,BoxColor="#ff3366",HealthBar=true,Skeleton=false,SkeletonColor="#00ff87",NameEsp=true,NameColor="#ffffff"},MainMisc={Bhop=true,Watermark=true,AutoAccept=true,Spectators=false},Keybinds={}}

local SNames={Enable="Ragebot",SilentAim="Silent Aim",AutoFire="Auto Fire",AutoScope="Auto Scope",AutoWall="Auto Wall",MultiPoint="Multi Point",Resolver="Resolver",SafePoint="Force Safe Point",ForceBaim="Force Baim",Rcs="Recoil Control",Triggerbot="Triggerbot",EnableESP="Player ESP",BoxEsp="ESP Box",HealthBar="ESP Health Bar",Skeleton="ESP Skeleton",NameEsp="ESP Name tag",AutoJump="Auto Jump (Bhop)",AutoStrafe="Auto Strafe",QuickStop="Quick Stop",StrafeAssist="Strafe Assist",AutoPeek="Auto Peek",EdgeJump="Edge Jump",InfinityDuck="Infinity Duck",Blockbot="Blockbot",AntiUntrusted="Anti Untrusted",FilterAds="Filter Text Advertisements",FilterConsole="Filter Developer Console",UnlockCvars="Unlock CVars",FastReload="Fast Reload",FastWeaponSwitch="Fast Weapon Switch",ShowHUD="Main Watermark",Bhop="Bunny Hop",Watermark="Performance Watermark",AutoAccept="Auto Match Accept",Spectators="Spectator Watchlist"}

local function MKSC(TM,NE)
	local SC={}
	SC.S=Sig.new(DC(Dflt))
	SC.Q=Sig.new("")
	SC.NE=NE or Instance.new("BindableEvent")
	function SC:GA() return self.S:g() end
	function SC:GQ() return self.Q:g() end
	function SC:SetQ(q) self.Q:s(q) end
	function SC:US(s,k,v)
		local st=self.S:g()
		if st[s] then st[s][k]=v end
		self.S:s(DC(st))
		SC:_TN(k,v)
	end
	function SC:UAM(k,v)
		local st=self.S:g()
		st.Antiaim.Movement[k]=v
		self.S:s(DC(st))
		SC:_TN(k,v)
	end
	function SC:UAO(k,v)
		local st=self.S:g()
		st.Antiaim.Other[k]=v
		self.S:s(DC(st))
		SC:_TN(k,v)
	end
	function SC:UK(p,c)
		local st=self.S:g()
		if c==nil then st.Keybinds[p]=nil else st.Keybinds[p]=c end
		self.S:s(DC(st))
	end
	function SC:LS(ns) self.S:s(DC(ns)) end
	function SC:DN(t,tx,ty,d) self.NE:Fire({Title=t,Text=tx,Type=ty or "info",Duration=d or 3000}) end
	function SC:_TN(k,v)
		if type(v)~="boolean" then return end
		local n=SNames[k] or tostring(k)
		local st=v and"Enabled"or"Disabled"
		local nt=v and"toggle_on"or"toggle_off"
		SC:DN(n,'Setting "'..n..'" is now '..st:lower(),nt,2500)
	end
	function SC:IKL()
		UIS.InputBegan:Connect(function(ip,gp)
			if gp then return end
			local ic=""
			if ip.UserInputType==Enum.UserInputType.Keyboard then ic=ip.KeyCode.Name
			elseif ip.UserInputType==Enum.UserInputType.MouseButton1 then ic="Mouse0"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton2 then ic="Mouse1"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton3 then ic="Mouse2"
			else return end
			if ic=="" then return end
			local st=SC:GA()
			local mp=nil
			for p,k in pairs(st.Keybinds) do if ic==k then mp=p;break end end
			if not mp then return end
			local pts=SP(mp,".")
			local nv=nil
			local s=SC:GA()
			if #pts==3 and pts[2]=="movement" then
				local cv=s.Antiaim.Movement[pts[3]]
				if type(cv)=="boolean" then nv=not cv;s.Antiaim.Movement[pts[3]]=nv end
			elseif #pts==3 and pts[2]=="other" then
				local cv=s.Antiaim.Other[pts[3]]
				if type(cv)=="boolean" then nv=not cv;s.Antiaim.Other[pts[3]]=nv end
			elseif #pts==2 then
				if s[pts[1]] then
					local cv=s[pts[1]][pts[2]]
					if type(cv)=="boolean" then nv=not cv;s[pts[1]][pts[2]]=nv end
				end
			end
			if nv~=nil then
				self.S:s(DC(s))
				local sk=pts[#pts]
				local nm=SNames[sk] or sk
				local st2=nv and"Enabled"or"Disabled"
				local nt2=nv and"toggle_on"or"toggle_off"
				SC:DN(nm,"Toggled "..st2:lower().." via ["..CL(ic).."]",nt2,2500)
			end
		end)
	end
	return SC
end

local function MKGO(p,TM)
	local c,o,isOpen,ch=U("Frame",{Size=UDim2.fromOffset(14,14),BackgroundTransparency=1},p),nil,false,{}
	local btn=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="⚙",TextColor3=Color3.fromRGB(98,106,115),TextSize=12,Font=Enum.Font.SourceSans,ZIndex=5},c)
	btn.MouseButton1Click:Connect(function()
		if isOpen then
			isOpen=false;btn.TextColor3=Color3.fromRGB(98,106,115)
			if o then AO(o,{BackgroundTransparency=1});o=nil end
			for i=1,#ch do ch[i].Parent=p end
		else
			isOpen=true;btn.TextColor3=Color3.new(1,1,1)
			o=U("Frame",{Size=UDim2.fromOffset(180,0),BackgroundColor3=Color3.fromRGB(22,25,29),BorderSizePixel=0,ZIndex=60,AutomaticSize=Enum.AutomaticSize.Y},c)
			UC(o,8);US(o,1,Color3.new(1,1,1),0.9)
			U("UIPadding",{PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,8)},o)
			UL(o,Enum.FillDirection.Vertical,6)
			AI(o,{BackgroundTransparency=0})
			for i=1,#ch do ch[i].Parent=o end
		end
	end)
	btn.MouseEnter:Connect(function() btn.TextColor3=Color3.new(1,1,1) end)
	btn.MouseLeave:Connect(function() if not isOpen then btn.TextColor3=Color3.fromRGB(98,106,115) end end)
	return{GetContainer=function() return c end,AddChild=function(cld)ch[#ch+1]=cld end,Destroy=function()c:Destroy()end}
end

local function MKTG(p,TM,cfg)
	local l=cfg.Label or"Toggle"
	local v=cfg.Checked or false
	local oc=cfg.OnChange or function()end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	local lb=U("TextLabel",{Size=UDim2.new(1,-80,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(80,22),Position=UDim2.new(1,-80,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6)
	rl.HorizontalAlignment=Enum.HorizontalAlignment.Right
	rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local tr=U("Frame",{Size=UDim2.fromOffset(28,14),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0},rc)
	UC(tr,14);US(tr,1,Color3.new(1,1,1),0.95)
	local th=U("Frame",{Size=UDim2.fromOffset(8,8),Position=UDim2.fromOffset(2,3),BackgroundColor3=Color3.fromRGB(74,81,91),BorderSizePixel=0},tr)
	UC(th,4)
	local bt=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=2},tr)
	bt.MouseButton1Click:Connect(function()
		v=not v
		local ac=TM:GA()
		if v then
			TW(tr,{BackgroundColor3=ac},0.2)
			TW(th,{Position=UDim2.fromOffset(18,3),BackgroundColor3=ac},0.2)
		else
			TW(tr,{BackgroundColor3=Color3.new(1,1,1)},0.2)
			TW(th,{Position=UDim2.fromOffset(2,3),BackgroundColor3=Color3.fromRGB(74,81,91)},0.2)
		end
		oc(v)
	end)
	if v then
		local ac=TM:GA()
		tr.BackgroundColor3=ac
		th.Position=UDim2.fromOffset(18,3);th.BackgroundColor3=ac
	end
	if cfg.HasColor and cfg.ColorValue then
		local cp=U("TextButton",{Size=UDim2.fromOffset(18,12),BackgroundColor3=CT(cfg.ColorValue or"#ffffff"),BorderSizePixel=0},rc)
		UC(cp,3);US(cp,1,Color3.new(1,1,1),0.9)
		U("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.new(1,1,1))}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.85),NumberSequenceKeypoint.new(1,1)}),Rotation=90},cp)
	end
	return f
end

local function MKSL(p,TM,cfg)
	local l=cfg.Label or"Slider"
	local mn=cfg.Min or 0
	local mx=cfg.Max or 100
	local v=cfg.Value or 0
	local oc=cfg.OnChange or function()end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	U("TextLabel",{Size=UDim2.new(1,-130,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(130,22),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local tr=U("Frame",{Size=UDim2.fromOffset(70,3),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.9,BorderSizePixel=0},rc)
	UC(tr,2)
	local fl=U("Frame",{Size=UDim2.fromOffset(math.floor((v-mn)/(mx-mn)*70),3),BackgroundColor3=TM:GSL(),BorderSizePixel=0},tr)
	UC(fl,2)
	local bt=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=3},tr)
	local vl=U("TextLabel",{Size=UDim2.fromOffset(24,14),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0,Text=tostring(v),TextColor3=Color3.fromRGB(255,255,255),TextSize=9,TextTransparency=0.25,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Center},rc)
	UC(vl,3);US(vl,1,Color3.new(1,1,1),0.95)
	local dr=false
	local function UM(i)
		local ax=tr.AbsolutePosition.X
		local rx=CLMP((i.Position.X-ax)/tr.AbsoluteSize.X,0,1)
		local nv=math.floor(mn+(mx-mn)*rx)
		nv=CLMP(nv,mn,mx)
		v=nv
		TW(fl,{Size=UDim2.fromOffset(math.floor(rx*70),3)},0.1)
		vl.Text=tostring(v)
		oc(v)
	end
	bt.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true;UM(i)end end)
	bt.InputChanged:Connect(function(i)if dr then UM(i)end end)
	bt.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
	return f
end

local function MKDD(p,TM,cfg)
	local l=cfg.Label or"Select"
	local opts=cfg.Options or{}
	local v=cfg.Value or(opts[1] or"")
	local oc=cfg.OnChange or function()end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	U("TextLabel",{Size=UDim2.new(1,-130,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(130,22),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local tf=U("Frame",{Size=UDim2.fromOffset(120,20),BackgroundColor3=Color3.fromRGB(10,12,14),BackgroundTransparency=0.05,BorderSizePixel=0},rc)
	UC(tf,6);local ts=US(tf,1,Color3.new(1,1,1),0.95)
	local tl=U("TextLabel",{Size=UDim2.new(1,-24,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=v,TextColor3=Color3.fromRGB(255,255,255),TextSize=11,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},tf)
	local ch=U("TextLabel",{Size=UDim2.fromOffset(12,12),Position=UDim2.new(1,-14,0.5,-6),BackgroundTransparency=1,Text="▼",TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSans},tf)
	local isOpen=false;local mn=nil
	local tb=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=4},tf)
	tb.MouseButton1Click:Connect(function()
		if isOpen then
			isOpen=false;tf.BackgroundColor3=Color3.fromRGB(10,12,14);ts.Color=Color3.new(1,1,1);ts.Transparency=0.95;ch.TextColor3=Color3.fromRGB(255,255,255);ch.TextTransparency=0.6
			if mn then AO(mn,{BackgroundTransparency=1});mn=nil end
		else
			isOpen=true;local ac=TM:GA();tf.BackgroundColor3=Color3.fromRGB(17,20,25);ts.Color=ac;ts.Transparency=0.5;ch.TextColor3=ac;ch.TextTransparency=0
			mn=U("Frame",{Size=UDim2.fromOffset(120,0),BackgroundColor3=Color3.fromRGB(12,15,19),BackgroundTransparency=0.02,BorderSizePixel=0,ZIndex=50,AutomaticSize=Enum.AutomaticSize.Y,ClipsDescendants=true},tf)
			UC(mn,6);US(mn,1,Color3.new(1,1,1),0.92);U("UIPadding",{PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,4)},mn)
			UL(mn,Enum.FillDirection.Vertical,0)
			for i=1,#opts do
				local o=opts[i];local sel=v==o
				local it=U("TextButton",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Text="",ZIndex=51},mn)
				if sel then it.BackgroundColor3=ac;it.BackgroundTransparency=0.92 end
				if sel then local id=U("Frame",{Size=UDim2.fromOffset(2,14),Position=UDim2.fromOffset(4,5),BackgroundColor3=ac,BorderSizePixel=0,ZIndex=52},it);UC(id,1)end
				local il=U("TextLabel",{Size=UDim2.new(1,-16,1,0),Position=UDim2.fromOffset(sel and 12 or 10,0),BackgroundTransparency=1,Text=o,TextColor3=sel and ac or Color3.fromRGB(255,255,255),TextSize=11,TextTransparency=sel and 0 or 0.4,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=51},it)
				it.MouseButton1Click:Connect(function()v=o;tl.Text=o;oc(o);isOpen=false;tf.BackgroundColor3=Color3.fromRGB(10,12,14);ts.Color=Color3.new(1,1,1);ts.Transparency=0.95;ch.TextColor3=Color3.fromRGB(255,255,255);ch.TextTransparency=0.6;if mn then AO(mn,{BackgroundTransparency=1});mn=nil end end)
				it.MouseEnter:Connect(function()if not sel then it.BackgroundTransparency=0.96;il.TextTransparency=0;TW(il,{Position=UDim2.fromOffset(14,0)},0.15)end end)
				it.MouseLeave:Connect(function()if not sel then it.BackgroundTransparency=1;il.TextTransparency=0.4;TW(il,{Position=UDim2.fromOffset(10,0)},0.15)end end)
			end
			AI(mn,{BackgroundTransparency=0.02})
		end
	end)
	tb.MouseEnter:Connect(function()if not isOpen then tf.BackgroundColor3=Color3.fromRGB(17,20,25)end end)
	tb.MouseLeave:Connect(function()if not isOpen then tf.BackgroundColor3=Color3.fromRGB(10,12,14)end end)
	return f
end

local function MKMD(p,TM,cfg)
	local l=cfg.Label or"Multi"
	local opts=cfg.Options or{}
	local v=cfg.Value or{}
	local oc=cfg.OnChange or function()end
	local function GD()
		if #v==0 then return"None"elseif #v==#opts then return"All selected"else return table.concat(v,", ")end
	end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	U("TextLabel",{Size=UDim2.new(1,-130,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(130,22),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local tf=U("Frame",{Size=UDim2.fromOffset(120,20),BackgroundColor3=Color3.fromRGB(10,12,14),BackgroundTransparency=0.05,BorderSizePixel=0},rc)
	UC(tf,6);local ts=US(tf,1,Color3.new(1,1,1),0.95)
	local tl=U("TextLabel",{Size=UDim2.new(1,-24,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=GD(),TextColor3=Color3.fromRGB(255,255,255),TextSize=11,TextTransparency=0.2,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},tf)
	local ch=U("TextLabel",{Size=UDim2.fromOffset(12,12),Position=UDim2.new(1,-14,0.5,-6),BackgroundTransparency=1,Text="▼",TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSans},tf)
	local isOpen=false;local mn=nil
	local tb=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=4},tf)
	local function TO(o)
		local nv={};local fnd=false
		for i=1,#v do if v[i]==o then fnd=true else nv[#nv+1]=v[i]end end
		if not fnd then nv[#nv+1]=o end
		v=nv;tl.Text=GD();oc(nv)
	end
	tb.MouseButton1Click:Connect(function()
		if isOpen then
			isOpen=false;tf.BackgroundColor3=Color3.fromRGB(10,12,14);ts.Color=Color3.new(1,1,1);ts.Transparency=0.95;ch.TextColor3=Color3.fromRGB(255,255,255);ch.TextTransparency=0.6
			if mn then AO(mn,{BackgroundTransparency=1});mn=nil end
		else
			isOpen=true;local ac=TM:GA();tf.BackgroundColor3=Color3.fromRGB(17,20,25);ts.Color=ac;ts.Transparency=0.5;ch.TextColor3=ac;ch.TextTransparency=0
			mn=U("Frame",{Size=UDim2.fromOffset(120,0),BackgroundColor3=Color3.fromRGB(12,15,19),BackgroundTransparency=0.02,BorderSizePixel=0,ZIndex=50,AutomaticSize=Enum.AutomaticSize.Y,ClipsDescendants=true},tf)
			UC(mn,6);US(mn,1,Color3.new(1,1,1),0.92);U("UIPadding",{PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,4)},mn)
			UL(mn,Enum.FillDirection.Vertical,0)
			for i=1,#opts do
				local o=opts[i];local sel=false;for j=1,#v do if v[j]==o then sel=true;break end end
				local it=U("TextButton",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Text="",ZIndex=51},mn)
				if sel then it.BackgroundColor3=ac;it.BackgroundTransparency=0.92 end
				if sel then local id=U("Frame",{Size=UDim2.fromOffset(2,14),Position=UDim2.fromOffset(4,5),BackgroundColor3=ac,BorderSizePixel=0,ZIndex=52},it);UC(id,1)end
				local il=U("TextLabel",{Size=UDim2.new(1,-30,1,0),Position=UDim2.fromOffset(sel and 12 or 10,0),BackgroundTransparency=1,Text=o,TextColor3=sel and ac or Color3.fromRGB(255,255,255),TextSize=11,TextTransparency=sel and 0 or 0.4,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=51},it)
				if sel then local cd=U("Frame",{Size=UDim2.fromOffset(6,6),Position=UDim2.new(1,-10,0.5,-3),BackgroundColor3=ac,BorderSizePixel=0,ZIndex=52},it);UC(cd,3)end
				it.MouseButton1Click:Connect(function()TO(o)end)
				it.MouseEnter:Connect(function()if not sel then it.BackgroundTransparency=0.96;il.TextTransparency=0;TW(il,{Position=UDim2.fromOffset(14,0)},0.15)end end)
				it.MouseLeave:Connect(function()if not sel then it.BackgroundTransparency=1;il.TextTransparency=0.4;TW(il,{Position=UDim2.fromOffset(10,0)},0.15)end end)
			end
			AI(mn,{BackgroundTransparency=0.02})
		end
	end)
	tb.MouseEnter:Connect(function()if not isOpen then tf.BackgroundColor3=Color3.fromRGB(17,20,25)end end)
	tb.MouseLeave:Connect(function()if not isOpen then tf.BackgroundColor3=Color3.fromRGB(10,12,14)end end)
	return f
end

local function MKTX(p,TM,cfg)
	local l=cfg.Label or"Input"
	local v=cfg.Value or""
	local oc=cfg.OnChange or function()end
	local pl=cfg.Placeholder or""
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	U("TextLabel",{Size=UDim2.new(1,-130,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(130,22),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local bg=U("Frame",{Size=UDim2.fromOffset(120,20),BackgroundColor3=Color3.fromRGB(9,12,14),BorderSizePixel=0},rc)
	UC(bg,4);local bs=US(bg,1,Color3.new(1,1,1),0.95)
	local ib=U("TextBox",{Size=UDim2.new(1,-8,1,0),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,Text=v,PlaceholderText=pl,TextColor3=Color3.new(1,1,1),PlaceholderColor3=Color3.fromRGB(255,255,255),TextSize=11,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false},bg)
	ib.FocusLost:Connect(function()v=ib.Text;oc(v);bs.Color=Color3.new(1,1,1);bs.Transparency=0.95 end)
	ib.Focused:Connect(function()local ac=TM:GA();bs.Color=ac;bs.Transparency=0.6 end)
	return f
end

local function MKKB(p,TM,cfg)
	local l=cfg.Label or"Keybind"
	local v=cfg.Value or"None"
	local oc=cfg.OnChange or function()end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	U("TextLabel",{Size=UDim2.new(1,-130,1,0),BackgroundTransparency=1,Text=l,TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
	local rc=U("Frame",{Size=UDim2.fromOffset(130,22),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,6);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	if cfg.HasOptions and cfg.OptionsWidget then cfg.OptionsWidget:GetContainer().Parent=rc end
	local lis=false;local cons={}
	local function CLR()
		lis=false
		for i=1,#cons do cons[i]:Disconnect()end;cons={}
		kb.BackgroundColor3=Color3.fromRGB(14,17,21);ks.Color=Color3.new(1,1,1);ks.Transparency=0.94
		kb.Text=v=="None"and"None"or CL(v);kb.TextColor3=Color3.fromRGB(255,255,255);kb.TextTransparency=0.3
	end
	local kb=U("TextButton",{Size=UDim2.fromOffset(60,16),BackgroundColor3=Color3.fromRGB(14,17,21),BorderSizePixel=0,Text=v=="None"and"None"or CL(v),TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.3,Font=Enum.Font.SourceSansBold,ZIndex=3},rc)
	UC(kb,3);ks=US(kb,1,Color3.new(1,1,1),0.94)
	kb.MouseButton1Click:Connect(function()
		if lis then return end;lis=true
		local ac=TM:GA();kb.Text="...";kb.BackgroundColor3=Color3.fromRGB(255,255,255);kb.BackgroundTransparency=0.8;ks.Color=ac;ks.Transparency=0.6;kb.TextColor3=ac;kb.TextTransparency=0
		local c1=UIS.InputBegan:Connect(function(ip,gp)
			if gp then return end;local cd=""
			if ip.UserInputType==Enum.UserInputType.Keyboard then
				if ip.KeyCode==Enum.KeyCode.Escape then v="None"else cd=ip.KeyCode.Name;v=cd end
			elseif ip.UserInputType==Enum.UserInputType.MouseButton1 then v="Mouse0"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton2 then v="Mouse1"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton3 then v="Mouse2"end
			oc(v);CLR()
		end)
		cons[#cons+1]=c1
		local c2=UIS.InputBegan:Connect(function(ip,gp)
			if gp or not lis then return end;local cd=""
			if ip.UserInputType==Enum.UserInputType.MouseButton1 then cd="Mouse0"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton2 then cd="Mouse1"
			elseif ip.UserInputType==Enum.UserInputType.MouseButton3 then cd="Mouse2"end
			if cd~="" then v=cd;oc(v);CLR()end
		end)
		cons[#cons+1]=c2
	end)
	return f
end

local function MKCP(p,TM,cfg)
	local v=cfg.Value or"#ffffff"
	local oc=cfg.OnChange or function()end
	local function H2R(h)
		h=h:gsub("#","")
		if #h==8 then h=h:sub(1,6)end
		if #h==3 then h=h:sub(1,1)..h:sub(1,1)..h:sub(2,2)..h:sub(2,2)..h:sub(3,3)..h:sub(3,3)end
		return tonumber(h:sub(1,2),16)/255,tonumber(h:sub(3,4),16)/255,tonumber(h:sub(5,6),16)/255
	end
	local function R2H(r,g,b) return string.format("#%02X%02X%02X",CLMP(math.floor(r*255+0.5),0,255),CLMP(math.floor(g*255+0.5),0,255),CLMP(math.floor(b*255+0.5),0,255))end
	local function R2HSV(r,g,b)
		local rn,gn,bn=r/255,g/255,b/255
		local mx,mm=math.max(rn,gn,bn),math.min(rn,gn,bn)
		local h,s,v2=0,0,mx
		if mx~=mm then
			local d=mx-mm;s=d/mx
			if mx==rn then h=(gn-bn)/d+(gn<bn and 6 or 0)
			elseif mx==gn then h=(bn-rn)/d+2
			else h=(rn-gn)/d+4 end
			h=h/6
		end
		return h,s,v2
	end
	local function HSV2R(h,s,v2)
		local i=math.floor(h*6);local f=h*6-i
		local p=v2*(1-s);local q=v2*(1-f*s);local t=v2*(1-(1-f)*s)
		i=i%6
		if i==0 then return v2*255,t*255,p*255
		elseif i==1 then return q*255,v2*255,p*255
		elseif i==2 then return p*255,v2*255,t*255
		elseif i==3 then return p*255,q*255,v2*255
		elseif i==4 then return t*255,p*255,v2*255
		else return v2*255,p*255,q*255 end
	end
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	if not cfg.Inline then
		U("TextLabel",{Size=UDim2.new(1,-90,1,0),BackgroundTransparency=1,Text=cfg.Label or"Color",TextColor3=Color3.fromRGB(255,255,255),TextSize=12,TextTransparency=0.15,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left},f)
	end
	local r,g,b=H2R(v)
	local pb=U("TextButton",{Size=cfg.Inline and UDim2.fromOffset(18,12)or UDim2.fromOffset(24,12),Position=cfg.Inline and UDim2.new(1,-18,0.5,-6)or UDim2.new(1,-90,0.5,-6),BackgroundColor3=Color3.fromRGB(r*255,g*255,b*255),BorderSizePixel=0,Text="",ZIndex=3},f)
	UC(pb,3);US(pb,1,Color3.new(1,1,1),0.9)
	U("UIGradient",{Color=ColorSequence.new(Color3.new(1,1,1)),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.85),NumberSequenceKeypoint.new(1,1)}),Rotation=90},pb)
	local isOpen=false;local mn=nil;local dS,dH=false,false
	pb.MouseButton1Click:Connect(function()
		if isOpen then
			isOpen=false;dS=false;dH=false
			if mn then AO(mn,{BackgroundTransparency=1});mn=nil end
		else
			isOpen=true
			mn=U("Frame",{Size=UDim2.fromOffset(220,0),Position=UDim2.new(1,0,0,20),AnchorPoint=Vector2.new(1,0),BackgroundColor3=Color3.fromRGB(18,21,25),BackgroundTransparency=0.02,BorderSizePixel=0,ZIndex=70,AutomaticSize=Enum.AutomaticSize.Y},f)
			UC(mn,8);US(mn,1,Color3.new(1,1,1),0.9);U("UIPadding",{PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10)},mn)
			local r2,g2,b2=H2R(v);local h,sv,vv=R2HSV(r2*255,g2*255,b2*255)
			local sq=U("Frame",{Size=UDim2.new(1,-20,0,120),BackgroundTransparency=1,ZIndex=71},mn)
			local so=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromHSV(h,1,1),BorderSizePixel=0,ZIndex=72},sq)
			U("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)}),Rotation=90},so)
			local si=U("Frame",{Size=UDim2.fromOffset(11,11),Position=UDim2.fromOffset(math.floor(sv*100),math.floor((1-vv)*100)),BackgroundTransparency=1,BorderColor3=Color3.new(1,1,1),BorderSizePixel=1,ZIndex=73},sq);UC(si,6)
			local sb=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=75},sq)
			local function USM(i)
				local ax=sq.AbsolutePosition;local as=sq.AbsoluteSize
				local rx=CLMP((i.Position.X-ax.X)/as.X,0,1);local ry=CLMP((i.Position.Y-ax.Y)/as.Y,0,1)
				local nh,_,_=R2HSV(r2*255,g2*255,b2*255)
				local nr,ng,nb=HSV2R(nh,rx,1-ry)
				v=R2H(nr/255,ng/255,nb/255);pb.BackgroundColor3=Color3.fromRGB(nr,ng,nb);si.Position=UDim2.fromOffset(math.floor(rx*100),math.floor(ry*100));oc(v)
			end
			sb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dS=true;USM(i)end end)
			sb.InputChanged:Connect(function(i)if dS then USM(i)end end)
			sb.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dS=false end end)
			local hb=U("Frame",{Size=UDim2.new(1,-20,0,9),Position=UDim2.fromOffset(0,136),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=71},mn);UC(hb,3)
			U("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,0,0)),ColorSequenceKeypoint.new(0.17,Color3.new(1,1,0)),ColorSequenceKeypoint.new(0.33,Color3.new(0,1,0)),ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)),ColorSequenceKeypoint.new(0.67,Color3.new(0,0,1)),ColorSequenceKeypoint.new(0.83,Color3.new(1,0,1)),ColorSequenceKeypoint.new(1,Color3.new(1,0,0))})},hb)
			local hi=U("Frame",{Size=UDim2.fromOffset(11,11),Position=UDim2.fromOffset(math.floor(h*200),-1),BackgroundTransparency=1,BorderColor3=Color3.new(1,1,1),BorderSizePixel=1,ZIndex=73},hb);UC(hi,6)
			local hbtn=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=75},hb)
			local function UHM(i)
				local ax=hb.AbsolutePosition;local as=hb.AbsoluteSize
				local rx=CLMP((i.Position.X-ax.X)/as.X,0,1)
				local _,cs,cv=R2HSV(r2*255,g2*255,b2*255)
				local nr,ng,nb=HSV2R(rx,cs,cv)
				v=R2H(nr/255,ng/255,nb/255);pb.BackgroundColor3=Color3.fromRGB(nr,ng,nb);so.BackgroundColor3=Color3.fromHSV(rx,1,1);hi.Position=UDim2.fromOffset(math.floor(rx*200),-1);oc(v)
			end
			hbtn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dH=true;UHM(i)end end)
			hbtn.InputChanged:Connect(function(i)if dH then UHM(i)end end)
			hbtn.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dH=false end end)
			local hxf=U("Frame",{Size=UDim2.new(1,-20,0,20),Position=UDim2.fromOffset(0,154),BackgroundTransparency=1,ZIndex=71},mn)
			U("TextLabel",{Size=UDim2.fromOffset(30,20),BackgroundTransparency=1,Text="HEX",TextColor3=Color3.fromRGB(255,255,255),TextSize=9,TextTransparency=0.6,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},hxf)
			local hx=U("TextBox",{Size=UDim2.new(1,-30,1,0),Position=UDim2.fromOffset(30,0),BackgroundColor3=Color3.fromRGB(9,12,14),BorderSizePixel=0,Text=v:upper(),TextColor3=Color3.new(1,1,1),TextSize=10,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=72},hxf)
			UC(hx,3);US(hx,1,Color3.new(1,1,1),0.95)
			hx.FocusLost:Connect(function()
				local val=hx.Text
				if val:sub(1,1)~="#" then val="#"<<val end
				if #val==4 or #val==5 or #val==7 or #val==9 then
					local cr,cg,cb=H2R(val);v=val:upper()
					pb.BackgroundColor3=Color3.fromRGB(cr*255,cg*255,cb*255)
					local ch,cs,cv=R2HSV(cr*255,cg*255,cb*255)
					so.BackgroundColor3=Color3.fromHSV(ch,1,1);si.Position=UDim2.fromOffset(math.floor(cs*100),math.floor((1-cv)*100));hi.Position=UDim2.fromOffset(math.floor(ch*200),-1);oc(v)
				end;hx.Text=v:upper()
			end)
			AI(mn,{BackgroundTransparency=0.02})
		end
	end)
	return f
end

local function MKB(p,TM,cfg)
	local f=U("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1},p)
	local ac=TM:GA()
	local bgc,tc,bdc,btr
	if cfg.Variant=="primary"then bgc=ac;tc=ac;bdc=ac;btr=0.6
	elseif cfg.Variant=="danger"then bgc=Color3.fromRGB(255,50,50);tc=Color3.fromRGB(255,50,50);bdc=Color3.fromRGB(255,50,50);btr=0.7
	else bgc=Color3.fromRGB(14,17,21);tc=Color3.fromRGB(255,255,255);bdc=Color3.new(1,1,1);btr=0.94 end
	local bt=U("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundColor3=bgc,BackgroundTransparency=cfg.Variant=="secondary"and 0 or 0.8,BorderSizePixel=0,Text=cfg.Label,TextColor3=tc,TextSize=11,TextTransparency=cfg.Variant=="secondary"and 0.3 or 0,Font=Enum.Font.SourceSansSemiBold,ZIndex=2},f)
	UC(bt,6);US(bt,1,bdc,btr)
	bt.MouseButton1Click:Connect(function()cfg.OnClick()local sc=U("UIScale",{Scale=0.95},bt);task.delay(0.08,function()if sc then TW(sc,{Scale=1},0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out)end end)end)
	return f
end

local function MKNM(TM,SC,p)
	local c=U("Frame",{Size=UDim2.fromOffset(210,0),Position=UDim2.new(1,-24,1,-24),AnchorPoint=Vector2.new(0,1),BackgroundTransparency=1,ZIndex=100,ClipsDescendants=true},p)
	UL(c,Enum.FillDirection.Vertical,6)
	local ns={};local rk={}
	local IC={"success","warning","error","info","toggle_on","toggle_off"}
	local IS={success="✔",warning="▲",error="✘",info="ℹ",toggle_on="✔",toggle_off="✘"}
	local GC={success=Color3.fromRGB(52,211,153),warning=Color3.fromRGB(251,191,36),error=Color3.fromRGB(244,63,94),info=nil,toggle_on=Color3.fromRGB(52,211,153),toggle_off=Color3.fromRGB(244,63,94)}
	local ixn=SC.NE.Event:Connect(function(d)
		local k=d.Title..":"..d.Text..":"..d.Type
		local n=tick()
		if rk[k]and n-rk[k]<0.4 then return end;rk[k]=n
		local ac=TM:GA()
		local gc=GC[d.Type]or ac
		local f2=U("Frame",{Size=UDim2.new(1,0,0,0),BackgroundColor3=Color3.fromRGB(10,13,16),BackgroundTransparency=0.05,BorderSizePixel=0,ZIndex=100},c)
		UC(f2,12);US(f2,1,Color3.new(1,1,1),0.8)
		local i2=U("Frame",{Size=UDim2.new(1,-8,0,0),Position=UDim2.fromOffset(4,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},f2)
		local ly2=UL(i2,Enum.FillDirection.Horizontal,6)
		U("TextLabel",{Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,Text=IS[d.Type]or"ℹ",TextColor3=IC[d.Type]and Color3.new(1,1,1)or ac,TextSize=14,Font=Enum.Font.SourceSans,TextTransparency=0.25},i2)
		local tc2=U("Frame",{Size=UDim2.new(1,-22,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1},i2)
		local tly=UL(tc2,Enum.FillDirection.Vertical,2)
		U("TextLabel",{Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text=d.Title,TextColor3=Color3.new(1,1,1),TextSize=10,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},tc2)
		local tl2=U("TextLabel",{Size=UDim2.new(1,0,0,12),BackgroundTransparency=1,Text=d.Text,TextColor3=Color3.fromRGB(255,255,255),TextSize=9,TextTransparency=0.3,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true},tc2)
		local cl=U("TextButton",{Size=UDim2.fromOffset(14,14),Position=UDim2.new(1,-18,0,2),BackgroundTransparency=1,Text="×",TextColor3=Color3.fromRGB(255,255,255),TextSize=12,Font=Enum.Font.SourceSansBold,TextTransparency=0.75,ZIndex=101},i2)
		local th2=tl2.TextBounds.Y+14+8
		f2.Size=UDim2.new(1,0,0,math.max(th2,30))
		AI(f2,{BackgroundTransparency=0.05},0.2)
		table.insert(ns,f2)
		cl.MouseButton1Click:Connect(function()for i=#ns,1,-1 do if ns[i]==f2 then table.remove(ns,i);AO(f2,{BackgroundTransparency=1})break end end end)
		task.delay(d.Duration/1000,function()for i=#ns,1,-1 do if ns[i]==f2 then table.remove(ns,i);AO(f2,{BackgroundTransparency=1})break end end end)
	end)
	return c
end

local function MKHU(TM,SC,p,cfg)
	local f=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ZIndex=0},p)
	local isL=(cfg.Position or"Top-Right")=="Top-Left"
	local wg=U("Frame",{Size=UDim2.new(0,0,0,0),Position=isL and UDim2.fromOffset(16,16)or UDim2.new(1,-16,0,16),AnchorPoint=isL and Vector2.new(0,0)or Vector2.new(1,0),BackgroundColor3=Color3.fromRGB(10,13,16),BackgroundTransparency=0.1,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X},f)
	UC(wg,4);US(wg,1,Color3.new(1,1,1),0.95)
	U("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6)},wg)
	local inl=UL(wg,Enum.FillDirection.Horizontal,12);inl.HorizontalAlignment=Enum.HorizontalAlignment.Center;inl.VerticalAlignment=Enum.VerticalAlignment.Center
	local tb=U("TextButton",{Size=UDim2.fromOffset(0,16),BackgroundTransparency=1,Text="Bullet.lua",TextColor3=TM:GA(),TextSize=12,Font=Enum.Font.SourceSansBold,AutomaticSize=Enum.AutomaticSize.X},wg)
	tb.MouseButton1Click:Connect(cfg.OnToggleVisibility)
	U("Frame",{Size=UDim2.fromOffset(1,12),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.9,BorderSizePixel=0},wg)
	local fps=U("TextLabel",{Size=UDim2.fromOffset(0,16),BackgroundTransparency=1,Text="144 FPS",TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.3,Font=Enum.Font.SourceSans,AutomaticSize=Enum.AutomaticSize.X},wg)
	U("Frame",{Size=UDim2.fromOffset(1,12),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.9,BorderSizePixel=0},wg)
	local tml=U("TextLabel",{Size=UDim2.fromOffset(0,16),BackgroundTransparency=1,Text=os.date("%H:%M:%S"),TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.5,Font=Enum.Font.SourceSans,AutomaticSize=Enum.AutomaticSize.X},wg)
	task.spawn(function()while task.wait(1)do tml.Text=os.date("%H:%M:%S")end end)
	task.spawn(function()while task.wait(2)do fps.Text=math.random(142,165).." FPS"end end)
	local sc=nil
	function f:SV(v)wg.Visible=v end
	TM:OC(function(t)tb.TextColor3=t.P end)
	return f
end

local function MKSB(TM,pr,cfg)
	local f=U("Frame",{Size=UDim2.fromOffset(200,600),BackgroundColor3=Color3.fromRGB(9,11,13),BorderSizePixel=0},pr)
	U("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0},f)
	local ct=U("Frame",{Size=UDim2.new(1,-24,1,-32),Position=UDim2.fromOffset(12,16),BackgroundTransparency=1},f)
	UL(ct,Enum.FillDirection.Vertical,14)
	U("TextLabel",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Text="BULLET.LUA",TextColor3=Color3.new(1,1,1),TextSize=18,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},ct)
	local tabs={};local ind=nil
	for ni=1,#Nav do
		local ns2=Nav[ni]
		U("TextLabel",{Size=UDim2.new(1,-10,0,14),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=ns2.C,TextColor3=Color3.fromRGB(98,106,115),TextSize=9,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},ct)
		local lf=U("Frame",{Size=UDim2.new(1,0,0,#ns2.I*28),BackgroundTransparency=1},ct)
		UL(lf,Enum.FillDirection.Vertical,1)
		for ii=1,#ns2.I do
			local item=ns2.I[ii];local act=cfg.AT==item.I
			local ic=U("Frame",{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1},lf)
			if act then
				ind=U("Frame",{Size=UDim2.fromOffset(2,18),Position=UDim2.fromOffset(0,4),BackgroundColor3=TM:GA(),BorderSizePixel=0,ZIndex=10},ic);UC(ind,1)
			end
			local btn=U("TextButton",{Size=UDim2.new(1,-12,1,0),Position=UDim2.fromOffset(12,0),BackgroundColor3=act and Color3.fromRGB(255,255,255)or Color3.new(0,0,0),BackgroundTransparency=act and 0.95 or 1,BorderSizePixel=0,Text="",ZIndex=2},ic)
			UC(btn,4)
			local bl=U("TextLabel",{Size=UDim2.new(1,-12,1,0),Position=UDim2.fromOffset(12,0),BackgroundTransparency=1,Text=item.L,TextColor3=act and Color3.new(1,1,1)or Color3.fromRGB(98,106,115),TextSize=12,Font=Enum.Font.SourceSansSemiBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},btn)
			btn.MouseButton1Click:Connect(function()cfg.OTC(item.I)end)
			btn.MouseEnter:Connect(function()if not act then btn.BackgroundTransparency=0.99;TW(bl,{TextColor3=Color3.new(1,1,1)},0.15)end end)
			btn.MouseLeave:Connect(function()if not act then btn.BackgroundTransparency=1;TW(bl,{TextColor3=Color3.fromRGB(98,106,115)},0.2)end end)
			tabs[item.I]={B=btn,L=bl,C=ic}
		end
	end
	function f:ST(tid)
		local ac=TM:GA()
		for id,d in pairs(tabs)do
			local act2=id==tid
			if act2 then
				d.B.BackgroundColor3=Color3.fromRGB(255,255,255);d.B.BackgroundTransparency=0.95;d.L.TextColor3=Color3.new(1,1,1)
				if ind then ind:Destroy()end
				ind=U("Frame",{Size=UDim2.fromOffset(2,18),Position=UDim2.fromOffset(0,4),BackgroundColor3=ac,BorderSizePixel=0,ZIndex=10},d.C);UC(ind,1)
				TW(ind,{Size=UDim2.fromOffset(2,18)},0.3,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out)
			else d.B.BackgroundTransparency=1;d.L.TextColor3=Color3.fromRGB(98,106,115)end
		end
	end
	return f
end

local function MKTB(TM,SC,pr,cfg)
	local f=U("Frame",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1},pr)
	local rc=U("Frame",{Size=UDim2.fromOffset(160,24),Position=UDim2.new(1,-160,0,0),BackgroundTransparency=1},f)
	local rl=UL(rc,Enum.FillDirection.Horizontal,8);rl.HorizontalAlignment=Enum.HorizontalAlignment.Right;rl.VerticalAlignment=Enum.VerticalAlignment.Center
	local sc2=U("Frame",{Size=UDim2.fromOffset(0,24),BackgroundTransparency=1,ClipsDescendants=true},rc)
	local ibg=U("Frame",{Size=UDim2.fromOffset(0,20),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0,Visible=false},sc2)
	UC(ibg,4);US(ibg,1,Color3.new(1,1,1),0.95)
	local sbx=U("TextBox",{Size=UDim2.new(1,-8,1,0),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,PlaceholderText="Search...",Text="",TextColor3=Color3.new(1,1,1),PlaceholderColor3=Color3.fromRGB(255,255,255),TextSize=11,Font=Enum.Font.SourceSans,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false},ibg)
	local sact=false
	sbx.FocusLost:Connect(function()if sbx.Text==""then sact=false;ibg.Visible=false;TW(ibg,{Size=UDim2.fromOffset(0,20)},0.15)if SC then SC:SetQ("")end end end)
	local sbtn=U("TextButton",{Size=UDim2.fromOffset(24,24),BackgroundTransparency=1,Text="🔍",TextColor3=Color3.fromRGB(98,106,115),TextSize=14,Font=Enum.Font.SourceSans},sc2)
	sbtn.MouseButton1Click:Connect(function()
		if not sact then sact=true;ibg.Visible=true;TW(ibg,{Size=UDim2.fromOffset(120,20)},0.2);sbx:CaptureFocus()
		else sact=false;ibg.Visible=false;TW(ibg,{Size=UDim2.fromOffset(0,20)},0.15)if SC then SC:SetQ("")end end
	end)
	sbtn.MouseEnter:Connect(function()sbtn.TextColor3=Color3.new(1,1,1)end)
	sbtn.MouseLeave:Connect(function()if not sact then sbtn.TextColor3=Color3.fromRGB(98,106,115)end end)
	local sbtn2=U("TextButton",{Size=UDim2.fromOffset(24,24),BackgroundTransparency=1,Text="⚙",TextColor3=Color3.fromRGB(98,106,115),TextSize=14,Font=Enum.Font.SourceSans},rc)
	sbtn2.MouseButton1Click:Connect(cfg.OTS)
	sbtn2.MouseEnter:Connect(function()sbtn2.TextColor3=Color3.new(1,1,1)end)
	sbtn2.MouseLeave:Connect(function()sbtn2.TextColor3=Color3.fromRGB(98,106,115)end)
	return f
end

local function MKCPanel(TM,SC,pr)
	local f=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pr);f.ClipsDescendants=true
	local cols=U("Frame",{Size=UDim2.new(1,8,1,0),BackgroundTransparency=1},f)
	U("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,16)},cols)
	local c1=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local c2=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local st=SC:GA()
	local function MQ(t)local q=SC:GQ()return q==""or t:lower():find(q:lower(),1,true)end
	local function SC2(par,ttl)
		local s=U("Frame",{Size=UDim2.new(1,0,0,0),BackgroundColor3=Color3.fromRGB(14,17,21),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y},par)
		UC(s,8);US(s,1,Color3.new(1,1,1),0.95);U("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12)},s)
		U("TextLabel",{Size=UDim2.new(1,-8,0,14),Position=UDim2.fromOffset(4,0),BackgroundTransparency=1,Text=ttl,TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},s)
		local ct=U("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.fromOffset(0,20),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},s)
		UL(ct,Enum.FillDirection.Vertical,6)
		return ct
	end
	-- Ragebot
	local rct=SC2(c1,"Ragebot (General)")
	if MQ("Enable Ragebot")then
		local go=MKGO(rct,TM)
		local kb=MKKB(rct,TM,{Label="Keybind",Value=st.Keybinds["rage.enable"]or"None",OnChange=function(v)SC:UK("rage.enable",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(rct,TM,{Label="Enable Ragebot",Checked=st.Rage.Enable,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("Rage","Enable",v)end})
	end
	if st.Rage.Enable then
		if MQ("FOV")then MKTX(rct,TM,{Label="FOV",Value=tostring(st.Rage.Fov)})end
		if MQ("Silent Aim")then MKTG(rct,TM,{Label="Silent Aim",Checked=st.Rage.SilentAim,OnChange=function(v)SC:US("Rage","SilentAim",v)end})end
		if MQ("Auto Fire")then MKTG(rct,TM,{Label="Auto Fire",Checked=st.Rage.AutoFire,OnChange=function(v)SC:US("Rage","AutoFire",v)end})end
		if MQ("Auto Scope")then MKTG(rct,TM,{Label="Auto Scope",Checked=st.Rage.AutoScope,OnChange=function(v)SC:US("Rage","AutoScope",v)end})end
		if MQ("Auto Wall")then MKTG(rct,TM,{Label="Auto Wall",Checked=st.Rage.AutoWall,OnChange=function(v)SC:US("Rage","AutoWall",v)end})end
		if MQ("Minimum Damage")then MKSL(rct,TM,{Label="Minimum Damage",Value=st.Rage.MinDamage,Min=0,Max=130,OnChange=function(v)SC:US("Rage","MinDamage",v)end})end
		if MQ("Hit Chance")then MKSL(rct,TM,{Label="Hit Chance",Value=st.Rage.HitChance,Min=0,Max=100,OnChange=function(v)SC:US("Rage","HitChance",v)end})end
	end
	-- Legitbot
	local lct=SC2(c2,"Legitbot")
	if MQ("Enable Legitbot")then
		local go=MKGO(lct,TM)
		local kb=MKKB(lct,TM,{Label="Keybind",Value=st.Keybinds["legit.enable"]or"None",OnChange=function(v)SC:UK("legit.enable",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(lct,TM,{Label="Enable Legitbot",Checked=st.Legit.Enable,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("Legit","Enable",v)end})
	end
	if st.Legit.Enable then
		if MQ("Smooth")then MKSL(lct,TM,{Label="Smooth",Value=st.Legit.Smooth,Min=1,Max=20,OnChange=function(v)SC:US("Legit","Smooth",v)end})end
		if MQ("RCS (Recoil Control)")then MKTG(lct,TM,{Label="RCS (Recoil Control)",Checked=st.Legit.Rcs,OnChange=function(v)SC:US("Legit","Rcs",v)end})end
		if MQ("Triggerbot")then MKTG(lct,TM,{Label="Triggerbot",Checked=st.Legit.Triggerbot,OnChange=function(v)SC:US("Legit","Triggerbot",v)end})end
	end
	-- Target Selection
	if st.Rage.Enable then
		local tct=SC2(c2,"Target Selection (Rage)")
		if MQ("Target Priority")then MKDD(tct,TM,{Label="Target Priority",Value=st.Rage.TargetPriority,Options={"Field of View","Lowest Health","Highest Damage","Distance"},OnChange=function(v)SC:US("Rage","TargetPriority",v)end})end
		if MQ("Hitbox")then MKDD(tct,TM,{Label="Hitbox",Value=st.Rage.Hitbox,Options={"Head","Chest","Stomach","Pelvis","Legs","Arms"},OnChange=function(v)SC:US("Rage","Hitbox",v)end})end
		if MQ("Multi-Point")then MKTG(tct,TM,{Label="Multi-Point",Checked=st.Rage.MultiPoint,OnChange=function(v)SC:US("Rage","MultiPoint",v)end})end
		if st.Rage.MultiPoint and MQ("Multi-Point Scale")then MKSL(tct,TM,{Label="Multi-Point Scale",Value=st.Rage.MultiPointScale,Min=1,Max=100,OnChange=function(v)SC:US("Rage","MultiPointScale",v)end})end
	end
	return f
end

local function MKVPanel(TM,SC,pr)
	local f=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pr);f.ClipsDescendants=true
	local cols=U("Frame",{Size=UDim2.new(1,8,1,0),BackgroundTransparency=1},f)
	U("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,16)},cols)
	local c1=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local c2=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local st=SC:GA()
	local function MQ(t)local q=SC:GQ()return q==""or t:lower():find(q:lower(),1,true)end
	local function SC2(par,ttl)
		local s=U("Frame",{Size=UDim2.new(1,0,0,0),BackgroundColor3=Color3.fromRGB(14,17,21),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y},par)
		UC(s,8);US(s,1,Color3.new(1,1,1),0.95);U("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12)},s)
		U("TextLabel",{Size=UDim2.new(1,-8,0,14),Position=UDim2.fromOffset(4,0),BackgroundTransparency=1,Text=ttl,TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},s)
		local ct=U("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.fromOffset(0,20),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},s)
		UL(ct,Enum.FillDirection.Vertical,6)
		return ct
	end
	local ect=SC2(c1,"ESP Features")
	if MQ("Enable ESP")then
		local go=MKGO(ect,TM);local kb=MKKB(ect,TM,{Label="Keybind",Value=st.Keybinds["players.enableESP"]or"None",OnChange=function(v)SC:UK("players.enableESP",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(ect,TM,{Label="Enable ESP",Checked=st.Players.EnableESP,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("Players","EnableESP",v)end})
	end
	if st.Players.EnableESP then
		if MQ("Bounding Box")then MKTG(ect,TM,{Label="Bounding Box",Checked=st.Players.BoxEsp,HasColor=true,ColorValue=st.Players.BoxColor,OnChange=function(v)SC:US("Players","BoxEsp",v)end})end
		if MQ("Health Bar")then MKTG(ect,TM,{Label="Health Bar",Checked=st.Players.HealthBar,OnChange=function(v)SC:US("Players","HealthBar",v)end})end
		if MQ("Player Name")then MKTG(ect,TM,{Label="Player Name",Checked=st.Players.NameEsp,HasColor=true,ColorValue=st.Players.NameColor,OnChange=function(v)SC:US("Players","NameEsp",v)end})end
		if MQ("Skeleton")then MKTG(ect,TM,{Label="Skeleton",Checked=st.Players.Skeleton,HasColor=true,ColorValue=st.Players.SkeletonColor,OnChange=function(v)SC:US("Players","Skeleton",v)end})end
	end
	local hct=SC2(c2,"Indicators & HUD")
	if MQ("Show HUD")then MKTG(hct,TM,{Label="Show HUD",Checked=st.Antiaim.Other.ShowHUD,OnChange=function(v)SC:UAO("ShowHUD",v)end})end
	if MQ("Watermark")then MKTG(hct,TM,{Label="Watermark",Checked=st.MainMisc.Watermark,OnChange=function(v)SC:US("MainMisc","Watermark",v)end})end
	if MQ("Spectator List")then
		local go=MKGO(hct,TM);local kb=MKKB(hct,TM,{Label="Keybind",Value=st.Keybinds["mainMisc.spectators"]or"None",OnChange=function(v)SC:UK("mainMisc.spectators",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(hct,TM,{Label="Spectator List",Checked=st.MainMisc.Spectators,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("MainMisc","Spectators",v)end})
	end
	if MQ("Third Person Mode")then
		local go=MKGO(hct,TM);local kb=MKKB(hct,TM,{Label="Keybind",Value=st.Antiaim.Other.ThirdPersonKey,OnChange=function(v)SC:UAO("ThirdPersonKey",v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(hct,TM,{Label="Third Person Mode",Checked=st.Antiaim.Other.ThirdPersonKey~="None",HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAO("ThirdPersonKey",v and"M4"or"None")end})
	end
	return f
end

local function MKMPanel(TM,SC,pr)
	local f=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pr);f.ClipsDescendants=true
	local cols=U("Frame",{Size=UDim2.new(1,8,1,0),BackgroundTransparency=1},f)
	U("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,16)},cols)
	local c1=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local c2=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local st=SC:GA()
	local function MQ(t)local q=SC:GQ()return q==""or t:lower():find(q:lower(),1,true)end
	local function SC2(par,ttl)
		local s=U("Frame",{Size=UDim2.new(1,0,0,0),BackgroundColor3=Color3.fromRGB(14,17,21),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y},par)
		UC(s,8);US(s,1,Color3.new(1,1,1),0.95);U("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12)},s)
		U("TextLabel",{Size=UDim2.new(1,-8,0,14),Position=UDim2.fromOffset(4,0),BackgroundTransparency=1,Text=ttl,TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},s)
		local ct=U("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.fromOffset(0,20),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},s)
		UL(ct,Enum.FillDirection.Vertical,6)
		return ct
	end
	local cct=SC2(c1,"Core Helper")
	if MQ("Bunny Hop")then
		local go=MKGO(cct,TM);local kb=MKKB(cct,TM,{Label="Keybind",Value=st.Keybinds["mainMisc.bhop"]or"None",OnChange=function(v)SC:UK("mainMisc.bhop",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(cct,TM,{Label="Bunny Hop",Checked=st.MainMisc.Bhop,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("MainMisc","Bhop",v)end})
	end
	if MQ("Auto Jump")then
		local go=MKGO(cct,TM)
		local md=MKDD(cct,TM,{Label="Mode",Value=st.Antiaim.Movement.AutoJumpMode or"Normal",Options={"Normal","Always"},OnChange=function(v)SC:UAM("AutoJumpMode",v)end});md.Visible=false;go.AddChild(md)
		local ok=MKTG(cct,TM,{Label="On Key",Checked=st.Antiaim.Movement.AutoJumpOnKey or false,OnChange=function(v)SC:UAM("AutoJumpOnKey",v)end});ok.Visible=false;go.AddChild(ok)
		local kb=MKKB(cct,TM,{Label="Keybind",Value=st.Keybinds["antiaim.movement.autoJump"]or"None",OnChange=function(v)SC:UK("antiaim.movement.autoJump",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb)
		MKTG(cct,TM,{Label="Auto Jump",Checked=st.Antiaim.Movement.AutoJump,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAM("AutoJump",v)end})
	end
	if MQ("Auto Strafe")then
		local go=MKGO(cct,TM);local ss=MKSL(cct,TM,{Label="Smoothness",Value=st.Antiaim.Movement.AutoStrafeSmoothness or 50,Min=0,Max=100,OnChange=function(v)SC:UAM("AutoStrafeSmoothness",v)end})
		ss.Visible=false;go.AddChild(ss)
		MKTG(cct,TM,{Label="Auto Strafe",Checked=st.Antiaim.Movement.AutoStrafe,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAM("AutoStrafe",v)end})
	end
	if MQ("Quick Stop")then MKTG(cct,TM,{Label="Quick Stop",Checked=st.Antiaim.Movement.QuickStop,OnChange=function(v)SC:UAM("QuickStop",v)end})end
	if MQ("Strafe Assist")then MKTG(cct,TM,{Label="Strafe Assist",Checked=st.Antiaim.Movement.StrafeAssist,OnChange=function(v)SC:UAM("StrafeAssist",v)end})end
	local tct=SC2(c2,"Tactical Movement")
	if MQ("Auto Peek")then
		local go=MKGO(tct,TM);local kb=MKKB(tct,TM,{Label="Keybind",Value=st.Keybinds["antiaim.movement.autoPeek"]or"None",OnChange=function(v)SC:UK("antiaim.movement.autoPeek",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb);MKTG(tct,TM,{Label="Auto Peek",Checked=st.Antiaim.Movement.AutoPeek,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAM("AutoPeek",v)end})
	end
	if MQ("Edge Jump")then MKTG(tct,TM,{Label="Edge Jump",Checked=st.Antiaim.Movement.EdgeJump,OnChange=function(v)SC:UAM("EdgeJump",v)end})end
	if MQ("Infinity Duck")then
		local go=MKGO(tct,TM);local kb=MKKB(tct,TM,{Label="Keybind",Value=st.Keybinds["antiaim.movement.infinityDuck"]or"None",OnChange=function(v)SC:UK("antiaim.movement.infinityDuck",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb);MKTG(tct,TM,{Label="Infinity Duck",Checked=st.Antiaim.Movement.InfinityDuck,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAM("InfinityDuck",v)end})
	end
	if MQ("Blockbot")then MKTG(tct,TM,{Label="Blockbot",Checked=st.Antiaim.Movement.Blockbot,OnChange=function(v)SC:UAM("Blockbot",v)end})end
	return f
end

local function MKEPanel(TM,SC,pr)
	local f=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pr);f.ClipsDescendants=true
	local cols=U("Frame",{Size=UDim2.new(1,8,1,0),BackgroundTransparency=1},f)
	U("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,16)},cols)
	local c1=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local c2=U("Frame",{Size=UDim2.new(0.5,-8,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},cols)
	local st=SC:GA()
	local function MQ(t)local q=SC:GQ()return q==""or t:lower():find(q:lower(),1,true)end
	local function SC2(par,ttl)
		local s=U("Frame",{Size=UDim2.new(1,0,0,0),BackgroundColor3=Color3.fromRGB(14,17,21),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y},par)
		UC(s,8);US(s,1,Color3.new(1,1,1),0.95);U("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12)},s)
		U("TextLabel",{Size=UDim2.new(1,-8,0,14),Position=UDim2.fromOffset(4,0),BackgroundTransparency=1,Text=ttl,TextColor3=Color3.fromRGB(255,255,255),TextSize=10,TextTransparency=0.6,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},s)
		local ct=U("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.fromOffset(0,20),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},s)
		UL(ct,Enum.FillDirection.Vertical,6)
		return ct
	end
	local cct=SC2(c1,"Combat Exploits")
	if MQ("Resolver")then MKTG(cct,TM,{Label="Resolver",Checked=st.Rage.Resolver,OnChange=function(v)SC:US("Rage","Resolver",v)end})end
	if MQ("Safe Point")then
		local go=MKGO(cct,TM);local kb=MKKB(cct,TM,{Label="Keybind",Value=st.Keybinds["rage.safePoint"]or"None",OnChange=function(v)SC:UK("rage.safePoint",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb);MKTG(cct,TM,{Label="Safe Point",Checked=st.Rage.SafePoint,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("Rage","SafePoint",v)end})
	end
	if MQ("Force Baim")then
		local go=MKGO(cct,TM);local kb=MKKB(cct,TM,{Label="Keybind",Value=st.Keybinds["rage.forceBaim"]or"None",OnChange=function(v)SC:UK("rage.forceBaim",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb);MKTG(cct,TM,{Label="Force Baim",Checked=st.Rage.ForceBaim,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:US("Rage","ForceBaim",v)end})
	end
	if MQ("Anti Untrusted")then
		local go=MKGO(cct,TM);local kb=MKKB(cct,TM,{Label="Keybind",Value=st.Keybinds["antiaim.other.antiUntrusted"]or"None",OnChange=function(v)SC:UK("antiaim.other.antiUntrusted",v=="None"and nil or v)end})
		kb.Visible=false;go.AddChild(kb);MKTG(cct,TM,{Label="Anti Untrusted",Checked=st.Antiaim.Other.AntiUntrusted,HasOptions=true,OptionsWidget=go,OnChange=function(v)SC:UAO("AntiUntrusted",v)end})
	end
	local nct=SC2(c2,"Network & Utility")
	if MQ("Fake Ping")then MKSL(nct,TM,{Label="Fake Ping",Value=st.Antiaim.Other.FakePing,Min=0,Max=200,OnChange=function(v)SC:UAO("FakePing",v)end})end
	if MQ("Clan Tag")then MKTX(nct,TM,{Label="Clan Tag",Value=st.Antiaim.Other.ClanTag,Placeholder="neverlose...",OnChange=function(v)SC:UAO("ClanTag",v)end})end
	if MQ("Fast Weapon Switch")then MKTG(nct,TM,{Label="Fast Weapon Switch",Checked=st.Antiaim.Other.FastWeaponSwitch,OnChange=function(v)SC:UAO("FastWeaponSwitch",v)end})end
	if MQ("Event Log")then MKMD(nct,TM,{Label="Event Log",Value=st.Antiaim.Other.EventLog,Options={"Damage","Purchases","Console","Errors"},OnChange=function(v)SC:UAO("EventLog",v)end})end
	return f
end

local function MKSW(TM,SC,pr,cfg)
	local f=U("Frame",{Size=UDim2.fromOffset(240,0),Position=UDim2.new(0.5,410,0.5,-300),AnchorPoint=Vector2.new(0,0),BackgroundColor3=Color3.fromRGB(12,15,18),BorderSizePixel=0,Visible=false,ZIndex=100,AutomaticSize=Enum.AutomaticSize.Y},pr)
	UC(f,8);US(f,1,Color3.new(1,1,1),0.9)
	local tb=U("Frame",{Size=UDim2.new(1,0,0,30),BackgroundColor3=Color3.fromRGB(9,11,13),BorderSizePixel=0},f)
	UC(tb,8);U("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0},tb)
	U("TextLabel",{Size=UDim2.fromOffset(120,30),Position=UDim2.fromOffset(12,0),BackgroundTransparency=1,Text="Settings",TextColor3=Color3.new(1,1,1),TextSize=11,Font=Enum.Font.SourceSansSemiBold,TextXAlignment=Enum.TextXAlignment.Left},tb)
	local cb=U("TextButton",{Size=UDim2.fromOffset(20,20),Position=UDim2.new(1,-28,0,5),BackgroundTransparency=1,Text="✕",TextColor3=Color3.fromRGB(98,106,115),TextSize=14,Font=Enum.Font.SourceSans},tb)
	cb.MouseButton1Click:Connect(function()cfg.OC()end)
	cb.MouseEnter:Connect(function()cb.TextColor3=Color3.new(1,1,1)end)
	cb.MouseLeave:Connect(function()cb.TextColor3=Color3.fromRGB(98,106,115)end)
	local ct=U("Frame",{Size=UDim2.new(1,-32,0,0),Position=UDim2.fromOffset(16,36),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},f)
	UL(ct,Enum.FillDirection.Vertical,8)
	U("TextLabel",{Size=UDim2.new(1,-16,0,14),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,Text="Select Style",TextColor3=Color3.fromRGB(98,106,115),TextSize=10,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},ct)
	local cg=U("Frame",{Size=UDim2.new(1,0,0,40),BackgroundTransparency=1},ct)
	U("UIGridLayout",{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Center,VerticalAlignment=Enum.VerticalAlignment.Center,CellPadding=UDim2.fromOffset(10,0),CellSize=UDim2.fromOffset(18,18)},cg)
	for n,to in pairs(Th)do
		local act2=TM:GA().Id==to.Id
		local bt=U("TextButton",{Size=UDim2.fromOffset(18,18),BackgroundColor3=to.P,BorderColor3=act2 and Color3.new(1,1,1)or Color3.new(0,0,0),BorderSizePixel=act2 and 2 or 0,Text="",ZIndex=5},cg)
		UC(bt,9)
		bt.MouseButton1Click:Connect(function()TM:SetT(to)end)
	end
	U("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=0.95,BorderSizePixel=0},ct)
	U("TextLabel",{Size=UDim2.new(1,-16,0,14),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,Text="HUD",TextColor3=Color3.fromRGB(98,106,115),TextSize=10,Font=Enum.Font.SourceSansBold,TextXAlignment=Enum.TextXAlignment.Left},ct)
	local st2=SC:GA()
	MKTG(ct,TM,{Label="Show HUD",Checked=st2.Antiaim.Other.ShowHUD,OnChange=function(v)SC:UAO("ShowHUD",v)end})
	return f
end

function TM:GA()return self.CT:g()end
function TM:GSL()return self.CT:g().SL end
function TM:OC(cb)return self.CT:oc(cb)end
function TM:SetT(t)self.CT:s(t)end

function Lib:CreateWindow(cfg)
	cfg=cfg or{}
	local sg=cfg.Parent or Instance.new("ScreenGui")
	if not cfg.Parent then
		sg.Name="BulletLua";sg.DisplayOrder=100;sg.ResetOnSpawn=false
		sg.Parent=cfg.PlayerGui or (game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
	end
	local mc=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(7,9,12),BorderSizePixel=0},sg)
	local TM2={CT=Sig.new(Th.Blue),GA=function()return TM2.CT:g()end,GSL=function()return TM2.CT:g().SL end,OC=function(cb)return TM2.CT:oc(cb)end,SetT=function(t)TM2.CT:s(t)end}
	local SC2=MKSC(TM2)
	SC2:IKL()
	local wf=U("Frame",{Size=UDim2.fromOffset(800,600),Position=UDim2.new(0.5,-400,0.5,-300),BackgroundColor3=Color3.fromRGB(12,15,18),BorderSizePixel=0,Visible=true,ZIndex=10},mc)
	UC(wf,8);US(wf,1,Color3.new(1,1,1),0.95)
	local drg=false;local ds,fs
	wf.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			local mx=UIS:GetMouseLocation().X-wf.AbsolutePosition.X
			if mx<=200 then drg=true;ds=UIS:GetMouseLocation();fs=wf.Position end
		end
	end)
	wf.InputChanged:Connect(function(i)
		if drg and i.UserInputType==Enum.UserInputType.MouseMovement then
			local mp=UIS:GetMouseLocation();local dv=mp-ds
			wf.Position=UDim2.fromOffset(fs.X.Offset+dv.X,fs.Y.Offset+dv.Y)
		end
	end)
	wf.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drg=false end end)
	local AT=Sig.new("combat")
	local iso=false
	local wfl=UL(wf,Enum.FillDirection.Horizontal,0)
	local sb=MKSB(TM2,wf,{AT=AT:g(),OTC=function(t)AT:s(t)end})
	local mc2=U("Frame",{Size=UDim2.new(0,564,1,0),BackgroundTransparency=1,Position=UDim2.fromOffset(200,0)},wf)
	U("UIPadding",{PaddingLeft=UDim.new(0,20),PaddingRight=UDim.new(0,20),PaddingTop=UDim.new(0,16),PaddingBottom=UDim.new(0,16)},mc2)
	local mly=UL(mc2,Enum.FillDirection.Vertical,0)
	local tb=MKTB(TM2,SC2,mc2,{OTS=function()iso=not iso;if iso then AI(sw,{BackgroundTransparency=0})else AO(sw,{BackgroundTransparency=1})end end})
	local pc=U("Frame",{Size=UDim2.new(1,0,1,-50),Position=UDim2.fromOffset(0,44),BackgroundTransparency=1,ClipsDescendants=true},mc2)
	local cp=nil
	local sw=MKSW(TM2,SC2,mc,{OC=function()iso=false;AO(sw,{BackgroundTransparency=1})end})
	local hu=MKHU(TM2,SC2,mc,{Position="Top-Right",OTV=function()wf.Visible=not wf.Visible end})
	local nm=MKNM(TM2,SC2,mc)
	local function SP2()
		if cp then pcall(function()cp:Destroy()end)end
		local q=SC2:GQ()
		local tid=AT:g()
		if q and q~=""then
			cp=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pc);cp.ClipsDescendants=true
			U("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,-10),BackgroundTransparency=1,Text="Search results for: "..q,TextColor3=Color3.fromRGB(255,255,255),TextSize=14,TextTransparency=0.1,Font=Enum.Font.SourceSansSemiBold,TextXAlignment=Enum.TextXAlignment.Center},cp)
			return
		end
		if tid=="combat"then cp=MKCPanel(TM2,SC2,pc)
		elseif tid=="visuals"then cp=MKVPanel(TM2,SC2,pc)
		elseif tid=="movement"then cp=MKMPanel(TM2,SC2,pc)
		elseif tid=="exploit"then cp=MKEPanel(TM2,SC2,pc)
		elseif tid=="configs"then
			cp=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pc);cp.ClipsDescendants=true
			U("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,-10),BackgroundTransparency=1,Text="Config Management",TextColor3=Color3.fromRGB(255,255,255),TextSize=14,Font=Enum.Font.SourceSansSemiBold,TextXAlignment=Enum.TextXAlignment.Center},cp)
		else
			cp=U("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},pc)
			U("TextLabel",{Size=UDim2.fromOffset(40,40),Position=UDim2.new(0.5,-20,0.5,-30),BackgroundTransparency=1,Text="⊘",TextColor3=Color3.fromRGB(98,106,115),TextSize=40,TextTransparency=0.3,Font=Enum.Font.SourceSans},cp)
			U("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0.5,10),BackgroundTransparency=1,Text="There is nothing here",TextColor3=Color3.fromRGB(98,106,115),TextSize=12,TextTransparency=0.5,Font=Enum.Font.SourceSansSemiBold,TextXAlignment=Enum.TextXAlignment.Center},cp)
		end
	end
	AT:c(function()sb:ST(AT:g());SP2()end)
	SC2:OC(function(st)
		if st.Antiaim and st.Antiaim.Other then
			hu:SV(st.Antiaim.Other.ShowHUD)
		end
	end)
	SP2()
	UIS.InputBegan:Connect(function(ip,gp)
		if gp then return end
		if ip.KeyCode==Enum.KeyCode.LeftAlt or ip.KeyCode==Enum.KeyCode.RightAlt then
			wf.Visible=not wf.Visible
		end
	end)
	local W={}
	function W:CT(tid)return{CS=function(sn)return{CT=function(cfg)end,CS=function(cfg)end,CD=function(cfg)end,CMD=function(cfg)end,CTX=function(cfg)end,CK=function(cfg)end,CCP=function(cfg)end end}end end
	print("[Bullet.lua] UI Library loaded successfully")
	return W
end

return Lib
