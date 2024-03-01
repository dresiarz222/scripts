if getgenv().Executed then
    return
else
    getgenv().Executed = true
end

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
for _,v in plrs:GetPlayers() do
    if v.Character and v.UserId ~= plr.UserId then
        v:ClearAllChildren()
    end
end
plrs.PlayerAdded:Connect(function(v)
    if v.UserId == plr.UserId then
        return
    end
    repeat task.wait() until v.Character
    v.Character:ClearAllChildren()
end)
function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(math.random(2,4))
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end
antiafk()
repeat task.wait()
    plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-262.611725, 22.5903587, -1135.40076, 0.905258954, -2.13175588e-09, -0.424860209, -4.58975025e-10, 1, -5.99549477e-09, 0.424860209, 5.62247582e-09, 0.905258954)
    pcall(function()
        if not plr.Character:FindFirstChild("Combat") then
            plr.Character:WaitForChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild("Combat"))
        end
    end)
    plr.Character:WaitForChild("Combat"):Activate()
    task.wait()
    plr.Character:WaitForChild("Combat"):Deactivate()
until tonumber(plr.DataFolder.Information:WaitForChild("BoxingValue").Value) >= 2500
for _,v in pairs(workspace.Ignored.Shop:GetChildren()) do
    if string.find(v.Name,"Boxing Moveset") then
        moveset = v
        break
    end
end
print("got moveset")
plr.Character:WaitForChild("HumanoidRootPart").CFrame = moveset.Head.CFrame
task.wait(5)
print("firing moveset clickdetector")
fireclickdetector(moveset:FindFirstChildOfClass("ClickDetector"))
print("shutting down")
game:Shutdown()