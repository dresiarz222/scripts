if getgenv().Executed then return end
getgenv().Executed = true

if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- variables
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local options = {}
local orbFolder = game:GetService("Workspace"):WaitForChild("__THINGS"):WaitForChild("Orbs")
local lootbagFolder = workspace:WaitForChild("__THINGS"):WaitForChild("Lootbags")
local breakablesFolder = game:GetService("Workspace"):WaitForChild("__THINGS"):WaitForChild("Breakables")
local libObject = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local clientObject = libObject:WaitForChild("Client")
task.wait(5) -- for good measure :)
-- requires
local Lib = require(libObject)
local Client = require(clientObject)

getfenv().LPH_NO_VIRTUALIZE = function(f) return f end; -- IMPORTANT LEAVE FOR SRC CODE TESTING, REMOVE FOR LUARMOR



function doPresents()
	for _,v in Client.Save.Get().HiddenPresents do
		if not v.Found and v.ID then
			Lib.Network.Invoke("Hidden Presents: Found",v.ID)
		end
	end
end
function infPetSpeed()
	local success, errorMsg = pcall(function() 
		hookfunction(Client.PlayerPet.CalculateSpeedMultiplier,function() return 200 end)
	end)
	if not success then
		print("InfPetSpeed error:", errorMsg)
	end
end
function antiafk()
	local virtualuser = game:GetService("VirtualUser")
	plr.Idled:Connect(function()
		pcall(function()
			virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(math.random(3,5))
			virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end)
	plr.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
	plr.PlayerScripts.Scripts.Core["Server Closing"].Enabled = false
	--[[ imma be honest i have no clue if this works but heavily impacts performance so bye bye
	local old 
	old = hookmetamethod(game,"__namecall",LPH_NO_VIRTUALIZE(function(...) 
		local self,arg = ...
		if not checkcaller() then 
			if tostring(self) == "__BLUNDER" or tostring(self) == "Move Server" then return end
		end
		return old(...)
	end))
	--]]
	Lib.Network.Fire("Idle Tracking: Stop Timer")
end
function autoFruits() -- TODO to be completely reworked this dogshit function :sob:
	while options["autoFruits"] do
		fruitTimes = {}
		getFruitIds()
		for _,fruit in pairs(fruits) do
			if not getFruitCount(fruit) then break end
			if not #fruitCmds.GetActiveFruits()[fruit] then
				fruitCount = 0
			else
				fruitCount = #fruitCmds.GetActiveFruits()[fruit]
			end
			print("usin", 20-fruitCount, fruit, "id is", fruitIdList[fruit])
			for i=1,(20-fruitCount) do
				game:GetService("ReplicatedStorage").Network:FindFirstChild("Fruits: Consume"):FireServer(fruitIdList[fruit],1)
				task.wait(0.35)
			end
		end
		for i,v in pairs(fruits) do
			if fruitCmds.GetActiveFruits()[v] then
				table.insert(fruitTimes,fruitCmds.GetActiveFruits()[v][1])
			end
		end
		print("waiting", math.min(unpack(fruitTimes)))
		task.wait(math.min(unpack(fruitTimes)))
	end
end
function autoToys() -- TODO same shit as above
	while options["autoToys"] do
		toyTimes = {}
		for i,v in pairs(toyList) do
			toyItem = plr.PlayerGui.Main.Boosts:FindFirstChild(v)
			if not toyItem then
				game:GetService("ReplicatedStorage").Network[removeSpaces(v).."_Consume"]:InvokeServer()
			elseif toyItem then
				table.insert(toyTimes,timeToSeconds(toyItem.TimeLeft.Text))
			end
		end
		if #toyTimes >= 1 then
			task.wait(math.min(unpack(toyTimes)))
		else
			task.wait(3)
		end
		task.wait(1)
	end
end
function hatchEggs(eggName) -- TODO needs improvement
	plr.PlayerScripts.Scripts.Game["Egg Opening Frontend"].Disabled = true
	while options["isHatching"] do
		args = {
			[1] = eggName,
			[2] = maxEgg
		}
		Lib.Network.Invoke("Eggs_RequestPurchase",unpack(args))
		task.wait()
	end
end
function autoOrbs(bool)
	if bool == true then
		autoOrbConnection = orbFolder.ChildAdded:Connect(function(v)
			if not tonumber((v.Name)) then
				Lib.Network.Fire("Orbs_ClaimMultiple",{v.Name})
			else
				Lib.Network.Fire("Orbs: Collect",{tonumber(v.Name)})
			end
			task.wait()
			v:Destroy()
		end)
	else
		if autoOrbConnection then
			autoOrbConnection:Disconnect()
		end
	end
end
function autoLootBags(bool)
	if bool == true then
		autoLootBagConnection = lootbagFolder.ChildAdded:Connect(function(v)
			Lib.Fire("Lootbags_Claim",{v.Name})
			task.wait()
			v:Destroy()
		end)
	else
		if autoLootBagConnection then
			autoLootBagConnection:Disconnect()
		end
	end
end
function autoFlag() -- TODO
	--game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Flags: Consume"):InvokeServer(config.flag, flagUID, flag amount) 
end
function hideItemNotifications()
	local mod = Client.NotificationCmds.Item
	local success, errorMsg = pcall(function()
		hookfunction(mod.Top,function() return end)
		hookfunction(mod.Bottom,function() return end)
	end)
	if not success then
		print("hideItemNotifications", errorMsg)
	end
end
function optimize()
	for _,v in breakablesFolder:GetChildren() do
		if v:IsA("Model") then
			local meshPart = v:FindFirstChildOfClass("MeshPart")
			if meshPart then
				meshPart.TextureID = "rbxassetid://0"
				meshPart.MeshId = "rbxassetid://0"
			end
		end
	end
	breakablesFolder.ChildAdded:Connect(function(v)
		if v:IsA("Model") then
			local meshPart = v:FindFirstChildOfClass("MeshPart")
			if meshPart then
				meshPart.TextureID = "rbxassetid://0"
				meshPart.MeshId = "rbxassetid://0"
			end
		end
	end)
	local emitFast = require(game:GetService("ReplicatedStorage").Library.Functions.EmitFast)
	local emit = require(game:GetService("ReplicatedStorage").Library.Functions.Emit)
	hookfunction(emit, function() return end)
	hookfunction(emitFast, function() return end)
	UserSettings():GetService("UserGameSettings").MasterVolume = 0
	local decalsyeeted = true
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	sethiddenproperty(l,"Technology",2)
	sethiddenproperty(t,"Decoration",false)
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = 0
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "1"
	for i, v in pairs(w:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("SpecialMesh") and decalsyeeted  then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.Graphic=1
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"]=1
		end
	end
	for i = 1,#l:GetChildren() do
		e=l:GetChildren()[i]
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
end

task.spawn(optimize)
task.spawn(hideItemNotifications)
task.spawn(antiafk)