plrs = game:GetService("Players")
plr = plrs.LocalPlayer
petsFolder = game:GetService("Workspace")["__THINGS"].Pets -- child of model in folder is pet
breakablesFolder =  game:GetService("Workspace")["__THINGS"].Breakables
eggsFolder = game:GetService("Workspace")["__THINGS"].Eggs
eggsOpeningFrontend = plr.PlayerScripts.Scripts.Game["Egg Opening Frontend"]
serverClosing = plr.PlayerScripts.Scripts.Core["Server Closing"]
idleTracking = plr.PlayerScripts.Scripts.Core["Idle Tracking"]
function consoleFps()
    getgenv().boostFPS = true 

repeat task.wait() until game:IsLoaded();

local vim = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")


setfpscap(5000)

CoreGui.DescendantAdded:Connect(function(d)
   if d.Name == "MainView" and d.Parent.Name == "DevConsoleUI" and boostFPS then
       task.wait()
       local screen = d.Parent.Parent.Parent
       screen.Enabled = false;
   end
end)

vim:SendKeyEvent(true, "F9", 0, game)    
wait()
vim:SendKeyEvent(false, "F9", 0, game)  

setfpscap(5000)

task.spawn(function()
	while true do task.wait()

        if not getgenv().boostFPS then
            local panel = CoreGui:FindFirstChild("DevConsoleMaster", true);

            if panel then
                panel.Enabled = true;
                vim:SendKeyEvent(true, "F9", 0, game)    
                vim:SendKeyEvent(false, "F9", 0, game)  
                repeat task.wait() until boostFPS
            end

            continue;
        end


		warn("")

		if not CoreGui:FindFirstChild("DevConsoleUI", true):FindFirstChild("MainView") then
			vim:SendKeyEvent(true, "F9", 0, game)    
			task.wait()
			vim:SendKeyEvent(false, "F9", 0, game)  
			continue
		end
	end
end)
end
function antiafk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(math.random(2,4))
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    eggsOpeningFrontend.Disabled = true
    serverClosing.Disabled = true
    idleTracking.Disabled = true
end
for i,v in petsFolder:GetDescendants() do
    if v:IsA("Part") then
        v.Transparency = 1
    end
end
petsFolder.DescendantAdded:Connect(function(v)
    pcall(function()
        v.Transparency = 1
    end)
end)
for i,v in breakablesFolder:GetDescendants() do
    pcall(function()
        v.Transparency = 1
    end)
end
for i,v in eggsFolder:GetDescendants() do
    pcall(function()
        v.Transparency = 1
    end)
end
antiafk()
consoleFps()
