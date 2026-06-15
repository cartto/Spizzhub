--UNIVERSAL VERSION

_G.flykey = "V"

_G.remote = nil
_G.oldremote = nil
_G.debounced = false

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

function flight(delta)
    local velocity = Vector3.new(0,0,0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + workspace.CurrentCamera.CFrame.LookVector * FlightSpeed end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then velocity = velocity - workspace.CurrentCamera.CFrame.LookVector * FlightSpeed end
    if rootPart then rootPart.Velocity = velocity end
end


function iter(l, callback)
    for i,v in pairs(l) do
        callback(i,v)
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

    -- check if table is empty
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
                .. tostring(v)
                .. "\n"
        end
    end

    str ..= string.rep(" ", indent) .. "}"
    return str
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Vlluu",
    Icon = "rocket", -- lucide icon
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
    Title = "Fly/Vfly",
    Desc = "Fly or Vfly works as both",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        local FlyKey = Enum.KeyCode[_G.flykey]
        local FlightSpeed = 256
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local flyingConnection


        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == FlyKey and state then
                if flyingConnection then flyingConnection:Disconnect() flyingConnection = nil
                else flyingConnection = RunService.Heartbeat:Connect(flight) end
            end
        end)
    end
})

main:Keybind({
    Title = "Fly bind",
    Desc = "",
    Value = "V",
    Callback = function(v)
        _G.flykey = v
        Window:SetToggleKey(Enum.KeyCode[v])
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

    

    task.spawn(function() while true do wait()  plr_info:SetDesc("Team: "..(plr.Team.Name).."\nHealth: "..(getchar(plr).Humanoid.Health)) end end)
    
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
    Title = "v1.0.0",
    Icon = "github",
    Color = BrickColor.new("New Yeller").Color,
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

            local var1 = "local args = "..tableToString(data.Args).."\n"

            local script =
                "local remote = "..data.Remote:GetFullName()..
                "\nremote:"..data.Method.."(table.unpack(args))"

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





scan(selfgetchar())
scan(selfgetplayer())
scan(game.ReplicatedStorage)
scan(game.Workspace)

-- > misc < --
local misc = Section:Tab({
    Title = "Misc",
    Icon = "info",
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
