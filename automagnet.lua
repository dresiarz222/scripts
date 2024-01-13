plr = game.Players.LocalPlayer
game.RunService:Set3dRenderingEnabled(false)
plr.Character.HumanoidRootPart.CFrame = CFrame.new(256.51,16.23,3568.124)
task.wait(5)
plr.Character.HumanoidRootPart.Anchored = true
local virtualuser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(math.random(3,4))
virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
loadstring(game:HttpGet("https://pastebin.com/raw/A1dBAiSy"))() -- optimization
local savemodule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local SaveFile = savemodule.Get(game.Players.LocalPlayer)
local SaveIndex = "Inventory" 
local MiscInv = SaveFile.Inventory.Misc
local FlagToPlace = "Magnet Flag" --Flag Name 
function infPetSpeed()
    require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier = function() return 200 end
end
infPetSpeed()
local function PlaceFlag()
    for ID,value in pairs(MiscInv) do
        if value.id == FlagToPlace and value._am >= 1 then --if named flag is found, and have 1+ in inven
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Flags: Consume"):InvokeServer(FlagToPlace, ID) --flag name, id found
        end
    end
end
while true do
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(256.51,16.23,3568.124)
    task.wait(1)
    PlaceFlag()
    task.wait(1)
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(9e9,9e9,9e9)
    task.wait(300)
end



