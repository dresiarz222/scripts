getgenv().config = {
    eggName = "Witch Egg",
    maxEgg = 74,
    eggDelay = 2
}
-- no touchy past this point
getgenv().on = true
local savemodule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local SaveFile = savemodule.Get(game.Players.LocalPlayer)
local MiscInv = SaveFile.Inventory.Misc
local fruitInv = SaveFile.Inventory.Fruit
plr = game.Players.LocalPlayer
hrp = plr.Character:FindFirstChild("HumanoidRootPart")
local virtualuser = game:GetService("VirtualUser")
fruitCmds = require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds)
game.RunService:Set3dRenderingEnabled(false)

loadstring(game:HttpGet("https://pastebin.com/raw/A1dBAiSy"))() -- optimization

function eggSkip()
    pcall(function() 
        plr.PlayerScripts.Scripts.Game["Egg Opening Frontend"]:Destroy() 
    end)
    --loadstring(game:HttpGet("https://pastebin.com/raw/rgERYiZj"))()
end
function infPetSpeed()
    require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier = function() return 200 end
end
function autoFruits()
    while task.wait(10) do
        for ID,value in pairs(fruitInv) do
            if value.id == "Banana" or value.id == "Apple" or value.id == "Rainbow" or value.id == "Orange" or value.id == "Pineapple" and value._am >= 1 then
                for i=1,(20-#fruitCmds.GetActiveFruits()[value.id]) do
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Fruits: Consume"):FireServer(ID,1)
                    task.wait(0.2)
                end
            end
        end
    end
end
function autofarmON()
    if not plr.PlayerGui.MainLeft.Left.Tools.AutoPets.StatusOn.Visible then
        game:GetService("ReplicatedStorage").Library.Signal["Side Button AutoPets"]:Fire()
    end
end
function antiafk()
    plr.Idled:connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(math.random(3,4))
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

antiafk()
hrp.CFrame = CFrame.new(256.51,16.23,3568.124)
task.wait(3)
autofarmON()
task.wait(3)
hrp.CFrame = CFrame.new(-26.833,55.805,-122.452)
task.wait(3)
hrp.Anchored = true
task.wait(3)
hrp.CFrame = CFrame.new(9e9,9e9,9e9)

task.spawn(eggSkip)
task.spawn(autoFruits)
task.spawn(infPetSpeed)
while getgenv().on do
    local args = {
        [1] = config.eggName,
        [2] = config.maxEgg
    }
    game:GetService("ReplicatedStorage").Network.Eggs_RequestPurchase:InvokeServer(unpack(args))
    task.wait(config.eggDelay)
end
