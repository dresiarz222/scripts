local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local diamondPos = Vector3.new(1547.62,53.165,-4481.09)
local TweenService = game:GetService("TweenService")
hrp.Anchored = false
if hrp:FindFirstChildOfClass("BodyPosition") then
    hrp:FindFirstChildOfClass("BodyPosition"):Destroy()
end
local advancedFishingCFrame = CFrame.new(-184.91,124.56,5170.91)
function tweenPart(part, cframe)
    if not part then
        print("part not found")
        return
    end
    local tweenInfo = TweenInfo.new(
        1,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out,
        0,
        false,
        1
    )   
    local tween = TweenService:Create(part, tweenInfo, {CFrame = cframe})
    tween:Play()
    return tween
end
tweenPart(hrp,advancedFishingCFrame)

local BP = Instance.new("BodyPosition")
BP.Parent = hrp
BP.Name = "bp"
BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
hrp.CFrame = CFrame.new(diamondPos)
BP.Position = diamondPos

local libInstance = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Lib = require(libInstance)
local args = {
    [1] = "AdvancedFishing",
    [2] = "RequestCast",
    [3] = Vector3.new(1424,60,-4448.54)
}
Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))


local args = {
    [1] = "AdvancedFishing",
    [2] = "RequestReel"
}
Lib.Network.Fire("Instancing_FireCustomFromClient", unpack(args))