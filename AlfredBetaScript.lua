local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

-- 🚫 THE BLACKLIST (Single line, just add names in quotes)
local Blacklist = {"User1", "User2", "User3"}

-- Check Blacklist
for _, name in pairs(Blacklist) do
    if game.Players.LocalPlayer.Name == name then
        -- Chat Message
        task.wait(2)
        local chatMsg = "You are blacklisted ask Owner for permission"
        pcall(function()
            if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(chatMsg)
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatMsg, "All")
            end
        end)
        
        -- Screen Notification (5 Seconds)
        local sg = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
        local txt = Instance.new("TextLabel", sg)
        txt.Size = UDim2.new(1, 0, 0.1, 0)
        txt.Position = UDim2.new(0, 0, 0.45, 0)
        txt.BackgroundColor3 = Color3.new(0,0,0)
        txt.BackgroundTransparency = 0.5
        txt.TextColor3 = Color3.new(1,0,0)
        txt.TextSize = 25
        txt.Text = "Ask permission to owner on discord: alfredopasta5042"
        task.wait(5)
        sg:Destroy()
        return 
    end
end

-- CONFIGURATION
local GoogleSheetURL = "https://script.google.com/macros/s/AKfycbzjgwXNtHB50gbWWle93YS8iR2rlX2CHSuOPlCWOXMcEen2SM7GOfpFvBVGmILhBzNA6Q/exec"
local OwnerUser = "Dadrails912"
local PermKey = "AIfredFESCRlPTS"
local SaveFile = "AlfredAuth.json"

-- KEYS LIST (30 Keys)
local ValidFreeKeys = {
    ["Alfredfreekey24hr"] = true, ["Alfredfreekey24hr-1432"] = true, ["Alfredfreekey24hr-8854"] = true, ["Alfredfreekey24hr-2109"] = true,
    ["Alfredfreekey24hr-5647"] = true, ["Alfredfreekey24hr-3321"] = true, ["Alfredfreekey24hr-9087"] = true,
    ["Alfredfreekey24hr-4456"] = true, ["Alfredfreekey24hr-1122"] = true, ["Alfredfreekey24hr-7765"] = true,
    ["Alfredfreekey24hr-6543"] = true, ["Alfredfreekey24hr-2980"] = true, ["Alfredfreekey24hr-8172"] = true,
    ["Alfredfreekey24hr-4498"] = true, ["Alfredfreekey24hr-5001"] = true, ["Alfredfreekey24hr-1987"] = true,
    ["Alfredfreekey24hr-3344"] = true, ["Alfredfreekey24hr-9981"] = true, ["Alfredfreekey24hr-2233"] = true,
    ["Alfredfreekey24hr-7070"] = true, ["Alfredfreekey24hr-6611"] = true, ["Alfredfreekey24hr-1029"] = true,
    ["Alfredfreekey24hr-8542"] = true, ["Alfredfreekey24hr-4114"] = true, ["Alfredfreekey24hr-5522"] = true,
    ["Alfredfreekey24hr-3698"] = true, ["Alfredfreekey24hr-1209"] = true, ["Alfredfreekey24hr-7431"] = true,
    ["Alfredfreekey24hr-9876"] = true, ["Alfredfreekey24hr-2580"] = true, ["Alfredfreekey24hr-4040"] = true
}

local LocalPlayer = Players.LocalPlayer

-- CHAT FUNCTION WITH 2s DELAY
local function SystemChat(msg)
    task.wait(2) -- Force 2 second delay before every chat
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = TextChatService.TextChannels.RBXGeneral
            channel:SendAsync(msg)
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- Logging Function
local function LogToSheet(key)
    local url = GoogleSheetURL .. "?username=" .. LocalPlayer.Name .. "&nickname=" .. LocalPlayer.DisplayName .. "&key=" .. key
    pcall(function() game:HttpGet(url) end)
end

-- Save System
local MyData = {Rank = "Guest", ExpireTime = 0}
if isfile(SaveFile) then
    local success, data = pcall(function() return HttpService:JSONDecode(readfile(SaveFile)) end)
    if success then MyData = data end
end

if LocalPlayer.Name == OwnerUser then MyData.Rank = "Owner" end

local function Save() 
    writefile(SaveFile, HttpService:JSONEncode(MyData)) 
end

-- Time Formatter (Hours and Minutes)
local function GetTimeLeft(expire)
    local diff = expire - os.time()
    local hours = math.floor(diff / 3600)
    local minutes = math.floor((diff % 3600) / 60)
    return hours .. " hours and " .. minutes .. " minutes"
end

-- Load Hub Function
local function LoadHub()
    local Window = Rayfield:CreateWindow({
        Name = "Alfred Simple Accessories Hub",
        LoadingTitle = "Rank: " .. MyData.Rank,
        LoadingSubtitle = "by Dadrails912",
        ConfigurationSaving = {Enabled = false}
    })

    -- Add your Home/Script Tabs here as before
    local HomeTab = Window:CreateTab("Home", 4483362458)
    HomeTab:CreateButton({Name = "Kill Script and GUI", Callback = function() Rayfield:Destroy() end})
    
    local ScriptTab = Window:CreateTab("Scripts", 4483362458)
    ScriptTab:CreateButton({Name = "Invisible FE", Callback = function() loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))() end})
    ScriptTab:CreateButton({Name = "Fling People FE", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AlfredFEscripts/Fling-All-script./main/Fling%20people.lua"))() end})
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

-- Execution Start Chat
SystemChat("AlfredCracked-scripts, Welcome!")

-- Key System
local function StartKeySystem()
    if MyData.Rank == "Owner" then
        SystemChat("Owner Detected! key system bypassed.")
        LogToSheet("OWNER_LOGIN")
        LoadHub() return
    elseif MyData.Rank == "Permanent" then
        SystemChat("Permanent detected! key system bypassed.")
        LogToSheet("PERM_SAVED_LOGIN")
        LoadHub() return
    elseif MyData.Rank == "Free" and os.time() < MyData.ExpireTime then
        local timeLeft = GetTimeLeft(MyData.ExpireTime)
        SystemChat("Welcome Free user! " .. timeLeft .. " is left for free access.")
        LogToSheet("FREE_SAVED_LOGIN")
        LoadHub() return
    end

    -- If we get here, they need a key
    SystemChat("Enter key to continue...")

    local keyGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    local main = Instance.new("Frame", keyGui)
    main.Size = UDim2.new(0, 300, 0, 180)
    main.Position = UDim2.new(0.5, -150, 0.5, -90)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", main)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0.3, 0)
    title.Text = "Alfred Hub | Key System"
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1

    local input = Instance.new("TextBox", main)
    input.Size = UDim2.new(0.8, 0, 0.25, 0)
    input.Position = UDim2.new(0.1, 0, 0.35, 0)
    input.PlaceholderText = "Enter Key Here..."
    input.Text = ""

    local enter = Instance.new("TextButton", main)
    enter.Size = UDim2.new(0.4, 0, 0.2, 0)
    enter.Position = UDim2.new(0.3, 0, 0.7, 0)
    enter.Text = "Check Key"
    enter.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    enter.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", enter)

    enter.MouseButton1Click:Connect(function()
        local typed = input.Text
        
        if typed == PermKey then
            MyData.Rank = "Permanent"
            Save()
            LogToSheet("PERM_ACTIVATE")
            SystemChat("Permanent detected! key system bypassed.")
            keyGui:Destroy()
            LoadHub()
        elseif ValidFreeKeys[typed] then
            local checkURL = GoogleSheetURL .. "?action=checkKey&key=" .. typed
            local status = game:HttpGet(checkURL)

            if status == "USED" then
                input.Text = ""
                input.PlaceholderText = "Key already used!"
            else
                MyData.Rank = "Free"
                MyData.ExpireTime = os.time() + 86400 
                Save()
                LogToSheet(typed)
                local timeLeft = GetTimeLeft(MyData.ExpireTime)
                SystemChat("Welcome Free user! " .. timeLeft .. " is left for free access.")
                keyGui:Destroy()
                LoadHub()
            end
        else
            input.Text = ""
            input.PlaceholderText = "Invalid Key!"
        end
    end)
end

StartKeySystem()
