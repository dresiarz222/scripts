local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dresiarz222/rgblib/main/main.lua"))()

local win = VLib:Window("dougware v1", "a ps99 hub", Enum.KeyCode.RightShift)

local ss1 = win:Tab("HOW TO USE")
local ss = win:Tab("MAIN")
local sss = win:Tab("MISC")
local cred = win:Tab("CREDITS")
    
ss:Dropdown("Mobs To Farm",Npc_Table,function(t)
mobs = t     
end) 

ss:Slider("Distance",-9,10,3,function(t)
distance = t     
end)
            
sss:Toggle("Spam X Skill",function(t)
skillsX = t 
while skillsX do wait() 
    pcall(function()
            local LP = game:GetService("Players").LocalPlayer
            local VIM = game:GetService("VirtualInputManager")
         VIM:SendKeyEvent(true, Enum.KeyCode.X, false, game)
        end)
    end
end)

cred:Button("Discord Server",function()
end) 

cred:Label("made with love by dougman and nazov <3")