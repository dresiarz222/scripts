loadstring(game:HttpGet("https://raw.githubusercontent.com/dresiarz222/anticheatbypass/main/anticheatbypass.lua"))()

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

for _,v in game:GetService("Workspace").Ignored.Shop:GetChildren() do
    if string.find(v.Name,"Key") then
        print("found them key B)")
        keyModel = v
        break
    end
end
function getKey()
    repeat task.wait()
        repeat task.wait()
            plr.Character:WaitForChild("HumanoidRootPart").CFrame = keyModel.Head.CFrame
            fireclickdetector(keyModel:FindFirstChildOfClass("ClickDetector"))
        until plr.Backpack:FindFirstChild("[Key]") or plr.Character:FindFirstChild("[Key]")
        pcall(function()
            plr.Character:WaitForChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild("[Key]"))
            task.wait()
            plr.Character:FindFirstChild("[Key]"):Activate()
        end)
        task.wait(5)
    until not plr.Backpack:FindFirstChild("[Key]") and not plr.Character:FindFirstChild("[Key]")
end
getKey()