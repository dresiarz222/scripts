if getgenv().Executed then
    return
else
    getgenv().Executed = true
end

print("executed")
loadstring(game:HttpGet("https://raw.githubusercontent.com/dresiarz222/anticheatbypass/main/anticheatbypass.lua"))()

local Workspace = game:GetService("Workspace")
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
Workspace:WaitForChild("Ignored")
local dropFolder = Workspace.Ignored:WaitForChild("Drop")
plr.Character:WaitForChild("BodyEffects")
plr.Character.BodyEffects:WaitForChild("Cuff")
local ok = "[+]"
local info = "[*]"
local done = false
--[[
local OpenPositions = {
    Vector3.new(-475.97125244140625, 22.949996948242188, -291.6875915527344),
    Vector3.new(-475.7712097167969, 22.950021743774414, -283.4876708984375),
    Vector3.new(-475.7712097167969, 22.950021743774414, -275.6878662109375),
    Vector3.new(-250.57122802734375, 21.85519027709961, -410.0876159667969),
    Vector3.new(-3.2987112998962402, 21.450021743774414, -101.2146987915039),
    Vector3.new(583.8019409179688, 48.750030517578125, -275.060546875),
    Vector3.new(596.90185546875, 51.31678771972656, -469.8149108886719),
    Vector3.new(-450.8978576660156, 22.850006103515625, -331.76031494140625),
    Vector3.new(94.70175170898438, 22.650014877319336, -520.7592163085938),
    Vector3.new(-401.6098327636719, 22.850004196166992, -590.2988891601562),
    Vector3.new(517.6295776367188, 49.25000762939453, -302.504150390625),
    Vector3.new(-219.88063049316406, 23.050006866455078, -786.9600219726562),
    Vector3.new(577.3017578125, 51.31678771972656, -469.8145446777344),
    Vector3.new(-480.89825439453125, 22.450021743774414, -78.31484985351562),
    Vector3.new(-624.5984497070312, 22.850021362304688, -286.6582336425781),
    Vector3.new(-627.5984497070312, 22.850021362304688, -286.6581726074219),
    Vector3.new(-807.9248046875, 22.850006103515625, -286.7871398925781),
    Vector3.new(-941.0987548828125, 22.850006103515625, -164.36013793945312),
    Vector3.new(-951.4989013671875, 22.850006103515625, -164.36013793945312),
    Vector3.new(-861.5985717773438, 22.45001983642578, -89.3124008178711),
    Vector3.new(-870.7984619140625, 22.45001983642578, -89.3124008178711),
    Vector3.new(-556.1212158203125, 23.124998092651367, 269.74993896484375),
    Vector3.new(-611.7501220703125, 21.625, 272.2710876464844),
    Vector3.new(-938.8798828125, 21.756710052490234, -656.7500610351562),
    Vector3.new(-938.8798828125, 21.756710052490234, -663.7500610351562),
    Vector3.new(-858.0089111328125, 21.8800048828125, -660.875),
    Vector3.new(-796.505126953125, 21.8800048828125, -655.875)
}
]]--
local OpenInstances = {}
for _,v in Workspace.Cashiers:GetChildren() do
    table.insert(OpenInstances,v.Open)
end

for _,v in Workspace:GetDescendants() do
    if v:IsA("Seat") or v:IsA("VehicleSeat") then
        v.Disabled = true
    end
end

print(info, "Player Ping is:" , plr:GetNetworkPing()*2500)

-- delete atms except for model and humanoid --
--[[
for _,v in cashiers do
    for _,k in v:GetChildren() do
        if k:IsA("Humanoid") then
            continue
        elseif k.Name == "Open" then
            k.CanCollide = false
            --k.Transparency = 1
        else
            k:Destroy()
        end
    end
end
]]--
-- deleting end --

function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(math.random(2,4))
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

function cashPartVal(cashPartObject)
    repeat task.wait() until cashPartObject:WaitForChild("BillboardGui"):WaitForChild("TextLabel")
    local text = cashPartObject.BillboardGui.TextLabel.Text
    text = text:gsub("[%$,]", "")
    if text then
        return tonumber(text)
    end
    
end

function checkPlayersNearby() -- TODO
    return false
end

function pickCash(savedPos)
    for _,v in dropFolder:GetChildren() do
        if v.Name == "MoneyDrop" then
            if (v.Position-savedPos).Magnitude <= 10 and cashPartVal(v) > 100 then
                pcall(function()
                    repeat 
                        if not checkPlayersNearby() and plr.Character:WaitForChild("Humanoid").Health > 0 then
                            fireclickdetector(v.ClickDetector)
                        end
                        task.wait()
                    until not v or plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true or checkPlayersNearby() or plr.Character:WaitForChild("Humanoid").Health <= 0
                end)
            end
        end
    end
end

function breakAtm(index)
    if index == 15 then
        atmCFrame = CFrame.new(-620.718262, 25.6308784, -285.94696, -0.802775383, 1.36148106e-08, 0.596281588, -6.88529722e-09, 1, -3.21025482e-08, -0.596281588, -2.98767091e-08, -0.802775383)
    elseif index == 16 then
        atmCFrame =  CFrame.new(-632.613403, 25.6308784, -286.729065, -0.561874747, -4.42204673e-08, -0.827222347, 2.70161742e-08, 1, -7.1806781e-08, 0.827222347, -6.26947951e-08, -0.561874747)
    else
        atmCFrame = OpenInstances[index].CFrame
    end
    local atmOpen = OpenInstances[index]
    task.spawn(function()
        repeat 
            plr.Character:WaitForChild("HumanoidRootPart").CFrame = atmCFrame
            task.wait()
        until atmOpen.Size.Z >= 1 or plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true
    end)
    task.spawn(function()
        pcall(function()
            repeat
                if plr.Backpack:FindFirstChild("Combat") or plr.Backpack:FindFirstChild("Combat") and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and plr.Character:WaitForChild("BodyEffects"):WaitForChild("Dead") == false then
                    plr.Character:WaitForChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild("Combat"))
                    plr.Character:WaitForChild("Humanoid"):EquipTool(plr.Character:FindFirstChild("Combat"))
                end
                task.wait()
            until atmOpen.Size.Z >= 1 or plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true
        end)
    end)
    pcall(function()
        repeat 
            if plr.Character and plr.Character:FindFirstChild("Humanoid").Health > 0 then
                plr.Character:FindFirstChild("Combat"):Activate()
            end
            task.wait()
        until atmOpen.Size.Z >= 1 or plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true
    end)
end

function atmLoop()
    while task.wait() do
        if plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true then 
            repeat task.wait() until plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == false
        end
        for i=1,#OpenInstances do
            if OpenInstances[i].Size.Z >= 1 then
                continue
            end
            print(info, "Breaking atm:", i)
            done = true
            breakAtm(i)
            local savedPos = plr.Character:WaitForChild("HumanoidRootPart").CFrame.Position
            if plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == false then
                done = false
                local savedCFrame = plr.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0,-7,0)
                task.spawn(function()
                    repeat 
                        plr.Character:WaitForChild("HumanoidRootPart").CFrame = savedCFrame
                        task.wait()
                    until plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true or done == true
                end)
            end
            print(ok, "Broke atm", i)
            print(info, "picking cash")
            task.wait(plr:GetNetworkPing()*5)
            pickCash(savedPos)
            print(ok, "picked cash")
            task.wait(plr:GetNetworkPing()*5)
        end
    end
end
-- GET KEY OBJECT
for _,v in game:GetService("Workspace").Ignored.Shop:GetChildren() do
    if string.find(v.Name,"Key") then
        keyModel = v
        break
    end
end
-- END
function getKey()
    repeat task.wait(1)
        repeat task.wait()
            plr.Character:WaitForChild("HumanoidRootPart").CFrame = keyModel.Head.CFrame
            fireclickdetector(keyModel:FindFirstChildOfClass("ClickDetector"))
        until plr.Backpack:FindFirstChild("[Key]") or plr.Character:FindFirstChild("[Key]")
        pcall(function()
            plr.Character:WaitForChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild("[Key]"))
            task.wait()
            plr.Character:FindFirstChild("[Key]"):Activate()
        end)
    until not plr.Backpack:FindFirstChild("[Key]") and not plr.Character:FindFirstChild("[Key]")
end

plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff"):GetPropertyChangedSignal("Value"):Connect(function()
    print("cuff is now", plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value)
    if plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true then
        task.wait(10)
        getKey()
    end
end)

if plr.Character:WaitForChild("BodyEffects"):WaitForChild("Cuff").Value == true then
    getKey()
end

antiafk()
atmLoop()
