getgenv().KiTTYWARE = {
    key = "n@z0V",
    autoPresents = true,
    autoFish = true,
    fishConfig = {
        autoRods = false,
        area = "AdvancedFishing",
        render = false,
        sendWebhooks = false,
        userID = "", -- Discord user ID
        webhookURL = "", -- Discord Webhook
        returnUser = "",
        autoReturn = false,
    },
    autoMail = false,
    mailConfig = {
        autoClaim = false,
        autoSend = false,
        userToMail = "", -- Username to Mail
        keepDiamonds = 50000,
        items = { -- Adjust config as needed, support for Every Item/Tier and Pet/Type
            {ClassName = "Pet", ItemName = "Huge Poseidon Corgi"},
            {ClassName = "Pet", ItemName = "Huge Poseidon Corgi", Tier = 1},
            {ClassName = "Pet", ItemName = "Huge Poseidon Corgi", Tier = 2},
            {ClassName = "Misc", ItemName = "Magic Shard", Amount = 150},
            {ClassName = "Currency", ItemName = "Diamonds", Amount = 2500000}
        }
    },
    minDelay = 1,
    maxDelay = 10,
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a0eb07bccea4ab44a65a44944c878520.lua"))()