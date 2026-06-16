--PRISON LIFE VERSION
_G.flykey = "F"
_G.remote = nil
_G.oldremote = nil
_G.debounced = false
_G.fly = false

function selfgetplayer()
    return game.Players.LocalPlayer
end

function selfgetchar()
    return selfgetplayer().Character
end

function getchar(plr)
    return plr.Character
end

function HasRemoteUpdated(remote, oldremote)
    if remote ~= oldremote then
        return true
    else
        return false
    end
end

function iter(l, callback)
    for i,v in pairs(l) do
        callback(i,v)
    end
end

function GetEquipedWeapon(char, GunsInPL)
    for i,v in pairs(char:GetChildren()) do
      for i2,v2 in pairs(GunsInPL) do
              if v.Name == i2 then
                return v.Name
            end
        end
    end
end

function GetClosestPlayer(maxDistance)
	local closestPlayer = nil
	local closestDistance = maxDistance or math.huge
	local character = game.Players.LocalPlayer.Character
	if not character then
		return nil
	end
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return nil
	end
	for _, player in ipairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer and player.Character then
			local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot then
				local distance = (root.Position - targetRoot.Position).Magnitude
				if distance < closestDistance then
					closestDistance = distance
					closestPlayer = player
				end
			end
		end
	end
	return closestPlayer
end

function SetPlayerAttribute(state, value)
    iter(getgc(true), function(_, v)
        if type(v) == "table" and rawget(v, "isFighting") ~= nil then
            if type(attribute) == "string" then
                v[attribute] = value
            end
        end
    end)
end

function GetPlayerAttribute(attribute)
    iter(getgc(true), function(_, v)
        if type(v) == "table" and rawget(v, "isFighting") ~= nil then
            if type(attribute) == "string" then
                return v[attribute]
            end
        end
    end)
end


function valueToString(v)
    if typeof(v) == "Instance" then
        return "game." .. v:GetFullName()
    elseif type(v) == "string" then
        return string.format("%q", v)
    else
        return tostring(v)
    end
end

function tableToString(t, indent, visited)
    indent = indent or 0
    visited = visited or {}

    local function formatKey(k)
        if type(k) == "string" then
            return '["' .. k .. '"]'
        else
            return "[" .. tostring(k) .. "]"
        end
    end

    if type(t) ~= "table" then
        return string.rep(" ", indent) .. tostring(t)
    end

    if visited[t] then
        return string.rep(" ", indent) .. "*cycle*"
    end
    visited[t] = true

    local isEmpty = next(t) == nil
    if isEmpty then
        return "{}"
    end

    local str = "{\n"

    for k, v in pairs(t) do
    if type(v) == "table" then
        str ..= string.rep(" ", indent + 2)
            .. formatKey(k)
            .. " = "
            .. tableToString(v, indent + 2, visited)
            .. "\n"
    else
        str ..= string.rep(" ", indent + 2)
            .. formatKey(k)
            .. " = "
            .. valueToString(v)
            .. "\n"
            end
        end

    str ..= string.rep(" ", indent) .. "}"
    return str
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Vlluu",
    Icon = "rocket",
    Author = "by spizzers",
    Folder = "hc",
	KeySystem = {
		Key = {"1231312312312312312", "a"},
		Note = "ganglard",
		SaveKey = true;
	},
     User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
			game.Players.LocalPlayer.Character.Head:BreakJoints()
		end,
    },
})


local Section = Window:Section({
    Title = "Main",
    Icon = "bird",
    Opened = true,
})

local main = Section:Tab({
    Title = "Home",
    Icon = "house",
    Locked = false,
})


main:Slider({
    Title = "WalkSpeed",
    Desc = "",
    Step = 1,
    Value = {
        Min = 1,
        Max = 1000,
        Default = 16,
    },
    Callback = function(value)
        selfgetchar().Humanoid.WalkSpeed = value
    end
})


main:Slider({
    Title = "Jump Power",
    Desc = "",
    Step = 1,
    Value = {
        Min = 1,
        Max = 1000,
        Default = 16,
    },
    Callback = function(value)
        selfgetchar().Humanoid.JumpPower = value
    end
})

main:Slider({
    Title = "Field Of View",
    Desc = "",
    Step = 1,
    Value = {
        Min = 1,
        Max = 120,
        Default = 16,
    },
    Callback = function(value)
        game.Workspace.Camera.FieldOfView = value
    end
})

local j = {}
main:Toggle({
    Title = "Infinite Jump",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
                
       if state then
        local UserInputService = game:GetService("UserInputService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        j["a"] = UserInputService.JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    else
        j["a"]:Disconnect()
        end

    end
})


main:Toggle({
    Title = "Fly",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
		_G.fly = state
    end
})

-- velo fly script
local a=game:GetService("Players")local b=game:GetService("RunService")local c=game:GetService("UserInputService")local d=a.LocalPlayer;local e=d.Character or d.CharacterAdded:Wait()local f=e:WaitForChild("Humanoid")local g=e:WaitForChild("HumanoidRootPart")local h=false;local i=100;local j=1000;local k=0.4;local l=workspace.Gravity;d.CharacterAdded:Connect(function(m)e=m;f=e:WaitForChild("Humanoid")g=e:WaitForChild("HumanoidRootPart")end)local function n(o,p)return o+o*math.random(-p,p)/100 end;local function q()while h do local r=Vector3.new()local s=workspace.CurrentCamera.CFrame;r=r+(c:IsKeyDown(Enum.KeyCode.W)and s.LookVector or Vector3.new())r=r-(c:IsKeyDown(Enum.KeyCode.S)and s.LookVector or Vector3.new())r=r-(c:IsKeyDown(Enum.KeyCode.A)and s.RightVector or Vector3.new())r=r+(c:IsKeyDown(Enum.KeyCode.D)and s.RightVector or Vector3.new())r=r+(c:IsKeyDown(Enum.KeyCode.Space)and Vector3.new(0,1,0)or Vector3.new())r=r-(c:IsKeyDown(Enum.KeyCode.LeftShift)and Vector3.new(0,1,0)or Vector3.new())if r.Magnitude>0 then i=math.min(i+k,j)r=r.Unit*math.min(n(i,10),j)g.Velocity=r*0.5 else g.Velocity=Vector3.new(0,0,0)end;b.RenderStepped:Wait()end end;c.InputBegan:Connect(function(t,u)if not u and t.KeyCode==Enum.KeyCode[_G.flykey]and _G.fly then h=not h;if h then workspace.Gravity=0;q()else i=100;g.Velocity=Vector3.new(0,0,0)workspace.Gravity=l end end end)


main:Keybind({
    Title = "Fly bind",
    Desc = "",
    Value = "V",
    Callback = function(v)
        _G.flykey = v
    end
})

main:Button({
    Title = "Delete Hammer",
    Desc = "",
    Locked = false,
    Callback = function()
        Instance.new("HopperBin", selfgetplayer().Backpack).BinType = "Hammer"
    end
})

main:Button({
    Title = "Rejoin",
    Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

-- > player list < --
local playerlist = Section:Tab({
    Title = "Player List",
    Icon = "users",
    Locked = false,
})

local plr_sections = {}
_G.loopgoto = false

function AddSection(plr)
        local plr_section = playerlist:Section({ 
        Title = tostring(plr.Name),
        Box = true,
        Opened = false,
    })
    
    local plr_info = plr_section:Paragraph({
        Title = "--> Player Info <--",
        Desc = ""
    })    

   pcall(function()  task.spawn(function() while true do wait()  plr_info:SetDesc("Team: "..(plr.Team.Name).."\nHealth: "..(getchar(plr).Humanoid.Health)) end end) end)

   plr_section:Button({
        Title = "Teleport To",
        Desc = "",
        Callback = function()
            selfgetchar():PivotTo(plr.Character:GetPivot())
        end
    })
    plr_section:Toggle({
        Title = "View/Unview",
        Value = false,
        Callback = function(state)
            if state then
                game.Workspace.Camera.CameraSubject = getchar(plr).Humanoid
            else
                game.Workspace.Camera.CameraSubject = selfgetchar().Humanoid
            end
        end
    })
    
    plr_section:Toggle({
        Title = "Loop Teleport",
        Value = false,
        Callback = function(state)
            _G.loopgoto = state
        end
    })
      task.spawn(function()
                    while true do wait()
                        if _G.loopgoto then
                            selfgetchar():PivotTo(getchar(plr):GetPivot())
                        end
                    end
                end)

    plr_sections[plr.Name] = plr_section
end

iter(game.Players:GetPlayers(), function(_, plr)
    if plr.Name ~= selfgetplayer().Name then
    AddSection(plr)
    playerlist:Divider()
   end
end)

game.Players.PlayerRemoving:Connect(function(plr, exitreason)
    plr_sections[plr.Name]:Destroy()
end)

game.Players.PlayerAdded:Connect(function(plr)
     AddSection(plr)
end)


-- > tags < --
Window:Tag({
    Title = game.Players.LocalPlayer.Name .. " is playing!",
    Icon = "signal",
    Color = BrickColor.new("Dark red").Color,
    Radius = 0, -- from 0 to 13
})

Window:Tag({
    Title = "Ver - Prison Life",
    Icon = "columns-4",
    Color = BrickColor.new("Bright orange").Color,
    Radius = 0, -- from 0 to 13
})


--> debugger < --
local debugger = Section:Tab({
    Title = "Debugger",
    Icon = "terminal",
    Locked = false,
})


_G.spyenabled = false
_G.FireServer = true
_G.InvokeServer = true
_G.BindableEvent = false
debugger:Toggle({
    Title = "Enable Spy",
    Description = "FireServer and Invoke Only",
    Value = false,
    Callback = function(state)
        _G.spyenabled = state
    end
})
debugger:Toggle({
    Title = "Enable FireServer",
    Description = "allow fireserver remotes",
    Value = true,
    Callback = function(state)
        _G.FireServer = state
    end
})
debugger:Toggle({
    Title = "Enable InvokeServer",
    Description = "alow invokeserver remotes",
    Value = true,
    Callback = function(state)
        _G.InvokeServer = state
    end
})

debugger:Toggle({
    Title = "Enable BindableEvent",
    Description = "alow events",
    Value = false,
    Callback = function(state)
        _G.BinableEvent = state
    end
})

local sectionlogs = {}
debugger:Button({
    Title = "Clear Logs",
    Callback = function()
        iter(sectionlogs, function(_, v)
            v:Destroy()
        end)
    end
})


local RemoteQueue = {}

local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if _G.spyenabled then
        if (method == "FireServer" and _G.FireServer)
        or (method == "InvokeServer" and _G.InvokeServer)
        or (method == "Fire" and _G.BindableEvent) then

            table.insert(RemoteQueue, {
                Remote = self,
                Method = method,
                Args = {...}
            })
        end
    end

    return old(self, ...)
end))

task.spawn(function()
    while task.wait(0.01) do
        while #RemoteQueue > 0 do
            local data = table.remove(RemoteQueue, 1)

            local remoteView = debugger:Section({
                Title = tostring(data.Remote.Name),
                Opened = false
            })

            local var1 = "local contents = "..tableToString(data.Args).."\n"

            local script =
                "local remote = game."..data.Remote:GetFullName()..
                "\nremote:"..data.Method.."(table.unpack(contents))"

            remoteView:Code({
                Title = "args",
                Code = "--spizzhub v1\n"..var1..script
            })

            table.insert(sectionlogs, remoteView)
        end
    end
end)


-- > bindable event creator < -- 
local bec = Section:Tab({
    Title = "Event Creator",
    Icon = "zap",
    Locked = false,
})

local events = {}

local f = Instance.new("Folder", game.Workspace)
f.Name = "spze"
function eventCreate(eventName, callback)
    local bindable = Instance.new("BindableEvent")
    bindable.Name = eventName
    bindable.Parent = f

    bindable.Event:Connect(callback)

    events[eventName] = bindable
    return bindable
end

function fireEvent(eventName, ...)
    local bindable = events[eventName]
    if bindable then
        bindable:Fire(...)
    end
end

_G.eventname = nil
_G.callbackcode = nil

bec:Input({
    Title = "Event Name",
    InputIcon = "pencil",
    Type = "Input",
    Placeholder = "Some Random Name Lmao",
    Callback = function(input) 
        _G.eventname = tostring(input)
    end
})

bec:Input({
    Title = "Callback Code",
    InputIcon = "pencil",
    Type = "Input",
    Placeholder = "print(\"test\")",
    Callback = function(input) 
        _G.callbackcode = tostring(input)
    end
})

bec:Button({
    Title = "Create",
    Callback = function()
        if not _G.eventname or not _G.callbackcode then
            warn("Missing event name or callback code")
            return
        end

        local source = [[
            return function(...)
                ]] .. _G.callbackcode .. [[
            end
        ]]

        local factory, err = loadstring(source)

        if not factory then
            warn(err)
            return
        end

        local callback = factory()

        eventCreate(_G.eventname, callback)

        print("Created event:", _G.eventname)
        fireEvent(_G.eventname, _G.callbackcode)
        game.Workspace.spze[_G.eventname]:FireServer()
    end
})


-- > decompiler < --
_G.LocalScripts = true
_G.ModuleScripts = true
_G.ServerScripts = false

local dectab = Section:Tab({
    Title = "Scripts",
    Icon = "scroll-text",
})

function isAllowed(v)
    return (_G.LocalScripts and v:IsA("LocalScript"))
        or (_G.ModuleScripts and v:IsA("ModuleScript"))
        or (_G.ServerScripts and v:IsA("Script"))
end

function addScript(v, codetext)
    local decompiled_code = "--Not Decompiled\nreturn nil,nil"
    local allscripts = dectab:Section({
        Title = v.Name,
        Desc = v.ClassName,
        Box = true,
        Opened = false,
    })

    local dc = allscripts:Code({
        Title = "Decompiled Source",
        Code = tostring(decompiled_code)
    })

    allscripts:Button({
        Title = "Decompile",
        Callback = function()
            local source = decompile(v)
            local new_source = source:gsub("-- https://lua.expert/", "\32")
            local path = "--spizzhub decompiler\nlocal path = game." .. v:GetFullName()
            dc:SetCode(path .. new_source)

        end
    })
    return v
end
function scan(container)
    iter(container:GetDescendants(), function(i, v)
        if isAllowed(v) then
            addScript(v)
        end
    end)
end

if getgenv().AllowDecompiler then
	scan(selfgetchar())
	scan(selfgetplayer())
	scan(game.ReplicatedStorage)
	scan(game.Workspace)
end

-- > gc scanner < --
local gc = Section:Tab({
    Title = "Garbage Collection",
    Icon = "trash-2",
    Locked = false,
})

gc:Input({
    Title = "key",
    InputIcon = "pencil",
    Type = "Input",
    Placeholder = "type",
    Callback = function(input) 
        _G.gctype = input
    end
})

gc:Input({
    Title = "pair",
    InputIcon = "pencil",
    Type = "Input",
    Placeholder = "tbl pair",
    Callback = function(input) 
        _G.gcpair = input
    end
})

local gcCodes = {   }
gc:Button({
    Title = "Scan",
    Callback = function()
        for i,v in pairs(getgc(true)) do
           if type(v) == _G.gctype and rawget(v, _G.gcpair) ~= nil then
                 local s1 = gc:Section({
                    Title = tostring(v)
                })
                local c = s1:Code({
                    Title = "Garbage Collection Scanner",
                    Code = ""
                })
                table.insert(gcCodes, s1)
                for a,b in pairs(v) do
                    if a == _G.gcpair then
                        c:SetCode("--spizzhub v1\nlocal tbl = {}\nreturn tbl."..tostring(a).."\ncurrent val -> "..tostring(b)) 
                    end
                end
           end
        end
    end
})

gc:Button({
    Title = "Clear Scans",
    Callback = function()
        iter(gcCodes, function(i ,v) v:Destroy() end)
    end
})

-- > misc < --
local misc = Section:Tab({
    Title = "Misc",
    Icon = "info",
})

misc:Button({
    Title = "Join Prison Life",
    Callback = function()
        game:GetService("TeleportService"):Teleport(155615604, selfgetplayer())
    end
})

misc:Button({
    Title = "Join BasePlate",
    Callback = function()
        game:GetService("TeleportService"):Teleport(95206881, selfgetplayer())
    end
})

misc:Button({
    Title = "Kick Yourself (idiot)",
    Callback = function()
        selfgetplayer():Kick("click leave to leave stupid fuck")
    end
})

misc:Button({
    Title = "Credits",
    Callback = function()
        WindUI:Popup({
        Title = "CREDITS",
        Icon = "info",
        Content = "Script Made By Spizzers",
        Buttons = {
            {
                Title = "Okay",
                Icon = "checkmark",
                Variant = "Primary",
            }
        }
    })
    end
})

misc:Paragraph({
    Title = "--> TODO <--",
    Desc = "add a scripts tab so u can see every script and decompile it\nmaybe a garbage collection scanner"
})



-- > main cheats < --
local Cheats = Window:Section({
    Title = "Prison Life Cheats",
    Icon = "braces",
    Opened = false;
})

local PrisonLife = Cheats:Tab({
    Title = "Main Cheats",
    Icon = "circle-dollar-sign",
})

PrisonLife:Button({
    Title = "Find Keycard",
    Callback = function()
        local card = game.Workspace:FindFirstChild("Key card")
        if card then
            local pos = card.Mesh.CFrame
            selfgetchar().HumanoidRootPart.CFrame = pos
            selfgetchar().HumanoidRootPart.CFrame.Y = selfgetchar().HumanoidRootPart.CFrame.Y + 10
        else
            WindUI:Notify({
                Title = "SPIZZHUB",
                Content = "key card not found",
                Duration = 3, -- 3 seconds
                Icon = "warning",
            })
        end
    end
})


PrisonLife:Toggle({
    Title = "Doors",
    Value = true,
    Callback = function(state)
        if state then
            print("is true")
            if game.ReplicatedStorage:FindFirstChild("Doors")  then
                game.ReplicatedStorage:FindFirstChild("Doors").Parent = game.Workspace
            end
        else
            game.Workspace.Doors.Parent = game.ReplicatedStorage
            print("is false")
        end
    end
})

PrisonLife:Divider()

local Rage = PrisonLife:Section({ 
    Title = "Rage",
    Opened = true;
})


local states

_G.ip = false
Rage:Toggle({
    Title = "Infinite Punch",
    Value = false,
    Callback = function(state)
        _G.ip = state
        iter(getgc(true), function(i, v)
            if type(v) == "table" and rawget(v, "isFighting") ~= nil then
                states = v
                return true
            end
        end)
        task.spawn(function()
            while true do wait()
                if _G.ip then
                    states.isFighting = false
                end
            end
        end)
    end
})


_G.at = false
Rage:Toggle({
    Title = "Anti Taze",
    Value = false,
    Callback = function(state)
        _G.at = state
        iter(getgc(true), function(i,v)
            if type(v) == "table" and rawget(v, "isTazed") ~= nil then
                states = v
                return true
            end
        end)
        task.spawn(function()
            while true do wait()
                if _G.at then
                    if states.isTazed then
                        selfgetchar().Humanoid.WalkSpeed = 25
                        states.isTazed = false
                    end
                end
            end
        end)
    end
})


_G.kaa = false
Rage:Toggle({
	Title = "Kill Aura",
	Value = false,
	Callback = function(state)
		_G.kaa = state
	end
})
task.spawn(function()
	while true do wait()
		if _G.kaa then
			local target = GetClosestPlayer(100)
			if target then
				local remote = game.ReplicatedStorage.meleeEvent
				remote:FireServer(target, 1, 1)
			end
		end
	end
end)
-- > weapon cheats < --
local WeaponCheats = Cheats:Tab({
    Title = "Weapon Cheats",
    Icon = "bow-arrow", -- optional
    Locked = false,
})

_G.weaponcheats_enabled = false

local CheatSounds = {
	["M4A1"] = {
        ReloadSound = "rbxassetid://142491708",
        ShootSound   = "rbxassetid://150544849"
    },
    ["AK-47"] = {
        ReloadSound = "rbxassetid://142491708",
        ShootSound   = "rbxassetid://153230498"
    },
    ["M9"] = {
        ReloadSound = "rbxassetid://138084889",
        ShootSound   = "rbxassetid://134436500"
    },
    ["Remington 870"] = {
        ReloadSound = "rbxassetid://145081845",
        ShootSound   = "rbxassetid://138083993"
    },
    ["M700"] = {
        ReloadSound = "rbxassetid://97852355",
        ShootSound   = "rbxassetid://406722373"
    },
    ["MP5"] = {
        ReloadSound = "rbxassetid://142491708",
		ShootSound = "rbxassetid://10209859",
    },
    ["FAL"] = {
        ReloadSound = "rbxassetid://142491708",
    },
}

local GunsInPL = {
    ["M4A1"] = true,
    ["M9"] = true,
    ["Remington 870"] = true,
    ["AK-47"] = true,
    ["MP5"] = true,
    ["FAL"] = true;
}

WeaponCheats:Toggle({
    Title = "Enable",
    Value = false,
    Callback = function(state)
        _G.weaponcheats_enabled = state
    end
})


_G.firerate = 0.5
WeaponCheats:Slider({
    Title = "Fire Rate",
    Desc = "",
    Step = 0.01,
    Value = {
        Min = 0.01,
        Max = 1,
        Default = 0.05,
    },
    Callback = function(value)
        _G.firerate = value
        if _G.weaponcheats_enabled then
            selfgetchar()[GetEquipedWeapon(selfgetchar(), GunsInPL)]:SetAttribute("FireRate", _G.firerate)
        end
    end
})


_G.af = false
WeaponCheats:Toggle({
    Title = "Auto Fire",
    Desc = "",
    Value = false,
    Callback = function(state)
        _G.af = state
            if GetEquipedWeapon(selfgetchar(), GunsInPL) == "M9" or GetEquipedWeapon(selfgetchar(), GunsInPL) == "Remington 870" then
                local currentgun = GetEquipedWeapon(selfgetchar(), GunsInPL)
                selfgetchar()[currentgun]:SetAttribute("AutoFire", true)
                selfgetchar().Humanoid:UnequipTools()
                wait()
                selfgetchar().Humanoid:EquipTool(selfgetplayer().Backpack[currentgun])
                
            end
    end
})
task.spawn(function()
    while true do wait()
        if _G.weaponcheats_enabled and _G.af then
            if GetEquipedWeapon(selfgetchar(), GunsInPL) == "M9" or GetEquipedWeapon(selfgetchar(), GunsInPL) == "Remington 870"then
                print(selfgetchar()[GetEquipedWeapon(selfgetchar(), GunsInPL)]) 
                selfgetchar()[GetEquipedWeapon(selfgetchar(), GunsInPL)]:SetAttribute("AutoFire", true)
            end
        end
    end
end)


WeaponCheats:Toggle({
    Title = "Old Sounds",
    Value = false,
    Callback = function(state)
        task.spawn(function()
            while true do wait()
                if state then
                    iter(selfgetplayer().Backpack:GetChildren(), function(i,v)
                        if v:IsA("Tool") and GunsInPL[v.Name] then
                            handle.ShootSound.SoundId = CheatSounds[v.Name].ShootSound
                            handle.ReloadSound.SoundId = CheatSounds[v.Name].ReloadSound
                        end
                    end)
                end
            end
        end)
    end
})

WeaponCheats:Divider()

local giver = WeaponCheats:Section({
    Title = "Giver",
})

local Meshes = {
    ["Remington 870"] = "Meshes/r870_2",
    ["MP5"] = "Meshes/MP5 (2)",
    ["Revolver"] = "Meshes/revolver (3)",
    ["M4A1"] = "Mesh";
}

function GrabGun(gunname, path2)
    --spizzhub v1
    local contents = {
        [1] = game.Workspace.Prison_ITEMS.giver[gunname][path2]
    }
        
    local remote = game.ReplicatedStorage.Remotes.InteractWithItem
    remote:InvokeServer(table.unpack(contents))
end

function CreateGiverButtons(i, gunname, loc)
    if i == gunname then
        giver:Button({
        Title = tostring(i),
        Callback = function()
                selfgetchar().HumanoidRootPart.CFrame = loc
                wait(1)
                for i = 1,100 do GrabGun(gunname, Meshes[gunname]) end
            end
        })
    end
end

iter(GunsInPL, function(i, v)
    CreateGiverButtons(i, "MP5", CFrame.new(816, 98, 2222))
    CreateGiverButtons(i, "Remington 870", CFrame.new(816, 98, 2222))
    CreateGiverButtons(i, "M4A1", CFrame.new(847, 98, 2222))
    CreateGiverButtons(i, "Revolver", CFrame.new(828, 98, 2222))
end)
