plr = game.Players.LocalPlayer
game.RunService:Set3dRenderingEnabled(false)
local virtualuser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(math.random(3,4))
virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
--loadstring(game:HttpGet("https://pastebin.com/raw/A1dBAiSy"))() -- optimization
local savemodule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local SaveFile = savemodule.Get(game.Players.LocalPlayer)
local SaveIndex = "Inventory" 
local MiscInv = SaveFile.Inventory.Misc
local FlagToPlace = "Magnet Flag" --Flag Name 
function getFlag(flag)
    for ID,value in pairs(MiscInv) do
        if value.id == flag and value._am >= 1 then --if named flag is found, and have 1+ in inven
            return ID
        end
    end
end
magnetUID = getFlag("Diamonds Flag")
while true do
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Flags: Consume"):InvokeServer(FlagToPlace, magnetUID) --flag name, id found
    task.wait(300)
end