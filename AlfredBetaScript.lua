local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

-- Chat Function
local function SendChatMessage(msg)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService.TextChannels.RBXGeneral
        channel:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

local LocalPlayer = Players.LocalPlayer

-- CONFIGURATION
local OwnerUser = "Dadrails912"
local PermKey = "AIfredFESCRlPTS"
local FreeKey = "Alfredfreekey24hr"
local SaveFile = "AlfredAuth.json"

local MyData = {Rank = "Guest", ExpireTime = 0}

-- AUTH LOGIC
if isfile(SaveFile) then
    local success, data = pcall(function() return HttpService:JSONDecode(readfile(SaveFile)) end)
    if success then MyData = data end
end

if LocalPlayer.Name == OwnerUser then MyData.Rank = "Owner" end

local function Save() writefile(SaveFile, HttpService:JSONEncode(MyData)) end

-- MAIN HUB
local function LoadHub()
    local Window = Rayfield:CreateWindow({
        Name = "Alfred Simple Accessories Hub",
        LoadingTitle = "Rank: " .. MyData.Rank,
        LoadingSubtitle = "by Dadrails912"
    })

    -- HOME TAB
    local HomeTab = Window:CreateTab("Home", 4483362458)
    
    HomeTab:CreateButton({
        Name = "Kill Script and GUI",
        Callback = function()
            Rayfield:Destroy()
        end
    })

    -- SCRIPTS TAB
    local ScriptTab = Window:CreateTab("Scripts", 4483362458)

    ScriptTab:CreateButton({
        Name = "Invisible FE",
        Callback = function() loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))() end
    })

    ScriptTab:CreateButton({
        Name = "Fling People FE",
        Callback = function()
            local function ScrubAll()
                for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                    if v.Name:find("Delta") or v.Name:find("Ghost") or v.Name:find("IY_") then v:Destroy() end
                end
            end
            ScrubAll()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
    })

    ScriptTab:CreateButton({
        Name = "Quizbot",
        Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Damian-11/quizbot/master/quizbot.luau"))() end
    })

    ScriptTab:CreateButton({
        Name = "Infinite Yield",
        Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end
    })

    ScriptTab:CreateButton({
        Name = "Scriptblox Searcher",
        Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/ScriptSearcher"))() end
    })

    ScriptTab:CreateButton({
        Name = "Delta Keyboard",
        Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))() end
    })

    ScriptTab:CreateButton({
        Name = "Dances FE (Requires Keyboard)",
        Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/UP-Just-a-baseplate.-KDV3-Modded-177753"))() end
    })

    ScriptTab:CreateButton({
        Name = "Sky Hub",
        Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Sky-Hub-18710"))() end
    })

    ScriptTab:CreateButton({
        Name = "Fearless Chat Bypass",
        Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fearless-Chat-Bypass-101789"))() end
    })
end

-- KEY SYSTEM STARTUP
local function StartKeySystem()
    SendChatMessage("AlfredCracked-Scripts, Welcome!")
    
    -- 2 Second Interval
    task.wait(2)

    -- CHECK EXISTING STATUS
    if MyData.Rank == "Owner" then
        SendChatMessage("Key System Bypassed, Script now accessible!")
        LoadHub()
        return
    elseif MyData.Rank == "Permanent" then
        SendChatMessage("Welcome back " .. LocalPlayer.Name .. "!")
        LoadHub()
        return
    elseif MyData.Rank == "Free" and os.time() < MyData.ExpireTime then
        local remaining = MyData.ExpireTime - os.time()
        local hours = math.floor(remaining / 3600)
        local minutes = math.floor((remaining % 3600) / 60)
        SendChatMessage("Welcome you have " .. hours .. " hours and " .. minutes .. " minutes left in your free key!")
        LoadHub()
        return
    end

    -- IF NOT AUTHENTICATED
    SendChatMessage("Access denied, Enter key to continue")

    local keyGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    local keyFrame = Instance.new("Frame", keyGui)
    keyFrame.Size = UDim2.new(0, 300, 0, 200)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Instance.new("UICorner", keyFrame)

    local input = Instance.new("TextBox", keyFrame)
    input.Size = UDim2.new(0.8, 0, 0.2, 0)
    input.Position = UDim2.new(0.1, 0, 0.3, 0)
    input.PlaceholderText = "Enter Key..."

    local enter = Instance.new("TextButton", keyFrame)
    enter.Size = UDim2.new(0.4, 0, 0.2, 0)
    enter.Position = UDim2.new(0.05, 0, 0.6, 0)
    enter.Text = "Enter"
    enter.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    enter.MouseButton1Click:Connect(function()
        if input.Text == PermKey then
            MyData.Rank = "Permanent"
            Save()
            SendChatMessage("Key Accepted! You have been granted permanent use without key system again.")
            keyGui:Destroy()
            LoadHub()
        elseif input.Text == FreeKey then
            MyData.Rank = "Free"
            MyData.ExpireTime = os.time() + 86400
            Save()
            SendChatMessage("Script now accessible, Enter new key in 24hrs.")
            keyGui:Destroy()
            LoadHub()
        else
            input.Text = ""
            input.PlaceholderText = "Invalid!"
        end
    end)
end

StartKeySystem()
