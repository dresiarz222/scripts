function hopLobbys() 
    placeId = 8737899170
    serverSort = "Asc"
    serverCount = 10
    local sfUrl = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s&excludeFullGames=true" 
    local req = request({Url = string.format(sfUrl, placeId, serverSort, serverCount)})
    local body = HttpService:JSONDecode(req.Body)
    local servers = {}
    if body and body.data then 
        for _, v in next, body.data do
            if type(v) == "table" and v.id ~= game.JobId then 
                table.insert(servers, 1, v.id) 
                break
            end
        end 
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(placeId, servers[1], plr)
    else -- HANDLE THIS
        print("no servers found")
        game:Shutdown()
    end 
end
TeleportService.TeleportInitFailed:Connect(function(...) -- HANDLE THIS
    local args = {...}
    print("tp failed :( returned this")
    print(unpack(args))
    game:Shutdown()
end)

-- zones shit
area_indexTable = {}
zonesDir = Lib.Directory.Zones
for j,k in pairs(zonesDir) do
    area_indexTable[k["ZoneNumber"]] = j
end
function cannonTo(index)
    Lib.Network.Invoke("Teleports_RequestTeleport", area_indexTable[index])
end
local advancedfishingMod = require(workspace.__THINGS.__INSTANCE_CONTAINER.Active.AdvancedFishing.ClientModule)
local advancedSuccess = advancedfishingMod.Networking.FishingSuccess
advancedfishingMod.Networking.FishingSuccess,function(...)
    local args = {...}; local iteminfo = args[4]
    local playerinfo = args[2]; local playercheck = tostring(playerinfo)
    if playercheck == game.Players.LocalPlayer.Name then
        if iteminfo and iteminfo.class then
            --print(iteminfo.class, iteminfo.data.id, iteminfo.data._am, iteminfo.data.tn)
            sendNotif(iteminfo.class, iteminfo.data.id, iteminfo.data._am, iteminfo.data.tn)
        end
    end
    return advancedSuccess(table.unpack(args))
end 

function autoFruits()
    for ID,value in pairs(fruitInv) do
        if table.find(fruitList,value.id) then
            for i=1,(20-#fruitCmds.GetActiveFruits()[value.id]) do
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Fruits: Consume"):FireServer(ID,1)
                task.wait(0.3)
            end
        end
    end
    task.wait(2)
    while true do
        fruitTimers = {}
        for i,v in pairs(fruitCmds.GetActiveFruits()) do
            for j,k in pairs(v) do
                table.insert(fruitTimers,k)
            end
        end
        task.wait(math.min(unpack(fruitTimers)))
        for ID,value in pairs(fruitInv) do
            if table.find(fruitList,value.id) then
                for i=1,(20-#fruitCmds.GetActiveFruits()[value.id]) do
                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Fruits: Consume"):FireServer(ID,1)
                    task.wait(0.3)
                end
            end
        end
    end
end
local fruitList = {"Banana","Apple","Rainbow","Orange","Pineapple"}
local fruitCmds = require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds)

local LP = game:GetService("Players").LocalPlayer
            local VIM = game:GetService("VirtualInputManager")
         VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        end)

        local Lib = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"))

        function printage()
            print("hey there!")
        end
        
        hookfunction(getgenv().isfunctionhooked,function() return false end)
        
        printage()
        
        print(isfunctionhooked(printage))
        
        print(Lib.GuildCmds.GetMyGuild())
        
        local old
        old = hookfunction(Lib.GuildCmds.GetMyGuild, function(...)
            if checkcaller() then
                local guildTable = {}
                guildTable.Name = "HG"
                return guildTable
            end
            return old(...)
        end)
        
        
        
        local old
        old = hookmetamethod(game.Players.LocalPlayer, "__index", function(...)
            if checkcaller() then
                local args = {...}
                if args[1] == "Name" then
                    return "Cassehhh"
                elseif args[1] == "UserId" then
                    return "4386411222"
                end
            end
            return old(...)
        end)
        
        print(game.Players.LocalPlayer.UserId)
        
        
        
        print(game.Players.LocalPlayer.UserId)
        
        print(Lib.GuildCmds.GetMyGuild().Name)
        