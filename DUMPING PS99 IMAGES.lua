dir = game:GetService("ReplicatedStorage").Library.Directory

function printCharms(module)
    local count = 0
    for i,v in require(module) do
        count += 1
        pcall(function()
            print(i, v.Icon)
        end)
    end
    return count
end
function printMiscItems(module)
    local count = 0
    for i,v in require(module) do
        count += 1
        pcall(function()
            print(i, v.Icon)
        end)
    end
    return count
end
function printFruits(module)
    local count = 0
    for i,v in require(module) do
        count += 1
        pcall(function()
            print(i, v.Icon)
        end)
    end
    return count
end
function printPotions(module)
    local count = 0
    for i,v in require(module) do
        for j,k in unpack(getupvalues(v.Icon)) do
            print(i, j, k)
            count += 1
        end
    end
    return count
end
function printEggs(module)
    local count = 0
    for i,v in require(module) do
        count += 1
        pcall(function()
            print(i, v.icon)
        end)
    end
    return count
end
function printPets(module)
    local count = 0
    for i,v in require(module) do
        if string.find(i,"Huge") or string.find(i,"Titanic") then
            count += 1
            pcall(function()
                print(i, v.thumbnail, v.goldenThumbnail)
            end)
        end
    end
    return count
end
function printEnchants(module)
    local count = 0
    for i,v in require(module) do
        for j,k in unpack(getupvalues(v.Icon)) do
            print(i, j, k)
            count += 1
        end
    end
    return count
end
