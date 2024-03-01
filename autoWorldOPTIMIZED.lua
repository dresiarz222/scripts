getgenv().config = {
    petSlots = 12
}

if getgenv().autoWorldExecuted then
    return
end
getgenv().autoWorldExecuted = true
print("executed")
setfpscap(10)
RunService = game:GetService("RunService")
--RunService:Set3dRenderingEnabled(false)
workspace = game:GetService("Workspace")
savemodule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
plrs = game:GetService("Players")
plr = plrs.LocalPlayer
hrp = plr.Character:FindFirstChild("HumanoidRootPart")
orbRemote = game:GetService("ReplicatedStorage").Network:FindFirstChild("Orbs: Collect")
orbFolder = game:GetService("Workspace")["__THINGS"]:FindFirstChild("Orbs")
lootbagFolder = game:GetService("Workspace"):FindFirstChild("__THINGS"):FindFirstChild("Lootbags")
lootbagRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Network"):FindFirstChild("Lootbags_Claim")
area_indexTable = {}
zonesDir = require(game:GetService("ReplicatedStorage").Library.Directory.Zones)
areasNum = 0
for j,k in pairs(zonesDir) do
    area_indexTable[k["ZoneNumber"]] = j
    areasNum += 1
end
for i,v in pairs(area_indexTable) do
    print(i, v)
end
print("zones done")
function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(5)
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
end
function getPetSlots(count)
    tp(4)
    task.wait(5)
    for i=1,count do
        local args = {
            [1] = tonumber(i)
        }
        game:GetService("ReplicatedStorage").Network.EquipSlotsMachine_RequestPurchase:InvokeServer(unpack(args))
        task.wait(1)
    end
end
getPetSlots(config.petSlots)
function getSave()
    SaveFile = savemodule.Get(game.Players.LocalPlayer)
    UnlockedAreas = SaveFile.UnlockedZones
    save = {
        lastAreaIndex = 0,
        rebirths = 0,
    }
    for i,v in pairs(UnlockedAreas) do
        save.lastAreaIndex += 1
    end
    save.rebirths = SaveFile.Rebirths
    return save
end
function buyZone(index)
    args = {
        [1] = area_indexTable[index]
    }
    return game:GetService("ReplicatedStorage").Network.Zones_RequestPurchase:InvokeServer(unpack(args))
end
function autoOrbs()
    autoOrbConnection = orbFolder.ChildAdded:Connect(function(v)
        orbRemote:FireServer({tonumber(v.Name)})
        task.wait()
        v:Destroy()
    end)
end
function autoLootBags()
    autoLootBagConnection = lootbagFolder.ChildAdded:Connect(function(v)
        lootbagRemote:FireServer({v.Name})
        task.wait()
        v:Destroy()
    end)
end
function infPetSpeed()
    require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier = function() return 200 end
end
areaCFrames = {}
function tp(index)
    if areaCFrames[index] then
        hrp.CFrame = areaCFrames[index]
        return
    end
    persistentTpCFrame = workspace.Map[index.." | " ..area_indexTable[index]].PERSISTENT.Teleport.CFrame
    hrp.CFrame = persistentTpCFrame
    repeat task.wait() until workspace.Map[index.." | " ..area_indexTable[index]]:FindFirstChild("BREAK_ZONE",true)
    breakZoneVectors = {}
    teleport_zone_Magnitudes = {}
    if #workspace.Map[index.." | " ..area_indexTable[index]]:FindFirstChild("INTERACT"):FindFirstChild("BREAK_ZONES"):GetChildren() >= 2 then
        breakZones = workspace.Map[index.." | " ..area_indexTable[index]]:FindFirstChild("INTERACT"):FindFirstChild("BREAK_ZONES"):GetChildren()
        for i,v in pairs(breakZones) do
            table.insert(breakZoneVectors,v.CFrame.Position)
        end
        for i,v in pairs(breakZoneVectors) do
            table.insert(teleport_zone_Magnitudes,(v-persistentTpCFrame.Position).Magnitude)
        end
        smallestVectorSaved = teleport_zone_Magnitudes[1]
        for _, value in ipairs(teleport_zone_Magnitudes) do
            if value < smallestVectorSaved then
                smallestVectorSaved = value
            end
        end
        for i,v in pairs(breakZones) do
            print("distance from dynamic distance to saved smallest distance is", math.abs(math.floor((v.CFrame.Position-persistentTpCFrame.Position).Magnitude)-math.floor(smallestVectorSaved)))
            if math.abs(math.floor((v.CFrame.Position-persistentTpCFrame.Position).Magnitude)-math.floor(smallestVectorSaved)) < 5 then
                areaCFrames[index] = v.CFrame
            end
        end
    elseif #workspace.Map[index.." | " ..area_indexTable[index]]:FindFirstChild("INTERACT"):FindFirstChild("BREAK_ZONES"):GetChildren() == 1 then
        areaCFrames[index] = workspace.Map[index.." | " ..area_indexTable[index]]:FindFirstChild("INTERACT"):FindFirstChild("BREAK_ZONES"):FindFirstChild("BREAK_ZONE").CFrame
    end
    hrp.CFrame = areaCFrames[index]
end
function rebirth(number)
    local args = {
        [1] = tostring(number)
    }
    return game:GetService("ReplicatedStorage").Network.Rebirth_Request:InvokeServer(unpack(args))
end
function optimize()
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
    for i,v in pairs(game.workspace['__THINGS'].Breakables:GetChildren()) do
        if v:FindFirstChildOfClass("MeshPart") then
            v:FindFirstChildOfClass("MeshPart").Transparency = 1
        end
    end
    game.workspace['__THINGS'].Breakables.ChildAdded:Connect(function(child)
        if child:FindFirstChildOfClass("MeshPart") then
            child:FindFirstChildOfClass("MeshPart").Transparency = 1
        end
    end)
end
optimize()

getgenv().AutoTap = true
local Player = game.Players.LocalPlayer
local Char = Player.Character
local Hum = Char:FindFirstChild("HumanoidRootPart", true)
local Breakables = game.workspace['__THINGS'].Breakables
local Network = game.ReplicatedStorage.Network
function autoTap()
    while getgenv().AutoTap and task.wait() do
        for _,v in pairs(Breakables:GetChildren()) do
            if v:FindFirstChild("Hitbox", true) then
                if (v:FindFirstChild("Hitbox", true).Position-Hum.Position).Magnitude <= Radius then
                    Network.Breakables_PlayerDealDamage:FireServer(v.Name)
                end
            end 
        end
    end
end
coroutine.wrap(autoTap)()
antiafk()
autoLootBags()
autoOrbs()
infPetSpeed()
print("areas num is", areasNum)
print("lastIndex is")
print(getSave().lastAreaIndex)
while getSave().lastAreaIndex < areasNum and task.wait() do
    lastIndex = getSave().lastAreaIndex
    tp(lastIndex)
    if buyZone(lastIndex+1) == true then
        if getSave().rebirths < 3 and getSave().lastAreaIndex >= 25*(getSave().rebirths+1) then
            print("rebirthing with arg")
            print(getSave().rebirths+1)
            autoLootBagConnection:Disconnect()
            autoOrbConnection:Disconnect()
            task.wait(10)
            print("tping to index", 25*(getSave().rebirths+1))
            tp(25*(getSave().rebirths+1))
            task.wait(10)
            rebirth(getSave().rebirths+1)
            task.wait(10)
            autoOrbs()
            autoLootBags()
        end
    end
end
autoLootBagConnection:Disconnect()
autoOrbConnection:Disconnect()