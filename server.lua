ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('almez-hud:GetPlayerDetails', function(source, cb, eventHandler)
    local src = source 
    local player = ESX.GetPlayerFromId(src)
    local gangText = false
    local societyMoney = false
    local society = false
    if not eventHandlerCounter[eventHandler] then
        eventHandlerCounter[eventHandler] = 0
    else
        eventHandlerCounter[eventHandler] = eventHandlerCounter[eventHandler] + 1
    end
    if player then
        Wait(500)
        cb({
            type = "updateDetails",
            cash = player.getMoney(),
            bank = player.getAccount('bank').money,
            black_money = player.getAccount('black_money').money,
        })
    else
        cb(false)
    end
end)
