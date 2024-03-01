getgenv().autotapRadius = 70

local plr = game.Players.LocalPlayer
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
breakables = game.Workspace['__THINGS'].Breakables
breakableDmgRemote = game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage
function getBreakables()
    local breakablesTable = {}
    for i,v in pairs(breakables:GetChildren()) do
        if not v:FindFirstChild("Hitbox",true) then continue end
        if v.Parent:IsA("Model") and not v:IsA("Highlight") and (hrp.Position-v:FindFirstChild("Hitbox",true).Position).Magnitude < autotapRadius  then
            table.insert(breakablesTable,v.Parent.Name)
        end
    end
    return breakablesTable
end

function reverseTable(inputTable)
    local reversedTable = {}
    local length = #inputTable
    for i,v in pairs(inputTable) do
        reversedTable[length-(i-1)] = v
    end
    return reversedTable
end

coroutine.wrap(function()
    while task.wait() do
        for _,v in pairs(getBreakables()) do
            breakableDmgRemote:FireServer(v)
        end
        task.wait(0.2)
    end
end)()

coroutine.wrap(function()
    while task.wait() do
        for _,v in pairs(reverseTable(getBreakables())) do
            breakableDmgRemote:FireServer(v)
        end
        task.wait(0.2)
    end
end)()
