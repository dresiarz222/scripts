getgenv().config = {
    vipOwnerId = 3614582719,
    alts = {
        3614582719,
    }
}

if getgenv().Executed then
    return
else
    getgenv().Executed = true
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

for i,v in pairs(workspace:GetDescendants()) do -- clear seats
    if v:IsA("Seat") or v:IsA("VehicleSeat") then
        v.Disabled = true
    end
end

-- VARIABLES
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local httpService = game:GetService("HttpService")
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local humanoid = plr.Character:WaitForChild("Humanoid")
local altNumber = table.find(config.alts,plr.UserId)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainEvent = ReplicatedStorage:WaitForChild("MainEvent")
local bringQueue = {}
local buyers = {}
local totalDhcToBeDropped = 0
-- END

loadstring(game:HttpGet("https://raw.githubusercontent.com/dresiarz222/anticheatbypass/main/anticheatbypass.lua"))()
function removeDollarSigns(input)
    return (input:gsub("[%$,]", ""))
end
function getOrderAmm(userId) -- returnval index 1 is permdhc, index is dynamic dhc
    local json = game:HttpGet("https://p.api.paths.wtf/api/userid/"..userId.."/info/dhc")
    local json = httpService:JSONDecode(json)
    if json["error"] then
        print("getorderammfunc", json["error"])
        return nil
    else
        return {json["permdhc"], json["dhc"]}
    end
end
function antiAfk()
    virtualuser = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(math.random(3,4))
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end
function blackGui()
    main = Instance.new("ScreenGui")
    Frame = Instance.new("Frame")
    TextLabel = Instance.new("TextLabel")
    TextLabel_2 = Instance.new("TextLabel")
    TextLabel_3 = Instance.new("TextLabel")
    
    main.Name = "autoDHC"
    main.Parent = game.CoreGui
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main.IgnoreGuiInset = true
    
    Frame.Parent = main
    Frame.Active = true
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    
    TextLabel.Parent = Frame
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.5, 0, 0.419999987, 0)
    TextLabel.Size = UDim2.new(0, 279, 0, 34)
    TextLabel.Font = Enum.Font.Ubuntu
    TextLabel.Text = "AutoPilot".." alt #"..altNumber.."\n"..plr.Name.." "..plr.UserId
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = false
    TextLabel.TextSize = 15.000
    TextLabel.TextWrapped = true
end
function postDhc(user,amount)
    amount = tostring(amount)
    local HttpService = game:GetService("HttpService")
    local success, response = pcall(function()
        local postData = {
            user = user,
            dhc = amount
        }
        local postDataJson = HttpService:JSONEncode(postData)
        local Headers = {
            ["Authorization"] = "$r*S7dv@@mBh1tmd*y!RL358Dv@DH!kDCd##tDLbgyCp7J$HunxaFXd7K1jm",
            ["Content-Type"] = "application/json"
        }
        return http_request({
            Url = "https://p.api.paths.wtf/api/path/create",
            Method = "POST",
            Headers = Headers,
            Body = postDataJson
        })
    end)
    if success then
        print("POST request successful")
        print("Response:", response.Body)
        print(response.StatusCode)
    else
        print("POST request failed")
        print("Error:", response)
    end
end
blackGui()
-- PVP OFF AND KICK IF NO ORDER AND CURRENT USER IS HOST
function togglePvp()
    if plr.UserId == config.vipOwnerId then
        print("this player is a host")
        print("toggling pvp")
        MainEvent:FireServer(unpack({[1] = "RoleplayModeChange"}))
    end 
end
function kickPlr(userId)
    if table.find(config.alts, userId) then
        print("not kicking alt cuz plr is in alts table")
        return
    end
    local args = {
        [1]="VIP_CMD",
        [2]="Kick",
        [3]=plrs:GetPlayerByUserId(userId)
        }
        MainEvent:FireServer(unpack(args))
end
-- END

function Setup(place,xMulti,zMulti,columnions,rows)
    if place == "bank" then
        SymmetryX = -375
        SymmetryZ = -284.249939
        height = 21.25
    elseif place == "club" then
        SymmetryX = -264.08
        SymmetryZ = -369.66
        height = -6.2
    end
    print("x", xMulti)
    print("z", zMulti)
    print("columns", columnions)
    print("rows", rows)
    if hrp then
        local Rows = rows       
        local Columns = columnions
        local SpacingX = xMulti    
        local SpacingZ = zMulti
        local row = math.floor((altNumber - 1) / Columns) + 1
        local column = (altNumber - 1) % Columns + 1
        
        local xOffset = (column - 1) * SpacingX - (Columns - 1) * SpacingX / 2  
        local zOffset = (row - 1) * SpacingZ - (Rows - 1) * SpacingZ / 2 
        
        local newPosition = Vector3.new(SymmetryX + xOffset, height, SymmetryZ + zOffset)
        hrp.CFrame = CFrame.new(newPosition)
    end
end
function graveAlt(bool,place)
    if place == "bank" then
        height = 21.25
    elseif place == "club" then
        height = -6.2
    end
    if bool then
        if hrp:FindFirstChildOfClass("BodyPosition") then
            hrp:FindFirstChildOfClass("BodyPosition"):Destroy()
        end
        local BP = Instance.new("BodyPosition")
        BP.Parent = hrp
        BP.Name = "bp"
        BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        BP.Position = Vector3.new(hrp.CFrame.X,height-12,hrp.CFrame.Z)
        hrp.CFrame *= CFrame.new(0,-12,0)
    elseif not bool then
        if hrp:FindFirstChildOfClass("BodyPosition") then
            hrp:FindFirstChildOfClass("BodyPosition"):Destroy()
            hrp.CFrame *= CFrame.new(0,14,0)
        end
    end
end
function BringPlayer(userId,place)
    bringing = true
    if place == "bank" then
        placeCFrame = CFrame.new(-388.6,21.24,-295.672)
    elseif place =="club" then
        placeCFrame = CFrame.new(-264.85308837890625, 0.034421682357788086, -340.4570617675781)
    end
    local player = plrs:GetPlayerByUserId(userId)
    local koBodyEffect = player.Character.BodyEffects:WaitForChild("K.O")
    local grabbedBodyEffect = player.Character.BodyEffects:WaitForChild("Grabbed")
    graveAlt(false,"bank")
    if not player then 
        print("Player that was supposed to be brought was not found") 
        return
    end
        local success, errormsg = pcall(function()
            repeat task.wait()
                hrp.CFrame = player.Character:WaitForChild("HumanoidRootPart").CFrame
                humanoid:EquipTool(plr.Backpack:FindFirstChild("Combat"))
                plr.Character:FindFirstChild("Combat"):Activate()
            until koBodyEffect.Value == true
            local args = {
                [1] = "Grabbing",
                [2] = false
            }
            task.spawn(function()
                repeat task.wait() 
                    hrp.CFrame = CFrame.new(player.Character.UpperTorso.CFrame.Position) * CFrame.new(0,3,0)
                until grabbedBodyEffect.Value == true or koBodyEffect.Value == false or not plrs:GetPlayerByUserId(userId)
            end)
            repeat 
                MainEvent:FireServer(unpack(args))
                task.wait(2)
            until grabbedBodyEffect.Value == true or koBodyEffect.Value == false or not plrs:GetPlayerByUserId(userId)
        end)
        print("player should be grabbed")
        hrp.CFrame = placeCFrame
        task.wait(5)
        local args = {
            [1] = "Grabbing",
            [2] = false
        }
        repeat
            MainEvent:FireServer(unpack(args))
            task.wait(2)
        until not grabbedBodyEffect.Value
        Setup(place,5,5,4,10)
        graveAlt(true,place)
        if table.find(bringQueue,userId) then
            table.remove(bringQueue,userId)
        end
        bringing = nil
        task.spawn(dropDhc)
end
function waitForPlayerDhcGoal(player,goal)
    local userId = player.UserId
    buyers[userId] = {}
    buyers[userId].beginDhcVal = player.DataFolder.Currency.Value
    repeat task.wait(1) print(player.Name.." "..player.DataFolder.Currency.Value-buyers[userId].beginDhcVal) until not player or player.DataFolder.Currency.Value-buyers[userId].beginDhcVal >= goal
    print(player.Name, "have finished picking their order")
    print("begun at", buyers[userId].beginDhcVal, "ending at", player.DataFolder.Currency.Value)
    print("asking to leave...")
    if plr.UserId ~= config.vipOwnerId then return end
    graveAlt(false,"bank")
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer((player.Name.." please leave"), 'All')
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(("your order is finished"), 'All')
    task.wait(60)
    if not bringing then
        graveAlt(true,"bank")
    end
    if plrs:FindFirstChild(player.Name) then
        kickPlr(userId)
    end
end
function dropDhc()
    local moneyDroppedConnection = game:GetService("Workspace").Ignored.Drop.ChildAdded:Connect(function(child)
        if child.Name ~= "MoneyDrop" then 
            child:Destroy()
            return
        end
        repeat task.wait() until child:FindFirstChild("BillboardGui")
        repeat task.wait() until child:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")
        local cashPartVal = tonumber(removeDollarSigns(child.BillboardGui.TextLabel.Text))
            if cashPartVal > 1000 then
                if totalDhcToBeDropped-cashPartVal <= 0 then
                    totalDhcToBeDropped = 0
                else
                    totalDhcToBeDropped -= cashPartVal
                end
            end
        child:Destroy()
    end)
    repeat task.wait()
        if totalDhcToBeDropped <= 0 then
            repeat task.wait() until totalDhcToBeDropped > 0 or bringing
        else
            game.ReplicatedStorage.MainEvent:FireServer("DropMoney",10000)
        end
    until bringing
    moneyDroppedConnection:Disconnect()
end
antiAfk()
Setup("bank",5,5,4,10) -- sets alts at bank (hopefully correctly)
graveAlt(true,"bank")
task.spawn(dropDhc)

plrs.PlayerAdded:Connect(function(player)
    local userId = player.UserId
    local orderAmount = getOrderAmm(userId)
    --[[
    repeat task.wait() until player.Character
    print("waiting for them to fully load")
    repeat task.wait() until player.Character:WaitForChild("FULLY_LOADED_CHAR")
    print("fully loaded")
    print("their order amount is")
    --]]
    if not orderAmount then
        print("no order amm found on this plr, UserId, kicking", player.Name, userId)
        if plr.UserId == config.vipOwnerId then
            kickPlr(userId)
        end
        return
    end
    print(player.Name, "joined with perm, dynamic order", orderAmount[1], orderAmount[2])
    print("waiting for char")
    repeat task.wait() until player.Character
    player.Character:WaitForChild("FULLY_LOADED_CHAR")
    print("char loaded?")
    if orderAmount[1] == orderAmount[2] then
        print("not rejoining back from order, starting fresh")
        totalDhcToBeDropped += orderAmount[2]
    else
        print("player mustve rejoined cuz permdhc is not equal to dhc")
        totalDhcToBeDropped += orderAmount[2]
    end
    if plr.UserId == config.vipOwnerId then
        print("this player is vip owner, bringing")
        BringPlayer(userId,"bank")
        print("brought, adding to total dhc to be dropped and waiting for player goal")
    end
    waitForPlayerDhcGoal(player,orderAmount[2])
end)

plrs.PlayerRemoving:Connect(function(player)
    print(player, "left so we gotta do sum shit lil bro")
    local userId = player.UserId
    local orderAmount = getOrderAmm(userId) -- 1 is permdhc 2 is dynamic dhc
    if table.find(bringQueue,userId) then
        table.remove(bringQueue,userId)
    end
    if buyers[userId] then
        if orderAmount[2]-(player.DataFolder.Currency.Value-buyers[userId].beginDhcVal) > 30000 then
            local cachedTotalDhc = totalDhcToBeDropped
            postDhc(player.Name,(-1)*(player.DataFolder.Currency.Value-buyers[userId].beginDhcVal))
            totalDhcToBeDropped -= (orderAmount[2]-player.DataFolder.Currency.Value-buyers[userId].beginDhcVal)
            print("plr left during order, decreasing totalDhcTobeDropped from", cachedTotalDhc, "by", orderAmount[2]-(player.DataFolder.Currency.Value-buyers[userId].beginDhcVal))
            print("so total dhc to be dropped is now", totalDhcToBeDropped)
        else
            print("order difference is this", orderAmount[2]-(player.DataFolder.Currency.Value-buyers[userId].beginDhcVal), "so fuck u")
            print("so marking order as finished")
            postDhc(player.Name,(-1)*orderAmount[2])
        end
        buyers[userId] = nil
    end
end)

while task.wait(10) do
    print("dhc to be dropped:", totalDhcToBeDropped)
end
