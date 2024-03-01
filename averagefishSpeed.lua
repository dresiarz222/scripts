local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local successBindable = Instance.new("BindableEvent")
successBindable.Parent = plr
successBindable.Name = "fishinSuccess"
local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
function getCastingAnimation()
	for _, animation in humanoid:GetPlayingAnimationTracks() do
		if animation.animation.AnimationId == "rbxassetid://15281163971" then
			return animation
		end
	end
	return nil
end
local advancedfishingMod = require(workspace.__THINGS.__INSTANCE_CONTAINER.Active.AdvancedFishing.ClientModule)
local advancedSuccess = advancedfishingMod.Networking.FishingSuccess
advancedfishingMod.Networking.FishingSuccess = function(...)
    local args = {...}; local iteminfo = args[4]
    local playerinfo = args[2]; local playercheck = tostring(playerinfo)
    if playercheck == game.Players.LocalPlayer.Name then
        game:GetService("Players").LocalPlayer:FindFirstChild("fishinSuccess"):Fire()
    end
    return advancedSuccess(table.unpack(args))
end
local castCount = 0
local totalFishTime = 0
while task.wait() do
    repeat task.wait() until getCastingAnimation()
    local tickStart = tick()
    castCount += 1
    successBindable.Event:Wait()
    totalFishTime += tick()-tickStart
    print("average cast is", totalFishTime/castCount)
end