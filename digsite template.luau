local Things = workspace:WaitForChild("__THINGS")
local Active = Things.__INSTANCE_CONTAINER:WaitForChild("Active")
local Player = game.Players.LocalPlayer
local character = Player.Character
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local Active = Things.__INSTANCE_CONTAINER.Active
local ActiveBlocks = Active.AdvancedDigsite.Important.ActiveBlocks
local ActiveChests = Active.AdvancedDigsite.Important.ActiveChests
local advancedDigsiteCFrame = CFrame.new(1152.35,-33.357,3792.9128)
function currentActive()
    return Active:GetChildren()[1]
end
function getChest()
    local chest = ActiveChests:GetChildren()[1]
    if chest then
        return chest
    end
    return nil
end
 
function getBlock()
    local blocks = ActiveBlocks:GetChildren()
    for i, v in pairs(ActiveBlocks:GetChildren()) do
        local CurrentBlock = blocks[#blocks - i + 1]
        if CurrentBlock.Color.R > 0.067 or CurrentBlock.Color.G > 0.067 or CurrentBlock.Color.B > 0.067 then
            local coord = CurrentBlock:GetAttribute('Coord')
            if (coord.X > 1 and coord.X < 16 and coord.Z > 1 and coord.Z < 16) then
                return CurrentBlock
            end
        end
    end
    return nil
end
 
function dig()
    local Chest = getChest()
    if Chest then
        j = 1
        while Chest.Parent == ActiveChests and j < 20 do
            humanoidRootPart.CFrame = Chest:FindFirstChildWhichIsA("BasePart").CFrame
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigChest", Chest:GetAttribute('Coord'))
            task.wait(0.2)
        end
        if j == 20 then
            Chest.Parent = nil
        end
    else
        local Block = GetBlock()
        j = 1
        while Block.Parent == ActiveBlocks and j < 100 do
            humanoidRootPart.CFrame = Block.CFrame
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer(CurrentActive().Name, "DigBlock", Block:GetAttribute('Coord'))
            task.wait(0.2)
            j = j + 1
        end
        if Block.Parent == ActiveBlocks then
            Block:Destroy()
        end
    end
end
