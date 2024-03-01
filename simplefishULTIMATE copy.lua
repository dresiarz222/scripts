getgenv().config = {
    mailUser = "Dresik1337",
    minShards = 300, -- minimum shards to mail
    minGems = 5000000,
    mailMsg = "#doug99",
    fps = 10,
    gui = true,
    randomization = 10,
}

if getgenv().Executed then
    return
end

getgenv().Executed = true
plrs = game:GetService("Players")
plr = plrs.LocalPlayer
advancedFishingCFrame = CFrame.new(-184.91,124.56,5170.91)
advancedFishingLeaveCFrame = CFrame.new(1336.138,71.231,-4442.78)
fishingEnter = CFrame.new(795.196,27.157,1136.443)
fishingLeave = CFrame.new(1051.025,86.659,-3441.567)
Lib = require(game:GetService("ReplicatedStorage").Library)
-- OPTIMIZATIONS BEGIN --
setfpscap(config.fps)
function greyScreen()
    main = Instance.new("ScreenGui")
    Frame = Instance.new("Frame")
    TextLabel = Instance.new("TextLabel")
 
    main.Name = "doug99"
    main.Parent = plr.PlayerGui
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main.IgnoreGuiInset = true
    main.Enabled = config.gui

    Frame.Parent = main
    Frame.Active = true
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Size = UDim2.new(1, 0, 1, 0)
 
    TextLabel.Parent = Frame
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.5, 0, 0.419999987, 0)
    TextLabel.Size = UDim2.new(0, 279, 0, 34)
    TextLabel.Font = Enum.Font.Ubuntu
    TextLabel.Text = "#doug99"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = false
    TextLabel.TextSize = 40.000
    TextLabel.TextWrapped = false
end

if not plr.PlayerGui:FindFirstChild("doug99") then
    game:GetService("RunService"):Set3dRenderingEnabled(not config.gui)
    greyScreen()
    local uis = game:GetService("UserInputService")
    uis.InputBegan:Connect(function(key, gameProcessed)
        pcall(function(key)
            if key.KeyCode == Enum.KeyCode.P then
                if config.gui == true then
                    game:GetService("RunService"):Set3dRenderingEnabled(true)
                    plr.PlayerGui:FindFirstChild("doug99").Enabled = false
                elseif config.gui == false then
                    game:GetService("RunService"):Set3dRenderingEnabled(false)
                    plr.PlayerGui:FindFirstChild("doug99").Enabled = true
                end 
                config.gui = not config.gui
            end
        end,key)
    end)
end

-- OPTIMIZATIONS END --

hrp = plr.Character:FindFirstChild("HumanoidRootPart")
savemodule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(5)
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Server Closing"].Enabled = false
end
task.spawn(antiafk)
function updateSave()
    local SaveFile = savemodule.Get(game.Players.LocalPlayer)
    local save = {
        diamonds = {},
        magic_shards = {},
        rods = {},
        pets = {},
        charmStones = {},
        fishingCoins = {},
    }
    for i,v in pairs(SaveFile.Inventory) do
        for ID,list in pairs(v) do
            name = list.id
            if list.id == "Diamonds" and i == "Currency" then
                save.diamonds.amount = list._am
                save.diamonds.id = ID
                save.diamonds.type = i
                save.diamonds.name = list.id
            elseif list.id == "Fishing" and i == "Currency" then
                save.fishingCoins.amount = list._am
                save.fishingCoins.id = ID
                save.fishingCoins.type = i
                save.fishingCoins.name = list.id
            elseif list.id == "Charm Stone" then
                save.charmStones.amount = list._am
                save.charmStones.id = ID
                save.charmStones.type = i
                save.charmStones.name = list.id
            elseif list.id == "Magic Shard" then
                save.magic_shards.amount = list._am
                save.magic_shards.id = ID
                save.magic_shards.type = i
                save.magic_shards.name = list.id
            elseif string.find(string.lower(list.id),"rod") and i == "Misc" then
                save.rods[list.id] = {}
            elseif string.find(name,"Huge Poseidon Corgi") then
                save.pets[name] = {}
                save.pets[name].id = ID
                save.pets[name].name = list.id
                save.pets[name].type = "Pet"
                save.pets[name].amount = 1
            end
        end
    end
    return save
end
function mail(item) -- parse item savefile eg.: save.magic_shards
    save = updateSave()
    arg3 = item.type
    arg4 = item.id
    arg5 = tonumber(item.amount)
    if not arg3 or not arg4 or not arg5 then return false end
    local args = {
        [1] = config.mailUser,
        [2] = config.mailMsg,
        [3] = arg3,
        [4] = arg4,
        [5] = arg5,
    }
    if item.name then
        if item.name == "Magic Shard" then
            if arg5 > config.minShards then
                return game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
            end
        elseif item.name == "Charm Stone" then
            if arg5 > 20 then
                return game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
            end
        elseif item.name == "Diamonds" then
            if arg5 > config.minGems then
                args[5] -= 200000
                return game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
            end
        elseif string.find(item.name,"Huge Poseidon Corgi") then
            if save.pets[item.name] then
                return game:GetService("ReplicatedStorage").Network:FindFirstChild("Mailbox: Send"):InvokeServer(unpack(args))
            end
        end
    end
end
function getRods()
    save = updateSave()
    if save.rods["Amethyst Fishing Rod"] then return end
    local coinAmm = tonumber(updateSave().fishingCoins.amount)
    if not save.rods["Platinum Fishing Rod"] and coinAmm > 45000 then
        local args = {
        [1] = "Platinum Fishing Rod"
        }
        Lib.Network.Invoke("FishingMerchant_PurchaseRod", unpack(args))
    elseif not save.rods["Emerald Fishing Rod"] and coinAmm > 150000 then
        local args = {
            [1] = "Emerald Fishing Rod"
        }
        Lib.Network.Invoke("FishingMerchant_PurchaseRod", unpack(args))
    elseif not save.rods["Sapphire Fishing Rod"] and coinAmm > 425000 then
        local args = {
            [1] = "Sapphire Fishing Rod"
        }
        Lib.Network.Invoke("FishingMerchant_PurchaseRod", unpack(args))
    elseif not save.rods["Amethyst Fishing Rod"] and coinAmm > 2250000 then
        local args = {
            [1] = "Amethyst Fishing Rod"
        }
        Lib.Network.Invoke("FishingMerchant_PurchaseRod", unpack(args))
    else
        return
    end
end
randomization = config.randomization
function cast()
    local randomVector = Vector3.new(1447.6587+math.random(((-1)*randomization),randomization),61.11,-4470.54+math.random(((-1)*randomization),randomization))
    local args = {
        [1] = "AdvancedFishing",
        [2] = "RequestCast",
        [3] = randomVector -- x is towards advanced fishing spawn -z is towards water 
    }
    Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))
    return randomVector
end
function getBobber(castVector)
    for _,v in pairs(game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active.AdvancedFishing.Bobbers:GetChildren()) do
        if v:FindFirstChild("Bobber") then
            if (v:FindFirstChild("Bobber").Position-castVector).Magnitude <= 0 then
                return v:FindFirstChild("Bobber")
            end
        end
    end
    return nil
end
function click()
    local args = {
        [1] = "AdvancedFishing",
        [2] = "Clicked"
    }
    return Lib.Network.Invoke("Instancing_InvokeCustomFromClient", unpack(args))
end
function reel()
    local args = {
        [1] = "AdvancedFishing",
        [2] = "RequestReel"
    }
    Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))
    --game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(args))
end
function doPresents()
    for i,v in pairs(savemodule.Get().HiddenPresents) do
        if not v.Found and v.ID then
            Lib.Network.Invoke("Hidden Presents: Found",v.ID)
        end
    end
end

-- PRE FISHING CHECKS BEGIN --

fishingEnter = CFrame.new(795.196,27.157,1136.443)
fishingLeave = CFrame.new(1051.025,86.659,-3441.567)
if not updateSave().rods["Wooden Fishing Rod"] then
    hrp.CFrame = fishingEnter
    task.wait(10)
    local args = {
        [1] = "Fishing",
        [2] = "ClaimRod"
    }
    -- game:GetService("ReplicatedStorage").Network.Instancing_FireCustomFromClient:FireServer(unpack(args))
    Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))
    task.wait(5)
    hrp.CFrame = fishingLeave
    task.wait(10)
end
if not updateSave().rods["Golden Fishing Rod"] and not updateSave().rods["Amethyst Fishing Rod"] and not updateSave().rods["Platinum Fishing Rod"] and not updateSave().rods["Sapphire Fishing Rod"] and not updateSave().rods["Emerald Fishing Rod"] and not updateSave().rods["Diamond Fishing Rod"] then
    repeat task.wait(1) print("waiting for golden rod") until updateSave().rods["Golden Fishing Rod"]
end

-- PRE FISHING CHECKS END -- 

hrp.CFrame = advancedFishingCFrame
task.wait(10)
rodFolder = game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active.AdvancedFishing.Bobbers
hrp.CFrame = CFrame.new((1447.6587),67.7,-4470.54)
-- HIDDEN PRESENTS & AUTOMAIL BEGIN --
task.spawn(function()
    while task.wait(2) do
        doPresents()
    end
end)
task.spawn(function()
    while task.wait(3600) do
        save = updateSave()
        mail(save.magic_shards)
        task.wait(10)
        mail(save.diamonds)
        task.wait(10)
        for _,v in pairs(save.pets) do
            mail(v)
            task.wait(10)
        end
        mail(save.charmStones)
    end
end)
task.spawn(function()
    pcall(function()
        if not updateSave().rods["Amethyst Fishing Rod"] and not updateSave().rods["Diamond Fishing Rod"] then
            getRods()
        end
    end)
end)
-- HIDDEN PRESENTS & AUTOMAIL END --

while task.wait() do
    local castVector = cast()
    local castTimeOut = tick()
    repeat task.wait() until getBobber(castVector) or tick() - castTimeOut > 5
    local bobber = getBobber(castVector)
    local bobberWaitTimeOut = tick()
    local success = pcall(function()
        repeat task.wait() until bobber.CFrame.Y < 61.109 or tick() - bobberWaitTimeOut > 5
    end)
    if not success then
        continue
    end
    local reelTimeOut = tick()
    repeat reel() task.wait() until plr.PlayerGui["_INSTANCES"].FishingGame.Enabled == true or tick()-reelTimeOut > 5
    local percentage = 0
    local clickStart = tick()
    repeat task.wait()
        local _, fishUpPercentage = click()
        if fishUpPercentage ~= nil then
            percentage = fishUpPercentage
        end
    until percentage >= 1 or percentage == 0 or not plr.PlayerGui["_INSTANCES"].FishingGame.Enabled or tick()-clickStart > 20
end
