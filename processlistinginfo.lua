local function processListingInfo(uid, gems, item, version, shiny, amount, boughtFrom)
    print(uid, gems, item, version, shiny, amount, boughtFrom)
    print("BOUGHT FROM:", boughtFrom)
    print("UID:", uid)
    print("GEMS:", gems)
    print("ITEM:", item)
    local snipeMessage = game.Players.LocalPlayer.Name .. " just sniped a "
    if version then
        if version == 2 then
            version = "Rainbow"
        elseif version == 1 then
            version = "Golden"
        end
    else
       version = "Normal"
    end
    
    snipeMessage = snipeMessage .. version
    
    if shiny then
        snipeMessage = snipeMessage .. " Shiny"
    end
    
    snipeMessage = snipeMessage .. " " .. (item)
    
    print(snipeMessage)
    
    if amount then
        print("AMOUNT:", amount)
    else
        amount = 1
        print("AMOUNT:", amount)
    end

    local fields = {
        {
            name = "PRICE:",
            value = tostring(gems) .. " GEMS",
            inline = true,
        },
        {
            name = "BOUGHT FROM:",
            value = tostring(boughtFrom),
            inline = true,
        },
        {
            name = "AMOUNT:",
            value = tostring(amount),
            inline = true,
        },
        {
            name = "PETID:",
            value = tostring(uid),
            inline = true,
        }
    }

    local message = {
        content = "@everyone",
        embeds = {
            {
                title = snipeMessage,
                fields = fields,
                author = {name = "New Pet Sniped!"}
            }
        },
        username = "piratesniper",
        attachments = {}
    }

    local http = game:GetService("HttpService")
    local jsonMessage = http:JSONEncode(message)

    http:PostAsync(
        "https://discord.com/api/webhooks/1187980213234188358/D0HQv_O7rm8Zf8ac1sAFNUYszh-TKu3FLkAaOdQmbJiEt1AKhCrq0qXybxMPmN1fuF7G",
        jsonMessage,
        Enum.HttpContentType.ApplicationJson,
        false
    )
end

processListingInfo(5,"5",2,6,5,2,1)

plaza teleportfailedHandler

TeleportService.TeleportInitFailed:Connect(function(player, resultEnum, msg) 
    print(string.format("server: teleport %s failed, resultEnum:%s, msg:%s", player.Name, tostring(resultEnum), msg)) 
    config.servers.pageDeep += 1
    task.wait(5)
    jumpToPlaza()
end)