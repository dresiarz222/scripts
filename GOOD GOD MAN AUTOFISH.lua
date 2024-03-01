getgenv().config = {
    mailUser = "Dresik1337",
    minShards = 500, -- minimum shards to mail
    minGems = 5000000,
    mailMsg = "#doug99",
    fps = 10,
    gui = true
}

if getgenv().Executed then
    return
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().Executed = true
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local advancedFishingCFrame = CFrame.new(-184.91,124.56,5170.91)
local advancedFishingLeaveCFrame = CFrame.new(1336.138,71.231,-4442.78)
local fishingEnter = CFrame.new(795.196,27.157,1136.443)
local fishingLeave = CFrame.new(1051.025,86.659,-3441.567)
local libInstance = game:GetService("ReplicatedStorage"):WaitForChild("Library")
task.wait(5)
local Lib = require(libInstance)
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local diamondPos = Vector3.new(1120.777,50.57,-4897.89)
-- OPTIMIZATIONS BEGIN --
task.spawn(function()
    pcall(function()
        for i=1,10 do
            setfps(config.fps)
            setfpscap(config.fps)
        end
    end)
end)
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
    greyScreen()
end

if config.gui == true and not getgenv().InputConnection then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    local uis = game:GetService("UserInputService")
    getgenv().InputConnection = uis.InputBegan:Connect(function(key, gameProcessed)
        pcall(function(key)
            if key.KeyCode == Enum.KeyCode.P then
                if plr.PlayerGui:FindFirstChild("doug99").Enabled == true then
                    game:GetService("RunService"):Set3dRenderingEnabled(true)
                    plr.PlayerGui:FindFirstChild("doug99").Enabled = false
                elseif plr.PlayerGui:FindFirstChild("doug99").Enabled == false then
                    game:GetService("RunService"):Set3dRenderingEnabled(false)
                    plr.PlayerGui:FindFirstChild("doug99").Enabled = true
                end 
            end
        end,key)
    end)
end
-- OPTIMIZATIONS END --

hrp = plr.Character:WaitForChild("HumanoidRootPart")
repeat task.wait() until libInstance:FindFirstChild("Client")
repeat task.wait() until libInstance:FindFirstChild("Client"):FindFirstChild("Save")
savemodule = require(libInstance.Client.Save)
function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(5)
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Server Closing"].Enabled = false
    local old 
    old = hookmetamethod(game,"__namecall",(function(...) 
    local self,arg = ...
    if not checkcaller() then 
        if tostring(self) == "__BLUNDER" or tostring(self) == "Move Server" then return end
    end
    return old(...)
end))
game.ReplicatedStorage.Network["Idle Tracking: Stop Timer"]:FireServer()
end
plrs.PlayerAdded:Connect(function(player)
    if player:IsInGroup(5060810) then
        game:Shutdown()
    end
end)
antiafk()
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
                return Lib.Network.Invoke("Mailbox: Send", unpack(args))
            end
        elseif item.name == "Charm Stone" then
            if arg5 > 20 then
                return Lib.Network.Invoke("Mailbox: Send", unpack(args))
            end
        elseif item.name == "Diamonds" then
            if arg5 > config.minGems then
                args[5] -= 500000
                return Lib.Network.Invoke("Mailbox: Send", unpack(args))
            end
        elseif string.find(item.name,"Huge Poseidon Corgi") then
            if save.pets[item.name] then
                return Lib.Network.Invoke("Mailbox: Send", unpack(args))
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
function cast()
    local args = {
        [1] = "AdvancedFishing",
        [2] = "RequestCast",
        [3] = Vector3.new(diamondPos.X,60,diamondPos.Z)
    }
    Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))
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
end
function doPresents()
    for _,v in pairs(savemodule.Get().HiddenPresents) do
        if not v.Found and v.ID then
            Lib.Network.Invoke("Hidden Presents: Found",v.ID)
        end
    end
end
function getLine()
    if plr.Character:FindFirstChild("Model") then
        if plr.Character:FindFirstChild("Model"):FindFirstChild("Rod") and plr.Character:FindFirstChild("Model"):FindFirstChild("Rod"):FindFirstChild("FishingLine") then
            return true
        end
    end
    return nil
end
function spoofers()
    local SpoofTable = {
        WalkSpeed = 16,
        JumpPower = 50
    }
    local __index
__index = hookmetamethod(game, "__index", function(t, k)
	-- // Make sure it's trying to get our humanoid's ws/jp
	if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
		-- // Return spoof values
		return SpoofTable[k]
	end

	-- //
	return __index(t, k)
end)

-- // __newindex hook
local __newindex
__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
	-- // Make sure it's trying to set our humanoid's ws/jp
	if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
		-- // Add values to spoof table
		SpoofTable[k] = v

		-- // Disallow the set
		return
	end

	-- //
	return __newindex(t, k, v)
end)
end
spoofers()
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
print("waiting for active")
repeat task.wait() until game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"]:FindFirstChild("Active")
print("waiting for advancedfishing")
repeat task.wait() until game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active:FindFirstChild("AdvancedFishing")
advancedfishing = game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active:FindFirstChild("AdvancedFishing")
print("waiting for bobbers")
repeat task.wait() until advancedfishing:FindFirstChild("Bobbers")
rodFolder = advancedfishing:FindFirstChild("Bobbers")
hrp.CFrame = CFrame.new(diamondPos)
local BP = Instance.new("BodyPosition")
BP.Parent = hrp
BP.Name = "bp"
BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
hrp.CFrame = CFrame.new(diamondPos)
BP.Position = diamondPos
-- ENTIRE MAGIC OF THE SCRIPT --
print("waiting for clientModule")
advancedfishing:WaitForChild("ClientModule")
print("got clientModule")
local mod = require(advancedfishing:FindFirstChild("ClientModule"))
local old = mod.Networking.Cast
mod.Networking.Cast = function(...)
    local args = {...}
    if tostring(args[2]) == game:GetService("Players").LocalPlayer.Name then
        return old(...)
    else
        return
    end
end
local old1 = mod.Networking.Hook
mod.Networking.Hook = function(...)
    local args = {...}
    if tostring(args[2]) == game:GetService("Players").LocalPlayer.Name then
        return old1(...)
    else
        return
    end
end
for _,v in rodFolder:GetChildren() do
    v:Destroy()
end
-- MAGIC END --

--[[
local fishingSuccessBindable = Instance.new("BindableEvent")
fishingSuccessBindable.Parent = plr

local advancedfishingMod = require(workspace.__THINGS.__INSTANCE_CONTAINER.Active.AdvancedFishing.ClientModule)
local advancedSuccess = advancedfishingMod.Networking.FishingSuccess
advancedfishingMod.Networking.FishingSuccess = function(...)
    local args = {...}; local iteminfo = args[4]
    local playerinfo = args[2]; local playercheck = tostring(playerinfo)
    if playercheck == game.Players.LocalPlayer.Name then
        game:GetService("Players").LocalPlayer:FindFirstChildOfClass("BindableEvent"):Fire()
    end
    return advancedSuccess(...)
end
]]--

-- HIDDEN PRESENTS & AUTOMAIL BEGIN --
task.spawn(function()
    while task.wait(2) do
        doPresents()
        pcall(function()
            if not updateSave().rods["Amethyst Fishing Rod"] and not updateSave().rods["Diamond Fishing Rod"] then
                getRods()
            end
        end)
    end
end)
task.spawn(function()
    while task.wait(43200) do
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
local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
function getCastingAnimation()
	for _, animation in humanoid:GetPlayingAnimationTracks() do
		if animation.animation.AnimationId == "rbxassetid://15281163971" then
			return animation
		end
	end
	return nil
end
task.wait(5)
-- HIDDEN PRESENTS & AUTOMAIL END --
while task.wait() do
    cast()
    local tickStart = tick()
    repeat task.wait() until getLine() or tick()-tickStart>5
    if not getLine() then continue end
    if getCastingAnimation() then
        getCastingAnimation().Stopped:Wait()
    end
    local rod = rodFolder:GetChildren()[1]
    local tickStart = tick()
    repeat task.wait() until rod:FindFirstChild("Bobber") or not getLine() or tick()-tickStart>5
    if not getLine() then continue end
    local bobber = rod.Bobber
    repeat task.wait() until bobber.CFrame.Y < 59.999
    reel()
    local percentage = 0
    repeat task.wait()
        local _, fishUpPercentage = click()
        if fishUpPercentage ~= nil then
            percentage = fishUpPercentage
        end
    until percentage >= 1 or percentage == 0 or plr.PlayerGui["_INSTANCES"].FishingGame.Enabled == false or not getLine()
end
