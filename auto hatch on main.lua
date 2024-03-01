getgenv().config = {
    eggNumber = 113,
    
}
game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save")
local savemodule = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save"))
for i,v in savemodule.Get().PurchasedEggs do
    print(i, v)
    if type(v) == "table" then
        for j,k in v do
            print(j, k)
        end
    end
end
function getSave()
    local save = {}

    return savemodule.Get()
end
-- no touchy past this point
local plr = game.Players.LocalPlayer
local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
local libInstance = game:GetService("ReplicatedStorage"):WaitForChild("Library")
task.wait(5)
local Lib = require(libInstance)

loadstring(game:HttpGet("https://pastebin.com/raw/A1dBAiSy"))()

function eggSkip()
    pcall(function() 
        plr.PlayerScripts.Scripts.Game["Egg Opening Frontend"]:Disabled = true 
    end)
end
function infPetSpeed()
    hookfunction(require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier,function() return 1000 end)
end
function antiAfk()
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
function antiStaff()
    plrs.PlayerAdded:Connect(function(player)
        if player:IsInGroup(5060810) then
            game:Shutdown()
        end
    end)
end

antiAfk()
antiStaff()


while getgenv().on do
    local args = {
        [1] = config.eggName,
        [2] = config.maxEgg
    }
    game:GetService("ReplicatedStorage").Network.Eggs_RequestPurchase:InvokeServer(unpack(args))
    task.wait()
end
